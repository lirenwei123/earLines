//
//  UIButtonManager.m
//  myTools
//
//  Created by apple   on 2018/6/7.
//  Copyright © 2018年 apple  . All rights reserved.
//

#import "UIButtonManager.h"


@interface UIButtonManager()
@property (strong, nonatomic)UIButton *btn;
@end
@implementation UIButtonManager

-(instancetype)initWithbtn:(UIButton *)btn{
    if (self == [super init]) {
        self.btn = btn;
    }
   
    return self;
}

-(UIButtonManager *(^)(UIView *))superView
{
    return ^(UIView *ksuperView){
        [ksuperView addSubview:self.btn];
        return self;
    };
}

-(UIButtonManager *(^)(CGRect))frame{
    return ^(CGRect kframe){
        [self.btn setFrame:kframe];
        return self;
    };
}

-(UIButtonManager *(^)(UIColor *))backGroundColor{
    return ^(UIColor *kcolor){
        [self.btn setBackgroundColor:kcolor];
        return self;
    };
}

-(UIButtonManager *(^)(CGFloat))Font{
    return ^(CGFloat kfont){
        self.btn.titleLabel.font = [UIFont systemFontOfSize:kfont];
        return self;
    };
}

-(UIButtonManager *(^)(CGFloat))blodFont{
    return ^(CGFloat kfont){
        self.btn.titleLabel.font = [UIFont boldSystemFontOfSize:kfont];
        return self;
    };
}

-(UIButtonManager *(^)(CGFloat))cornerRadius{
    return ^(CGFloat kcornerRadius){
        self.btn.layer.cornerRadius = kcornerRadius;
        return self;
    };
}

-(UIButtonManager *(^)(UIColor *))borderColor{
    return ^(UIColor *kcolor){
        self.btn.layer.borderColor = kcolor.CGColor;
        return self;
    };
}

-(UIButtonManager *(^)(CGFloat))borderWidth{
    return ^(CGFloat kborderWidth){
        self.btn.layer.borderWidth = kborderWidth;
        return self;
    };
}

-(UIButtonManager *(^)(CGPoint))center{
    return ^(CGPoint kcenter ){
        self.btn.center = kcenter;
        return self;
    };
}

-(UIButtonManager *(^)(BOOL))enlable{
    return ^(BOOL kenlable ){
        self.btn.enabled = kenlable;
        return self;
    };
}

-(UIButtonManager *(^)(BOOL))selected{
    return ^(BOOL kselected ){
        self.btn.selected = kselected;
        return self;
    };
}

- (UIButtonManager *(^)(NSString *))Title{
    return ^(NSString *title){
        [self.btn setTitle:title forState:UIControlStateNormal];
        return self;
    };
}

-(UIButtonManager *(^)(NSString *, UIControlState))stateTitle{
    return ^(NSString *title, UIControlState state){
        [self.btn setTitle:title forState:state];
        return self;
    };
}


-(UIButtonManager *(^)(UIColor *, UIControlState))TextColor{
    return ^(UIColor *color, UIControlState state){
        [self.btn setTitleColor:color forState:state];
        return self;
    };
}

-(UIButtonManager *(^)(UIImage *, UIControlState))stateImg{
    return ^(UIImage *img, UIControlState state){
        [self.btn setImage:img forState:state];
        return self;
    };
}

-(UIButtonManager *(^)(UIImage *, UIControlState))stateBackGroundImg{
    return ^(UIImage *img, UIControlState state){
        [self.btn setBackgroundImage:img forState:state];
        return self;
    };
}


@end
