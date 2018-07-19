//
//  addressCell.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/24.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "addressCell.h"
#import "AddAddressViewController.h"

@implementation addressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _nameLab.font = EWKJfont(13);
    _nameLab.textColor = COLOR(0x33);
    
    _contactPhone.font = EWKJfont(13);
    _contactPhone.textColor = COLOR(0x33);
    
    _address.font = EWKJfont(13);
    _address.textColor = COLOR(0x33);
    
    if (_mrdz) {
        _mrdz.font = EWKJfont(13);
        _mrdz.textColor = COLOR(0x99);
    }
    if (_markflag) {
        _markflag.layer.cornerRadius  = 10;
        _markflag.clipsToBounds = YES;
        [_markflag setImage:[UIImage imageNamed:@"shop_list_dit"] forState:UIControlStateNormal];
        [_markflag setImage:[UIImage imageNamed:@"shop_list_dit1"] forState:UIControlStateSelected];
    }
    if (_editBtn) {
        _editBtn.titleLabel.font = EWKJfont(13);
        [_editBtn setTitleColor:COLOR(0x99) forState:0];
    }
    if (_deleteBtn) {
        _deleteBtn.titleLabel.font =EWKJfont(13);
       [_deleteBtn setTitleColor:COLOR(0x99) forState:0];
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)addressCell{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}
+(instancetype)mannageAdressCell{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

-(void)setItem:(addressModel *)item{
    _item =item;
    _nameLab.text = _item.consigneeName;
    _contactPhone.text = _item.markedPhoneNumber;
    
    NSString *addresname = _item.addressFullName.length>0?_item.addressFullName:_item.address1;
   
    
    if (_item.defaultAddressInd) {
        
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"[默认地址]%@",addresname] attributes:@{NSFontAttributeName:EWKJfont(13),NSForegroundColorAttributeName:COLOR(0x33)}];
        [attr addAttributes:@{NSFontAttributeName:EWKJfont(11),NSForegroundColorAttributeName:RGB(0xec, 0x3c, 0x1a)} range:NSMakeRange(0, 6)];
        _address.attributedText = attr;
        
        if (_markflag) {
            _markflag.selected = YES;
        }
        
    }else{
        _address.text = [NSString stringWithFormat:@"%@",addresname];
    }
    
    
    
}

- (IBAction)editAdress:(UIButton *)sender {
    
    if (_editAddressBlock) {
        _editAddressBlock(_item);
    }
}
- (IBAction)deleteAdress:(UIButton *)sender {
    if (_deleteAddressBlock) {
        _deleteAddressBlock(_item);
    }
}
- (IBAction)markTouch:(UIButton *)sender {
    if (sender.isSelected == NO) {
        sender.selected = YES;
        if (_defaultAddressIndBlock) {
            _defaultAddressIndBlock(sender.isSelected);
        }
    }
   
}



@end
