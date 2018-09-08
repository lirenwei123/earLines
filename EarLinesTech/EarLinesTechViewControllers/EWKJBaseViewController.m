//
//  EWKJBaseViewController.m
//  ERWENKEJI
//
//  Created by  RWLi on 2018/4/10.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EWKJBaseViewController.h"




@interface EWKJBaseViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)alertBlcok alertSureBlock;
@end

@implementation EWKJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _navigationBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SW , navigationBottom)] ;
    _navigationBar.image = [UIImage imageNamed:@"Head_portrait_bg"];
    _navigationBar.userInteractionEnabled = YES ;
    [self.view addSubview:_navigationBar] ;
    
    _navigationTitle = [[UILabel alloc] initWithFrame:CGRectMake((SW-200)*0.5, statusBarHeight, 200, 44)] ;
    _navigationTitle.textAlignment = NSTextAlignmentCenter ;
    _navigationTitle.adjustsFontSizeToFitWidth = YES ;
    _navigationTitle.textColor = [UIColor whiteColor] ;
    _navigationTitle.font = EWKJboldFont(16);
    [_navigationBar addSubview:_navigationTitle] ;
     [self addReturn];
    
    
    [self addUI];
}

-(void)addUI{
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)addReturn{
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, statusBarHeight+12, 22, 22)];
    image1.userInteractionEnabled = YES;
    image1.backgroundColor = [UIColor clearColor];
    image1.image = [UIImage imageNamed:@"nav_back"];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, statusBarHeight+5, 62, 35);
    [backBtn addTarget: self action:@selector(returnCLick) forControlEvents:UIControlEventTouchUpInside];
    
    image1.tag = 10;
    backBtn.tag = 20;
    
    [_navigationBar addSubview:image1];
    [_navigationBar addSubview:backBtn];

 
    
}
-(void)removeReturn{
    [[_navigationBar viewWithTag:10]removeFromSuperview];
    [[_navigationBar viewWithTag:20]removeFromSuperview];
}

-(void)returnCLick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addRightBtnWithIMGname:(NSString *)imgName{
  
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(SW-10-22, statusBarHeight+12, 22, 22)];
    [backBtn addTarget: self action:@selector(rightNavitemCLick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    _rightNaviBtn = backBtn;
 
    [_navigationBar addSubview:backBtn];

    
}
-(void)addRightBtnWithtitle:(NSString *)title{
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(SW-10-80, statusBarHeight+12, 80, 22)];
    [backBtn addTarget: self action:@selector(rightNavitemCLick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:title forState:UIControlStateNormal];
    backBtn.titleLabel.font = EWKJfont(13);
    backBtn.backgroundColor = [UIColor clearColor];
    _rightNaviBtn = backBtn;
    
    [_navigationBar addSubview:backBtn];
    
    
}

-(void)rightNavitemCLick{
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)close{
    [self.navigationController popViewControllerAnimated:NO];
}

    
- (void)alertWithString:(NSString *)str{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
}




-(void)searchRequestWith:(NSString *)searchText complete:(successBlock)completeBlock   fail:(failureBlockCode)failBlock{
    [SVProgressHUD showWithStatus:@"正在努力搜索中..."];
    //        api/mall/search/proucts?//搜索商品
//    product/search/merchant/proucts? 搜索商家商品
  WeakSelf
    NSString * url =[NSString stringWithFormat:@"%@product/search/merchant/proucts?name=%@&pageSize=10&pageIndex=1",httpHead,searchText];
 
    //需要把中文编码
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [HttpRequest lrw_getWithURLString:url parameters:nil success:^(id responseObject) {
         [SVProgressHUD dismiss];
        if (responseObject) {
            NSArray *datas = responseObject[Data];
            if (datas) {
                if (completeBlock) {
                    completeBlock(datas);
                }
            }
        }
    } failure:^(NSError *error,NSInteger code) {
         [SVProgressHUD dismiss];
        [weakSelf TipWithErrorCode:code];
    }];
   
    
}

-(void)TipWithErrorCode:(NSInteger)errorCode{
    if (errorCode == 401) {
        if (![self.navigationController.topViewController isKindOfClass:[LoginViewController class]]) {
            [self alertWithString:@"登录已过期，请重新登录账号"];
            LoginViewController *logvc = [[LoginViewController alloc]init];
            logvc.loginCompelete = ^{
                [self.navigationController popViewControllerAnimated:NO];
            };
            [self.navigationController pushViewController:logvc animated:NO];
        }
    }else{
        
//        [self alertWithString:[NSString stringWithFormat:@"errorcode = %ld",(long)errorCode]];
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
