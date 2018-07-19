//
//  EarLinesTechnologyViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/4/10.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "EarLinesTechnologyViewController.h"
#import "USERBaseClass.h"



@interface EarLinesTechnologyViewController ()

@end

@implementation EarLinesTechnologyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
}

-(void)addUI{
    self.navigationTitle.text = @"耳纹科技";
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, 200)];
    imgv.image = [UIImage imageNamed:@"js_bg"];
    [self.view addSubview:imgv];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SW, 20)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = EWKJfont(18);
    lab.text = @"Auricular technology";
    lab.textColor = [UIColor whiteColor];
    [imgv addSubview:lab];
    
    UITextView *textV = [[UITextView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(imgv.frame)+20, SW-40, SH-bottomHeight-CGRectGetMaxY(imgv.frame))];
    textV.font = EWKJfont(12);
    textV.textColor = COLOR(0x51);
    [self.view addSubview:textV];
    textV.text = @"\t耳纹科技是一家全球化创新公司，2013年由戚如嬅自然医学博士归国创立，现总部位于中国深圳，现已发展成一个全球创新共同体，创新机构分布在多个国家和地区。耳纹以戚如嬅来命名，其发明专利耳纹远程识别人体健康及耳纹生物认证全部提供社会公益免费使用。励志为中华健康科技复兴而努力。耳纹专注于颠覆式的创新，掌握了远程耳纹识别人体技术、新型空间技术和无线互联技术及相关核心自主知识产权，拥有世界级的创新研发团队，充分融合电子信息领域、数理统计领域等学科的各种先进技术。耳纹的专利申请总量超过100件，授权专利超过60件，其中，在耳纹的专利具有压倒性的优势，申请量占该领域专利申请总量的86%。耳纹对未来的设计，包括深度空间、机器自觉与终极互联三大特征。通过整合全球创新资源，设计未来、实现未来、分享未来进行跨代创新，推动时代变革。\r\r\t使命：小耳朵，大健康。耳纹认证，健康分析公益平台，让全人类拥有健康！\r\r\t戚如嬅博士通过多年的研究，发现耳朵对人的好处无处不在。对疑难杂症从形态，颜色，条索纹等能判断出它过去，现在及将来的身体情况。发现原来耳朵和地图一样有每个区域的板块，耳朵就像个倒置的胎儿非常的神奇，刚好对应人体各部位器官。就此研究多年终于发现【耳纹识别远程图像身体诊断系统】耳前二十二个区块链诊断及治疗系统，耳后十二个区块链诊断及治疗系统。【耳纹学识别-远程图像身体诊断系统】的发明是以高科技生态环保、健康、养生技术为主要服务目的！以高科技生态健康产业链为目标，主要服务于热爱健康人群。目标：戚如嬅耳纹科技将不遗余力，努力创造社会价值，将推出系列智能高科技健康产品，让健康科技全球化（B2B），健康科技生活化（B2C），推动健康生活方式和建立可持续发展健康产业服务而努力。";
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  
   
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
