//
//  mallClassesViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/20.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "mallClassesViewController.h"
#import "MallTableView.h"
#import "UIImage+WebP.h"
#import "UIImageView+WebCache.h"

@interface mallClassesViewController ()<UITextFieldDelegate>

@end

@implementation mallClassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)addUI{
    self.navigationTitle.text = @"全部分类";
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self addSearchV];
    [self request];
}


-(void)request{
   WeakSelf
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [HttpRequest lrw_getWithURLString:[NSString stringWithFormat:@"%@mall/product/categories",httpHead] parameters:nil success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *arrayData = responseObject[Data];
        if (arrayData.count) {
            [weakSelf addMallClassesWith:arrayData];
        }
    } failure:^(NSError *error, NSInteger errorCode) {
        [SVProgressHUD dismiss];
        [weakSelf alertWithString:@"没有分类商品！"];
    }];
}

#pragma mark - 搜索框
-(void)addSearchV{
    UIView *searchBG = [[UIView alloc]initWithFrame:CGRectMake(15, navigationBottom+5, SW-30,33)];
    searchBG.backgroundColor = COLOR(243);
    searchBG.layer.cornerRadius = 3;
    [self.view addSubview:searchBG];
    
    UIButton *searchIMG = [[UIButton alloc]initWithFrame:CGRectMake(8, 7, 20, 20)];
    searchIMG.backgroundColor = [UIColor clearColor];
    [searchIMG setBackgroundImage:[UIImage imageNamed:@"nav_search"] forState:UIControlStateNormal];
    [searchBG addSubview:searchIMG];
    
    UITextField *searchTF = [[UITextField alloc]initWithFrame:CGRectMake(36,0, CGRectGetWidth(searchBG.frame) - 55,33)] ;
    searchTF.backgroundColor = [UIColor clearColor];
    searchTF.font = EWKJfont(15);
//    searchTF.textColor = RGB(0xfe, 0xb7, 0xab);
    searchTF.returnKeyType = UIReturnKeySearch;
    NSAttributedString *attr = [[NSAttributedString alloc]initWithString:@"输入关键字进行搜索" attributes:@{NSFontAttributeName:EWKJboldFont(14),NSForegroundColorAttributeName:COLOR(0x99)}];
    searchTF.attributedPlaceholder = attr;
    searchTF.delegate = self;
    [searchBG addSubview:searchTF];
    
    UIView *seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBG.frame)+7, SW, 10)];
    seperateLine.backgroundColor = COLOR(243);
    [self.view addSubview:seperateLine];
}

#pragma mark - 增加商品分类视图
-(void)addMallClassesWith:(NSArray *)classesData{

    CGFloat Hmargin = 15;
    CGFloat Vmargin = 30;
    CGFloat w = (SW-Hmargin*4)/3;
    CGFloat h = 90;
    WeakSelf
    [classesData enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger i, BOOL * _Nonnull stop) {
        
        EWKJBtn *mall = [[EWKJBtn alloc]initWithFrame:CGRectMake(Hmargin+i%3*(w+15), navigationBottom+60 + i/3*(h+Vmargin), w, h) img:nil title:obj[@"CategoryName"] touchEvent:^(EWKJBtn *btn) {
            NSInteger categoryId =[obj[@"CategoryId"] integerValue];
            [weakSelf selectMall:categoryId];
        } andbtnType:BTNTYPE_mallClass];
        mall.tag = 100+i;
        NSString *imgurl = obj[@"ImageUrl"];
        if ([[imgurl substringWithRange:NSMakeRange(imgurl.length-4, 4)]isEqualToString:@"webp"]) {
            mall.imgv.image = [UIImage sd_imageWithWebPData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]]];
        }else{
            [mall.imgv sd_setImageWithURL:[NSURL URLWithString:imgurl]];
        }
       
        mall.imgv.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:mall];
    }];
    
    
    
}


#pragma maek - 选择商品种类
-(void)selectMall:(NSInteger)tag{
    MallTableView *mallTab = [[MallTableView alloc]init];
    mallTab.isNotNeedOption = YES;
    mallTab.mallType = mallTableType_category;
    mallTab.categoryId = (int)tag;
    [self.navigationController pushViewController:mallTab animated:NO];
}


#pragma mark -textFielddelegate

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
            
        } fail:^(NSError *error, NSInteger statusCode) {
            
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
