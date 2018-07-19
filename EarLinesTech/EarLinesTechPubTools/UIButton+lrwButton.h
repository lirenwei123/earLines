//
//  UIButton+lrwButton.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/6/7.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButtonManager.h"

@interface UIButton (lrwButton)

+(instancetype)lrw_setBtn:(void(^)(UIButtonManager *manager))block;

-(void)lrw_setBtn:(void(^)(UIButtonManager *manager))block;

@end
