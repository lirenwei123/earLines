//
//  MallTableView.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/20.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "MallTableView.h"
#import "onlineshopCollectionViewCell.h"
#import "merchantCell.h"
#import "LocationManager.h"
#import "MallHomeDataModels.h"
#import "mallClassesViewController.h"


@interface MallTableView ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UICollectionView *adviceMallcoView;
@property(nonatomic,strong)UITableView *nearbyMalltab;

@property(nonatomic,strong)MallHome *adviceMallModel;
@property(nonatomic,strong)UIView *noneDataBottomV;


@end

@implementation MallTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)addUI{
    self.view.backgroundColor = COLOR(243);
    [self addTopMenu];
    switch (_mallType) {
        case mallTableType_advice:
        {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.itemSize =   CGSizeMake((SW-15*3)/2, 164);
            CGFloat magin = 15;
            layout.minimumLineSpacing = magin;
            layout.minimumInteritemSpacing = magin;
            layout.sectionInset = UIEdgeInsetsMake(0, magin, 0, magin);
            layout.scrollDirection =  UICollectionViewScrollDirectionVertical;
            layout.footerReferenceSize = CGSizeMake(SW, 100);
            
            _adviceMallcoView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, navigationBottom+10, SW, SH-navigationBottom-10-bottomHeight) collectionViewLayout:layout];
            _adviceMallcoView.showsVerticalScrollIndicator = NO;
            _adviceMallcoView.backgroundColor = COLOR(243);
            [_adviceMallcoView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"co"];
            [_adviceMallcoView registerNib:[UINib nibWithNibName:@"onlineshopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"onlineshop"];
            [_adviceMallcoView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
            [self.view addSubview:_adviceMallcoView];
        }
            break;
            
            
        case mallTableType_nearby:
        {
            _nearbyMalltab =  [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBottom+10, SW, SH-navigationBottom-10-bottomHeight)];
            _nearbyMalltab.backgroundColor = COLOR(243);
            _nearbyMalltab.delegate = self;
            _nearbyMalltab.dataSource = self;
            _nearbyMalltab.separatorStyle = UITableViewCellSeparatorStyleNone;
            [_nearbyMalltab registerNib:[UINib nibWithNibName:@"merchantCell" bundle:nil] forCellReuseIdentifier:@"merchantCell"];
            _nearbyMalltab.tableFooterView = [self nearbyMalltabFooter];
            [self.view addSubview:_nearbyMalltab];
        }
            break;
        default:
            break;
    }
    
    [self request];
}

-(UIView *)nearbyMalltabFooter{
    if (_noneDataBottomV == nil) {
        _noneDataBottomV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 100)];
        _noneDataBottomV.backgroundColor =  [UIColor clearColor];
        
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((SW-100)/2, 25, 100, 20)];
        lab.text =@"没有更多宝贝了";
        lab.font = EWKJboldFont(11);
        lab.textColor= COLOR(0x99);
        lab.textAlignment = NSTextAlignmentCenter;
        [_noneDataBottomV addSubview:lab];
        
        UIView *linel = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(lab.frame)-60, 35, 50, 1)];
        linel.backgroundColor = COLOR(0x99);
        [_noneDataBottomV addSubview:linel];
        UIView *liner = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, 35, 50, 1)];
        liner.backgroundColor = COLOR(0x99);
        [_noneDataBottomV addSubview:liner];
        
    }
    return _noneDataBottomV;
    
}
-(void)addTopMenu{
    //搜索
    UIView *searchBG = [[UIView alloc]initWithFrame:CGRectMake(70, statusBarHeight+5, SW-70-50,34)];
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
}
-(void)rightNavitemCLick{
    mallClassesViewController *mallClass = [[mallClassesViewController alloc]init];
    [self.navigationController pushViewController:mallClass animated:NO];
}




-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _adviceMallModel.products.count;
    
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
   if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footer  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        if (_noneDataBottomV == nil) {
            _noneDataBottomV = [[UIView alloc]initWithFrame:footer.bounds];
            _noneDataBottomV.backgroundColor =  [UIColor clearColor];
         
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((SW-100)/2, 25, 100, 20)];
            lab.text =@"没有更多宝贝了";
            lab.font = EWKJboldFont(11);
            lab.textColor= COLOR(0x99);
            lab.textAlignment = NSTextAlignmentCenter;
            [_noneDataBottomV addSubview:lab];
            
            UIView *linel = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(lab.frame)-60, 35, 50, 1)];
            linel.backgroundColor = COLOR(0x99);
            [_noneDataBottomV addSubview:linel];
            UIView *liner = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, 35, 50, 1)];
            liner.backgroundColor = COLOR(0x99);
            [_noneDataBottomV addSubview:liner];
            
            [footer addSubview:_noneDataBottomV];
        }
        return footer;
        
    }else{
        return nil;
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    onlineshopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"onlineshop" forIndexPath:indexPath];
    if ((!cell)) {
        cell = [onlineshopCollectionViewCell cell];
    }
    Products  *product = _adviceMallModel.products[indexPath.row];
    cell.item = product;
    cell.addBlock = ^(Products *item) {
        
    };
    
    return cell;
}

#pragma mark -- tableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
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
    cell.imgv.image = [UIImage imageNamed:@"people"];
    cell.describleLab.text = @"小龙坎老火锅(春熙店)";
    cell.adressLab.text = @"春熙路 1.1km";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




#pragma mark - request
-(void)request{
    //    GET api/mall/home?productPageSize={productPageSize}&merchantPageSize={merchantPageSize}&latitude={latitude}&longitude={longitude}
     WeakSelf
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    switch (_mallType) {
        case mallTableType_advice:
            {
                NSString * url =[NSString stringWithFormat:@"http://em-webapi.zhiyunhulian.cn/api/mall/home?productPageSize=20&merchantPageSize=1&latitude=%.2f&longitude=%.2f",LAT,LNG];
                
                [HttpRequest getWithURLString:url parameters:nil success:^(id responseObject) {
                    [SVProgressHUD dismiss];
                    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    if (dictResponse) {
                        NSDictionary *dict = dictResponse[Data];
                        if (dict) {
                            weakSelf.adviceMallModel = [MallHome modelObjectWithDictionary:dict];
                            weakSelf.adviceMallcoView.delegate = self;
                            weakSelf.adviceMallcoView.dataSource = self;
                            [weakSelf.adviceMallcoView reloadData];
                            
                        }
                    }
                    
                } failure:^(NSError *error) {
                    [SVProgressHUD dismiss];
                    [weakSelf alertWithString:@"推荐商品请求数据失败"];
                }];
                
            }
            break;
            
        case mallTableType_nearby:
        {
            
            NSString * url =[NSString stringWithFormat:@"http://em-webapi.zhiyunhulian.cn/api/mall/search/nearmerchants?latitude=%.2f&longitude=%.2f&pageSize=2&pageIndex=1",LAT,LNG];
            [HttpRequest getWithURLString:url parameters:nil success:^(id responseObject) {
                
                [SVProgressHUD dismiss];
                NSDictionary *dictResponse1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                if (dictResponse1) {
                    NSDictionary *dict = dictResponse1[Data];
                    if (dict) {
#pragma mark TODO
                    }
                }
                
                
                
                
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                [weakSelf alertWithString:@"附近商家请求错误"];
            }];
        }
            break;
        default:
            break;
    }
   
   
    
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
                    [self alertWithString:[NSString stringWithFormat:@"%@",dataArray]];
                }else{
                    [self alertWithString:@"没有您搜索的商品！"];
                }
            }
        } fail:^(NSError *error) {
            [self alertWithString:@"请求错误！"];
        }];
        
        textField.text = nil;
        
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
