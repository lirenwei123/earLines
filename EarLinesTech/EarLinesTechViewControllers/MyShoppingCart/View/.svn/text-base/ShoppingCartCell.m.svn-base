//
//  ShoppingCartCell.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/9.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "UIImageView+WebCache.h"
#import "EWKJRequest.h"


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
    
   
}

- (IBAction)stateClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (_selectBlcok) {
        _selectBlcok(sender.isSelected,_item);
    }
}

- (IBAction)add:(UIButton *)sender {
    _count++;
    _item.qty = _count;
     [self setCountAndMoney];
    
}
- (IBAction)sub:(UIButton *)sender {
    if (_count !=0) {
        _count--;
        _item.qty = _count;
        [self setCountAndMoney];
       
    }
}

-(void)requestCount{
    WeakSelf
    [[EWKJRequest request]requestWithAPIId:cart3 httphead:nil bodyParaDic:@{@"CartItemId":@((int)_item.cartItemId),@"Qty":@((int)_item.qty)}.mutableCopy completed:^(id datas) {
        if (weakSelf.countBlcok) {
            weakSelf.countBlcok((int)weakSelf.count,weakSelf.item);
        }
    } error:^(NSError *error, NSInteger statusCode) {
        
    }];
}

-(void)setItem:(CartItem *)item{
    _item = item;
    [_imgv sd_setImageWithURL:[NSURL URLWithString:_item.imageUrl]];
    _describleLab.text = _item.productName;
    
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%.2f",_item.price*_item.qty]];
    [attr addAttribute:NSFontAttributeName value:EWKJfont(11) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:EWKJfont(13) range:NSMakeRange(1, attr.length-1)];
   _priceLab.attributedText = attr;
    _countLab.text = [NSString stringWithFormat:@"%.0f",_item.qty];
    _count = (NSInteger)_item.qty;
    _price = _item.price;
    _markBtn.selected = _item.selected;
}


-(void)setCountAndMoney{
    _countLab.text = [NSString stringWithFormat:@"%d",(int)_count];
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%.2f",_price*_count]];
    [attr addAttribute:NSFontAttributeName value:EWKJfont(11) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:EWKJfont(13) range:NSMakeRange(1, attr.length-1)];
    _priceLab.attributedText = attr;
    [self requestCount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
