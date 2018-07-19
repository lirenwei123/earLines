//
//  LoginViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/4/11.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "LoginViewController.h"
#import "pwdCtrl.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UITextField *acountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)addUI{
    self.navigationTitle.text = @"登录";
    self.loginBtn.layer.cornerRadius =  self.loginBtn.frame.size.height/2;
    self.clearBtn.layer.cornerRadius = self.clearBtn.frame.size.height/2;
    
    
}

- (IBAction)regist:(UIButton *)sender {
    [self.view endEditing:YES];
    pwdCtrl *pwd = [[pwdCtrl alloc]init];
    pwd.pwdType = PWDTYPE_REGIST;
    [self.navigationController pushViewController:pwd animated:NO];
}
- (IBAction)forgetPwd:(UIButton *)sender {
    [self.view endEditing:YES];
    pwdCtrl *pwd = [[pwdCtrl alloc]init];
    pwd.pwdType = PWDTYPE_FORGETPWD;
    [self.navigationController pushViewController:pwd animated:NO];
}
- (IBAction)loginClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if (_acountTF.text.length  == 0) {
        [self alertWithString:@"请输入账号"];
        return;
    }else if (_pwdTF.text.length == 0){
        [self alertWithString:@"请输入密码"];
        return;
    }
    sender.enabled = NO;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:_acountTF.text,@"Account",_pwdTF.text,@"Password", nil];
    WeakSelf
    [[EWKJRequest request]requestWithAPIId:user1 httphead:nil bodyParaDic:dict completed:^(id datas) {
        sender.enabled = YES;
        if (datas) {
            //保存客户登陆信息
            NSDictionary *dic = (NSDictionary*)datas[Data];
            USERBaseClass *user = [USERBaseClass modelObjectWithDictionary:dic];
            user.pwd = weakSelf.pwdTF.text;
            if (user) {
                [NSKeyedArchiver archiveRootObject:user toFile:USERINFOPATH];
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:ISLOGIN];
            }
        }
        
        
        [weakSelf.navigationController popViewControllerAnimated:NO];
        [weakSelf alertWithString:@"登录成功"];
        
        if (weakSelf.loginCompelete) {
            weakSelf.loginCompelete();
        }
    } error:^(NSError *error) {
         sender.enabled = YES;
        if (error) {
            [weakSelf alertWithString:[NSString stringWithFormat:@"%@",error]];
        }
    }];
    
}
- (IBAction)clearAcount:(UIButton *)sender {
    _acountTF.text =@"";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
