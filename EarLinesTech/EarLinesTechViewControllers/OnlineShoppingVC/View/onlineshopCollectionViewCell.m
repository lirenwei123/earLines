//
//  onlineshopCollectionViewCell.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/18.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "onlineshopCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation onlineshopCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cell{
    return [[NSBundle mainBundle]
            loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    
}

- (IBAction)add:(UIButton *)sender {
    if (_addBlock) {
        _addBlock(_item);
    }
}

-(void)setItem:(Products *)item{
    _item = item;
    [_topIMGV sd_setImageWithURL:[NSURL URLWithString:_item.imageUrl]];
//    [_topIMGV sd_setImageWithURL:[NSURL URLWithString:_item.imageUrl] placeholderImage:[UIImage imageNamed:@"index_btn"]];
    _topIMGV.contentMode = UIViewContentModeScaleAspectFit;
    _contentLab.text = _item.productName;
    _priceLab.text =  [NSString stringWithFormat:@"￥ %.2f",_item.productPrice];
    
    _contentLab.font = EWKJboldFont(12);
    _priceLab.font = EWKJboldFont(16);
    _priceLab.textColor = RGB(0xfe, 0x07, 00);
}

-(void)setAddBlock:(void (^)(Products *))addBlock{
    _addBlock = addBlock;
}

@end
