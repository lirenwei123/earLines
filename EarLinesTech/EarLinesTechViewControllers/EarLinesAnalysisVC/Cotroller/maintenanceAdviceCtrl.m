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

@interface maintenanceAdviceCtrl ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *adviceMallcoView;
@property(nonatomic,strong)UIView *headerBGV;
@property(nonatomic,strong)MallHome *mallModel;
@property(nonatomic,assign)CGFloat textH;
@end

@implementation maintenanceAdviceCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self request];
}

-(void)addUI{
    self.navigationTitle.text = @"保养建议";
    
    
      _adviceString = @"\t1.营养早餐必须有主食，还要有蔬菜和水果。假如只有两种以下营养的早餐，就属于低质量早餐。现在我们中国人20%不吃早餐，50%-60%不会吃早餐，早餐营养不好，中午，晚上是补不回来的。\n\t2.每天一盘蔬菜，必须八两到一斤，每天两个水果，每天三勺青油，不要超过25克，每天四两米饭或四个馒头，加上充足的职务蛋白质。";
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
  
    [self.view addSubview:_adviceMallcoView];
    
    
    
  
    
    
}


#pragma mark -- 请求
-(void)request{
//    api/mall/maintenancesuggestion/proucts?suggestionId={suggestionId}&pageSize={pageSize}&pageIndex={pageIndex}
    WeakSelf
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
   
//    NSString *url = [NSString stringWithFormat:@"api/mall/maintenancesuggestion/proucts?suggestionId=%ld&pageSize=10&pageIndex=1",(long)_suggestID];
    
    //test
    NSString * url =[NSString stringWithFormat:@"http://em-webapi.zhiyunhulian.cn/api/mall/home?productPageSize=6&merchantPageSize=5&latitude=%d&longitude=%d",30,40];
    
        [HttpRequest getWithURLString:url parameters:nil success:^(id responseObject) {
            [SVProgressHUD dismiss];
            NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if (dictResponse) {
                NSDictionary *dict = dictResponse[Data];
                if (dict) {
                    weakSelf.mallModel = [MallHome modelObjectWithDictionary:dict];
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

#pragma mark -- collectionView delegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _mallModel.products.count;
    
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
    Products  *product = _mallModel.products[indexPath.row];
    cell.item = product;
    cell.addBlock = ^(Products *item) {
        
    };
    
    return cell;
}


#pragma mark --more
-(void)moreMall:(UIButton *)sender{
    
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
