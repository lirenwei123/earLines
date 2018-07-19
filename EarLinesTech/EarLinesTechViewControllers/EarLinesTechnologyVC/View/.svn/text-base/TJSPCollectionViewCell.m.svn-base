//
//  TJSPCollectionViewCell.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/4/23.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "TJSPCollectionViewCell.h"


@interface TJSPCollectionViewCell()
@property(nonatomic,strong)UIImageView *imgv;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *priceLab;

@end

@implementation TJSPCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)];
        [self.contentView addSubview:imgv];
        _imgv = imgv;
        
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(_imgv.frame), frame.size.width-8*2, frame.size.height/4)];
        [self.contentView addSubview:titleLab];
        _titleLab = titleLab;
        
        UILabel *priceLab = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(_titleLab.frame), frame.size.width-8*2, frame.size.height - CGRectGetMaxY(_titleLab.frame) -10)];
        [self.contentView addSubview:priceLab];
        _priceLab = priceLab;
        
        
        
    }
    return self;
}

@end
