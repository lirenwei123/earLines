//
//  OnlineShoppingViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/4/10.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "OnlineShoppingViewController.h"
#import "MallHomeDataModels.h"
#import "onlineshopCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIImage+WebP.h"
#import "LocationManager.h"
#import "SVProgressHUD.h"
#import "merchantCell.h"
#import "MallTableView.h"
#import "mallClassesViewController.h"
#import "PersonalCenterCtrl.h"
#import "MallDetailModel.h"
#import "MallDetailViewController.h"
#import "MerchantModel.h"
#import "MerchantDetailViewController.h"
#import "MyShoppingCartCtrl.h"



@interface OnlineShoppingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)MallHome *mallHomeModel;
@property(nonatomic,strong)UITableView *nearlyMalltab;
@property(nonatomic,strong)UICollectionView *adviceMallcoView;
@property(nonatomic,strong)UITableView *nearbyMalltab;
@property(nonatomic,strong)UIScrollView *adSc;
@property(nonatomic,strong)UIView *adbg;//广告滚动背景
@property(nonatomic,assign)UIPageControl *SCpg;
@property(nonatomic,assign)NSInteger SCcurrentPage;
@property(nonatomic,strong)UIView *headerBGV;
@property(nonatomic,strong)UIView *FooterBGV;
@property(nonatomic,strong)UIView *tabHeader;

@property(nonatomic,assign)CGFloat lat;//纬度
@property(nonatomic,assign)CGFloat  lng;//经度

@property(nonatomic,strong)UICollectionViewFlowLayout * layout;


@property(nonatomic,strong)NSMutableArray *nearMerchantModels;
@property(nonatomic,assign)NSInteger index;

@end

@implementation OnlineShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     _nearMerchantModels = @[].mutableCopy;
    [self requestMallHomePage];
    _index = 0;
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(adMove) userInfo:nil repeats:YES];
    
}

-(void)adMove{

    if (_mallHomeModel.banners.count>1) {
        _index++;
        if (_index == _mallHomeModel.banners.count) {
            _index = 0;
        }
        [_adSc setContentOffset:CGPointMake((_index)*SW, 0)];
        _SCpg.currentPage = _index;
    }
}

-(void)setUI{
    //菜单
   
    [self addTopMenu];
    
    //头部广告
//    _adSc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, 190)];
//    _adSc.showsHorizontalScrollIndicator = NO;
//    _adSc.pagingEnabled = YES;
//    _adSc.delegate =self;
//    [self.view addSubview:_adSc];
    
    
    //主框架。 collectionview做精品推荐。footerView 做附近商家
    _layout = [[UICollectionViewFlowLayout alloc]init];
    _layout.itemSize =   CGSizeMake((SW-15*3)/2, 164);
    CGFloat magin = 15;
    _layout.minimumLineSpacing = magin;
    _layout.minimumInteritemSpacing = magin;
    _layout.sectionInset = UIEdgeInsetsMake(0, magin, 0, magin);
    _layout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    _layout.headerReferenceSize = CGSizeMake(SW, 70+190);
    _layout.footerReferenceSize = CGSizeMake(SW, 70*2+93*_nearMerchantModels.count);
  
   

    
    _adviceMallcoView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom-bottomHeight) collectionViewLayout:_layout];
    _adviceMallcoView.showsVerticalScrollIndicator = NO;
    _adviceMallcoView.backgroundColor = COLOR(243);
    [_adviceMallcoView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"co"];
    [_adviceMallcoView registerNib:[UINib nibWithNibName:@"onlineshopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"onlineshop"];
     [_adviceMallcoView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
     [_adviceMallcoView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    _adviceMallcoView.delegate = self;
    _adviceMallcoView.dataSource = self;
    [self.view addSubview:_adviceMallcoView];
    
    
    
    
    //购物车
    UIButton *buyCart = [[UIButton alloc]initWithFrame:CGRectMake(SW- 82, SH-bottomHeight-100, 62, 62)];
    buyCart.clipsToBounds =  YES;
    buyCart.layer.cornerRadius = 31;
    buyCart.backgroundColor = [UIColor redColor];
    
    [buyCart setImage:[[UIImage imageNamed:@"nav_Shopping_Cart"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [buyCart addTarget:self action:@selector(buyCartClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyCart];
    
}

-(void)addTopMenu{
    //搜索
    UIView *searchBG = [[UIView alloc]initWithFrame:CGRectMake(70, statusBarHeight+5, SW-70-100,34)];
    searchBG.backgroundColor = [UIColor redColor];
    searchBG.layer.cornerRadius = 15;
    [self.navigationBar addSubview:searchBG];
    
    UIButton *searchIMG = [[UIButton alloc]initWithFrame:CGRectMake(10, 7, 20, 20)];
    searchIMG.backgroundColor = [UIColor clearColor];
    [searchIMG setBackgroundImage:[UIImage imageNamed:@"nav_search"] forState:UIControlStateNormal];
    [searchBG addSubview:searchIMG];
    
    UITextField *searchTF = [[UITextField alloc]initWithFrame:CGRectMake(40,0, CGRectGetWidth(searchBG.frame) - 55,34)] ;
    searchTF.backgroundColor = [UIColor redColor];
    searchTF.font = EWKJfont(15);
//    searchTF.textColor = RGB(0xfe, 0xb7, 0xab);
    searchTF.returnKeyType = UIReturnKeySearch;
    NSAttributedString *attr = [[NSAttributedString alloc]initWithString:@"输入关键字进行搜索" attributes:@{NSFontAttributeName:EWKJboldFont(15),NSForegroundColorAttributeName:RGB(0xfe, 0xb7, 0xab)}];
    searchTF.attributedPlaceholder = attr;
    searchTF.delegate = self;
    [searchBG addSubview:searchTF];
    
    
    //选项
    [self addRightBtnWithIMGname:@"nav_classification"];
    //用户
    UIButton * userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userBtn setFrame:CGRectMake(SW-10-22-42, statusBarHeight+12, 22, 22)];
    [userBtn addTarget: self action:@selector(userClick) forControlEvents:UIControlEventTouchUpInside];
    [userBtn setBackgroundImage:[UIImage imageNamed:@"nav_Personal_Center"] forState:UIControlStateNormal];
    userBtn.backgroundColor = [UIColor clearColor];
    [self.navigationBar addSubview:userBtn];
    
}

#pragma mark -- collectionView delegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
        return _mallHomeModel.products.count;
   
}


- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if (_headerBGV == nil) {
            _headerBGV = [[UIView alloc]initWithFrame:headerView.bounds];
            _headerBGV.backgroundColor = [UIColor clearColor];
            [headerView addSubview:_headerBGV];
            
            
            _adSc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SW, 180)];
            _adSc.showsHorizontalScrollIndicator = NO;
            _adSc.pagingEnabled = YES;
            _adSc.delegate =self;
            _adbg = [[UIView alloc]initWithFrame:_adSc.frame];
            [_headerBGV addSubview:_adbg];
            [_adbg addSubview:_adSc];
            [_headerBGV addSubview:_adbg];
            [self setAdWith:_mallHomeModel.banners];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((SW-100)/2, 180, 100, 70)];
            lab.text =@"精品推荐";
            lab.textColor= [UIColor redColor];
            lab.textAlignment = NSTextAlignmentCenter;
            [_headerBGV addSubview:lab];
            
            UIView *linel = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(lab.frame)-60, 215, 50, 1)];
            linel.backgroundColor = [UIColor redColor];
            [_headerBGV addSubview:linel];
            UIView *liner = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, 215, 50, 1)];
            liner.backgroundColor = [UIColor redColor];
            [_headerBGV addSubview:liner];
            
            UIButton *more = [[UIButton alloc]initWithFrame:CGRectMake(SW-45, 205, 30, 20)];
            [more setTitle:@"更多" forState:UIControlStateNormal];
            more.backgroundColor = [UIColor clearColor];
            [more addTarget:self action:@selector(moreMall:) forControlEvents:UIControlEventTouchUpInside];
            more.tag = 100;
            more.titleLabel.font = EWKJboldFont(11);
            [more setTitleColor:COLOR(0x99) forState:UIControlStateNormal];
            [_headerBGV addSubview:more];
        }
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footer  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        if (_FooterBGV == nil) {
            _FooterBGV = [[UIView alloc]initWithFrame:footer.bounds];
            _FooterBGV.backgroundColor =  [UIColor clearColor];
            [footer addSubview:_FooterBGV];
            
            _nearbyMalltab =  [[UITableView alloc]initWithFrame:footer.bounds];
            _nearbyMalltab.backgroundColor = COLOR(243);
            _nearbyMalltab.delegate = self;
            _nearbyMalltab.dataSource = self;
            _nearbyMalltab.separatorStyle = UITableViewCellSeparatorStyleNone;
            [_nearbyMalltab registerNib:[UINib nibWithNibName:@"merchantCell" bundle:nil] forCellReuseIdentifier:@"merchantCell"];
            _nearbyMalltab.tableHeaderView = [self nearbyTabHeader];
            [_FooterBGV addSubview:_nearbyMalltab];
        }
        return footer;
        
    }else{
        return nil;
    }
}
-(UIView *)nearbyTabHeader{
    if (!_tabHeader) {
        _tabHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 70)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((SW-100)/2, 20, 100, 50)];
        lab.text =@"附近商家";
        lab.textColor= [UIColor redColor];
        lab.textAlignment = NSTextAlignmentCenter;
        [_tabHeader addSubview:lab];
        
        UIView *linel = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(lab.frame)-60, 45, 50, 1)];
        linel.backgroundColor = [UIColor redColor];
        [_tabHeader addSubview:linel];
        UIView *liner = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, 45, 50, 1)];
        liner.backgroundColor = [UIColor redColor];
        [_tabHeader addSubview:liner];
        
        UIButton *more = [[UIButton alloc]initWithFrame:CGRectMake(SW-45, 35, 30, 20)];
        [more setTitle:@"更多" forState:UIControlStateNormal];
        more.backgroundColor = [UIColor clearColor];
        [more addTarget:self action:@selector(moreMall:) forControlEvents:UIControlEventTouchUpInside];
        more.tag = 200;
        more.titleLabel.font = EWKJboldFont(11);
        [more setTitleColor:COLOR(0x99) forState:UIControlStateNormal];
        [_tabHeader addSubview:more];
        
    }
    return _tabHeader;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    onlineshopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"onlineshop" forIndexPath:indexPath];
    if ((!cell)) {
        cell = [onlineshopCollectionViewCell cell];
    }
    Products  *product = _mallHomeModel.products[indexPath.row];
    cell.item = product;
    WeakSelf
    cell.addBlock = ^(Products *item) {
        //添加商品到购物车
        [weakSelf addtoCartWithMall:item];
    };
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     Products  *product = _mallHomeModel.products[indexPath.row];
    MallDetailViewController *detail = [[MallDetailViewController alloc]init];
    detail.productID = product.productId;
    [self.navigationController pushViewController:detail animated:NO];
}

#pragma mark -- tableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _nearMerchantModels.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    merchantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"merchantCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [merchantCell cell];
    }
    cell.contentView.backgroundColor = COLOR(243);
    cell.item =_nearMerchantModels[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchantModel *merchant = _nearMerchantModels[indexPath.row];
    MerchantDetailViewController *merchantVC = [[MerchantDetailViewController alloc]init];
    merchantVC.merchantId = merchant.merchantId;
    [self.navigationController pushViewController:merchantVC animated:NO];
    
    
    
}

//#pragma mark - layoutDelegate
//-(CGSize)itemSizeWithSection:(NSInteger)section{
//    if (section == 0) {
//      return  CGSizeMake((SW-15*3)/2, 164);
//    }else{
//        return CGSizeMake(SW-30, 85);
//    }
//}
#pragma mark - 更多按钮事件
-(void)moreMall:(UIButton *)sender{
   
    MallTableView *mallTab = [[MallTableView alloc]init];
    mallTab.mallType = sender.tag==100?mallTableType_advice:mallTableType_nearby;
    [self.navigationController pushViewController:mallTab animated:NO];
    
}
#pragma mark -- 购物车点击
-(void)buyCartClick:(UIButton *)sender{
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

#pragma mark -- 添加到购物车
-(void)addtoCartWithMall:(Products *)product{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:ISLOGIN]) {
        LoginViewController *logvc = [[LoginViewController alloc]init];
        WeakSelf
        logvc.loginCompelete = ^{
            NSMutableDictionary *dict = @{@"ProductId":@((int)product.productId),@"Qty":@(1)}.mutableCopy;
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

#pragma mark -- 请求
-(void)requestMallHomePage{
//    GET api/mall/home?productPageSize={productPageSize}&merchantPageSize={merchantPageSize}&latitude={latitude}&longitude={longitude}
    WeakSelf
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    [LocationManager getMoLocationWithSuccess:^(double lat, double lng) {
        [LocationManager stop];
        NSString * url =[NSString stringWithFormat:@"%@mall/home?productPageSize=10&merchantPageSize=10&latitude=%.2f&longitude=%.2f",httpHead,lat,lng];
      
        [HttpRequest lrw_getWithURLString:url parameters:nil success:^(id responseObject) {
            [SVProgressHUD dismiss];
            if (responseObject) {
                NSDictionary *dict = responseObject[Data];
                if (dict) {
                    weakSelf.mallHomeModel = [MallHome modelObjectWithDictionary:dict];
                    weakSelf.nearMerchantModels = weakSelf.mallHomeModel.agencies.copy;
                    [weakSelf setUI];
                   
                }
            }
            
        } failure:^(NSError *error,NSInteger code) {
             [SVProgressHUD dismiss];
            [weakSelf TipWithErrorCode:code];
            
        }];
        
        
//        NSString * url1 =[NSString stringWithFormat:@"http://em-webapi.zhiyunhulian.cn/api/mall/search/nearmerchants?latitude=%.2f&longitude=%.2f&pageSize=10&pageIndex=1",lat,lng];
//
//        [HttpRequest lrw_getWithURLString:url1 parameters:nil success:^(id responseObject) {
//            [SVProgressHUD dismiss];
//            if (responseObject) {
//                NSArray *datas = responseObject[Data];
//                weakSelf.layout.footerReferenceSize = CGSizeMake(SW, 70*2+93*datas.count);
//                if (datas.count) {
//                    for (int i =0; i<datas.count; i++) {
//                        nearMerchant  *model = [nearMerchant modelObjectWithDictionary:datas[i]];
//                        [weakSelf.nearMerchantModels addObject:model];
//                    }
//                      [weakSelf.adviceMallcoView reloadData];
//                }else{
////                    [weakSelf alertWithString:@"没有返回附近商家数据"];
//                    [weakSelf.adviceMallcoView reloadData];
//                }
//            }
//
//
//            
//
//        } failure:^(NSError *error,NSInteger code) {
//            [SVProgressHUD dismiss];
//            if (code ==401) {
//                [weakSelf alertWithString:@"登录时效过期，请重新登录"];
//            }else{
//                [weakSelf alertWithString:[NSString stringWithFormat:@"请求数据失败%ld",code]];
//            }
//        }];
    } Failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        if ([error code] == kCLErrorDenied) {
            [weakSelf alertWithString:@"获取定位失败,请到设置里打开定位"];
        }
        NSString * url =[NSString stringWithFormat:@"%@mall/home?productPageSize=10&merchantPageSize=10&latitude=%.2f&longitude=%.2f",httpHead,lati,longti];
        
        [HttpRequest lrw_getWithURLString:url parameters:nil success:^(id responseObject) {
            [SVProgressHUD dismiss];
            if (responseObject) {
                NSDictionary *dict = responseObject[Data];
                if (dict) {
                    weakSelf.mallHomeModel = [MallHome modelObjectWithDictionary:dict];
                    weakSelf.nearMerchantModels = weakSelf.mallHomeModel.agencies.copy;
                    [weakSelf setUI];
                    
                }
            }
            
        } failure:^(NSError *error,NSInteger code) {
            [SVProgressHUD dismiss];
            [weakSelf TipWithErrorCode:code];
            
        }];
        
    }];
   
    
}



#pragma mark textfield dlegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  
    [self.view endEditing:YES];
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.view endEditing:YES];
    if (textField.text.length) {
        //搜索请求
        [self searchRequestWith:textField.text complete:^(id datas) {
            if ([datas isKindOfClass:[NSArray class]])  {
                NSArray *dataArray = (NSArray *)datas;
                if (dataArray.count) {
                    //展示
//                    [self alertWithString:[NSString stringWithFormat:@"%@",dataArray]];
                }else{
                    [self alertWithString:@"没有您搜索的商品！"];
                }
            }
        } fail:^(NSError *error,NSInteger code) {
            
        }];

          textField.text = nil;
        
    }
    
}



#pragma mark 其他


-(void)rightNavitemCLick{
    mallClassesViewController *mallClass = [[mallClassesViewController alloc]init];
    [self.navigationController pushViewController:mallClass animated:NO];
}

-(void)userClick{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:ISLOGIN]) {
        LoginViewController *logvc = [[LoginViewController alloc]init];
        WeakSelf
        logvc.loginCompelete = ^{
            [weakSelf.navigationController pushViewController: [[PersonalCenterCtrl alloc]init] animated:NO];
        };
        [self.navigationController pushViewController:logvc animated:NO];
    }else{
        [self.navigationController pushViewController:[[PersonalCenterCtrl alloc]init] animated:NO];
    }
   
}
-(void)setAdWith:(NSArray *)adImgUrls{
    for (int i = 0 ; i<adImgUrls.count; i++) {
        
        UIButton *imgv = [[UIButton alloc]initWithFrame:CGRectMake(i*SW, 0, SW, 190)];
        Banners *banner = adImgUrls[i];
//        [imgv sd_setImageWithURL:[NSURL URLWithString:banner.imageUrl]];

        if ([[banner.imageUrl substringWithRange:NSMakeRange(banner.imageUrl.length-4, 4)]isEqualToString:@"webp"]) {
            [imgv setImage:[UIImage sd_imageWithWebPData:[NSData dataWithContentsOfURL:[NSURL URLWithString:banner.imageUrl]]] forState:0];
        }else{
            [imgv sd_setImageWithURL:[NSURL URLWithString:banner.imageUrl] forState:0];
        }
        [imgv addTarget:self action:@selector(touchAd:) forControlEvents:UIControlEventTouchUpInside];
        imgv.tag = i;
        imgv.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_adSc addSubview:imgv];
    }
    _adSc.contentSize =CGSizeMake(SW*adImgUrls.count, 190);
    
    if (adImgUrls.count >1) {
        
        UIPageControl *pg = [[UIPageControl alloc]initWithFrame:CGRectMake(SW/2, 160, 20, 20)];
        [_adbg addSubview:pg];
        pg.numberOfPages = adImgUrls.count;
        pg.currentPage = 0;
        _SCcurrentPage = 0;
        pg.currentPageIndicatorTintColor = [UIColor whiteColor];
        pg.pageIndicatorTintColor = [UIColor grayColor];
        pg.enabled = NO;
//        [pg addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
        _SCpg = pg;
    }
}

-(void)touchAd:(UIButton*)sender{
    if (sender.tag < _mallHomeModel.banners.count) {
        Banners *baner  = _mallHomeModel.banners[sender.tag];
        MallDetailViewController *detail = [[MallDetailViewController alloc]init];
        detail.productID = baner.productId;
        [self.navigationController pushViewController:detail animated:NO];
    }
}

//-(void)pageChange:(UIPageControl *)sender{
//    if (_SCcurrentPage != sender.currentPage) {
//        _SCcurrentPage = sender.currentPage;
//        _adSc.contentOffset = CGPointMake(_SCcurrentPage*SW, 0);
//    }
//}

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
