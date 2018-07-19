//
//  EWKJOrderCell.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/5.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EWKJOrderCell.h"
#import "UIImageView+WebCache.h"

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
    self.contentView.backgroundColor = COLOR(243);
}

-(void)setItem:(CartItem *)item{
    _item = item;
    
    [_imgV  sd_setImageWithURL:[NSURL URLWithString:_item.imageUrl]];
    _describleLab.text = _item.productName;
    _countLab.text = [NSString stringWithFormat:@"x%.0f",_item.qty];
   
    //待确认
//    cell.wuliuLab.text = @"买家已付款";
 
    
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%.2f",_item.price]];
    [attr addAttribute:NSFontAttributeName value:EWKJfont(11) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:EWKJfont(13) range:NSMakeRange(1, attr.length-1)];
    _priceLab.attributedText = attr;
}

+(instancetype)orderCell{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
