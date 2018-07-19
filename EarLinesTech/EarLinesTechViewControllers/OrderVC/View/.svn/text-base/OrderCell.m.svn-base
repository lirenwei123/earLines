//
//  OrderCell.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/23.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "OrderCell.h"
#import "UIImageView+WebCache.h"

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _MallDes.font = EWKJboldFont(14);
    _MallDes.textColor = COLOR(0x33);
    
    _priceLab.font = EWKJfont(13);
    _priceLab.textColor = COLOR(0x33);
    
    _countLab.font = EWKJfont(12);
    _countLab.textColor = COLOR(0x33);
}

+(instancetype)mallCell{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}


-(void)setMallCartItem:(CartItem *)mallCartItem{
    _mallCartItem = mallCartItem;
    [_imgV sd_setImageWithURL:[NSURL URLWithString:_mallCartItem.imageUrl]];
    _MallDes.text = _mallCartItem.productName;
    _priceLab.text = [NSString stringWithFormat:@"￥%.2f",_mallCartItem.price];
    _countLab.text = [NSString stringWithFormat:@"x%.0f",_mallCartItem.qty];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
