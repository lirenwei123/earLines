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




@interface EWKJBaseViewController : UIViewController
@property(nonatomic ,assign)BOOL isNeedLogin;

@property (nonatomic, strong) UIImageView *navigationBar ;
@property (nonatomic, strong) UILabel *navigationTitle ;
@property (nonatomic, strong) UIButton *rightNaviBtn ;

-(void)addUI;
-(void)addReturn;
-(void)returnCLick;
-(void)removeReturn;

-(void)addRightBtnWithIMGname:(NSString *)imgName;
-(void)rightNavitemCLick;

-(void)alertWithString:(NSString *)str;

-(void)searchRequestWith:(NSString *)searchText complete:(successBlock)completeBlock fail:(failureBlock)failBlock;// 搜索

@end
