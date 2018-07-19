//
//  myFavirateCell.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/24.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "myFavirateCell.h"
#import "UIImageView+WebCache.h"

@implementation myFavirateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_markBtn setImage:[UIImage imageNamed:@"shop_list_dit1"] forState:UIControlStateSelected];
    [_markBtn setImage:[UIImage imageNamed:@"shop_list_dit"] forState:UIControlStateNormal];
    
    _describleLab.font = EWKJfont(14);
    _describleLab.textColor = COLOR(0x33);
    
    _priceLab.font = EWKJfont(15);
    _priceLab.textColor = RGB(0xd8, 0x08, 0x02);
    
    _detailLab.font= EWKJfont(11);
    _detailLab.textColor = COLOR(0x99);
}

-(void)setItem:(FavirateModel *)item{
    _item = item;
    
    
    [_imgV sd_setImageWithURL:[NSURL URLWithString:_item.imageUrl]];
    _describleLab.text = _item.productName;
    _priceLab.text = [NSString stringWithFormat:@"￥%.2f",_item.productPrice];
    _detailLab.text = [NSString stringWithFormat:@"%.0f人收藏",_item.productId];
}

- (IBAction)markClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (_selectBlcok) {
        _selectBlcok(sender.isSelected,(NSInteger)_item.productId);
    }
}

+(instancetype)FavirateCell{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
