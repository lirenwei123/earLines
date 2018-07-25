//
//  RealNameAuthenticationCtrl.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/7/26.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "RealNameAuthenticationCtrl.h"

@interface RealNameAuthenticationCtrl ()
@property(nonatomic,strong)NSMutableArray *tfs;
@end

@implementation RealNameAuthenticationCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addReturn];
    self.navigationTitle.text = @"实名认证";
    _tfs = @[].mutableCopy;
    NSArray *names = @[@"姓名",@"身份证号码",@"银行卡号",@"手机号码"].copy;
    CGFloat top = navigationBottom +20;
    for (int i =0; i<names.count; i++) {
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(20, top+60*i, 80, 60)];
        name.textColor = [UIColor grayColor];
        name.font = [UIFont systemFontOfSize:15];
        name.text = names[i];
        [self.view addSubview:name];
        
        UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(100, top+60*i, SW-120, 60)];
        tf.font = [UIFont systemFontOfSize:14];
        [_tfs addObject:tf];
        [self.view addSubview:tf];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(SW-40, top+20+60*i, 20, 20)];
        [btn setBackgroundImage:[UIImage imageNamed:@"Close"] forState:0];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 10;
        [self.view addSubview:btn];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(clearTF:) forControlEvents:UIControlEventTouchUpInside];
    
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, top+60+60*i, SW-40, 1)];
        line.backgroundColor = COLOR(243);
        [self.view addSubview:line];
        
        if (i == names.count -1) {
            UIButton * registBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(line.frame)+30, SW-40, 40)];
            [registBtn setTitleColor:[UIColor whiteColor] forState:0];
            registBtn.titleLabel.font = EWKJboldFont(15);
            registBtn.backgroundColor = [UIColor redColor];
            [registBtn setTitle:@"立即认证" forState:0];
            [registBtn addTarget:self action:@selector(rzClick) forControlEvents:UIControlEventTouchUpInside];
            registBtn.layer.cornerRadius = 20;
            [self.view addSubview:registBtn];
        }
    }
    
}

-(void)clearTF:(UIButton *)sender{
    if (sender.tag-10 <_tfs.count) {
        UITextField *tf = _tfs[sender.tag-10];
        tf.text = @"";
    }
    
}

-(void)rzClick{
    UITextField *tf  = _tfs[0];
    if (tf.text.length ==0 ) {
        [self alertWithString:@"请输入姓名"];
        return;
    }
    tf = _tfs[1];
    if (tf.text.length ==0 ) {
        [self alertWithString:@"请输入身份证号码"];
        return;
    }
    tf = _tfs[2];
    if (tf.text.length ==0) {
        [self alertWithString:@"银行卡号"];
        return;
    }
    tf = _tfs[3];
    if (tf.text.length ==0 ) {
        [self alertWithString:@"手机号码"];
        return;
    }
    
    [self reuestRZ];
    
    
}

-(void)reuestRZ{
//    POST api/user/realname/authentication
    NSDictionary *dict = @{@"RealName":[_tfs[0] text],
                           @"IdCardNumber":[_tfs[1] text],
                           @"BankCardNumber":[_tfs[2] text],
                           @"Mobile":[_tfs[3] text]
                           };
    WeakSelf
    [SVProgressHUD showWithStatus:@"正在认证..."];
    [HttpRequest lirw_postWithURLString:[NSString stringWithFormat:@"%@user/realname/authentication",httpHead] parameters:@{Data:dict}.mutableCopy success:^(id responseObject) {
         [SVProgressHUD dismiss];
        if (responseObject[@"ErrorMessage"]) {
            [weakSelf alertWithString:responseObject[@"ErrorMessage"]];
        }
    } failure:^(NSError *error, NSInteger errorCode) {
        [SVProgressHUD dismiss];
        [weakSelf TipWithErrorCode:errorCode];
    }];
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
