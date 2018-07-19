//
//  PayResultViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/31.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "PayResultViewController.h"

@interface PayResultViewController ()

@end

@implementation PayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationTitle.text = @"支付结果";
    
    UILabel *payMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(0, navigationBottom+68, SW, 20)];
    payMoneyLab.textColor  = COLOR(0x99);
    payMoneyLab.font= EWKJboldFont(12);
    payMoneyLab.text = @"支付金额";
    payMoneyLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:payMoneyLab];
    
    UILabel *payMoney = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(payMoneyLab.frame)+20, SW, 50)];
    payMoney.textColor = COLOR(0x33);
    payMoney.font = EWKJboldFont(36);
    payMoney.textAlignment = NSTextAlignmentCenter;
    payMoney.text = [NSString stringWithFormat:@"%.2f",_payMoney];
    [self.view addSubview:payMoney];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake((SW-200)/2, CGRectGetMaxY(payMoney.frame)+30, 200, 1)];
    line.backgroundColor = COLOR(243);
    [self.view addSubview:line];
    
    
//    EWKJBtn *paySuccess =  [[EWKJBtn alloc]initWithFrame:CGRectMake((SW-100)/2, CGRectGetMaxY(line.frame)+20, 100, 20) img:[UIImage imageNamed:@"Payment_success"] title:@"支付成功" touchEvent:nil andbtnType:BTNTYPELR];
//    [self.view addSubview:paySuccess];
  
    UIButton *paySuccess = [UIButton buttonWithType:UIButtonTypeSystem];
    paySuccess.frame = CGRectMake((SW-100)/2, CGRectGetMaxY(line.frame)+20, 100, 20) ;
    [paySuccess setImage:  [[UIImage imageNamed:@"Payment_success"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:0];
    [paySuccess setTitle:@"支付成功" forState:0];
    [paySuccess setTitleColor:COLOR(0x33) forState:0];
    paySuccess.titleLabel.font = EWKJboldFont(12);
    paySuccess.imageEdgeInsets  = UIEdgeInsetsMake(0, -10, 0, 0);
    [self.view addSubview:paySuccess];
    
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake((SW-100)/2, CGRectGetMaxY(paySuccess.frame)+80, 100, 30) ;
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"Payment_success_k"] forState:0];
    [returnBtn setTitle:@"返回" forState:0];
    [returnBtn setTitleColor:COLOR(0x66) forState:0];
    returnBtn.titleLabel.font = EWKJboldFont(12);
    [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    
}



-(void)returnClick{
    NSArray *controllers = self.navigationController.viewControllers;
    for ( id viewController in controllers) {
        if ([viewController isKindOfClass:NSClassFromString(@"MyShoppingCartCtrl")]) {
            [self.navigationController popToViewController:viewController animated:NO];
        }
    }
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
