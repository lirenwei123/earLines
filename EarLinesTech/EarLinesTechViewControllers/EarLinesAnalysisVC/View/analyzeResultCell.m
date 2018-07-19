//
//  analyzeResultCell.m
//  EarLinesTech
//
//  Created by apple   on 2018/4/24.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "analyzeResultCell.h"

@interface analyzeResultCell()
   

@end


@implementation analyzeResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

    -(instancetype)initWithType:(cellType)type{
        if(self == [ super init]){
            _cellType = type;
            switch (type) {
                case cellTypeScore:
                [self scoreCell];
                break;
                case cellTypeContent:
                [self contentCell];
                break;
                default:
                break;
            }
        }
        return self;
    }
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

    
    -(void)scoreCell{
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 90, 90)];
        _imgv = imgv;
        [self.contentView addSubview:_imgv];
        
        UILabel *score = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imgv.frame)+10, 20, SW-20-90-10, 20)];
        [self.contentView addSubview:score];
        score.textAlignment = NSTextAlignmentLeft;
        score.numberOfLines = 0;
        _scoreLab = score;
        
        UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(110, 55, SW-110-20-20, self.contentView.frame.size.height -CGRectGetMaxY(_scoreLab.frame)-15-5 )];
        [self.contentView addSubview:content];
        content.textAlignment = NSTextAlignmentLeft;
        content.font = EWKJfont(12);
        content.textColor = COLOR(0x33);
        content.numberOfLines = 0;
        _contentLab = content;
        
       
        
    }
    
      -(void)contentCell{
          UIButton * titleB = [[UIButton alloc]initWithFrame:CGRectMake((SW-200)/2, 20, 200, 30)];
          titleB.clipsToBounds = YES;
          titleB.layer.cornerRadius = 15;
          titleB.userInteractionEnabled = NO;
          titleB.titleLabel.font = EWKJfont(15);
          titleB.titleLabel.textColor = [UIColor whiteColor];
          titleB.backgroundColor = [UIColor clearColor];
          [titleB setBackgroundImage:[UIImage imageNamed:@"nav1_bg"] forState:0];
          [self.contentView addSubview:titleB];
          _titleBtn = titleB;
          
          UILabel * content = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, SW - 40, self.contentView.frame.size.height-CGRectGetMaxY(_titleBtn.frame)-20-10)];
          content.font = EWKJfont(12);
          content.textColor = COLOR(0x33);
          content.numberOfLines = 0;
          _contentLab = content;
          [self.contentView addSubview:_contentLab];
          
      }


-(void)setCellItem:(analyseResultViewModel *)cellItem{
       _cellItem = cellItem;
    switch (_cellType) {
        case cellTypeScore:
            _contentLab.text = cellItem.content;
            _contentLab.frame = CGRectMake(110, 55, SW-110-20,_cellItem.contentHeight);
            break;
        case cellTypeContent:
            [_titleBtn setTitle:_cellItem.title forState:0];
            _contentLab.text = cellItem.content;
            _contentLab.frame = CGRectMake(10, 70, SW - 40,_cellItem.contentHeight);
            
            break;
            
        default:
            break;
    }
  
    
}

-(void)setResultModel:(analyseResult *)resultModel{
    _resultModel = resultModel;
    
    NSString *score = [NSString stringWithFormat:@"耳朵健康评分: %.f分  %@",_resultModel.score, _resultModel.shortDescription];
    
    NSMutableAttributedString *attriScore = [[NSMutableAttributedString alloc]initWithString:score];
    [attriScore addAttribute:NSForegroundColorAttributeName value:RGB(0xd8, 7, 2) range:NSMakeRange(0, 7)];
    [attriScore addAttribute:NSFontAttributeName value:EWKJfont(15) range:NSMakeRange(0, 7)];
    [attriScore addAttribute:NSForegroundColorAttributeName value:RGB(0, 0xc9, 0x93) range:NSMakeRange(8, score.length-8)];
    [attriScore addAttribute:NSFontAttributeName value:EWKJfont(18) range:NSMakeRange(8, score.length-8)];
    _scoreLab.attributedText = attriScore;
    
   
    
    
    
}

@end
