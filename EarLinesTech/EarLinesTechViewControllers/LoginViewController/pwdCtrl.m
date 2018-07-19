//
//  pwdCtrl.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/4/17.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "pwdCtrl.h"
#import "USERBaseClass.h"
#import "LoginViewController.h"


static int mytime = 60;

@interface pwdCtrl ()
   @property(nonatomic,strong)NSMutableArray *tfs;
   @property(nonatomic,strong)NSTimer *mytimer;
   @property(nonatomic,strong)UIButton *yzmBtn;
@end



@implementation pwdCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mytimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_mytimer forMode:NSRunLoopCommonModes];
    _mytimer.fireDate = [NSDate distantFuture];
    
}
-(void)addUI{
    
    self.view.backgroundColor = COLOR(0xf9);
    NSArray *titles ;
    
    if (_pwdType == PWDTYPE_REGIST) {
        titles = @[@"手机号注册",@"请输入手机号",@"请输验证码",@"请输入密码",@"请输入邀请人电话",@"立即注册"];
    }else if (_pwdType == PWDTYPE_FORGETPWD){
        titles = @[@"忘记密码",@"请输入手机号",@"请输验证码",@"请输入您的新密码",@"请确认您的新密码",@"重置密码"];
    }else if (_pwdType == PWDTYPE_MODIFYPWD){
        titles = @[@"修改登录密码",@"当前密码",@"新密码",@"确认密码",@"密码不可见",@"保存"];
    }
    
    if (_pwdType != PWDTYPE_MODIFYPWD) {
        [self addPWDWithTitles:titles];
    }else{
        [self addModifyPWDWithTitles:titles];
    }
}

-(void)addPWDWithTitles:(NSArray*)names{
    self.navigationTitle.text = names.firstObject;
    CGFloat top = navigationBottom +14;
    CGFloat h = 48;
    CGFloat leftMarhin = 15;
    CGFloat updownMargin = 14;
    _tfs = @[].mutableCopy;
    for (int i = 1; i<names.count-1; i++) {
        
        
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, top+(h+updownMargin)*(i-1), SW, h)];
        bg.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bg];
       
        UITextField *tf= [[UITextField alloc]initWithFrame:CGRectMake(leftMarhin, 0, SW-2*leftMarhin, h)];
        tf.backgroundColor = [UIColor whiteColor];
        [bg addSubview:tf];
//        tf.placeholder = names[i];
        tf.font = EWKJboldFont(15);
        tf.textAlignment = NSTextAlignmentLeft;
//        tf.textColor = COLOR(0xc9);
        tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:names[i] attributes:@{NSForegroundColorAttributeName:COLOR(0xc9) }];
        NSString *title = names[i];
        if ([title containsString:@"密码"]) {
            tf.secureTextEntry = YES;
        }
        [_tfs addObject:tf];
        
        if ([names[i] isEqualToString:@"请输验证码"]) {
            UIButton * yzm = [UIButton buttonWithType:UIButtonTypeCustom];
            [yzm setFrame:CGRectMake(SW-20-90, (h-24)/2, 90, 24)];
            [yzm setTitle:@"获取验证码" forState:0];
            yzm.clipsToBounds = YES;
            yzm.layer.cornerRadius = 12;
            [yzm setTitleColor:[UIColor redColor] forState:0];
            yzm.titleLabel.textAlignment = NSTextAlignmentCenter;
            yzm.backgroundColor = [UIColor whiteColor];
            yzm.layer.borderColor = RGB(0xf3, 0x4e, 0x22).CGColor;
            yzm.layer.borderWidth = 1;
            yzm.titleLabel.font = EWKJboldFont(12);
            [bg addSubview:yzm];
            [yzm addTarget:self action:@selector(yzmClick:) forControlEvents:UIControlEventTouchUpInside];
            _yzmBtn = yzm;
            
        }
    }
    
    top = navigationBottom+(updownMargin + h)*(names.count-2)+25;
    
    UIButton * registBtn = [[UIButton alloc]initWithFrame:CGRectMake(leftMarhin, top, SW-2*leftMarhin, 40)];
    [registBtn setTitleColor:[UIColor whiteColor] forState:0];
    registBtn.titleLabel.font = EWKJboldFont(15);
    registBtn.backgroundColor = [UIColor redColor];
    [registBtn setTitle:names.lastObject forState:0];
    [registBtn addTarget:self action:@selector(pwdClick:) forControlEvents:UIControlEventTouchUpInside];
     registBtn.layer.cornerRadius = 20;
    [self.view addSubview:registBtn];
    registBtn.tag = _pwdType;
    
}

    -(void)yzmClick:(UIButton *)sender{
    [self.view endEditing:YES];
   
    // 获取验证码
    UITextField *tf = self.tfs[0];
        if (![self isPhoneNumber:tf.text]) {
            [self alertWithString:@"请输入正确的手机号码"];
            return;
        }
        sender.enabled = NO;
        
        API_ID apiid = user3;
        if (_pwdType == PWDTYPE_REGIST) {
           apiid = user3;
        }else if (_pwdType == PWDTYPE_FORGETPWD){
            apiid = user9;
        }
        WeakSelf
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:tf.text,@"PhoneNumber", nil];
        [[EWKJRequest request]requestWithAPIId:apiid httphead:nil bodyParaDic:dict completed:^(id datas) {
            weakSelf.mytimer.fireDate =  [NSDate distantFuture];
            DebugLog(@"%@",datas);
            sender.enabled = YES;
            mytime = 60;
            if ([datas isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary*)datas;
                NSString *ErrorMessage = [dic objectForKey:@"ErrorMessage"];
                if (ErrorMessage.length) {
                    [weakSelf alertWithString:ErrorMessage];
                }
            }
        } error:^(NSError *error) {
            weakSelf.mytimer.fireDate =  [NSDate distantFuture];
            sender.enabled = YES;
            mytime = 60;
            if(error ){
                [weakSelf alertWithString:[NSString stringWithFormat:@"%@",error]];
            }
            
        }];
    
        
    //计时器
        sender.enabled = NO;
        _mytimer.fireDate = [NSDate distantPast];
      
        
        
}
    
-(void)timer{
    mytime--;
    if(mytime == 0){
        [_mytimer invalidate];
        _mytimer = nil;
        mytime = 60;
    }else{
        [_yzmBtn setTitle:[NSString stringWithFormat:@"%is",mytime] forState:UIControlStateDisabled];
    }
}
-(void)addModifyPWDWithTitles:(NSArray*)names{
    self.navigationTitle.text = names.firstObject;
    CGFloat top = navigationBottom +14;
    CGFloat h = 48;
    CGFloat leftMarhin = 15;
    CGFloat updownMargin = 28;
    CGFloat leftW = 104;
    _tfs = @[].mutableCopy;
    for (int i = 1; i<names.count-1; i++) {
        
        
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, top+(h+updownMargin)*(i-1), SW, h)];
        bg.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bg];
        
        UILabel *leftLab = [[UILabel alloc]initWithFrame:CGRectMake(leftMarhin, 0, leftW-leftMarhin, h)];
        leftLab.backgroundColor = [UIColor whiteColor];
        leftLab.font = EWKJboldFont(15);
        leftLab.textAlignment = NSTextAlignmentLeft;
        leftLab.textColor = COLOR(0x33);
        leftLab.text = names[i];
        [bg addSubview:leftLab];
        
        
        if ([names[i] isEqualToString:@"密码不可见"]) {
            UIButton * pwdCanSee = [[UIButton alloc]initWithFrame:CGRectMake(leftW, (h-30)/2, 100, 30)];
            [pwdCanSee setImage:[UIImage imageNamed:@"login_close"] forState:0];
             [pwdCanSee setImage:[UIImage imageNamed:@"login_open"] forState:UIControlStateSelected];
            pwdCanSee.selected = YES;
            [pwdCanSee addTarget:self action:@selector(onoffClick:) forControlEvents:UIControlEventTouchUpInside];
            [bg addSubview:pwdCanSee];
            
            
         
            continue;
        }
        
        
        UITextField *tf= [[UITextField alloc]initWithFrame:CGRectMake(leftW, 0, SW-2*leftMarhin-leftW, h)];
        tf.backgroundColor = [UIColor whiteColor];
        [bg addSubview:tf];
        tf.placeholder = names[i];
        tf.font = EWKJboldFont(15);
        tf.textAlignment = NSTextAlignmentLeft;
        tf.textColor = COLOR(0xc8);
        tf.secureTextEntry = YES;
        [_tfs addObject:tf];
        
        
        UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake(leftW, top+h+(h+updownMargin)*(i-1), SW-leftW, updownMargin)];
        tip.backgroundColor = [UIColor clearColor];
        tip.textAlignment = NSTextAlignmentLeft;
        tip.font = EWKJboldFont(12);
        tip.textColor = RGB(0xed, 0x2c, 0x2c);
        tip.text = @"test";
        tip.tag = 100+i-1;
        [self.view addSubview:tip];
        

    }
    
    top = navigationBottom+(updownMargin + h)*(names.count-2)+25;
    
    UIButton * registBtn = [[UIButton alloc]initWithFrame:CGRectMake(leftMarhin, top, SW-2*leftMarhin, 40)];
    [registBtn setTitleColor:[UIColor whiteColor] forState:0];
    registBtn.titleLabel.font = EWKJboldFont(15);
    registBtn.backgroundColor = [UIColor redColor];
    [registBtn setTitle:names.lastObject forState:0];
    [registBtn addTarget:self action:@selector(pwdClick:) forControlEvents:UIControlEventTouchUpInside];
    registBtn.layer.cornerRadius = 20;
    [self.view addSubview:registBtn];
    registBtn.tag = _pwdType;
    
    
    
}

-(void)addModifyPWDSuccess{
    CGFloat top =  navigationBottom;
    CGFloat w = 200;
    EWKJBtn * success =  [[EWKJBtn alloc]initWithFrame:CGRectMake((SW-w)/2, top +35, w, w) img:[UIImage imageNamed:@"login_right"] title:@"登录密码修改成功" touchEvent:nil andbtnType:BTNTYPEUD];
    success.lab.textColor = RGB(0x03, 0xcc, 0x62);
    success.lab.font = EWKJboldFont(15);
    [self.view addSubview:success];
    
    UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake(15, top+35+w+50, SW-30, 35)];
    tip.text = @"密码修改成功，客户端原有登录状态已失效，请使用新密码重新登录";
    tip.numberOfLines = 2;
    tip.textColor = COLOR(0x99);
    tip.font = EWKJboldFont(12);
    [self.view addSubview:tip];
    
    UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(15, top+35+w+50+35+35, SW-30, 40)];
    login.backgroundColor = [UIColor redColor];
    [login setTitle:@"重新登录" forState:0];
    login.titleLabel.textColor = [UIColor whiteColor];
    login.titleLabel.font = EWKJboldFont(15);
    [self.view addSubview:login];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)login{
    LoginViewController *logvc = [[LoginViewController alloc]init];
    WeakSelf
    logvc.loginCompelete = ^{
        [weakSelf.navigationController popViewControllerAnimated:NO];
    };
    [self.navigationController pushViewController:logvc animated:NO];
    
}

-(void)onoffClick:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    for (UITextField * tf in _tfs) {
        tf.secureTextEntry = sender.isSelected;
    }
}

#pragma mark - request
-(void)pwdClick:(UIButton*)sender{
    WeakSelf
    if (sender.tag == PWDTYPE_REGIST) {
        //注册
        if ([_tfs[0] text].length != 11) {
            [self alertWithString:@"请输入正确的手机号码"];
            return;
        }else if ([_tfs[1] text].length == 0){
             [self alertWithString:@"请输入验证码"];
             return;
        }else if ([_tfs[2] text].length == 0){
            [self alertWithString:@"请输入您的密码"];
             return;
        }
        
         sender.enabled = NO;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [_tfs[0] text],@"Account",
                             [_tfs[2] text],@"Password",
                             @"",@"NickName",
                             @"",@"Gender",
                             [_tfs[1] text],@"VerificationCode", nil];
        
        [[EWKJRequest request]requestWithAPIId:user4 httphead:(NSString *)nil bodyParaDic:dic completed:^(id datas) {
            sender.enabled = YES;
            if (datas) {
                //保存客户登陆信息
                NSDictionary *dic = (NSDictionary*)datas;
                USERBaseClass *user = [USERBaseClass modelObjectWithDictionary:dic];
                if (user) {
                    [NSKeyedArchiver archiveRootObject:user toFile:USERINFOPATH];
                }
                [weakSelf.navigationController popViewControllerAnimated:NO];
                [weakSelf alertWithString:@"注册成功!"];
            }
        } error:^(NSError *error) {
            [weakSelf alertWithString:[NSString stringWithFormat:@"%@",error]];
            sender.enabled = YES;
        }];
      
        
        
        
    }else if (sender.tag == PWDTYPE_FORGETPWD){
        // 忘记密码
        if ([_tfs[0] text].length != 11) {
            [self alertWithString:@"请输入手机号码"];
            return;
        }else if ([_tfs[1] text].length == 0){
            [self alertWithString:@"请输入验证码"];
            return;
        }else if ([_tfs[2] text].length == 0){
            [self alertWithString:@"请输入您的密码"];
            return;
        }else if (![[_tfs[2] text] isEqualToString:[_tfs[3] text]]){
            [self alertWithString:@"请两次新密码输入保持一致"];
            return;
        }
         sender.enabled = NO;
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[_tfs[0] text],@"Account",[_tfs[1] text],@"ValidationCode",[_tfs[2] text],@"Password",nil];
        [[EWKJRequest request]requestWithAPIId:user8 httphead:nil bodyParaDic:dict completed:^(id datas) {
            if (datas) {
                NSString *message = datas[@"ErrorMessage"];
                if (message.length) {
                    [weakSelf alertWithString:message];
                }
            }
            sender.enabled = YES;
        } error:^(NSError *error) {
            if (error) {
                [weakSelf alertWithString:[NSString stringWithFormat:@"%@",error]];
            }
            sender.enabled = YES;
        }];
        
        
    }else if (sender.tag == PWDTYPE_MODIFYPWD){
        //修改密码
        
        if ([_tfs[0] text].length == 0) {
            [self alertWithString:@"请输入当前密码"];
            return;
        }else if (![[_tfs[0] text] isEqualToString:[USERBaseClass user].pwd]){
            [self alertWithString:@"当前密码输入不正确"];
            return;
        }
        else if ([_tfs[1] text].length == 0){
             [self alertWithString:@"请输入新密码"];
            return;
        }else if (![[_tfs[1] text] isEqualToString:[_tfs[2] text]]){
            [self alertWithString:@"两次新密码不一致"];
            return;
        }
        sender.enabled = NO;
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[_tfs[0] text],@"OldPassword",[_tfs[1] text],@"Password", nil];
        
        [[EWKJRequest request]requestWithAPIId:user10 httphead:nil bodyParaDic:dict completed:^(id datas) {
            sender.enabled = YES;
            //保存pwd
            USERBaseClass *user = [USERBaseClass user];
            user.pwd =  [weakSelf.tfs[1] text];
            if (user) {
                [NSKeyedArchiver archiveRootObject:user toFile:USERINFOPATH];
            }
            [weakSelf.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            } ];
            
            
            
            [weakSelf addModifyPWDSuccess];
            
            
        } error:^(NSError *error) {
            sender.enabled = YES;
            if (error) {
                [weakSelf alertWithString:[NSString stringWithFormat:@"%@",error]];
            }
        }];
        
       
        
    }
}


-(BOOL)isPhoneNumber:(NSString *)mobileNum{
    if (mobileNum.length !=11) {
        return NO;
    }
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0135678])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
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
