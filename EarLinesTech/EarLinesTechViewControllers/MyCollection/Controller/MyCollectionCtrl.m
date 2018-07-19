//
//  MyCollectionCtrl.m
//  EarLinesTech
//
//  Created by apple   on 2018/4/20.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "MyCollectionCtrl.h"
#import "FavirateModel.h"
#import "myFavirateCell.h"
#import "MallDetailViewController.h"


@interface MyCollectionCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)  NSMutableArray *models;
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)UIButton *allSelectBtn;
@property(nonatomic,strong)NSMutableArray *productIDs;
@property(nonatomic,assign)BOOL isAllSelected;


@end

@implementation MyCollectionCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self request];
}
-(void)addUI{
    self.navigationTitle.text = @"我的收藏";
    _productIDs = @[].mutableCopy;
    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom) style:UITableViewStylePlain];
    [_tab registerNib:[UINib nibWithNibName:@"myFavirateCell" bundle:nil] forCellReuseIdentifier:@"myFavirateCell"];
    _tab.delegate = self;
    _tab.dataSource = self;
    _tab.backgroundColor = COLOR(243);
    _tab.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tab];
    [self addBottomV];
}

-(void)addBottomV{
    UIView *bootomV = [[UIView alloc]initWithFrame:CGRectMake(0, SH-58-bottomHeight, SW, 58)];
    bootomV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bootomV];
    
    UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.frame = CGRectMake(20, (58-20)/2, 20, 20);
    [allBtn setImage:[UIImage imageNamed:@"shop_list_dit1"] forState:UIControlStateSelected];
    [allBtn setImage:[UIImage imageNamed:@"shop_list_dit"] forState:UIControlStateNormal];
    [allBtn addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];
    [bootomV addSubview:allBtn];
    _allSelectBtn = allBtn;
    
    UILabel *quanxuan = [[UILabel alloc]initWithFrame:CGRectMake(49, 0, 150, 58)];
    quanxuan.textAlignment = NSTextAlignmentLeft;
    quanxuan.font = EWKJfont(15);
    quanxuan.textColor = COLOR(0x33);
    quanxuan.text = @"全选";
    [bootomV addSubview:quanxuan];
    
    UIButton * delete = [ UIButton buttonWithType:UIButtonTypeCustom];
    delete.frame = CGRectMake(SW-150, (58-33)/2, 55, 33);
    delete.layer.cornerRadius = 3;
    delete.layer.borderColor = RGB(0xd8, 8, 2).CGColor;
    delete.layer.borderWidth = 1;
    delete.backgroundColor = [UIColor whiteColor];
    [delete setTitle:@"删除" forState:UIControlStateNormal];
    delete.titleLabel.font = EWKJfont(13);
    [delete setTitleColor:RGB(0xd8, 8, 2) forState:UIControlStateNormal];
    [bootomV addSubview:delete];
    [delete addTarget:self action:@selector(deleteFavirate) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * jiesuan = [ UIButton buttonWithType:UIButtonTypeSystem];
    jiesuan.frame = CGRectMake(SW-75, (58-33)/2, 55, 33);
    jiesuan.layer.cornerRadius = 3;
    jiesuan.layer.borderColor = COLOR(0x33).CGColor;
    jiesuan.layer.borderWidth = 1;
    jiesuan.backgroundColor = [UIColor whiteColor];
    [jiesuan setTitle:@"完成" forState:UIControlStateNormal];
    jiesuan.titleLabel.font = EWKJfont(13);
    [jiesuan setTitleColor:COLOR(0x33) forState:UIControlStateNormal];
    [bootomV addSubview:jiesuan];
    [jiesuan addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
}


-(void)allSelect:(UIButton *)sender
{
    if (_models.count == 0) {
        return;
    }
    
    sender.selected = !sender.isSelected;
    _isAllSelected = sender.isSelected;
     [_productIDs removeAllObjects];
    if (sender.isSelected) {
        WeakSelf
        [_models enumerateObjectsUsingBlock:^(FavirateModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [weakSelf.productIDs addObject:@((NSInteger)obj.productId)];
        }];
    }
    [_tab reloadData];
    
}

-(void)deleteFavirate
{
    
    if (_productIDs.count == 0) {
        [self alertWithString:@"请勾选需要删除的商品"];
        return;
    }
    WeakSelf
    [HttpRequest lirw_postWithURLString:[NSString stringWithFormat:@"%@mall/product/favorite/remove",httpHead] parameters:@{Data:_productIDs}.mutableCopy success:^(id responseObject) {
        if ([responseObject[@"Status"]isEqualToString:@"ok"]) {
//            [weakSelf alertWithString:@"删除收藏成功！"];
            weakSelf.isAllSelected = NO;
            weakSelf.allSelectBtn.selected = NO;
            [weakSelf.models removeAllObjects];
            [weakSelf.productIDs removeAllObjects];
            [weakSelf request];
        }
    } failure:^(NSError *error,NSInteger code) {
        [weakSelf TipWithErrorCode:code];
    }];
}
-(void)complete
{
    [self.navigationController  popViewControllerAnimated:NO];
}

//请求我的收藏
-(void)request{
WeakSelf
    [HttpRequest lirw_postWithURLString:[NSString stringWithFormat:@"%@mall/product/favorite/list?pageSize=%d&pageIndex=%d",httpHead,10,1] parameters:nil success:^(id responseObject) {
        NSArray *datas = responseObject[Data];
        if (datas.count) {
           weakSelf.models = @[].mutableCopy;
            for (int i = 0; i<datas.count; i++) {
                FavirateModel *model = [FavirateModel modelObjectWithDictionary:datas[i]];
                [weakSelf.models addObject:model];
                [weakSelf.tab reloadData];
            }
        }else{
            [weakSelf haveNoFarirate];
            if (weakSelf.tab) {
                [weakSelf.tab reloadData];
            }
        }
    } failure:^(NSError *error, NSInteger errorCode) {
        [weakSelf TipWithErrorCode:errorCode];
    }];
}

-(void)haveNoFarirate{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((SW-150)/2, navigationBottom+30, 150, 20)];
    lab.text =@"您还没有收藏！";
    lab.textColor= COLOR(0x99);
    lab.font = EWKJfont(12);
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    UIView *linel = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(lab.frame)-60, navigationBottom+40, 50, 1)];
    linel.backgroundColor = COLOR(0xe3);
    [self.view addSubview:linel];
    UIView *liner = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, navigationBottom+40, 50, 1)];
    liner.backgroundColor =  COLOR(0xe3);
    [self.view addSubview:liner];
}

#pragma mark - tabdelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _models.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myFavirateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myFavirateCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [myFavirateCell FavirateCell];
    }
    
    
    cell.markBtn.selected = _isAllSelected;
    cell.item = _models[indexPath.row];
    WeakSelf
    cell.selectBlcok = ^(BOOL isSelect, NSInteger product) {
        if (isSelect) {
            [weakSelf.productIDs addObject:@(product)];
            if (weakSelf.productIDs.count == weakSelf.models.count) {
                weakSelf.allSelectBtn.selected = YES;
            }
        }else{
            [weakSelf.productIDs removeObject:@(product)];
            if (weakSelf.productIDs.count == 0) {
                weakSelf.allSelectBtn.selected = NO;
            }
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//进入商品详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FavirateModel *favi  = _models[indexPath.row];
    MallDetailViewController *detail = [[MallDetailViewController alloc]init];
    detail.productID = favi.productId;
    [self.navigationController pushViewController:detail animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
