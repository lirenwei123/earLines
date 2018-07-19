//
//  UILableManager.h
//  myTools
//
//  Created by apple   on 2018/5/24.
//  Copyright © 2018年 apple  . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UILableManager : NSObject


-(instancetype)initWthLab:(UILabel*)lab;

    
-(UILableManager* (^)(CGRect rect))frame;
-(UILableManager* (^)(UIColor* color))backGroundColor;
-(UILableManager* (^)(CGFloat font))Font;
-(UILableManager* (^)(CGFloat font))blodFont;
-(UILableManager* (^)(NSString* text))Text;
-(UILableManager* (^)(NSMutableAttributedString * attr))AttText;
-(UILableManager* (^)(UIColor* color))TextColor;
-(UILableManager* (^)(NSTextAlignment alig))TextAlignment;
-(UILableManager* (^)(NSInteger lines))NumberOfLines;
-(UILableManager* (^)(CGPoint center))center;
-(UILableManager* (^)(void))sizeTofit;

-(UILableManager* (^)(UIView *superView))superView;

    
    

    

@end
