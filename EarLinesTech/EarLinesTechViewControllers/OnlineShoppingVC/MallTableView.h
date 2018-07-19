//
//  MallTableView.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/20.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EWKJBaseViewController.h"

typedef NS_ENUM(NSUInteger, mallTableType) {
    mallTableType_advice,
    mallTableType_nearby,
};

@interface MallTableView : EWKJBaseViewController
@property(nonatomic,assign)mallTableType mallType;


@end
