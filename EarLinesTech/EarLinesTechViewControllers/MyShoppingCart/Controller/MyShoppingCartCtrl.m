//
//  MyShoppingCartCtrl.m
//  EarLinesTech
//
//  Created by apple   on 2018/4/20.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "MyShoppingCartCtrl.h"
#import "ShoppingCartCell.h"
#import "SureOrderViewController.h"
#import "MallCartModel.h"
#import "PersonalCenterCtrl.h"
#import "MallDetailViewController.h"
#import "CartItem.h"

@interface MyShoppingCartCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)UIButton *allSelectBtn;
@property(nonatomic,strong)NSMutableArray *carts;//购物车商品
@property(nonatomic,strong)NSMutableArray *merchants;//购物车商家
@property(nonatomic,strong)NSMutableArray *selectCarts;
@property(nonatomic,strong)UILabel *moenyLab;
@property(nonatomic,strong)UIView *headerBGV;
@end

@implementation MyShoppingCartCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}

-(void)addUI{
    _selectCarts = @[].mutableCopy;
    _carts = @[].mutableCopy;
    _merchants = @[].mutableCopy;
    self.navigationTitle.text = @"购物车";
    self.view.backgroundColor = COLOR(0xf0);
    [self addRightBtnWithIMGname:@"nav_Personal_Center"];
    
    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom) style:UITableViewStylePlain];
    [_tab registerNib:[UINib nibWithNibName:@"ShoppingCartCell" bundle:nil] forCellReuseIdentifier:@"ShoppingCartCell"];
    _tab.delegate = self;
    _tab.dataSource = self;
    _tab.backgroundColor = [UIColor clearColor];
    _tab.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tab];
    
    
    
    //底部结算
    UIView *bootomV = [[UIView alloc]initWithFrame:CGRectMake(0, SH-58-bottomHeight, SW, 58)];
    bootomV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bootomV];
    
    UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.frame = CGRectMake(20, (58-20)/2, 20, 20);
    [allBtn setImage:[UIImage imageNamed:@"shop_list_dit1"] forState:UIControlStateSelected];
    [allBtn setImage:[UIImage imageNamed:@"shop_list_dit"] forState:UIControlStateNormal];
    [allBtn addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];
    allBtn.selected = NO;
    [bootomV addSubview:allBtn];
    _allSelectBtn = allBtn;
    
    UILabel *quanxuan = [[UILabel alloc]initWithFrame:CGRectMake(49, 0, 200, 58)];
    quanxuan.textAlignment = NSTextAlignmentLeft;
    quanxuan.font = EWKJfont(15);
    quanxuan.textColor = COLOR(0x33);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@"全选 合计： 0.00元"];
    [attr addAttribute:NSForegroundColorAttributeName value:RGB(0xff,0X07, 0X00) range:NSMakeRange(6, attr.length-6)];
    quanxuan.attributedText = attr;
    [bootomV addSubview:quanxuan];
    _moenyLab = quanxuan;
    
    UIButton * delete = [ UIButton buttonWithType:UIButtonTypeCustom];
    delete.frame = CGRectMake(SW-150, (58-33)/2, 55, 33);
    delete.layer.cornerRadius = 3;
    delete.layer.borderColor = COLOR(0x66).CGColor;
    delete.layer.borderWidth = 1;
    delete.backgroundColor = [UIColor whiteColor];
    [delete setTitle:@"删除" forState:UIControlStateNormal];
    delete.titleLabel.font = EWKJfont(13);
    [delete setTitleColor:COLOR(0x66) forState:UIControlStateNormal];
    [bootomV addSubview:delete];
    [delete addTarget:self action:@selector(deleteShop) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * jiesuan = [ UIButton buttonWithType:UIButtonTypeSystem];
    jiesuan.frame = CGRectMake(SW-75, (58-33)/2, 55, 33);
    jiesuan.layer.cornerRadius = 3;
    jiesuan.layer.borderColor = RGB(0xd8, 0x08, 0x02).CGColor;
    jiesuan.layer.borderWidth = 1;
    jiesuan.backgroundColor = [UIColor whiteColor];
    [jiesuan setTitle:@"结算" forState:UIControlStateNormal];
    jiesuan.titleLabel.font = EWKJfont(13);
    [jiesuan setTitleColor:RGB(0xd8, 0x08, 0x02) forState:UIControlStateNormal];
    [bootomV addSubview:jiesuan];
    [jiesuan addTarget:self action:@selector(jiesuanShop) forControlEvents:UIControlEventTouchUpInside];
    
     [self requestCart];
}

-(void)haveNoCart{
    
    if(_headerBGV == nil){
        _headerBGV = [[UIView alloc]initWithFrame:CGRectMake(0, navigationBottom+ 20, SW, 80)];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((SW-150)/2, 0, 150, 20)];
        lab.text =@"购物车里还没有商品";
        lab.textColor= COLOR(0x99);
        lab.font = EWKJfont(12);
        lab.textAlignment = NSTextAlignmentCenter;
        [_headerBGV addSubview:lab];
        
        UIView *linel = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(lab.frame)-60, 10, 50, 1)];
        linel.backgroundColor = COLOR(0xe3);
        [_headerBGV addSubview:linel];
        UIView *liner = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, 10, 50, 1)];
        liner.backgroundColor =  COLOR(0xe3);
        [_headerBGV addSubview:liner];
    }
    [self.view addSubview:_headerBGV];
}


#pragma mark - 请求购物车
-(void)requestCart{
    [_merchants removeAllObjects];
    [_selectCarts removeAllObjects];
    [_carts removeAllObjects];
    WeakSelf
    [[EWKJRequest request]requestWithAPIId:cart6 httphead:nil bodyParaDic:nil completed:^(id datas) {
        NSArray *carts = datas[Data];
        if (carts.count) {
            for (int i =0; i<carts.count; i++) {
                MallCartModel  *model = [MallCartModel modelObjectWithDictionary:carts[i]];
                [weakSelf.merchants addObject:model];
               
                for (CartItem *cart in model.items) {
                    [weakSelf.carts addObject:cart];
                    if (cart.selected) {
                        [weakSelf.selectCarts addObject:cart];
                    }
                }
                if (weakSelf.selectCarts.count == weakSelf.carts.count) {
                    weakSelf.allSelectBtn.selected = YES;
                }
                [weakSelf caculateMoney];
            }
            [weakSelf.tab reloadData];
        }else{
            [weakSelf.tab reloadData];
            [weakSelf haveNoCart];
//            [weakSelf alertWithString:@"购物车没有商品"];
        }
    } error:^(NSError *error, NSInteger statusCode) {
        
    }];
}



-(void)deleteShop{
    if (_selectCarts.count == 0) {
        [self alertWithString:@"请勾选需要删除的商品"];
        return;
    }
    WeakSelf
    
  __block  NSMutableArray *cartItems = @[].mutableCopy;
    
    [_selectCarts enumerateObjectsUsingBlock:^(CartItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [cartItems addObject:@((int)obj.cartItemId)];
    }];
    
    
    [[EWKJRequest request]requestWithAPIId:cart5 httphead:nil bodyParaDic:@{@"CartItemIds":cartItems} completed:^(id datas) {
//        [weakSelf alertWithString:@"删除购物车商品成功！"];
        weakSelf.allSelectBtn.selected = NO;
        [weakSelf requestCart];
    } error:^(NSError *error, NSInteger statusCode) {
        [weakSelf TipWithErrorCode:statusCode];
    }];
    
}
-(void)jiesuanShop{
    if (_selectCarts.count) {
        
        SureOrderViewController *order = [[SureOrderViewController alloc]init];
        [self.navigationController pushViewController:order animated:NO];
    }else{
        [self alertWithString:@"请选择结算商品"];
    }
}
-(void)allSelect:(UIButton*)sender{
    if (_carts.count == 0) {
        return;
    }
    
    sender.selected = !sender.isSelected;
    [self selectallWithYesNo:sender.selected];
}


-(void)rightNavitemCLick{
    [self.navigationController pushViewController:[[PersonalCenterCtrl alloc]init] animated:NO];
   
}


#pragma mark - tabdelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _carts.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [ShoppingCartCell cartCell];
    }
    cell.item = _carts[indexPath.row];
  
    WeakSelf
    cell.selectBlcok = ^(BOOL isSelect, CartItem *Item) {
        if (isSelect) {
            [weakSelf.selectCarts addObject:Item];
            if (weakSelf.selectCarts.count == weakSelf.carts.count) {
                weakSelf.allSelectBtn.selected = YES;
            }
        }else{
            [weakSelf.selectCarts removeObject:Item];
            if (weakSelf.selectCarts.count < weakSelf.carts.count) {
                weakSelf.allSelectBtn.selected = NO;
            }
        }
        [weakSelf selectWithCart:Item yesNo:isSelect];
        [weakSelf caculateMoney];
    };
    
    cell.countBlcok = ^(int count, CartItem *Item) {
            [weakSelf requestCart];
    };
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CartItem *cart = _carts[indexPath.row];
    MallDetailViewController *detail = [[MallDetailViewController alloc]init];
    detail.productID = (int)cart.productId;
    [self.navigationController pushViewController:detail animated:NO];
}

#pragma mark - 选中或取消单个商品

-(void)selectWithCart:(CartItem*)car yesNo:(BOOL)yn{
WeakSelf
    [[EWKJRequest request]requestWithAPIId:cart4 httphead:nil bodyParaDic:@{@"CartId":@((int)car.cartId),@"Selected":@(yn),@"CartItemIds":@[@(car.cartItemId)]}.mutableCopy completed:^(id datas) {
    
} error:^(NSError *error, NSInteger statusCode) {
    [weakSelf alertWithString:[NSString stringWithFormat:@"%ld",(long)statusCode]];
}];
}

#pragma mark - 选中或取消全部商品
-(void)selectallWithYesNo:(BOOL)yn{
    WeakSelf
    for (int j =0; j<_merchants.count; j++) {
        MallCartModel *mall  =_merchants[j];
        int cartid = 0;
        NSMutableArray *cartIds = @[].mutableCopy;
        for (int i =0; i<mall.items.count;i++) {
            CartItem *car = mall.items[i];
            if (i == 0) {
                cartid = car.cartId;
            }
            [cartIds addObject:@((int)car.cartItemId)];
        }
        
        [[EWKJRequest request]requestWithAPIId:cart4 httphead:nil bodyParaDic:@{@"CartId":@(cartid),@"Selected":@(yn),@"CartItemIds":cartIds}.mutableCopy completed:^(id datas) {
            [weakSelf requestCart];
        } error:^(NSError *error, NSInteger statusCode) {
            [weakSelf alertWithString:[NSString stringWithFormat:@"%ld",statusCode]];
        }];
    }
}
-(void)caculateMoney{
  
     CGFloat money = 0;
    for (int i = 0; i<_selectCarts.count; i++) {
        CartItem *car = _selectCarts[i];
        money += car.price*car.qty;
    }
    _moenyLab.text = [NSString stringWithFormat:@"全选 合计： %.2f元",money];
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
