//
//  addressCell.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/24.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addressModel.h"

@interface addressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *contactPhone;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UIButton *markflag;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) IBOutlet UILabel *mrdz;

@property(nonatomic,strong)addressModel *item;

@property(nonatomic,strong)void(^deleteAddressBlock)(addressModel *address);
@property(nonatomic,strong)void(^editAddressBlock)(addressModel *address);
@property(nonatomic,strong)void(^defaultAddressIndBlock)(BOOL defaultId);

+(instancetype)addressCell;

+(instancetype)mannageAdressCell;





@end
