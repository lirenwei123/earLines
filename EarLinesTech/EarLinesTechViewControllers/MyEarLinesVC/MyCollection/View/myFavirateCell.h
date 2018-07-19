//
//  myFavirateCell.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/24.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavirateModel.h"
@interface myFavirateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *markBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@property (weak, nonatomic) IBOutlet UILabel *describleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;


@property(nonatomic,strong)FavirateModel *item;


@property(nonatomic,strong)void (^selectBlcok)(BOOL isSelect,NSInteger product);

+(instancetype)FavirateCell;
@end
