//
//  pwdCtrl.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/4/17.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EWKJBaseViewController.h"

typedef NS_ENUM(NSUInteger, PWDTYPE) {
    PWDTYPE_REGIST = 100,
    PWDTYPE_FORGETPWD,
    PWDTYPE_MODIFYPWD,
};

@interface pwdCtrl : EWKJBaseViewController
@property(nonatomic,assign)PWDTYPE pwdType;
@end
