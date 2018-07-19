//
//  HomePageViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/14.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImgV;
@property (weak, nonatomic) IBOutlet UILabel *bottomLab;
@property (weak, nonatomic) IBOutlet UIButton *ewkjBtn;
@property (weak, nonatomic) IBOutlet UIButton *myEwBtn;
@property (weak, nonatomic) IBOutlet UIButton *ewlinesAnasize;

@property (weak, nonatomic) IBOutlet UIButton *onlineShopBtn;

@property (weak, nonatomic) IBOutlet UILabel *topLogoLab;
@property (weak, nonatomic) IBOutlet UIImageView *toplogImgv;
@property (weak, nonatomic) IBOutlet UIImageView *earImgv;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMagrgin;

@end

@implementation HomePageViewController


- (IBAction)click:(UIButton *)sender {
    NSArray *classArray = @[@"EarLinesAnalysisViewController",@"OnlineShoppingViewController",@"EarLinesTechnologyViewController",@"PersonalCenterCtrl"].copy;
    NSInteger index = sender.tag -100;
    if (index < classArray.count) {
        Class class = NSClassFromString(classArray[index]);
        if (class) {
            UIViewController *vc = [[class alloc]init];
            vc.title = sender.titleLabel.text;
            if (index!=1) {
                EWKJBaseViewController *ctrl = (EWKJBaseViewController*)vc;
                ctrl.isNeedLogin = YES;
            }
            [self.navigationController pushViewController:vc animated:NO];
        }
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self removeReturn];
    self.navigationTitle.text = @"耳纹科技分析";
    _topMargin.constant = navigationBottom;
    _bottomMagrgin.constant = bottomHeight +20;
    
  
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if( [[NSUserDefaults standardUserDefaults]boolForKey:ISLOGIN]){
            NSString *account= [USERBaseClass user].account;
            __block  NSString *pwd = [USERBaseClass user].pwd;
            
            if (account.length && pwd.length ) {
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:account,@"Account",pwd,@"Password", nil];
                [[EWKJRequest request]requestWithAPIId:user1 httphead:nil bodyParaDic:dict completed:^(id datas) {
                    
                    if (datas) {
                        //更新token
                        NSDictionary *dic = (NSDictionary*)datas[Data];
                        USERBaseClass *user = [USERBaseClass user];
                        user.token = dic[@"Token"];
                        if (user) {
                            [NSKeyedArchiver archiveRootObject:user toFile:USERINFOPATH];
                        }
                    }
                    
                } error:^(NSError *error) {
                    
                    if (error) {
                        [self alertWithString:[NSString stringWithFormat:@"%@",error]];
                    }
                }];
                
            }
        }
    });
    
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
