//
//  wuliuViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/6/3.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "wuliuViewController.h"
#import "wuliuModel.h"
#import "EWKJOrderCell.h"
#import "UIImageView+WebCache.h"


@interface wuliuViewController ()
@property(nonatomic,strong)wuliuModel *wuliu;

@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *statusLab;
@property(nonatomic,strong)UILabel *kuaidiLab;
@property(nonatomic,strong)UILabel *kuaidiTipLab;

@end

@implementation wuliuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationTitle.text =@"查看物流";
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    WeakSelf
    [[EWKJRequest request]requestWithAPIId:order9 httphead:[NSString stringWithFormat:@"%d",_merchantOrderId] bodyParaDic:nil completed:^(id datas) {
        [SVProgressHUD dismiss];
        weakSelf.wuliu = [wuliuModel  modelObjectWithDictionary:datas[Data]];
        [weakSelf setUI];
       
        
    } error:^(NSError *error, NSInteger statusCode) {
        [SVProgressHUD dismiss];
    }];
    
}

-(void)setUI{

    
    
    _imgV = [[UIImageView alloc]initWithFrame:CGRectMake(20,30+navigationBottom, 60, 60)];
    [self.view addSubview:_imgV];
    [_imgV sd_setImageWithURL:[NSURL URLWithString:_merchantUrl]];
    
    _statusLab= [[UILabel alloc]initWithFrame:CGRectMake(100, 30+navigationBottom, SW - 120, 20)];
    _statusLab.font = EWKJboldFont(14);
    _statusLab.textColor = RGB(0xd8, 2, 2);
    [self.view addSubview:_statusLab];
    _statusLab.text  = _stastusName;
    
    _kuaidiLab = [[UILabel alloc]initWithFrame:CGRectMake(100,50+navigationBottom , SW - 120, 20)];
    _kuaidiLab.font = EWKJfont(12);
    _kuaidiLab.textColor = COLOR(0x66);
    [self.view addSubview:_kuaidiLab];
    _kuaidiLab.text = [NSString stringWithFormat:@"%@:%@",_wuliu.expressCompanyName,_wuliu.expressNumber];
    
    _kuaidiTipLab = [[UILabel alloc]initWithFrame:CGRectMake(100,70+navigationBottom , SW - 120, 20)];
    _kuaidiTipLab.font = EWKJfont(12);
    _kuaidiTipLab.textColor = COLOR(0x66);
    [self.view addSubview:_kuaidiTipLab];
    _kuaidiTipLab.text = [NSString stringWithFormat:@"官方电话: %@",_wuliu.expressPhoneNumber] ;
    
    UIView *line0 = [[UIView alloc]initWithFrame:CGRectMake(0, navigationBottom+120, SW, 10)];
    line0.backgroundColor = COLOR(243);
    [self.view addSubview:line0];
    
    
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, navigationBottom+130, SW, SH-bottomHeight -navigationBottom-130)];
    [self.view addSubview:sc];
    
    CGFloat top = 20;
    CGFloat h  =80;
    
    CGFloat leftW = 100;
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(leftW, top+10, 20, 20)];
    imgv.image = [UIImage imageNamed:@"landmark"];
    [sc addSubview:imgv];
    //地址
    
  
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(leftW+30, top, SW-leftW-50, 40)];
    address.font = EWKJfont(13);
    address.textColor = COLOR(0x33);
    address.numberOfLines = 0;
    [sc addSubview:address];
    address.text = [NSString stringWithFormat:@"[收货地址] %@",_wuliu.deliveryAddress] ;
    
     sc.contentSize = CGSizeMake(SW, h+h*_wuliu.trackingItems.count);
    top = h;
    for (int i =0; i<_wuliu.trackingItems.count; i++) {
        TrackingItems *item = _wuliu.trackingItems[i];
        if (i == 0) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(leftW-1, top, 2, h*(_wuliu.trackingItems.count-1))];
            line.backgroundColor = COLOR(243);
            [sc addSubview:line];
        }
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(leftW-10,top+ h*i, 20, 20)];
        imgv.image = [UIImage imageNamed:@"shop_list_dit1"];
        [sc addSubview:imgv];
        
        UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(10,  top+h*i-10, 80, 40)];
        time.font = EWKJfont(12);
        time.textColor = RGB(0xec, 0x3b, 0x1a);
        time.numberOfLines = 0;
        NSString *timeStr = [item.createDt stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
        time.text = timeStr;
        time.textAlignment = NSTextAlignmentCenter;
        [sc addSubview:time];
        
        
        CGFloat heigt = [item.trackingItemsDescription boundingRectWithSize:CGSizeMake(SW-leftW-50, 70) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:EWKJfont(12)} context:nil].size.height;
        if (heigt < 40) {
            heigt = 40;
        }
        UILabel *desLab = [[UILabel alloc]initWithFrame:CGRectMake(leftW+20,  top+h*i-10, SW-leftW-50, heigt)];
        desLab.font = EWKJfont(12);
        desLab.textColor = RGB(0xec, 0x3b, 0x1a);
        desLab.numberOfLines = 0;
        desLab.text = item.trackingItemsDescription;
        [sc addSubview:desLab];
        
        
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
