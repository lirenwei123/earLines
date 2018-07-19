//
//  ShoppingCartCell.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/9.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartItem.h"

@interface ShoppingCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *markBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgv;
@property (weak, nonatomic) IBOutlet UILabel *describleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIButton *countAdd;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIButton *countSub;

@property(nonatomic,assign)NSInteger count;
@property(nonatomic,assign)CGFloat price;


@property(nonatomic,strong)CartItem *item;

@property(nonatomic,strong)void (^selectBlcok)(BOOL isSelect,CartItem *Item);
@property(nonatomic,strong)void (^countBlcok)(int count,CartItem *Item);

+(instancetype)cartCell;

@end
