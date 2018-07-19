//
//  onlineshopCollectionViewCell.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/18.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Products.h"

@interface onlineshopCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *topIMGV;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property(nonatomic,strong)Products *item;
@property(nonatomic,strong)void (^addBlock)(Products *item);

+(instancetype)cell;

@end
