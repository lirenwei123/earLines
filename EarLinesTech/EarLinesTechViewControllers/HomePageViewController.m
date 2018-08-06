//
//  HomePageViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/14.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "HomePageViewController.h"



@interface HomePageViewController ()
@property (strong, nonatomic)  UIImageView *topImgV;
@property (strong, nonatomic)  UILabel *bottomLab;
@property (strong, nonatomic)  UIButton *ewkjBtn;
@property (strong, nonatomic)  UIButton *myEwBtn;
@property (strong, nonatomic)  UIButton *ewlinesAnasize;

@property (strong, nonatomic)  UIButton *onlineShopBtn;

@property (strong, nonatomic)  UILabel *topLogoLab;
@property (strong, nonatomic)  UIImageView *toplogImgv;
@property (strong, nonatomic)  UIImageView *earImgv;
@property (strong, nonatomic)  UILabel *detailLab;




@end

@implementation HomePageViewController



//耳纹分析，是您健康的分析师
//耳纹识别远程图像身体诊断系统
//专利号：ZL201520317240.4
//发明专利号：20140684383.9
//版权号：沪作登字-2015-L-00449879


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    [self removeReturn];
    self.navigationTitle.text = @"耳纹科技分析";
    [self UI2];
//    [self loginRequest];
    
}


-(void)loginRequest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if( [[NSUserDefaults standardUserDefaults]boolForKey:ISLOGIN]){
            NSString *account= [USERBaseClass user].account;
            __block  NSString *pwd = [USERBaseClass user].pwd;
            
            if (account.length && pwd.length ) {
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:account,@"Account",pwd,@"Password", nil];
                [[EWKJRequest request]requestWithAPIId:user1 httphead:nil bodyParaDic:dict completed:^(id datas) {
                    
                    if (datas) {
                        //更新token
                        NSDictionary *dic = (NSDictionary*)datas[Data];
                        USERBaseClass *user = [USERBaseClass user];
                        user.token = dic[@"Token"];
                        if (user) {
                            [NSKeyedArchiver archiveRootObject:user toFile:USERINFOPATH];
                        }
                    }
                    
                } error:^(NSError *error, NSInteger statusCode) {
                    if (error) {
                        [self alertWithString:[NSString stringWithFormat:@"%@",error]];
                    }
                }];
                
            }
        }
    });
}

-(void)UI1{
    UIImage *image = [UIImage imageNamed:@"a_banner_bg"];
    _topImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, image.size.height)];
    _topImgV.image = image;
    _topImgV.userInteractionEnabled = YES;
    [self.view addSubview:_topImgV];
    
    _topLogoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, SW/3, 30)];
    _topLogoLab.textAlignment = NSTextAlignmentCenter;
    [_topImgV addSubview:_topLogoLab];
    _topLogoLab.font = EWKJfont(12);
    _topLogoLab.numberOfLines = 0;
    _topLogoLab.text = @"Auricular technology\r耳纹科技";
    
    _toplogImgv = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_topLogoLab.frame)+20, 20, SW-CGRectGetMaxX(_topLogoLab.frame)-30, (SW-CGRectGetMaxX(_topLogoLab.frame)-30)*324/698.0)];
    _toplogImgv.image = [UIImage imageNamed:@"9"];
    [_topImgV addSubview:_toplogImgv];
    
    UIImage *erd = [UIImage imageNamed:@"a_er"];;
    _earImgv= [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_topLogoLab.frame)+40, erd.size.width, erd.size.height)];
    _earImgv.image = erd;
    [_topImgV addSubview:_earImgv];
    
    UILabel *lab1 = [[ UILabel alloc]initWithFrame:CGRectMake(SW/2+20, CGRectGetMaxY(_toplogImgv.frame)+20, SW/2-30, 20)];
    lab1.font = EWKJfont(12);
    lab1.adjustsFontSizeToFitWidth =YES;
    lab1.text = @"耳纹分析，是您健康的分析师";
    [_topImgV addSubview:lab1];
    
    UILabel *lab2 = [[ UILabel alloc]initWithFrame:CGRectMake(SW/2+20, CGRectGetMaxY(lab1.frame)+10, SW/2-30, 20)];
    lab2.font = EWKJfont(12);
    lab2.text = @"耳纹识别远程图像身体诊断系统";
    lab2.adjustsFontSizeToFitWidth =YES;
    [_topImgV addSubview:lab2];
    
    UILabel *lab3 = [[ UILabel alloc]initWithFrame:CGRectMake(SW/2+20, CGRectGetMaxY(lab2.frame)+10, SW/2-30, 20)];
    lab3.font = EWKJfont(10);
    lab3.text = @"专利号：ZL201520317240.4";
    lab3.adjustsFontSizeToFitWidth =YES;
    [_topImgV addSubview:lab3];
    
    UILabel *lab4 = [[ UILabel alloc]initWithFrame:CGRectMake(SW/2+20, CGRectGetMaxY(lab3.frame)+10, SW/2-30, 20)];
    lab4.font = EWKJfont(10);
    lab4.text = @"发明专利号：20140684383.9";
    lab4.adjustsFontSizeToFitWidth =YES;
    [_topImgV addSubview:lab4];
    
    UILabel *lab5 = [[ UILabel alloc]initWithFrame:CGRectMake(SW/2+20, CGRectGetMaxY(lab4.frame)+10, SW/2-30, 20)];
    lab5.font = EWKJfont(10);
    lab5.text = @"版权号：沪作登字-2015-L-00449879";
    lab5.adjustsFontSizeToFitWidth =YES;
    [_topImgV addSubview:lab5];
    
    
    _ewlinesAnasize = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ewlinesAnasize setFrame:CGRectMake(SW/2+35, CGRectGetMaxY(lab5.frame)+15, SW/2-70, 45)];
    [_ewlinesAnasize setBackgroundImage:[UIImage imageNamed:@"index_btn"] forState:UIControlStateNormal];
    [_topImgV addSubview:_ewlinesAnasize];
    [_ewlinesAnasize addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _ewlinesAnasize.tag = 100;
    
    _detailLab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_ewlinesAnasize.frame)+10, SW-40, 20)];
    _detailLab.textAlignment = NSTextAlignmentRight;
    _detailLab.text = @"每个耳朵都是唯一 耳朵是您个人的专属ID";
    _detailLab.font = EWKJfont(12);
    [_topImgV addSubview:_detailLab];
    
    
    NSString *content = @"耳纹识别介绍:\r\t所谓耳纹，是指我们每个人耳朵上的图纹。科学家已经证实，每个人耳朵的外耳特征是终生不变的，而且世界上没有相同的耳朵。与人的胎记或指纹一样，耳纹是独一无二的，每个人的耳朵的差异与生俱来，由基因所决定。\r\t耳纹识别是根据全息胚胎倒影学说，解剖学，遗传学，免疫学，神经学，交感神经，周围神经系统，病理形态学，生物电理论，骨骼肌肉运动系统，内脏组织器官分布规律和耳纹相应部位，耳纹相关群点，耳纹生理功能设计出来的。";
    
    //    CGFloat h = [content boundingRectWithSize:CGSizeMake(SW-40, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:EWKJfont(12)} context:nil].size.height;
    
    _bottomLab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_topImgV.frame)+15, SW-40,SH-CGRectGetMaxY(_topImgV.frame)-100 )];
    _bottomLab.numberOfLines = 0;
    _bottomLab.text = content;
    //    _bottomLab.font = EWKJfont(12);
    _bottomLab.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_bottomLab];
    
    NSArray *names = @[@"在线选购",@"耳纹科技",@"我的耳纹"].copy;
    CGFloat magin = (SW-40-100*3)/2;
    for (int i=0; i<names.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(20 +(100 +magin)*i, SH-70, 100, 45)];
        [btn setBackgroundImage:[UIImage imageNamed:@"index_btn_bottom"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:names[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.tag = 101+i;
        
    }
}

-(void)UI2{
    UIImage *image = [UIImage imageNamed:@"a_banner_bg"];
    _topImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, image.size.height)];
    _topImgV.image = image;
    _topImgV.userInteractionEnabled = YES;
    [self.view addSubview:_topImgV];
    
    
    UIImage *erd = [UIImage imageNamed:@"newear"];
    _earImgv= [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, SW-30, (SW-30)*erd.size.height/erd.size.width)];
    _earImgv.image = erd;
    [_topImgV addSubview:_earImgv];
    
    _topLogoLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_earImgv.frame)+10, SW/2-30, 30)];
    _topLogoLab.textAlignment = NSTextAlignmentCenter;
    [_topImgV addSubview:_topLogoLab];
    _topLogoLab.font = EWKJfont(16);
    _topLogoLab.adjustsFontSizeToFitWidth = YES;
    _topLogoLab.numberOfLines = 1;
    _topLogoLab.textColor = [UIColor redColor];
    _topLogoLab.text = @"人类私人健康管理顾问";
    
    _toplogImgv = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_topLogoLab.frame)+20, CGRectGetMaxY(_earImgv.frame)+10, SW-CGRectGetMaxX(_topLogoLab.frame)-30, (SW-CGRectGetMaxX(_topLogoLab.frame)-30)*324/698.0)];
    _toplogImgv.image = [UIImage imageNamed:@"9"];
    [_topImgV addSubview:_toplogImgv];
    
    _detailLab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_topLogoLab.frame)+10, SW/2-30, 20)];
    _detailLab.textAlignment = NSTextAlignmentLeft;
    _detailLab.text = @"每个耳朵都是唯一";
    _detailLab.numberOfLines = 1;
    _detailLab.font = EWKJfont(16);
    [_topImgV addSubview:_detailLab];
    
    UILabel *lab1 = [[ UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_detailLab.frame), SW/2-30, 30)];
    lab1.font = EWKJfont(16);
    lab1.numberOfLines = 1;
    lab1.adjustsFontSizeToFitWidth =YES;
    lab1.text = @"耳朵是您个人的专属ID";
    [_topImgV addSubview:lab1];
    
    UILabel *lab2 = [[ UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lab1.frame)+5, SW/2-20, 15)];
    lab2.font = EWKJfont(12);
    lab2.text = @"耳纹识别人体分析软件";
    lab2.adjustsFontSizeToFitWidth =YES;
    [_topImgV addSubview:lab2];
    
    UILabel *lab3 = [[ UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lab2.frame), SW/2-30, 15)];
    lab3.font = EWKJfont(12);
    lab3.numberOfLines = 1;
    lab3.adjustsFontSizeToFitWidth =YES;
    lab3.text = @"软著专利号:2018SR504313";
    [_topImgV addSubview:lab3];
    
    UILabel *lab4 = [[ UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lab3.frame), SW/2, 20)];
    lab4.font = EWKJfont(9);
    lab4.numberOfLines = 1;
    lab4.adjustsFontSizeToFitWidth =YES;
    lab4.text = @"软著著作权由戚如嬅耳纹科技(深圳)有限公司所有";
    [_topImgV addSubview:lab4];
    
    
    _ewlinesAnasize = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ewlinesAnasize setFrame:CGRectMake(SW/2+35, CGRectGetHeight(_topImgV.frame)-55, SW/2-70, 45)];
    [_ewlinesAnasize setBackgroundImage:[UIImage imageNamed:@"index_btn"] forState:UIControlStateNormal];
    [_topImgV addSubview:_ewlinesAnasize];
    [_ewlinesAnasize addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _ewlinesAnasize.tag = 100;
    
   
    
    
    NSString *content = @"\t所谓耳纹，是指我们每个人耳朵上的图纹。科学家已经证实，每个人耳朵的外耳特征是终生不变的，而且世界上没有相同的耳朵。与人的胎记或指纹一样，耳纹是独一无二的，每个人的耳朵的差异与生俱来，由基因所决定。耳纹识别是根据全息胚胎倒影学说，解剖学，遗传学，免疫学，神经学，交感神经，周围神经系统，病理形态学，体液学，生物电理论，骨骼肌肉运动系统，内脏组织器官分布规律和耳纹相应部位，耳纹相关群点，耳纹生理功能设计出来的。耳纹图像识别技术是人工智能的一个重要领域，图像识别中的模式识别，是一种从大量信息和数据出发，图形自动完成识别、评价的过程，耳纹识别蕴含大量新数据的“宝藏”，是人类私人的健康管理顾问";
    
    //    CGFloat h = [content boundingRectWithSize:CGSizeMake(SW-40, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:EWKJfont(12)} context:nil].size.height;
    
    _bottomLab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_topImgV.frame)+15, SW-40,SH-CGRectGetMaxY(_topImgV.frame)-100 )];
    _bottomLab.numberOfLines = 0;
    _bottomLab.text = content;
    //    _bottomLab.font = EWKJfont(12);
    _bottomLab.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_bottomLab];
    
    NSArray *names = @[@"在线选购",@"耳纹科技",@"我的耳纹"].copy;
    CGFloat magin = (SW-40-100*3)/2;
    for (int i=0; i<names.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(20 +(100 +magin)*i, SH-70, 100, 45)];
        [btn setBackgroundImage:[UIImage imageNamed:@"index_btn_bottom"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:names[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.tag = 101+i;
        
    }
}

- (void)btnClick:(UIButton *)sender {
    NSArray *classArray = @[@"EarLinesAnalysisViewController",@"OnlineShoppingViewController",@"EarLinesTechnologyViewController",@"PersonalCenterCtrl"].copy;
    NSInteger index = sender.tag -100;
    if (index < classArray.count) {
        Class class = NSClassFromString(classArray[index]);
        if (class) {
            UIViewController *vc = [[class alloc]init];
            vc.title = sender.titleLabel.text;
            if (index!=1&&index!=2) {
                if (![[NSUserDefaults standardUserDefaults]boolForKey:ISLOGIN]) {
                    LoginViewController *logvc = [[LoginViewController alloc]init];
                    WeakSelf
                    logvc.loginCompelete = ^{
                        [weakSelf.navigationController pushViewController:vc animated:NO];
                    };
                    [self.navigationController pushViewController:logvc animated:NO];
                }else{
                    [self.navigationController pushViewController:vc animated:NO];
                }
            }else{
                
                [self.navigationController pushViewController:vc animated:NO];
            }
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
