//
//  AddressViewController.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/24.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EWKJBaseViewController.h"


typedef NS_ENUM(NSUInteger, adressFlag) {
    adressFlag_select,
    adressFlag_manage,
   
};

@interface AddressViewController : EWKJBaseViewController

@property(nonatomic,assign)adressFlag type;
@property(nonatomic,assign)BOOL isPersonnalPageInto;
@end
