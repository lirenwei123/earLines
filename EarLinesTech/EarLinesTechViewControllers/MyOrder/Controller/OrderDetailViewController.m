//
//  OrderDetailViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/6/1.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "orderDetail.h"
#import "OrderCell.h"
#import "MallDetailViewController.h"
#import "PayViewController.h"
#import "returnFunViewController.h"
#import "wuliuViewController.h"

@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)orderDetail *orderDetail;
@property(nonatomic,strong)UITableView *orderTab;
@property(nonatomic,strong)UIView *header;
@property(nonatomic,strong)UIView *footer;
@property(nonatomic,strong)UILabel *adressLab;
@property(nonatomic,assign)CGFloat money;



@property(nonatomic,strong)UILabel *payMoneyLab;
@property(nonatomic,strong)UILabel *needPayMonyLab;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *phone;
@property(nonatomic,strong)UILabel *orderNO;
@property(nonatomic,strong)UILabel *orderTime;
@property(nonatomic,strong)UILabel *payTime;
@property(nonatomic,strong)UIButton *statusbtn;

@property(nonatomic,strong)UIButton *wuliuBtm;
@property(nonatomic,strong)UIButton *tuihuanBtn;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


-(void)addUI{
    
    
    
    self.navigationTitle.text = @"订单详情";
    _orderTab  =[[UITableView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom-bottomHeight) style:UITableViewStylePlain];
    _orderTab.delegate = self;
    _orderTab.dataSource = self;
    _orderTab.backgroundColor =  COLOR(243);
    _orderTab.tableHeaderView = [self headerV];
    _orderTab.tableFooterView = [self footerV];
    [_orderTab registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"OrderCell"];
    [self.view addSubview:_orderTab];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestOrderDetail];
}

#pragma mark - 请求订单详情
-(void)requestOrderDetail{
    //    api/order/detail?orderId={orderId}&merchantOrderId={merchantOrderId}
    [SVProgressHUD showWithStatus:@"加载中..."];
    WeakSelf
    NSString *url = [NSString stringWithFormat:@"%@order/detail?orderId=%d&merchantOrderId=%d",httpHead,(int)_order.orderId,(int)_order.merchantOrderId];
    [HttpRequest lrw_getWithURLString:url parameters:nil success:^(id responseObject) {
        [SVProgressHUD dismiss];
        weakSelf.orderDetail = [orderDetail modelObjectWithDictionary:responseObject[Data]];
        [weakSelf.orderTab reloadData];
        [weakSelf setOrderDetail];
       
    } failure:^(NSError *error, NSInteger errorCode) {
        [SVProgressHUD dismiss];
    }];
  
    
}


-(void)setOrderDetail{
    _adressLab.text = _orderDetail.deliveryAddress;
    _name.text = [NSString stringWithFormat:@"收货人: %@",_orderDetail.contacterName];
    _phone.text =  [NSString stringWithFormat:@"电话: %@",_orderDetail.phoneNumber];
    
    if (_orderDetail.orderStatus == 1) {
        //未支付
        [self botomMenu];
    }
    else if (_orderDetail.orderStatus >=2 && _orderDetail.orderStatus <=5) {
        _wuliuBtm.hidden = NO;
        if (_orderDetail.orderStatus!=5) {
            _tuihuanBtn.hidden = NO;
            _tuihuanBtn.selected = NO;
        }
        
    }else if (_orderDetail.orderStatus == 7 ){
        _tuihuanBtn.hidden = NO;
        _tuihuanBtn.selected = YES;
    }
     [self caculateMoney];
    [_statusbtn setTitle:_orderDetail.orderStatusName forState:0];
    
    NSString *str1 = [@"订单编号: " stringByAppendingString:_orderDetail.orderNumber];
    NSMutableAttributedString *orderno = [[NSMutableAttributedString  alloc]initWithString:str1];
    [orderno addAttributes:@{NSForegroundColorAttributeName:COLOR(0x33)} range:NSMakeRange(0, 5)];
    [orderno addAttributes:@{NSForegroundColorAttributeName:COLOR(0x99)} range:NSMakeRange(5, str1.length-5)];
    _orderNO.attributedText = orderno;
    
    
    NSString *str2= [@"创建时间: " stringByAppendingString:_orderDetail.createDt];
    NSMutableAttributedString *time1 = [[NSMutableAttributedString  alloc]initWithString:str2];
    [time1 addAttributes:@{NSForegroundColorAttributeName:COLOR(0x33)} range:NSMakeRange(0, 5)];
    [time1 addAttributes:@{NSForegroundColorAttributeName:COLOR(0x99)} range:NSMakeRange(5, str2.length-5)];
    _orderTime.attributedText = time1;
    
    
    NSString *str3  = [@"付款时间: " stringByAppendingString:_orderDetail.paymentDt==nil?@"待付款":_orderDetail.paymentDt];
    NSMutableAttributedString *time2 = [[NSMutableAttributedString  alloc]initWithString:str3];
    [time2 addAttributes:@{NSForegroundColorAttributeName:COLOR(0x33)} range:NSMakeRange(0, 5)];
    [time2 addAttributes:@{NSForegroundColorAttributeName:COLOR(0x99)} range:NSMakeRange(5, str3.length-5)];
    _payTime.attributedText = time2;
}

-(void)botomMenu{
    UIView *bg =  [[UIView alloc]initWithFrame:CGRectMake(0, SH-bottomHeight-50, SW, 50)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    _needPayMonyLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SW-115, 50)];
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString:@"需付： 00.00元"];
    [attr addAttributes:@{NSFontAttributeName:EWKJfont(18),NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(3, attr.length-3)];
    [attr addAttributes:@{NSFontAttributeName:EWKJfont(12),NSForegroundColorAttributeName:COLOR(0x33)} range:NSMakeRange(0, 3)];
    _needPayMonyLab.attributedText = attr;
    [bg addSubview:_needPayMonyLab];
    
    UIButton *buy = [UIButton buttonWithType:UIButtonTypeCustom];
    buy.frame = CGRectMake(SW-100, 0, 100, 50);
    [buy setBackgroundImage:[UIImage imageNamed:@"Head_portrait_bg"] forState:0];
    [buy setTitle:@"立即支付" forState:0];
    [buy setTitleColor:[UIColor whiteColor] forState:0];
    [bg addSubview:buy];
    [buy addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
    delete.frame = CGRectMake(SW-200, 0, 100, 50);
    [delete setBackgroundColor:[UIColor grayColor]];
    [delete setTitle:@"删除订单" forState:0];
    [delete setTitleColor:[UIColor whiteColor] forState:0];
    [bg addSubview:delete];
    [delete addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - tabledalegate



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return _orderDetail.items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mallCartItem = _orderDetail.items[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bg  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 40)];
    bg.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 20, 20)];
    imgv.image = [UIImage imageNamed:@"Personal_Center_list_shop"];
    [bg addSubview:imgv];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(46, 10, 300, 20)];
    name.text = _orderDetail.merchantName ;
    name.font = EWKJfont(13);
    name.textColor = COLOR(0x33);
    [bg addSubview:name];
    return bg;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   CartItem *cart = _orderDetail.items[indexPath.row];
    MallDetailViewController *detail = [[MallDetailViewController alloc]init];
    detail.productID = (int)cart.productId;
    [self.navigationController pushViewController:detail animated:NO];
}

-(UIView*)headerV{
    if (_header == nil) {
        _header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 85)];
        _header.backgroundColor = [UIColor whiteColor];
        
        
        
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
        imgv.image = [UIImage imageNamed:@"landmark"];
        [_header addSubview:imgv];
        //地址
        UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(50, 15, 300, 20)];
        address.font = EWKJfont(13);
        address.textColor = COLOR(0x33);
        [_header addSubview:address];
        _adressLab = address;
        
        //收货人
        _name = [[UILabel alloc]initWithFrame:CGRectMake(50, 40, 100, 20)];
        _name.font = EWKJfont(13);
        _name.textColor = COLOR(0x33);
        [_header addSubview:_name];
        //电话
        _phone = [[UILabel alloc]initWithFrame:CGRectMake(180, 40, 150, 20)];
        _phone.font = EWKJfont(13);
        _phone.textColor = COLOR(0x33);
        [_header addSubview:_phone];
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 75, SW, 10)];
        line.backgroundColor  = COLOR(243);
        [_header addSubview:line];
        
    }
    return _header;
}



-(UIView*)footerV{
    
    if (!_footer) {
        
        _footer  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 160)];
        _footer.backgroundColor = [UIColor whiteColor];
        
      
        //商品小记
        _payMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 150, 40)];
        _payMoneyLab.textColor = COLOR(0x33);
        _payMoneyLab.font =EWKJfont(13);
        [_footer addSubview:_payMoneyLab];
        _payMoneyLab.text = @"商品小计 ￥0.00";
        [_footer addSubview:_payMoneyLab];
        
        UIView *line0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 1)];
        line0.backgroundColor = COLOR(243);
        [_footer addSubview:line0];
        
        //退换货 查看物流
        NSArray *btnNames = @[@"退换货",@"查看物流"].copy;
        NSArray *btnimgs = @[@"Payment_success_k",@"login_yz"].copy;
        NSArray *colors = @[COLOR(0x66),RGB(0xff, 0, 0)].copy;
        CGFloat w = 58;
        for (int i = 0; i<btnNames.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(SW-(w+20)*btnNames.count + (w+20)*i, 10, w, 20);
            [btn setBackgroundImage:[UIImage imageNamed:btnimgs[i]] forState:0];
            [btn setTitle:btnNames[i] forState:0];
            [btn setTitleColor:colors[i] forState:0];
            btn.titleLabel.font = EWKJfont(11);
            [_footer addSubview:btn];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100+i;
            btn.hidden  = YES;
            
            if (i==0) {
                _tuihuanBtn = btn;
                 [btn setTitle:@"取消退换货" forState:UIControlStateSelected];
            }else if (i== 1){
                _wuliuBtm = btn;
            }
        }
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 39, SW, 1)];
        line1.backgroundColor = COLOR(243);
        [_footer addSubview:line1];
        
        //订单编号
        _orderNO = [[UILabel alloc]initWithFrame:CGRectMake(15, 40, SW-100, 40)];
        _orderNO.textColor = COLOR(0x33);
        _orderNO.font =EWKJfont(13);
        [_footer addSubview:_orderNO];
        _orderNO.text = @"订单编号";
        [_footer addSubview:_orderNO];
        
        _statusbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _statusbtn.frame=CGRectMake(SW-78, 50, 58, 20);
        [_statusbtn setBackgroundImage:[UIImage imageNamed:@"login_yz"] forState:0];
        [_statusbtn setTitleColor:RGB(0xff, 0, 0) forState:0];
        _statusbtn.titleLabel.font = EWKJfont(11);
        [_footer addSubview:_statusbtn];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 79, SW, 1)];
        line2.backgroundColor = COLOR(243);
        [_footer addSubview:line2];
        
        //创建时间
        _orderTime = [[UILabel alloc]initWithFrame:CGRectMake(15, 80, SW-30, 40)];
        _orderTime.font =EWKJfont(13);
        [_footer addSubview:_orderTime];
        _orderTime.text = @"创建时间";
        [_footer addSubview:_orderTime];
        
        UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, 119, SW, 1)];
        line3.backgroundColor = COLOR(243);
        [_footer addSubview:line3];
        //付款时间
        
        _payTime = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, SW-30, 40)];
        _payTime.font =EWKJfont(13);
        [_footer addSubview:_payTime];
        _payTime.text = @"付款时间";
        [_footer addSubview:_payTime];
    }
    return _footer;
}

-(void)btnClick:(UIButton *)sender{
    if (sender.tag == 100) {
        // 退换货
        if (sender.isSelected) {
            WeakSelf
            [[EWKJRequest request]requestWithAPIId:order10 httphead:nil bodyParaDic:@{@"MerchantOrderId":@((int)_orderDetail.merchantOrderId)}.copy completed:^(id datas) {
                if ([datas[@"Status"] isEqualToString:@"ok"]) {
                    [weakSelf alertWithString:@"取消退货或退款成功！"];
                    [weakSelf requestOrderDetail];
                }else{
                    [weakSelf alertWithString:datas[@"ErrorMessage"]];
                }
            } error:^(NSError *error, NSInteger statusCode) {
                
            }];
        }else{
            
            returnFunViewController *tuihuanVC = [[returnFunViewController alloc]init];
            tuihuanVC.merchantOrderId = (int)_orderDetail.merchantOrderId;
            [self.navigationController pushViewController:tuihuanVC animated:NO];
        }
    }else{
        //　查看物流
        wuliuViewController *wuliuVC = [[wuliuViewController alloc]init];
        wuliuVC.merchantOrderId = (int)_orderDetail.merchantOrderId;
        wuliuVC.merchantUrl = _orderDetail.merchantImageUrl;
        wuliuVC.stastusName = _orderDetail.orderStatusName;
        [self.navigationController pushViewController:wuliuVC animated:NO];
    }
}

-(void)buy{
    //     pay.PaymentMethod = 0;免费产品就不用跳支付页面了,
    
    
    PayViewController *pay= [[PayViewController alloc]init];
    pay.money = _money;
    pay.orderId = (int)_orderDetail.orderId;
    [self.navigationController pushViewController:pay animated:NO];
}


#pragma mark - 删除未支付订单
-(void)delete{
WeakSelf
    [[EWKJRequest request]requestWithAPIId:order7 httphead:[NSString stringWithFormat:@"%d",(int)_orderDetail.orderId] bodyParaDic:nil completed:^(id datas) {
        NSString *errMSG = datas[@"ErrorMessage"];
        if (errMSG.length) {
            [weakSelf alertWithString:errMSG];
        }else{
            [weakSelf alertWithString:@"删除订单成功！"];
            [weakSelf.navigationController popViewControllerAnimated:NO];
        }
    } error:^(NSError *error, NSInteger statusCode) {
        
    }];
}

#pragma mark -- 计算金额
-(void)caculateMoney{
    CGFloat money = 0;
    for (int i =0; i<_orderDetail.items.count; i++) {

        CartItem *car = _orderDetail.items[i];
        money += car.price*car.qty;
        
    }
    _money = money;
    _payMoneyLab.text = [NSString stringWithFormat:@"商品小计 ￥%.2f",money];
    
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"需付：  %.2f元",money]];
    [attr addAttributes:@{NSFontAttributeName:EWKJfont(18),NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(3, attr.length-3)];
    [attr addAttributes:@{NSFontAttributeName:EWKJfont(12),NSForegroundColorAttributeName:COLOR(0x33)} range:NSMakeRange(0, 3)];
    _needPayMonyLab.attributedText = attr;
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
