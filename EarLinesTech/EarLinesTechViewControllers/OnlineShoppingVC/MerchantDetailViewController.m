//
//  MerchantDetailViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/23.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "MerchantDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "merchantCell.h"
#import "onlineshopCollectionViewCell.h"
#import "MallDetailViewController.h"
#import "MallTableView.h"
#import "MyShoppingCartCtrl.h"

@interface MerchantDetailViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIView *headerBGV;
@property(nonatomic,assign)CGFloat jianjieHeight;
@property(nonatomic,strong)UIScrollView *adSc;// 广告滚动
@property(nonatomic,strong)UIView *adbg;//广告滚动背景
@property(nonatomic,assign)UIPageControl *SCpg;//pagecontrl
@property(nonatomic,assign)NSInteger SCcurrentPage;

@property(nonatomic,strong)UICollectionView *adviceMallcoView;

@property(nonatomic,strong)MerchantModel *merchant;


@end

@implementation MerchantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestMerchant];
}

#pragma mark - 请求店铺详情
-(void)requestMerchant{
     WeakSelf
    [HttpRequest lrw_getWithURLString:[NSString stringWithFormat:@"%@mall/merchant?merchantId=%d&productPageSize=10",httpHead,_merchantId] parameters:nil success:^(id responseObject) {
       
        NSDictionary *dict = responseObject[Data];
        if (dict) {
            weakSelf.merchant = [MerchantModel modelObjectWithDictionary:dict];
            [weakSelf loadUI];
        }
    } failure:^(NSError *error, NSInteger errorCode) {
         [weakSelf TipWithErrorCode:errorCode];
    }];
}

-(void)loadUI{
    self.navigationTitle.text = @"店铺详情";
    self.view.backgroundColor = [UIColor whiteColor];
    if (_merchant == nil) {
        return;
    }
    
      _jianjieHeight = [_merchant.internalBaseClassDescription boundingRectWithSize:CGSizeMake(SW-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:EWKJboldFont(12)} context:nil].size.height;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize =   CGSizeMake((SW-15*3)/2, 164);
    CGFloat magin = 15;
    layout.minimumLineSpacing = magin;
    layout.minimumInteritemSpacing = magin;
    layout.sectionInset = UIEdgeInsetsMake(0, magin, 0, magin);
    layout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(SW, 390+_jianjieHeight);
    
    
    _adviceMallcoView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom-bottomHeight) collectionViewLayout:layout];
    _adviceMallcoView.delegate  = self;
    _adviceMallcoView.dataSource  = self;
    _adviceMallcoView.showsVerticalScrollIndicator = NO;
    _adviceMallcoView.backgroundColor = COLOR(243);
    [_adviceMallcoView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"co"];
    [_adviceMallcoView registerNib:[UINib nibWithNibName:@"onlineshopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"onlineshop"];
    [_adviceMallcoView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.view addSubview:_adviceMallcoView];
    

    
}




#pragma mark -- collectionView delegate
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if (_headerBGV == nil) {
            _headerBGV = [[UIView alloc]initWithFrame:headerView.bounds];
            _headerBGV.backgroundColor = [UIColor whiteColor];
            [headerView addSubview:_headerBGV];
            
            
            //ad
            _adSc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SW, 180)];
            _adSc.showsHorizontalScrollIndicator = NO;
            _adSc.pagingEnabled = YES;
            _adSc.delegate =self;
            
            
            _adbg = [[UIView alloc]initWithFrame:_adSc.frame];
            [_headerBGV addSubview:_adbg];
            [_adbg addSubview:_adSc];
            [self setAdWith:@[_merchant.imageUrl]];
            
            //商品
            UILabel *mallDescrible = [[UILabel alloc]initWithFrame:CGRectMake(15, 200, SW-100, 20)];
            mallDescrible.font = EWKJboldFont(14);
            mallDescrible.textColor = COLOR(0x33);
            mallDescrible.numberOfLines = 0;
            mallDescrible.text = _merchant.merchantName;
            [_headerBGV addSubview:mallDescrible];
            
            UILabel *addressLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 235, SW-100, 20)];
            addressLab.textColor = COLOR(0x66);
            addressLab.font = EWKJboldFont(12);
            addressLab.numberOfLines = 0;
            addressLab.text = [NSString stringWithFormat:@"地址：%@",_merchant.address];
            [_headerBGV addSubview:addressLab];
            
            UILabel *tell = [[UILabel alloc]initWithFrame:CGRectMake(15, 270, SW-100, 20)];
            tell.font = EWKJboldFont(12);
            tell.textColor = COLOR(0x66);
            tell.text = [NSString stringWithFormat:@"联系电话: %@",_merchant.contactPhoneNumber];
            [_headerBGV addSubview:tell];
            
            
            
            
            UILabel *jianjie = [[UILabel alloc]initWithFrame:CGRectMake(15, 305, SW-30, _jianjieHeight)];
            jianjie.numberOfLines = 0;
            jianjie.font = EWKJboldFont(12);
            jianjie.textColor = COLOR(0x66);
            jianjie.text = [NSString stringWithFormat:@"简介： %@",_merchant.internalBaseClassDescription];
            [_headerBGV addSubview:jianjie];
            
            
            //
            UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 320+_jianjieHeight, SW, 70)];
            bg.backgroundColor = COLOR(243);
            [_headerBGV addSubview:bg];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((SW-100)/2, 0, 100, 70)];
            lab.text =@"推荐商品";
            lab.textColor= [UIColor redColor];
            lab.textAlignment = NSTextAlignmentCenter;
            [bg addSubview:lab];
            
            UIView *linel = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(lab.frame)-60, 35, 50, 1)];
            linel.backgroundColor = [UIColor redColor];
            [bg addSubview:linel];
            UIView *liner = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, 35, 50, 1)];
            liner.backgroundColor = [UIColor redColor];
            [bg addSubview:liner];
            
            UIButton *more = [[UIButton alloc]initWithFrame:CGRectMake(SW-45, 25, 30, 20)];
            [more setTitle:@"更多" forState:UIControlStateNormal];
            more.backgroundColor = [UIColor clearColor];
            [more addTarget:self action:@selector(moreMall) forControlEvents:UIControlEventTouchUpInside];
            more.tag = 100;
            more.titleLabel.font = EWKJboldFont(11);
            [more setTitleColor:COLOR(0x99) forState:UIControlStateNormal];
            [bg addSubview:more];
        }
        return headerView;
    }else{
        return nil;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _merchant.products.count;
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    onlineshopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"onlineshop" forIndexPath:indexPath];
    if ((!cell)) {
        cell = [onlineshopCollectionViewCell cell];
    }
    Products  *product = _merchant.products[indexPath.row];
    cell.item = product;
    WeakSelf
    cell.addBlock = ^(Products *item) {
        //添加商品到购物车
        [weakSelf addtoCartWithMall:item];
    };
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Products  *product = _merchant.products[indexPath.row];
    MallDetailViewController *detail = [[MallDetailViewController alloc]init];
    detail.productID = product.productId;
    [self.navigationController pushViewController:detail animated:NO];
}



-(void)setAdWith:(NSArray *)adImgUrls{
    for (int i = 0 ; i<adImgUrls.count; i++) {
        
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(i*SW, 0, SW, 180)];
        NSString *imgurl = adImgUrls[i];
        [imgv sd_setImageWithURL:[NSURL URLWithString:imgurl]];
        imgv.contentMode = UIViewContentModeScaleAspectFill;
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

#pragma mark -


#pragma mark -- 添加到购物车
-(void)addtoCartWithMall:(Products *)product{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:ISLOGIN]) {
        LoginViewController *logvc = [[LoginViewController alloc]init];
        logvc.loginCompelete = ^{
            NSMutableDictionary *dict = @{@"ProductId":@((int)product.productId),@"Qty":@(1)}.mutableCopy;
            WeakSelf
            [[EWKJRequest request]requestWithAPIId:cart2 httphead:nil bodyParaDic:dict completed:^(id datas) {
                [weakSelf alertWithString:@"添加成功！"];
            } error:^(NSError *error, NSInteger statusCode) {
                [weakSelf alertWithString:@"添加到购物车失败"];
            }];
        };
        [self.navigationController pushViewController:logvc animated:NO];
    }else{
        NSMutableDictionary *dict = @{@"ProductId":@((int)product.productId),@"Qty":@(1)}.mutableCopy;
        WeakSelf
        [[EWKJRequest request]requestWithAPIId:cart2 httphead:nil bodyParaDic:dict completed:^(id datas) {
            [weakSelf alertWithString:@"添加成功！"];
        } error:^(NSError *error, NSInteger statusCode) {
            [weakSelf alertWithString:@"添加到购物车失败"];
        }];
    }
}



-(void)moreMall{
    MallTableView *mallTab = [[MallTableView alloc]init];
    mallTab.mallType = mallTableType_advice;
    [self.navigationController pushViewController:mallTab animated:NO];
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
