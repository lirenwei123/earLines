//
//  EWKJBaseViewController.h
//  ERWENKEJI
//
//  Created by  RWLi on 2018/4/10.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWKJBtn.h"
#import "EWKJRequest.h"
//#import "MBProgressHUD.h"
#import "SVProgressHUD.h"
#import "USERBaseClass.h"
#import "LoginViewController.h"


typedef void(^alertBlcok)(void);


@interface EWKJBaseViewController : UIViewController


@property (nonatomic, strong) UIImageView *navigationBar ;
@property (nonatomic, strong) UILabel *navigationTitle ;
@property (nonatomic, strong) UIButton *rightNaviBtn ;

-(void)addUI;
-(void)addReturn;
-(void)returnCLick;
-(void)removeReturn;

-(void)addRightBtnWithIMGname:(NSString *)imgName;
-(void)addRightBtnWithtitle:(NSString *)title;
-(void)rightNavitemCLick;

-(void)alertWithString:(NSString *)str;
- (void)testAlertWithString:(NSString *)str block:(alertBlcok)block;

-(void)searchRequestWith:(NSString *)searchText complete:(successBlock)completeBlock fail:(failureBlockCode)failBlock;// 搜索

-(void)TipWithErrorCode:(NSInteger)errorCode;

@end
