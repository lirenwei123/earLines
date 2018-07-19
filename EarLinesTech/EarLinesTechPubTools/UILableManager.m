//
//  UILableManager.m
//  myTools
//
//  Created by apple   on 2018/5/24.
//  Copyright © 2018年 apple  . All rights reserved.
//

#import "UILableManager.h"

@interface UILableManager()
@property(nonatomic,strong)UILabel *lable;
@end

@implementation UILableManager

-(instancetype)initWthLab:(UILabel *)lab{
    if (self == [super init]) {
        self.lable = lab;
    }
    return self;
    
  
}


-(UILableManager *(^)(CGRect))frame{
    return ^(CGRect kframe){
        self.lable.frame = kframe;
        return self;
    };
}


-(UILableManager *(^)(UIColor *))backGroundColor{
    return ^(UIColor *kcolor){
        self.lable.backgroundColor = kcolor;
        return self;
    };
}


-(UILableManager *(^)(CGFloat))Font{
    return ^(CGFloat kfont){
        self.lable.font = [UIFont systemFontOfSize:kfont];
        return self;
    };
}


-(UILableManager *(^)(CGFloat))blodFont{
    return ^(CGFloat kfont){
        self.lable.font = [UIFont boldSystemFontOfSize:kfont];
        return self;
    };
}

-(UILableManager *(^)(NSString *))Text{
    return ^(NSString *ktext ){
        self.lable.text = ktext;
        return self;
    };
}

-(UILableManager *(^)(NSMutableAttributedString *))AttText{
    return ^(NSMutableAttributedString *ktext ){
        self.lable.attributedText = ktext;
        return self;
    };
}

-(UILableManager *(^)(UIColor *))TextColor{
    return ^(UIColor *ktextcolor ){
        self.lable.textColor = ktextcolor;
        return self;
    };
}

-(UILableManager *(^)(NSTextAlignment))TextAlignment{
    return ^(NSTextAlignment kaligin ){
        self.lable.textAlignment = kaligin;
        return self;
    };
}

-(UILableManager *(^)(NSInteger))NumberOfLines{
    return ^(NSInteger Lines ){
        self.lable.numberOfLines = Lines;
        return self;
    };
}

-(UILableManager *(^)(CGPoint))center{
    return ^(CGPoint kcenter ){
        self.lable.center = kcenter;
        return self;
    };
}

-(UILableManager *(^)(void))sizeTofit{
    return ^{
        [self.lable sizeToFit];
        return self;
    };
}

-(UILableManager *(^)(UIView *))superView{
    return ^(UIView *ksuperView){
        [ksuperView addSubview:self.lable];
        return self;
    };
}

@end
