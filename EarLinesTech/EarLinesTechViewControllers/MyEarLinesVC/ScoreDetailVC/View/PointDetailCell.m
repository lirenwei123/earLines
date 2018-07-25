//
//  PointDetailCell.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/6/10.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "PointDetailCell.h"

@interface PointDetailCell()
@property(nonatomic,copy)NSMutableAttributedString *payOut;
@property(nonatomic,copy)NSMutableAttributedString *payIn;
@end

@implementation PointDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _line.backgroundColor = COLOR(222);
    _scoreLab.font = EWKJfont(12);
    _scoreLab.textColor = [UIColor blackColor];
    _typeLab.font = EWKJfont(12);
    _typeLab.textColor= COLOR(153);
    _timeLab.font = EWKJfont(10);
    _timeLab.textColor= COLOR(153);
    _seperateLine.backgroundColor = COLOR(240);
    
    NSString *str1 = @"类型: 收入";
    NSString *str2 = @"类型: 支出";
    _payIn  = [[NSMutableAttributedString alloc]initWithString:str1];
    [_payIn addAttributes:@{NSForegroundColorAttributeName:COLOR(153)} range:NSMakeRange(0, 3)];
    [_payIn addAttributes:@{NSForegroundColorAttributeName:RGB(255, 114, 0)} range:NSMakeRange(3, str1.length - 3)];
    _payOut = [[NSMutableAttributedString alloc]initWithString:str2];
    [_payOut addAttributes:@{NSForegroundColorAttributeName:COLOR(153)} range:NSMakeRange(0, 3)];
    [_payOut addAttributes:@{NSForegroundColorAttributeName:RGB(0, 156, 40)} range:NSMakeRange(3, str2.length - 3)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(ScoreModel *)item{
    _item = item;
    NSString *score = [NSString stringWithFormat:@"积分数量: %d",_item.points];
    NSMutableAttributedString *attr1 =[[NSMutableAttributedString alloc]initWithString:score];
    [attr1 addAttributes:@{NSForegroundColorAttributeName:COLOR(153)} range:NSMakeRange(0, 5)];
    _scoreLab.attributedText = attr1;
    
    _typeLab.attributedText = _item.type==1 ?_payOut:_payIn;
    _timeLab.text = _item.createDt;
    
}

@end
