//
//  selectHeadPhotoCtrl.h
//  EarLinesTech
//
//  Created by apple   on 2018/4/19.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EWKJBaseViewController.h"

@interface selectHeadPhotoCtrl : EWKJBaseViewController

-(instancetype)initWithimg:(UIImage *)head complechangeHead:(void(^)(UIImage *img))comleteChangeHead;
@end
