//
//  pubDefine.h
//  ERWENKEJI
//
//  Created by  RWLi on 2018/4/9.
//  Copyright © 2018年  RWLi. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef pubDefine_h
#define pubDefine_h



#define DEBUG_MODE
#define SD_WEBP 1

#ifdef DEBUG_MODE
#define DebugLog( s, ... ) NSLog( @"< %@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif


#define FISTAPP  @"firstApp"

#define SW [UIScreen mainScreen].bounds.size.width
#define SH [UIScreen mainScreen].bounds.size.height

#define fontsize (20)
#define FONT_S   (18)
#define FONT_M   (20)
#define FONT_L   (22)
#define FONT_XL  (24)
#define FONT_XXL (26)

#define EWKJfont_S   [UIFont systemFontOfSize:FONT_S]
#define EWKJfont_M   [UIFont systemFontOfSize:FONT_M]
#define EWKJfont_L   [UIFont systemFontOfSize:FONT_L]
#define EWKJfont_XL  [UIFont systemFontOfSize:FONT_XL]
#define EWKJfont_XXL [UIFont systemFontOfSize:FONT_XXL]
#define EWKJfont(x) [UIFont systemFontOfSize:(x)]

#define EWKJboldFont_S [UIFont boldSystemFontOfSize:FONT_S]
#define EWKJboldFont_M [UIFont boldSystemFontOfSize:FONT_M]
#define EWKJboldFont_L [UIFont boldSystemFontOfSize:FONT_L]
#define EWKJboldFont_XL [UIFont boldSystemFontOfSize:FONT_XL]
#define EWKJboldFont_XXL [UIFont boldSystemFontOfSize:FONT_XXL]
#define EWKJboldFont(x) [UIFont boldSystemFontOfSize:(x)]


#define  statusBarHeight   [UIApplication sharedApplication].statusBarFrame.size.height
#define isIphoneX (statusBarHeight>20)
#define navigationBottom   (statusBarHeight + 44)
#define bottomHeight (statusBarHeight>20?34:0)

#define WeakSelf __weak typeof(self) weakSelf = self;

#define COLOR(x) [UIColor colorWithRed:(x/256.0) green:(x/256.0) blue:(x/256.0) alpha:1]
#define RGB(x,y,z) [UIColor colorWithRed:(x/256.0) green:(y/256.0) blue:(z/256.0) alpha:1]


#define DOCPATH NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
#define USERINFOPATH [DOCPATH stringByAppendingPathComponent:@"userinfo"]

//登录状态， 在登录成功回调里赋值yes
#define ISLOGIN  @"islogin"

static float LAT;//纬度
static float LNG;//经度

static NSString * httpHead = @"http://em-webapi.zhiyunhulian.cn/api/";
static NSString *Data = @"Data";

#endif /* pubDefine_h */
