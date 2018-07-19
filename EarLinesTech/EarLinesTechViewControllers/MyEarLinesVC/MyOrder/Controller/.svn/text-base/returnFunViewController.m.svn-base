//
//  returnFunViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/6/3.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "returnFunViewController.h"

@interface returnFunViewController ()
@property(nonatomic,strong)UITextField *tf;
@end

@implementation returnFunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationTitle.text = @"退款退货";
    
    NSString *tip = @"退款说明 (请与商家沟通退换货，以及金额等相关事宜)";
    NSMutableAttributedString *tipattr = [[NSMutableAttributedString  alloc]initWithString:tip];
    [tipattr addAttributes:@{NSForegroundColorAttributeName:COLOR(0x33),NSFontAttributeName:EWKJboldFont(15)} range:NSMakeRange(0, 5)];
    [tipattr addAttributes:@{NSForegroundColorAttributeName:COLOR(0x99),NSFontAttributeName:EWKJfont(13)} range:NSMakeRange(5, tip.length-5)];
   
    UILabel *tipLab = [[UILabel alloc]initWithFrame:CGRectMake(20,navigationBottom + 10, SW-40, 30)];
    tipLab.attributedText = tipattr;
    [self.view addSubview:tipLab];
    
    _tf = [[UITextField alloc]initWithFrame:CGRectMake(20, navigationBottom +40, SW - 40, 100)];
    NSMutableAttributedString *place = [[NSMutableAttributedString alloc]initWithString:@"请输入退款说明" attributes:@{NSForegroundColorAttributeName:COLOR(0x99),NSFontAttributeName:EWKJfont(14)}];
    _tf.attributedPlaceholder = place;
    _tf.borderStyle = UITextBorderStyleLine;
    _tf.layer.borderWidth = 1;
    _tf.layer.borderColor = COLOR(243).CGColor;
    _tf.font = EWKJfont(14);
    _tf.contentVerticalAlignment  =UIControlContentVerticalAlignmentTop;
    
    [self.view addSubview:_tf];
    
    
    
    UIButton *tijiao = [UIButton buttonWithType:UIButtonTypeCustom];
    tijiao.frame = CGRectMake(0, SH-bottomHeight-48, SW, 48);
    [tijiao setBackgroundImage:[UIImage imageNamed:@"Head_portrait_bg"] forState:0];
    [tijiao setTitle:@"提交申请" forState:0];
    [tijiao setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:tijiao];
    [tijiao addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
}


-(void)tijiao{
    if (_tf.text.length) {
        WeakSelf
        NSDictionary *dict = @{@"RefundNotes":_tf.text,@"MerchantOrderId":@(_merchantOrderId)}.copy;
        [[EWKJRequest request]requestWithAPIId:order8 httphead:nil bodyParaDic:dict completed:^(id datas) {
            if ([datas[@"Status"] isEqualToString:@"ok"]) {
                [weakSelf.navigationController popViewControllerAnimated:NO];
                [weakSelf alertWithString:@"退货或退款申请已提交！"];
            }else{
                [weakSelf alertWithString:datas[@"ErrorMessage"]];
            }
            
        } error:^(NSError *error, NSInteger statusCode) {
            
        }];
    }else{
        [self alertWithString:@"请输入退款说明"];
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
