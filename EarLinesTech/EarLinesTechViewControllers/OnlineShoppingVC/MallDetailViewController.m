//
//  MallDetailViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/21.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "MallDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+WebP.h"
#import "merchantCell.h"
#import "MerchantDataModels.h"
#import "MerchantDetailViewController.h"
#import "MyShoppingCartCtrl.h"
#import "PayViewController.h"
#import "MallDetailModel.h"


@interface MallDetailViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bgSc;//总滚动
@property(nonatomic,strong)UIScrollView *adSc;// 广告滚动
@property(nonatomic,strong)UIView *adbg;//广告滚动背景
@property(nonatomic,assign)UIPageControl *SCpg;//pagecontrl
@property(nonatomic,assign)NSInteger SCcurrentPage;
@property(nonatomic,strong)UILabel *buyCountLab;
@property(nonatomic,assign)NSInteger currentBuyCount;

@property(nonatomic,strong)MallDetailModel *detailModel;
@end

@implementation MallDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestDetail];
}

#pragma mark - 请求商品详情
-(void)requestDetail{
    WeakSelf
    [SVProgressHUD showWithStatus:@"加载中..."];
    [HttpRequest lrw_getWithURLString:[NSString stringWithFormat:@"%@mall/product/detail?productId=%d",httpHead,_productID] parameters:nil success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if (responseObject) {
            NSDictionary *dict = responseObject[Data];
            weakSelf.detailModel = [MallDetailModel modelObjectWithDictionary:dict];
            [weakSelf loadUI];
        }
    } failure:^(NSError *error,NSInteger code) {
        [weakSelf TipWithErrorCode:code];
        [SVProgressHUD dismiss];
        
    }];
}

-(void)loadUI{
    if (_detailModel == nil) {
        return;
    }
    
    self.navigationTitle.text = _detailModel.productName;
    [self addRightBtnWithIMGname:@"nav_Shopping_Cart"];
    
    _bgSc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom-bottomHeight-50)];
    
    
    [self.view addSubview:_bgSc];
    //ad
    _adSc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SW, 180)];
    _adSc.showsHorizontalScrollIndicator = NO;
    _adSc.pagingEnabled = YES;
    _adSc.delegate =self;
  
    
    _adbg = [[UIView alloc]initWithFrame:_adSc.frame];
    [_bgSc addSubview:_adbg];
    [_adbg addSubview:_adSc];
    
    [self setAdWith:_detailModel.imageUrls];
    
    //商品
    UILabel *mallDescrible = [[UILabel alloc]initWithFrame:CGRectMake(15, 200, SW-100, 20)];
    mallDescrible.font = EWKJboldFont(14);
    mallDescrible.textColor = COLOR(0x33);
    mallDescrible.numberOfLines = 0;
    mallDescrible.text = _detailModel.productDescription;
    [_bgSc addSubview:mallDescrible];
    
    UILabel *priceLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 238, 100, 20)];
    priceLab.textColor = RGB(0xfe, 7, 00);
    priceLab.font = EWKJboldFont(18);
    priceLab.text = [NSString stringWithFormat:@"￥%.2f",_detailModel.price];
    [_bgSc addSubview:priceLab];
    
    UILabel *youdi = [[UILabel alloc]initWithFrame:CGRectMake(15, 270, 100, 20)];
    youdi.font = EWKJfont(11);
    youdi.textColor = COLOR(0x99);
    youdi.text = @"快递包邮";
    [_bgSc addSubview:youdi];
    
    UILabel *xiaolaing = [[UILabel alloc]initWithFrame:CGRectMake(SW-115, 270, 100, 20)];
    xiaolaing.font = EWKJfont(11);
    xiaolaing.textColor = COLOR(0x99);
    xiaolaing.text = [NSString stringWithFormat:@"销量： %.0f件",_detailModel.saleCount];
    [_bgSc addSubview:xiaolaing];
    
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 300, SW, 10)];
    line1.backgroundColor = COLOR(243);
    [_bgSc addSubview:line1];
    
    //数量
    UILabel *selectCountLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 325, 100, 20)];
    selectCountLab.font = EWKJboldFont(14);
    selectCountLab.text = @"请选择 数量";
    [_bgSc addSubview:selectCountLab];
    
    UIButton *select = [[UIButton alloc]initWithFrame:CGRectMake(SW-30, 325, 10, 20)];
    [select setBackgroundImage:[UIImage imageNamed:@"Personal_l"] forState:UIControlStateNormal];
    [select addTarget:self action:@selector(selectCount) forControlEvents:UIControlEventTouchUpInside];
    [_bgSc addSubview:select];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 355, SW, 10)];
    line2.backgroundColor = COLOR(243);
    [_bgSc addSubview:line2];
    
    
    //商城
    
    UIImageView *merchantIMGV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 375, 72, 72)];
    [merchantIMGV sd_setImageWithURL:[NSURL URLWithString:_detailModel.merchantImageUrl]];
    [_bgSc addSubview:merchantIMGV];
    
    UILabel *merchantDes = [[UILabel alloc]initWithFrame:CGRectMake(102, 375, 200, 20)];
    merchantDes.font = EWKJfont(15);
    merchantDes.textColor = COLOR(0x33);
    merchantDes.text = _detailModel.merchantName;
    [_bgSc addSubview:merchantDes];
    
    UILabel *merchantTell = [[UILabel alloc]initWithFrame:CGRectMake(102, 420, 200, 20)];
    merchantTell.font = EWKJfont(13);
    merchantTell.textColor = COLOR(0x66);
    merchantTell.text = [NSString stringWithFormat:@"联系电话： %@",_detailModel.contactPhoneNumber];
    [_bgSc addSubview:merchantTell];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, 460, SW, 10)];
    line3.backgroundColor = COLOR(243);
    [_bgSc addSubview:line3];
    
    //商品详情
    UILabel *spxq = [[UILabel alloc]initWithFrame:CGRectMake(0, 490, SW, 20)];
    spxq.textAlignment = NSTextAlignmentCenter;
    spxq.text = @"商品详情";
    
    CGFloat top = 520;
    for (int i =0 ; i< _detailModel.productDetailImages.count; i++) {
        NSString *imgurl = _detailModel.productDetailImages[i];
        
//        float rate = [self imageHWRateWithimgDes:imgurl];
        
        UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]]];
        float rate = image.size.height/image.size.width;
        
        CGFloat h = SW*rate;
        UIImageView *detailImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, top, SW, h)];
//        [detailImgV sd_setImageWithURL:[NSURL URLWithString:imgurl]];
        detailImgV.image = image;
        [_bgSc addSubview:detailImgV];
        top +=(h+10);
        
       
        
    }
    _bgSc.contentSize = CGSizeMake(SW, top+20);
    
    
    
    //底部菜单
    [self addBottomMenu];
    
}

#pragma mark - 底部菜单
-(void)addBottomMenu{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, SH-bottomHeight-50, SW, 2)];
    line.backgroundColor = COLOR(243);
    [self.view addSubview:line];
    WeakSelf
    //收藏
    EWKJBtn *favirate = [[EWKJBtn alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(line.frame)+5, 45, 43) img:[UIImage imageNamed:@"Personal_Center_list_3"] title:@"收藏" touchEvent:^(EWKJBtn *btn) {
        [weakSelf favirateWithBtn:btn];
    } andbtnType:BTNTYPEUD];
    favirate.tag = 10;
    if (_detailModel.favoriteInd) {
        favirate.lab.text = @"取消收藏";
          favirate.tag = 20;
    }
    favirate.lab.font =EWKJfont(11);
    favirate.lab.textColor = COLOR(0x66);
    [self.view addSubview:favirate];
    //店铺
    EWKJBtn *house = [[EWKJBtn alloc]initWithFrame:CGRectMake(90, CGRectGetMaxY(line.frame)+5, 45, 43) img:[UIImage imageNamed:@"Personal_Center_list_shop"] title:@"店铺" touchEvent:^(EWKJBtn *btn) {
        [weakSelf house];
    } andbtnType:BTNTYPEUD];
    house.lab.font =EWKJfont(11);
    house.lab.textColor = COLOR(0x66);
    [self.view addSubview:house];
    
    //加入购物车
    UIButton *addCart = [[UIButton alloc]initWithFrame:CGRectMake(SW-212, CGRectGetMaxY(line.frame), 106, 48)];
    addCart.backgroundColor = RGB(0xec, 0x50, 0x1a);
    addCart.titleLabel.font = EWKJboldFont(15);
    [addCart setTitleColor:[UIColor whiteColor] forState:0];
    [addCart setTitle:@"加入购物车" forState:0];
    [addCart addTarget:self action:@selector(addCart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addCart];
    //立刻购买
    UIButton *buy = [[UIButton alloc]initWithFrame:CGRectMake(SW-106, CGRectGetMaxY(line.frame), 106, 48)];
    buy.backgroundColor = RGB(0xd7, 5, 1);
    buy.titleLabel.font = EWKJboldFont(15);
    [buy setTitleColor:[UIColor whiteColor] forState:0];
    [buy setTitle:@"立刻购买" forState:0];
    [buy addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buy];
    
}

-(CGFloat)imageHWRateWithimgDes:(NSString *)imgurlstring{
//.jpg?w=1080&amp;h=655"
     NSRange range = [imgurlstring rangeOfString:@"?w="];
    NSString *usestring =  [imgurlstring substringFromIndex:range.location+range.length];
    NSArray *wh = [usestring componentsSeparatedByString:@"&amp;h="];
    float w = [wh.firstObject intValue];
    float h = [wh.lastObject intValue];
    return h/w;
}
-(void)setAdWith:(NSArray *)adImgUrls{
    for (int i = 0 ; i<adImgUrls.count; i++) {
        
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(i*SW, 0, SW, 180)];
        NSString *imgurl = adImgUrls[i];
                [imgv sd_setImageWithURL:[NSURL URLWithString:imgurl]];
        imgv.contentMode = UIViewContentModeScaleAspectFit;
        [_adSc addSubview:imgv];
    }
    _adSc.contentSize =CGSizeMake(SW*adImgUrls.count, 180);
    
    if (adImgUrls.count >1) {
        
        UIPageControl *pg = [[UIPageControl alloc]initWithFrame:CGRectMake(SW/2, 160, 20, 20)];
        [_adbg addSubview:pg];
        pg.numberOfPages = adImgUrls.count;
        pg.currentPage = 0;
        _SCcurrentPage = 0;
        pg.currentPageIndicatorTintColor = [UIColor blueColor];
        pg.pageIndicatorTintColor = [UIColor grayColor];
        pg.enabled = NO;
        _SCpg = pg;
    }
}

#pragma mark - scrollViewdelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _adSc) {
        if ((NSInteger)(_adSc.contentOffset.x/SW) != _SCcurrentPage) {
            _SCcurrentPage = _adSc.contentOffset.x/SW;
            _SCpg.currentPage = _SCcurrentPage;
        }
    }
}



#pragma mark - 选择数量
-(void)selectCount{
    UIView *maoboli =  [[UIView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom)];
    maoboli.backgroundColor = [UIColor grayColor];
    maoboli.alpha = 0.7;
    [self.view addSubview:maoboli];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeCountView)];
    [maoboli addGestureRecognizer:tap];
    maoboli.tag = 100;
    
    UIView *top = [[UIView alloc]initWithFrame:CGRectMake(0, SH-bottomHeight-160, SW, 120)];
    top.backgroundColor =  [UIColor whiteColor];
    top.tag = 200;
    [self.view addSubview:top];
    
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(15, -20, 72, 72)];
    [imgv sd_setImageWithURL:[NSURL URLWithString:_detailModel.imageUrls.firstObject]];
    [top addSubview:imgv];
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(105, 10, 100, 20)];
    price.font = EWKJboldFont(18);
    price.textColor = [UIColor redColor];
    price.text = [NSString stringWithFormat:@"￥%.2f",_detailModel.price];
    [top addSubview:price];
    
    
    UILabel *count = [[UILabel alloc]initWithFrame:CGRectMake(105, 35, 100, 20)];
    count.font =  EWKJfont(13);
    NSString *kucun = [NSString stringWithFormat:@"库存%.0f件",_detailModel.capacity];
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString:kucun attributes:@{NSForegroundColorAttributeName:COLOR(0x66)}];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2,attr.length-3)];
    count.attributedText = attr;
    [top addSubview:count];
    
    UILabel *numberLab =  [[UILabel alloc]initWithFrame:CGRectMake(15, 75, 50, 20)];
    numberLab.font = EWKJfont(13);
    numberLab.textColor = COLOR(0x66);
    numberLab.text = @"数量";
    [top addSubview:numberLab];
    
    
    UIButton *sub = [UIButton buttonWithType:UIButtonTypeSystem];
    [sub setFrame:CGRectMake(SW-33*3-20, 75, 33, 20)];;
    [sub setTitle:@"-" forState:0];
    [sub setTitleColor:[UIColor grayColor] forState:0];
    sub.layer.borderColor = COLOR(243).CGColor;
    sub.layer.borderWidth =1;
    [sub addTarget:self action:@selector(sub) forControlEvents:UIControlEventTouchUpInside];
    [top addSubview:sub];
    
    
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(SW-33*2-20, 75, 33, 20)];
    lab.layer.borderWidth = 1;
    lab.layer.borderColor = COLOR(243).CGColor;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"1";
    [top addSubview:lab];
    _buyCountLab = lab;
    _currentBuyCount = 1;
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeSystem];
    [add setFrame:CGRectMake(SW-33-20, 75, 33, 20)];
    [add setTitleColor:[UIColor grayColor] forState:0];
    [add setTitle:@"+" forState:0];
    add.layer.borderColor = COLOR(243).CGColor;
    add.layer.borderWidth =1;
    [top addSubview:add];
    [add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *sure = [[UIButton alloc]initWithFrame:CGRectMake(0, SH-bottomHeight-40, SW, 40)];
    sure.backgroundColor = RGB(0xd7, 5, 1);
    [sure setTitle:@"确定" forState:0];
    [sure setTitleColor:[UIColor whiteColor] forState:0];
    sure.titleLabel.font = EWKJboldFont(15);
    [self.view addSubview:sure];
    sure.tag = 300;
    [sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    
    
 }

#pragma mark - 购物车
-(void)rightNavitemCLick{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:ISLOGIN]) {
        LoginViewController *logvc = [[LoginViewController alloc]init];
        WeakSelf
        logvc.loginCompelete = ^{
            MyShoppingCartCtrl *cartVC = [[MyShoppingCartCtrl alloc]init];
            [weakSelf.navigationController pushViewController:cartVC animated:NO];
        };
        [self.navigationController pushViewController:logvc animated:NO];
    }else{
        MyShoppingCartCtrl *cartVC = [[MyShoppingCartCtrl alloc]init];
        [self.navigationController pushViewController:cartVC animated:NO];
    }
}

-(void)favirateWithBtn:(EWKJBtn*)sender{
    if (sender.tag == 20) {
        //取消收藏
       
        NSArray *productIds = [NSArray arrayWithObjects:@(_detailModel.productId), nil];
        
        WeakSelf
        [HttpRequest lirw_postWithURLString:[NSString stringWithFormat:@"%@mall/product/favorite/remove",httpHead] parameters:@{Data:productIds}.mutableCopy success:^(id responseObject) {
            if ([responseObject[@"Status"]isEqualToString:@"ok"]) {
//                [weakSelf alertWithString:@"删除收藏成功！"];
                sender.lab.text = @"收藏";
                sender.tag = 10;
            }
        } failure:^(NSError *error,NSInteger code) {
            [weakSelf TipWithErrorCode:code];
        }];
        
    }else{
         //收藏
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%.0f",_detailModel.productId],@"ProductId",@1,@"FavoriteInd", nil];
        
        WeakSelf
        [HttpRequest lirw_postWithURLString:[NSString stringWithFormat:@"%@mall/product/favorite",httpHead] parameters:@{Data:param}.mutableCopy success:^(id responseObject) {
            if ([responseObject[@"Status"]isEqualToString:@"ok"]) {
//                [weakSelf alertWithString:@"收藏成功！"];
                sender.lab.text = @"取消收藏";
                sender.tag = 20;
            }
        } failure:^(NSError *error,NSInteger code) {
            [weakSelf TipWithErrorCode:code];
        }];
    }
}

-(void)house{
    
    WeakSelf
     MerchantDetailViewController *merchantVC = [[MerchantDetailViewController alloc]init];
    merchantVC.merchantId = (int)_detailModel.merchantId;
    [self.navigationController pushViewController:merchantVC animated:NO];
}

-(void)addCart{

    if (![[NSUserDefaults standardUserDefaults]boolForKey:ISLOGIN]) {
        LoginViewController *logvc = [[LoginViewController alloc]init];
        logvc.loginCompelete = ^{
            NSMutableDictionary *dict = @{@"ProductId":@((int)_detailModel.productId),@"Qty":@(_currentBuyCount)}.mutableCopy;
            WeakSelf
            [[EWKJRequest request]requestWithAPIId:cart2 httphead:nil bodyParaDic:dict completed:^(id datas) {
                [weakSelf alertWithString:@"添加成功！"];
            } error:^(NSError *error, NSInteger statusCode) {
                [weakSelf alertWithString:@"添加到购物车失败"];
            }];
        };
        [self.navigationController pushViewController:logvc animated:NO];
    }else{
    
        NSMutableDictionary *dict = @{@"ProductId":@((int)_detailModel.productId),@"Qty":@(_currentBuyCount)}.mutableCopy;
        WeakSelf
        [[EWKJRequest request]requestWithAPIId:cart2 httphead:nil bodyParaDic:dict completed:^(id datas) {
            [weakSelf alertWithString:@"添加成功！"];
        } error:^(NSError *error, NSInteger statusCode) {
            [weakSelf alertWithString:@"添加到购物车失败"];
        }];
    }
}

-(void)buy{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:ISLOGIN]) {
        LoginViewController *logvc = [[LoginViewController alloc]init];
        WeakSelf
        logvc.loginCompelete = ^{
            PayViewController *pay = [[PayViewController alloc]init];
            [weakSelf.navigationController pushViewController:pay animated:NO];
        };
        [self.navigationController pushViewController:logvc animated:NO];
    }else{
    PayViewController *pay = [[PayViewController alloc]init];
    [self.navigationController pushViewController:pay animated:NO];
    }
}

-(void)sure{

    [[self.view viewWithTag:100]removeFromSuperview];
    [[self.view viewWithTag:200]removeFromSuperview];
    [[self.view viewWithTag:300]removeFromSuperview];
    
}

-(void)sub{
    if (_currentBuyCount == 0) {
        return;
    }else{
        _currentBuyCount--;
        _buyCountLab.text = [NSString stringWithFormat:@"%ld",_currentBuyCount];
    }
}
-(void)add{
     _buyCountLab.text = [NSString stringWithFormat:@"%ld",++_currentBuyCount];
}
-(void)removeCountView{
    [[self.view viewWithTag:100]removeFromSuperview];
    [[self.view viewWithTag:200]removeFromSuperview];
    [[self.view viewWithTag:300]removeFromSuperview];
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
