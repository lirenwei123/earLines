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
        _content =  [NSString stringWithFormat:@"        %@",content];
            //适配高度
      
      
                
        
                _contentHeight = [_content boundingRectWithSize:CGSizeMake(SW-130, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:EWKJfont(12)} context:nil].size.height;
                _cellHeight  =   _contentHeight + 55;
                if (_cellHeight<110) {
                    _cellHeight = 110;
                }
    }
    return self;
}


- (instancetype)initWithContentWith:(Items *)item
{
    self = [super init];
    if (self) {
        _title = item.subject;
        _content = [NSString stringWithFormat:@"        %@",item.body];
            //适配高度
     
                _contentHeight = [_content boundingRectWithSize:CGSizeMake(SW-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:EWKJfont(12)} context:nil].size.height;
                _cellHeight  =   _contentHeight + 70+20;
        
    }
    return self;
}
@end
