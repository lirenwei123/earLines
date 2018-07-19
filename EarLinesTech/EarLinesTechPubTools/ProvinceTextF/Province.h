//
//  Province.h
//  省市联动
//



#import <Foundation/Foundation.h>

@interface Province : NSObject
@property (copy,nonatomic) NSString * name;// 要与plist文件匹配
@property (strong,nonatomic) NSArray * cities;
+(NSArray *)provinceList;
@end
