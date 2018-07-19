//
//  EWKJOrderCell.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/5.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EWKJOrderCell.h"

@implementation EWKJOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imgV.clipsToBounds = YES;
    _imgV.layer.cornerRadius= 3;
    _describleLab.font = EWKJfont(14);
    _describleLab.textColor = COLOR(0x33);
    _describleLab.textAlignment =  NSTextAlignmentLeft;
    _wuliuLab.font = EWKJfont(11);
    _wuliuLab.textColor = RGB(0xec, 0x3c, 0x1a);
    _wuliuLab.textAlignment = NSTextAlignmentLeft;
    _priceLab.textColor = COLOR(0x66);
    _priceLab.textAlignment = NSTextAlignmentRight;
    _countLab.textColor = COLOR(0x66);
    _countLab.font = EWKJfont(12);
    _countLab.textAlignment = NSTextAlignmentRight;
    
    
}

+(instancetype)orderCell{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
