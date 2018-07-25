//
//  analyseResultViewModel.m
//  EarLinesTech
//
//  Created by apple   on 2018/4/25.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "analyseResultViewModel.h"

@implementation analyseResultViewModel

- (instancetype)initWithScoreWith:(NSString *)content
{
    self = [super init];
    if (self) {
        _content =  content;
            //适配高度
      
      
                
        
                _contentHeight = [_content boundingRectWithSize:CGSizeMake(SW-130, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:EWKJfont(12)} context:nil].size.height;
                _cellHeight  =   _contentHeight + 55+150;
        
    }
    return self;
}


- (instancetype)initWithContentWith:(Items *)item
{
    self = [super init];
    if (self) {
        _title = item.subject;
        _content = [NSString stringWithFormat:@"\t%@",item.body];
        _ImgUrl = item.imageUrl;
            //适配高度
     
                _contentHeight = [_content boundingRectWithSize:CGSizeMake(SW-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:EWKJfont(12)} context:nil].size.height;
                _cellHeight  =   _contentHeight + 30+30+300;
        
    }
    return self;
}
@end
