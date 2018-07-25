//
//  merchantCell.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/10.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "nearMerchant.h"

@interface merchantCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgv;
@property (weak, nonatomic) IBOutlet UILabel *describleLab;

@property (weak, nonatomic) IBOutlet UILabel *adressLab;

@property(nonatomic,strong)nearMerchant *item;





+(instancetype)cell;
@end
