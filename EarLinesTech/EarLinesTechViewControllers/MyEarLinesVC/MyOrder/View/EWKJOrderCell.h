//
//  EWKJOrderCell.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/5.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EWKJOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *describleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@property (weak, nonatomic) IBOutlet UILabel *wuliuLab;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;

+(instancetype)orderCell;

@end
