//
//  ADViewContrller.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/26.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "ADViewContrller.h"

@interface ADViewContrller ()
@property(nonatomic,strong)UIScrollView *adSC;
@end

@implementation ADViewContrller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   _adSC =[[UIScrollView alloc]initWithFrame:self.view.bounds];
    NSArray *imgNames = @[@"index_banner.jpg"].copy;
    for (int i = 0 ;i<imgNames.count;i++) {
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(SW*i, 0, SW, SH)];
        imgv.image = [UIImage imageNamed:imgNames[i]];
        [_adSC addSubview:imgv];
        
        imgv.userInteractionEnabled= YES;
    }
    _adSC.contentSize = CGSizeMake(SW*imgNames.count, SH);
    [self.view addSubview:_adSC];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame  =CGRectMake((SW-100)/2, SH/3*2, 100, 100) ;
    [btn setTitle:@"进入" forState:0];
    [btn setTitleColor:[UIColor redColor] forState:0];
    [btn addTarget:self action:@selector(into) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)into{
    if (_returnBlock) {
        _returnBlock();
    }
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
