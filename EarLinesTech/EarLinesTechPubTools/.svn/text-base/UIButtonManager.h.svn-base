//
//  UIButtonManager.h
//  myTools
//
//  Created by apple   on 2018/6/7.
//  Copyright © 2018年 apple  . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButtonManager : NSObject

-(instancetype)initWithbtn:(UIButton*)btn;


-(UIButtonManager* (^)(CGRect rect))frame;
-(UIButtonManager* (^)(UIColor* color))backGroundColor;
-(UIButtonManager* (^)(CGFloat font))Font;
-(UIButtonManager* (^)(CGFloat font))blodFont;
-(UIButtonManager* (^)(CGFloat cornerRadius))cornerRadius;
-(UIButtonManager* (^)(UIColor *borderColor))borderColor;
-(UIButtonManager* (^)(CGFloat borderWidth))borderWidth;
-(UIButtonManager* (^)(CGPoint center))center;
-(UIButtonManager* (^)(BOOL yn))enlable;
-(UIButtonManager* (^)(BOOL yn))selected;
-(UIButtonManager* (^)(NSString* text))Title;

-(UIButtonManager* (^)(NSString* text,UIControlState state))stateTitle;
-(UIButtonManager* (^)(UIColor* color,UIControlState state))TextColor;
-(UIButtonManager* (^)(UIImage *img,UIControlState state))stateImg;
-(UIButtonManager* (^)(UIImage *img,UIControlState state))stateBackGroundImg;


-(UIButtonManager* (^)(UIView *superView))superView;



@end
