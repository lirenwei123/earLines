//
//  UILabel+lrwLab.m
//  myTools
//
//  Created by apple   on 2018/5/24.
//  Copyright © 2018年 apple  . All rights reserved.
//

#import "UILabel+lrwLab.h"


@implementation UILabel (lrwLab)

+(instancetype)lrw_setLab:(void (^)(UILableManager *))block{
   UILabel *lab = [[UILabel alloc]init];
    [lab lrw_setLab:block];
    return lab;
}

-(void)lrw_setLab:(void (^)(UILableManager *m))block
{
    UILableManager *manager = [[UILableManager alloc]initWthLab:self];
    block(manager);
}

@end
