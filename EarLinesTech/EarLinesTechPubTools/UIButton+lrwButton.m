//
//  UIButton+lrwButton.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/6/7.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "UIButton+lrwButton.h"

@implementation UIButton (lrwButton)

+(instancetype)lrw_setBtn:(void (^)(UIButtonManager *))block{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn lrw_setBtn:block];
    return btn;
}

-(void)lrw_setBtn:(void (^)(UIButtonManager *))block{
    UIButtonManager *manager = [[UIButtonManager alloc]initWithbtn:self];
    block(manager);
}

@end
