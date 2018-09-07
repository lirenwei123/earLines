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
    
    
    _pwdTF.secureTextEntry = YES;
  UIImageView *  navigationBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SW , navigationBottom)] ;
    navigationBar.image = [UIImage imageNamed:@"Head_portrait_bg"];
    navigationBar.userInteractionEnabled = YES ;
    [self.view addSubview:navigationBar] ;
    
   UILabel * navigationTitle = [[UILabel alloc] initWithFrame:CGRectMake((SW-200)*0.5, statusBarHeight, 200, 44)] ;
    navigationTitle.textAlignment = NSTextAlignmentCenter ;
    navigationTitle.adjustsFontSizeToFitWidth = YES ;
    navigationTitle.textColor = [UIColor whiteColor] ;
    navigationTitle.font = EWKJboldFont(16);
    [navigationBar addSubview:navigationTitle] ;
    
    navigationTitle.text  =@"登录";
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, statusBarHeight+12, 22, 22)];
    image1.userInteractionEnabled = YES;
    image1.backgroundColor = [UIColor clearColor];
    image1.image = [UIImage imageNamed:@"nav_back"];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, statusBarHeight+5, 62, 35);
    [backBtn addTarget: self action:@selector(returnCLick) forControlEvents:UIControlEventTouchUpInside];
    
    image1.tag = 10;
    backBtn.tag = 20;
    
    [navigationBar addSubview:image1];
    [navigationBar addSubview:backBtn];

   
    self.loginBtn.layer.cornerRadius =  self.loginBtn.frame.size.height/2;
    self.clearBtn.clipsToBounds = YES;
    self.clearBtn.layer.cornerRadius = self.clearBtn.frame.size.height/2;
   
}
-(void)returnCLick{
    [self.navigationController popViewControllerAnimated:YES];
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
        if(datas&&[@"ok" isEqualToString:[datas objectForKey:@"Status"]])
                   {
                       //保存客户登陆信息
                       NSDictionary *dic = (NSDictionary*)datas[Data];
                       USERBaseClass *user1 = [USERBaseClass modelObjectWithDictionary:dic];
                       user1.pwd = weakSelf.pwdTF.text;
                       if (user1) {
                           
                           [[NSUserDefaults standardUserDefaults]setBool:YES forKey:ISLOGIN];
                           [[NSUserDefaults standardUserDefaults]synchronize];
                           if ([NSKeyedArchiver archiveRootObject:user1 toFile:USERINFOPATH]) {
                               [weakSelf.navigationController popViewControllerAnimated:NO];
                                [weakSelf alertWithString:@"登录成功"];
                               if (weakSelf.loginCompelete) {
                                   weakSelf.loginCompelete();
                               }
                           }
                           
                       }
                   
                   }
        else
        {
              [weakSelf alertWithString:datas[@"ErrorMessage"]];
        }
       
        
        
      
    } error:^(NSError *error,NSInteger code) {
         sender.enabled = YES;
        [weakSelf alertWithString:@"请求错误"];
    }];
    
}
- (IBAction)clearAcount:(UIButton *)sender {
    _acountTF.text =@"";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)alertWithString:(NSString *)str{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
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
