//
//  MyOrderCtrl.h
//  EarLinesTech
//
//  Created by apple   on 2018/4/20.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EWKJBaseViewController.h"


typedef NS_ENUM(NSUInteger, OrderState) {
    OrderState_all,
    OrderState_waitPay,
    OrderState_waitPost,
    OrderState_waitRec,
    OrderState_end,
    OrderState_tuiHuan,
};//    所有 = 0, 未付款 = 1, 待发货 = 2, 待收货 = 3, 完成 = 4, 退款 = 5

@interface MyOrderCtrl : EWKJBaseViewController

    @property(nonatomic,assign)OrderState orderState;
    
@end
