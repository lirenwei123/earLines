//
//  PayViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/23.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "PayViewController.h"
#import "orderCreatModel.h"
#import "WechatPaymentData.h"
#import "AlipayPaymentData.h"

#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "WechatAuthSDK.h"
#import "UIAlertView+WX.h"
#import "PayResultViewController.h"
#import "UIButton+lrwButton.h"
#import <AlipaySDK/AlipaySDK.h>

@interface PayViewController ()
@property(nonatomic,strong)UIButton *moneyBtn;
@property(nonatomic,strong)UILabel *jifenLab;
@property(nonatomic,strong)EWKJBtn *currentPayBtn;
@property(nonatomic,strong)orderCreatModel *order;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(WXSuccess) name:@"WXSuccess" object:nil];
}
-(void)addUI{
    _PaymentMethod = PaymentMethod_noSelect;// 默认值
    self.navigationTitle.text = @"支付方式";
    //积分
    UILabel *jifen = [[UILabel alloc]initWithFrame:CGRectMake(15, navigationBottom+30, 200, 20)];
    [self.view addSubview:jifen];
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString:@"剩余积分： 0"];
    [attr addAttributes:@{NSFontAttributeName:EWKJfont(18),NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(5, attr.length-5)];
    [attr addAttributes:@{NSFontAttributeName:EWKJfont(12),NSForegroundColorAttributeName:COLOR(0x33)} range:NSMakeRange(0, 5)];
    jifen.attributedText = attr;
    _jifenLab = jifen;
    
    //支付方式
    
    NSArray *imgNames = @[@"pay_weixin",@"pay_zfb",@"pay_jf"].copy;
   NSArray *names = @[@"微信支付",@"支付宝",@"积分"].copy;
    CGFloat w = 110;
    CGFloat magin = (SW-3*w)/4;
    WeakSelf
    for (int i = 0; i<imgNames.count; i++) {
        
        EWKJBtn *payBtn = [[EWKJBtn alloc]initWithFrame:CGRectMake(magin+i*(w+magin), CGRectGetMaxY(jifen.frame)+30, w, 40) normalBackImg:[UIImage imageNamed:@"圆角矩形"] selectBackImg:[UIImage imageNamed:@"组3"] title:names[i] img:[UIImage imageNamed:imgNames[i]] touchEvent:^(EWKJBtn *btn) {
             [weakSelf payWithTag:btn];
        }];
        payBtn.lab.font = EWKJfont(12);
        payBtn.tag = 103+i;
        [self.view addSubview:payBtn];
    }
    
    UIButton *pay =[UIButton buttonWithType:UIButtonTypeCustom];
    pay.frame = CGRectMake(0, SH-bottomHeight-50, SW, 50);
    [pay setBackgroundImage:[UIImage imageNamed:@"Head_portrait_bg"] forState:0];
   
    
    [pay setTitle:[NSString stringWithFormat:@"支付%.2f元",_money] forState:0];
    [pay setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:pay];
    _moneyBtn =  pay;
    [pay addTarget:self action:@selector(requestOrder) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self requestPointScore];
}


#pragma mark -   支付

-(void)payWithTag:(EWKJBtn*)sender{
    NSInteger tag = sender.tag;
    if (tag -101 == _PaymentMethod) {
        return;
    }
    if (tag -101 == 4) {
        tag =102;
    }
    if (_currentPayBtn) {
        _currentPayBtn.selected = NO;
    }
    sender.selected = YES;
    _currentPayBtn = sender;
    
    _PaymentMethod = (int)tag -101;
    [self refreshMoney];
    
}

#pragma mark - 刷新money

-(void)refreshMoney{
    NSString *payMerhod = nil;
    switch (_PaymentMethod) {
        case PaymentMethod_score:
            payMerhod = @"积分";
            break;
        case PaymentMethod_wx:
            payMerhod = @"微信";
            break;
        case PaymentMethod_ali:
            payMerhod = @"支付宝";
            break;
        default:
            break;
    }
    
    [_moneyBtn setTitle:[NSString stringWithFormat:@"%@支付%.2f元",payMerhod,_money] forState:0];
}


#pragma mark - 请求订单

-(void)requestOrder{
 
    
    
    if (_PaymentMethod <0 || _PaymentMethod >3) {
        [self alertWithString:@"请选择支付方式"];
        return;
    }
    
    
    if (_notes == nil) {
        _notes = @"";
    }
    
    //提交订单
    if (_orderId) {
        NSDictionary *dict  = @{
                                @"PaymentMethod": @(_PaymentMethod),
                                @"OrderId": @(_orderId),
                                }.copy;
        [[EWKJRequest request]requestWithAPIId:order3 httphead:nil bodyParaDic:dict completed:^(id datas) {
            WeakSelf
            NSString *errorMsg = [datas objectForKey:@"ErrorMessage"];
            if (errorMsg.length) {
                [weakSelf  alertWithString:errorMsg];
                return ;
            }else{
                if (weakSelf.PaymentMethod==PaymentMethod_score) {
                    PayResultViewController *payRes = [[PayResultViewController alloc]init];
                    payRes.payMoney = weakSelf.money;
                    [weakSelf.navigationController pushViewController:payRes animated:NO];
                    
                    return;
                }
            }
            
            weakSelf.order= [orderCreatModel modelObjectWithDictionary:datas[Data]];
            [weakSelf paySdk];
            
        } error:^(NSError *error, NSInteger statusCode) {
            
        }];
    }else{
        //创建订单
        NSDictionary *dict  = @{
                                @"PaymentMethod": @(_PaymentMethod),
                                @"AddressId": @(_AddressId),
                                @"Notes": _notes
                                }.copy;
        [[EWKJRequest request]requestWithAPIId:order2 httphead:nil bodyParaDic:dict completed:^(id datas) {
            WeakSelf
            NSString *errorMsg = [datas objectForKey:@"ErrorMessage"];
            if (errorMsg.length) {
                [weakSelf  alertWithString:errorMsg];
                return ;
            }else{
                if (weakSelf.PaymentMethod==PaymentMethod_score) {
                    PayResultViewController *payRes = [[PayResultViewController alloc]init];
                    payRes.payMoney = weakSelf.money;
                    [weakSelf.navigationController pushViewController:payRes animated:NO];
                    
                    return;
                }
            }
            
            weakSelf.order= [orderCreatModel modelObjectWithDictionary:datas[Data]];
            [weakSelf paySdk];
            
        } error:^(NSError *error, NSInteger statusCode) {
            
        }];
    }
    
    
}

-(void)requestPointScore{
    WeakSelf
    [[EWKJRequest request]requestWithAPIId:user2 httphead:nil bodyParaDic:nil completed:^(id datas) {
        NSDictionary *dict = datas[Data];;
        CGFloat  score = [[dict objectForKey:@"UserPoints"] floatValue];
        NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"剩余积分： %.2f",score]];
        [attr addAttributes:@{NSFontAttributeName:EWKJfont(18),NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(5, attr.length-5)];
        [attr addAttributes:@{NSFontAttributeName:EWKJfont(12),NSForegroundColorAttributeName:COLOR(0x33)} range:NSMakeRange(0, 5)];
        weakSelf.jifenLab.attributedText = attr;
    } error:^(NSError *error, NSInteger statusCode) {
        
    }];
}

#pragma mark - 调用支付sdk
-(void)paySdk{
    switch (_PaymentMethod) {
        case PaymentMethod_wx:
            [self wxPay];
            break;
        case PaymentMethod_ali:
            [self aliPay];
            break;
        default:
            break;
    }
}


#pragma mark - 调用微信支付sdk

#pragma mark - 微信支付
- (void)wxPay
{
 BOOL result =   [WXApiRequestHandler jumpToBizPayWith:_order];
    if(!result){
        [self alertWithString:@"没有安装客户端"];
    }
       
    
}
#pragma mark - 支付宝支付
-(void)aliPay{
    [[AlipaySDK defaultService] payOrder:_order.alipayPaymentData.orderInfo fromScheme:@"EarLinesTech" callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
    }];
}


-(void)WXSuccess{
    PayResultViewController *payRes = [[PayResultViewController alloc]init];
    payRes.payMoney = _money;
    [self.navigationController pushViewController:payRes animated:NO];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
