//
//  PayViewController.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/23.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EWKJBaseViewController.h"

typedef NS_ENUM(int, PaymentMethod) {
    PaymentMethod_noSelect = -1,
    PaymentMethod_free =0,
    PaymentMethod_score,
    PaymentMethod_wx,
    PaymentMethod_ali
};//付款方式 0：免费的订单 1：积分支付 2: 微信支付 3：支付宝支付

@interface PayViewController : EWKJBaseViewController

@property(nonatomic,copy)NSString *notes;
@property(nonatomic,assign)PaymentMethod PaymentMethod; 
@property(nonatomic,assign)int AddressId;
@property(nonatomic,assign)int orderId;//未支付订单

@property(nonatomic,assign)CGFloat money;
@end
