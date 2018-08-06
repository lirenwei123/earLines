//
//  MyOrderCtrl.m
//  EarLinesTech
//
//  Created by apple   on 2018/4/20.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "MyOrderCtrl.h"
#import "EWKJOrderCell.h"
#import "orderModel.h"
#import "OrderDetailViewController.h"
#import "CartItem.h"


CGFloat cellh = 80;

@interface MyOrderCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)CGFloat btnW ;
@property (nonatomic,strong)UIView *currentTopLine;
@property (nonatomic,strong) UIView *noneBG;
@property (nonatomic,strong) UIView *topBG;
@property (nonatomic,strong) EWKJBtn *currentBtn;
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *orderModels;

@end

@implementation MyOrderCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)addUI{
    _orderModels= @[].mutableCopy;
    //    _merchantModels = @[].mutableCopy;
//    [self requestOrder];
    self.navigationTitle.text = @"我的订单";
    self.view.backgroundColor = COLOR(249);
    
    CGFloat top = navigationBottom;
    CGFloat magin = 2;
    CGFloat h = 30;
    
    NSArray * topBtnTitles = @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成",@"退换货"];
    CGFloat w = (SW-2*magin)/topBtnTitles.count;
    _btnW = w;
    
    UIView *topbg = [[UIView alloc]initWithFrame:CGRectMake(0, top, SW, h)];
    topbg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topbg];
    _topBG = topbg;
    
    WeakSelf
    for (int i = 0 ; i< topBtnTitles.count; i++) {
        EWKJBtn * topBtn = [[EWKJBtn alloc]initWithFrame:CGRectMake(magin+w*i, 0, w, h) img:nil title:topBtnTitles[i] touchEvent:^(EWKJBtn *btn) {
            [weakSelf topBtnClick:btn];
        } andbtnType:BTNTYPETEXT];
        topBtn.lab.font = EWKJboldFont(12);
        topBtn.lab.textColor = COLOR(0x33);
        [topbg addSubview:topBtn];
        topBtn.tag = i;
        
        if (i == _orderState ) {
            if(i ==4){
                _orderState ++;
            }else{
                
                _currentBtn = topBtn;
                UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(magin+i*w, h-2, w, 2)];
                bottomLine.backgroundColor = RGB(0xd8,8, 2);
                [topbg addSubview:bottomLine];
                _currentTopLine = bottomLine;
            }
        }
    }
    
    
    
    
    
    
    
    _tab =  [[UITableView alloc]initWithFrame:CGRectMake(0, top+h+10, SW,SH-top-10-statusBarHeight-20) style:UITableViewStylePlain];
    _tab.backgroundColor = [UIColor clearColor];
    _tab.delegate = self;
    _tab.dataSource = self;
    [_tab registerNib:[UINib nibWithNibName:@"EWKJOrderCell" bundle:nil] forCellReuseIdentifier:@"EWKJOrderCell"];
    _tab.separatorColor = [UIColor whiteColor];
    _tab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tab];
}
-(void)haveNoOrder{
    CGFloat  top = navigationBottom +30 +10;
    //没有数据的时候显示
    if (!_noneBG) {
        _noneBG = [[UIView alloc]initWithFrame:CGRectMake(0, top, SW, SH -top)];
        _noneBG.backgroundColor =  [UIColor whiteColor];
        CGFloat nonewidth = 150;
        EWKJBtn *noneIMGV = [[EWKJBtn alloc]initWithFrame:CGRectMake((SW-nonewidth)/2, 32, nonewidth, nonewidth) img:[UIImage imageNamed:@"none"] title:@"什么都还没有哦～" touchEvent:nil andbtnType:BTNTYPEUD];
        noneIMGV.lab.font = EWKJfont(14);
        noneIMGV.lab.textColor = COLOR(0x99);
        [_noneBG addSubview:noneIMGV];
    }
    [_noneBG removeFromSuperview];
    [self.view addSubview:_noneBG];
    
}

-(void)topBtnClick:(EWKJBtn*)sender{
    //底线先滑过去
    if(sender != _currentBtn ){
        _currentBtn = sender;
        _orderState = sender.tag;
        WeakSelf
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.currentTopLine.frame = CGRectMake(2+weakSelf.btnW*sender.tag,28,weakSelf.btnW, 2);
        }];
        
        
        
        //request
        [self requestOrder];
    }
    
    
    
}


#pragma mark - 订单请求

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestOrder];
}

-(void)requestOrder {
    
    //    GET api/order/myorders?status={status}&pageSize={pageSize}&pageIndex={pageIndex}
    //    所有 = 0, 未付款 = 1, 待发货 = 2, 待收货 = 3, 完成 = 4, 退款 = 5
    [SVProgressHUD showWithStatus:@"加载中..."];
    [_orderModels removeAllObjects];
    //    [_merchantModels removeAllObjects];
    
    WeakSelf
    [HttpRequest lrw_getWithURLString:[NSString stringWithFormat:@"http://em-webapi.zhiyunhulian.cn/api/order/myorders?status=%ld&pageSize=50&pageIndex=1",_orderState] parameters:nil success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *datas = responseObject[Data];
        WeakSelf
        if (datas.count) {
            if (weakSelf.noneBG) {
                [weakSelf.noneBG removeFromSuperview];
            }
            for (int i =0; i<datas.count; i++) {
                orderModel *model = [orderModel modelObjectWithDictionary:datas[i]];
                [weakSelf.orderModels addObject:model];
                //                [weakSelf.merchantModels addObject:model];
            }
        }else{
            [weakSelf haveNoOrder];
        }
        [weakSelf.tab reloadData];
    } failure:^(NSError *error, NSInteger errorCode) {
        [SVProgressHUD dismiss];
        [weakSelf TipWithErrorCode:errorCode];
    }];
}

#pragma mark -  tabdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _orderModels.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    orderModel *order = _orderModels[section];
    return order.items.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EWKJOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EWKJOrderCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [EWKJOrderCell orderCell];
    }
    cell.backgroundColor = [UIColor whiteColor];
    orderModel *order = _orderModels[indexPath.section];
    cell.item = order.items[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellh;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController *detail = [[OrderDetailViewController alloc]init];
    detail.order = _orderModels[indexPath.section];
    [self.navigationController pushViewController:detail animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    orderModel *order = _orderModels[section];
    
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 40)];
    bg.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 20, 20)];
    imgv.image = [UIImage imageNamed:@"Personal_Center_list_shop"];
    [bg addSubview:imgv];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(46, 10, SW-70, 20)];
    name.textAlignment = NSTextAlignmentLeft;
    name.font = EWKJboldFont(13);
    name.textColor = COLOR(0x33);
    name.text = order.merchantName;
    [bg addSubview:name];
    
    
    return bg;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    orderModel *order = _orderModels[section];
    UIView *bg1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 50)];
    bg1.backgroundColor = COLOR(243);
    
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 40)];
    bg.backgroundColor = [UIColor whiteColor];
    [bg1 addSubview:bg];
    
    UILabel *left = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 100, 20)];
    left.font = EWKJfont(11);
    left.textColor = RGB(0xec, 0x3c, 0x1a);
    left.text = order.orderStatusName;
    left.textAlignment = NSTextAlignmentLeft;
    [bg addSubview:left];
    
    UILabel *right = [[UILabel alloc]initWithFrame:CGRectMake(SW/2-20, 10 , SW/2, 20)];
    right.font = EWKJfont(13);
    right.textColor = COLOR(0x33);
    CGFloat money = 0;
    for (int i =0; i<order.items.count; i++) {
        CartItem *cart = order.items[i];
        money += cart.price*cart.qty;
    }
    right.text = [NSString stringWithFormat:@"共计%ld件商品 合计: ￥%.2f元",order.items.count,money];
    right.textAlignment = NSTextAlignmentRight;
    [bg addSubview:right];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SW, 1)];
    line.backgroundColor = COLOR(200);
    [bg1 addSubview:line];
    
    return bg1;
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
