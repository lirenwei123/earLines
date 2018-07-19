//
//  AddAddressViewController.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/24.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EWKJBaseViewController.h"
#import "addressModel.h"

@interface AddAddressViewController : EWKJBaseViewController
@property(nonatomic,strong)addressModel *address;
@property(nonatomic,assign)BOOL edit;
@end
