//
//  maintenanceAdviceCtrl.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/4/20.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "maintenanceAdviceCtrl.h"
#import "MallHomeDataModels.h"
#import "onlineshopCollectionViewCell.h"
#import "Products.h"
#import "MallTableView.h"

@interface maintenanceAdviceCtrl ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *adviceMallcoView;
@property(nonatomic,strong)UIView *headerBGV;
@property(nonatomic,assign)CGFloat textH;
@property(nonatomic,strong)NSMutableArray *productModels;

@end

@implementation maintenanceAdviceCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationTitle.text = @"保养建议";
    _productModels = @[].mutableCopy;
    [self requestSuggestionInfo];
  
}


-(void)addTab{
    
    
    _textH = [_adviceString boundingRectWithSize:CGSizeMake(SW-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:EWKJfont(13)} context:nil].size.height;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize =   CGSizeMake((SW-15*3)/2, 164);
    CGFloat magin = 15;
    layout.minimumLineSpacing = magin;
    layout.minimumInteritemSpacing = magin;
    layout.sectionInset = UIEdgeInsetsMake(0, magin, 0, magin);
    layout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(SW, _textH +48+70);
    
    _adviceMallcoView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom-bottomHeight) collectionViewLayout:layout];
    _adviceMallcoView.showsVerticalScrollIndicator = NO;
    _adviceMallcoView.backgroundColor = COLOR(243);
    [_adviceMallcoView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"co"];
    [_adviceMallcoView registerNib:[UINib nibWithNibName:@"onlineshopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"onlineshop"];
    [_adviceMallcoView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
   _adviceMallcoView.delegate = self;
    _adviceMallcoView.dataSource = self;
    [self.view addSubview:_adviceMallcoView];
    
    
    
  
    
    
}

#pragma mark -- 请求保养建议信息
-(void)requestSuggestionInfo{
//    api/mall/maintenancesuggestion?suggestionId={suggestionId}&productPageSize={productPageSize}
    if (_suggestID == 0) {
        _suggestID = 1;
    }
    NSString *url = [NSString stringWithFormat:@"%@mall/maintenancesuggestion?suggestionId=%d&productPageSize=%d",httpHead,_suggestID,5];
    
    WeakSelf
    
    [HttpRequest lrw_getWithURLString:url parameters:nil success:^(id responseObject) {
        if (responseObject) {
            NSDictionary *dict = [responseObject  objectForKey:Data];
            if (![dict isKindOfClass:[NSNull class]]) {
                
                weakSelf.adviceString = dict[@"FoodSuggestion"];
                NSArray *products= dict[@"Products"];
                if (products.count) {
                    
                    for (int i =0; i<products.count; i++) {
                        Products  *model = [Products modelObjectWithDictionary:products[i]];
                        [weakSelf.productModels addObject:model];
                    }
                    [weakSelf.adviceMallcoView reloadData];
                }else{
                    //单独获取保养建议商品
                    [weakSelf requestAdviceMallNumber:6];
                }
                [weakSelf addTab];
            }else{
                [weakSelf alertWithString:@"没有推荐商品"];
            }
        }
        
        
        
    } failure:^(NSError *error,NSInteger code) {
      
        [weakSelf TipWithErrorCode:code];
    }];
}

#pragma mark - 分页获取保养建议推荐商品

-(void)requestAdviceMallNumber:(int)mallCount{
    WeakSelf
//    api/mall/maintenancesuggestion/proucts?suggestionId={suggestionId}&pageSize={pageSize}&pageIndex={pageIndex}
      NSString *url = [NSString stringWithFormat:@"%@mall/maintenancesuggestion/proucts?suggestionId=%d&pageSize=%d&pageIndex=%d",httpHead,_suggestID,mallCount,1];
    [HttpRequest lrw_getWithURLString:url parameters:nil success:^(id responseObject) {
        NSArray *datas = responseObject[Data];
        if (datas.count) {
            for (int i  =0 ; i <datas.count; i++) {
                Products  *model = [Products modelObjectWithDictionary:datas[i]];
                [weakSelf.productModels addObject:model];
            }
            [weakSelf.adviceMallcoView reloadData];
        }else{
            [weakSelf alertWithString:@"没有商品"];
        }
    } failure:^(NSError *error, NSInteger errorCode) {
        [weakSelf alertWithString:@"请求商品错误"];
    }];
}


#pragma mark -- collectionView delegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _productModels.count;
    
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if (_headerBGV == nil) {
            _headerBGV = [[UIView alloc]initWithFrame:headerView.bounds];
            _headerBGV.backgroundColor = [UIColor clearColor];
            [headerView addSubview:_headerBGV];
            
            UIView *texBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, _textH + 48)];
            texBG.backgroundColor = [UIColor whiteColor];
            UILabel * contentLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 24, SW-30, _textH)];
            contentLab.text = _adviceString;
            contentLab.numberOfLines = 0;
            contentLab.font = EWKJfont(13);
            [texBG addSubview:contentLab];
            
            [_headerBGV addSubview:texBG];
            
            
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((SW-100)/2, _textH +48, 100, 70)];
            lab.text =@"推荐商品";
            lab.textColor= [UIColor redColor];
            lab.textAlignment = NSTextAlignmentCenter;
            [_headerBGV addSubview:lab];
            
            UIView *linel = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(lab.frame)-60, _textH +48+35, 50, 1)];
            linel.backgroundColor = [UIColor redColor];
            [_headerBGV addSubview:linel];
            UIView *liner = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, _textH +48+35, 50, 1)];
            liner.backgroundColor = [UIColor redColor];
            [_headerBGV addSubview:liner];
            
            UIButton *more = [[UIButton alloc]initWithFrame:CGRectMake(SW-45, _textH +48+25, 30, 20)];
            [more setTitle:@"更多" forState:UIControlStateNormal];
            more.backgroundColor = [UIColor clearColor];
            [more addTarget:self action:@selector(moreMall:) forControlEvents:UIControlEventTouchUpInside];
            more.tag = 100;
            more.titleLabel.font = EWKJboldFont(11);
            [more setTitleColor:COLOR(0x99) forState:UIControlStateNormal];
            [_headerBGV addSubview:more];
        }
        return headerView;
    }else{
        return nil;
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    onlineshopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"onlineshop" forIndexPath:indexPath];
    if ((!cell)) {
        cell = [onlineshopCollectionViewCell cell];
    }
    Products  *product = _productModels[indexPath.row];
    cell.item = product;
    WeakSelf
    cell.addBlock = ^(Products *item) {
        //添加商品到购物车
        [weakSelf addtoCartWithMall:item];
    };
    
    return cell;
}

#pragma mark -- 添加到购物车
-(void)addtoCartWithMall:(Products *)product{
    NSMutableDictionary *dict =
  @{@"ProductId":@((int)product.productId),@"Qty":@(1)}.mutableCopy;
    WeakSelf
    [[EWKJRequest request]requestWithAPIId:cart2 httphead:nil bodyParaDic:dict completed:^(id datas) {
        [weakSelf alertWithString:@"添加成功！"];
    } error:^(NSError *error, NSInteger statusCode) {
        [weakSelf alertWithString:@"添加到购物车失败"];
    }];
}
#pragma mark --更多商品　
-(void)moreMall:(UIButton *)sender{
    MallTableView *mallTab = [[MallTableView alloc]init];
    mallTab.mallType = mallTableType_baoyang;
    mallTab.suggestId = _suggestID;
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
