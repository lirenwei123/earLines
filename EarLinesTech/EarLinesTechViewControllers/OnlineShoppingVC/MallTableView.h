//
//  MallTableView.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/20.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EWKJBaseViewController.h"

typedef NS_ENUM(NSUInteger, mallTableType) {
    mallTableType_advice,//商城首页推荐商品
    mallTableType_nearby,//商城首页附近商家
    mallTableType_baoyang,//保养建议推荐商品
    mallTableType_category,//分页获取分类商品
};

@interface MallTableView : EWKJBaseViewController
@property(nonatomic,assign)mallTableType mallType;
@property(nonatomic,assign)BOOL isNotNeedOption;
@property(nonatomic,assign)int suggestId;//保养建议推荐商品使用
@property(nonatomic,assign)int categoryId;//分类商品实使用

@end
