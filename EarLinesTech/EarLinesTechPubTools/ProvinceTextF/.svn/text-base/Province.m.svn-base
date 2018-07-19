//
//  Province.m
//  省市联动


#import "Province.h"

@implementation Province

-(instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(instancetype)provinceWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}
+(NSArray *)provinceList {
    // 获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"provinces" ofType:@"plist"];
    // 文件转数组(数组中每个元素是字典)
    NSArray *dicArr = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *tempArr = [NSMutableArray array];
    // 字典转对象
    for (NSDictionary *dic in dicArr) {
        Province *pro = [Province provinceWithDic:dic];
        [tempArr addObject:pro];
    }
    return tempArr;
}
@end
