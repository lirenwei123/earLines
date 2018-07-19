//
//  ShoppingCartCell.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/9.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "ShoppingCartCell.h"


@implementation ShoppingCartCell


+(instancetype)cartCell{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil
                                      options:nil].firstObject;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imgv.clipsToBounds = YES;
    _imgv.layer.cornerRadius = 3;
    
    [_markBtn setImage:[UIImage imageNamed:@"shop_list_dit1"] forState:UIControlStateSelected];
    [_markBtn setImage:[UIImage imageNamed:@"shop_list_dit"] forState:UIControlStateNormal];
   
    _describleLab.textColor = COLOR(0x33);
    _describleLab.font = EWKJfont(14);
    
    _priceLab.textColor = COLOR(0x66);
    
    _countAdd.layer.borderColor = COLOR(0xde).CGColor;
    _countLab.layer.borderColor = COLOR(0xde).CGColor;
    _countSub.layer.borderColor = COLOR(0xde).CGColor;
    _countAdd.layer.borderWidth = 1;
    _countLab.layer.borderWidth = 1;
    _countSub.layer.borderWidth = 1;
    
    _countLab.textColor = COLOR(0x33);
    _countLab.font = EWKJfont(12);
    
    _count = 6;
    _price = 159.0;
}

- (IBAction)stateClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (IBAction)add:(UIButton *)sender {
    _count++;
     [self setCountAndMoney];
}
- (IBAction)sub:(UIButton *)sender {
    _count--;
    if (_count < 0) {
        
    }else{
        [self setCountAndMoney];
       
    }
}



-(void)setCountAndMoney{
    _countLab.text = [NSString stringWithFormat:@"%d",(int)_count];
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%.2f",_price*_count]];
    [attr addAttribute:NSFontAttributeName value:EWKJfont(11) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:EWKJfont(13) range:NSMakeRange(1, attr.length-1)];
    _priceLab.attributedText = attr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
