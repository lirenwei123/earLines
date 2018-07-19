//
//  OrderCell.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/23.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartItem.h"

@interface OrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *MallDes;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@property(nonatomic,strong)CartItem *mallCartItem;

+(instancetype)mallCell;


@end
