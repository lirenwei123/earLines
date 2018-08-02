//
//  MessageDetailCtrl.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/7/18.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "MessageDetailCtrl.h"

@interface MessageDetailCtrl ()

@end

@implementation MessageDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)addUI{
    self.navigationTitle.text = @"消息详情";
    [self addReturn];
    if (_message == nil) {
        return;
    }
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(10, navigationBottom, SW-20, SH-navigationBottom-bottomHeight)];
    [self.view addSubview:sc];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, SW-20, 20)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = _message.title;
    titleLab.font = EWKJfont(14);
    [sc addSubview:titleLab];
    
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, SW-20, 20)];
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.font = EWKJfont(10);
    timeLab.textColor = [UIColor grayColor];
    timeLab.text = _message.createDt;
    [sc addSubview:timeLab];
    
    CGFloat  h  = [_message.content boundingRectWithSize:CGSizeMake(SW-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    
    UILabel *content= [[UILabel alloc]initWithFrame:CGRectMake(0, 100, SW-20, h)];
    content.text = _message.content;
    content.numberOfLines = 0;
    content.textAlignment = NSTextAlignmentLeft;
    content.font = EWKJfont(13);
    [sc addSubview:content];
    [sc setContentSize:CGSizeMake(SW-20, h+110)];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
