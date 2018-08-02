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
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SW, 200)];
    imgv.image = [UIImage imageNamed:@"js_bg"];
   
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SW, 20)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = EWKJfont(18);
    lab.text = @"Auricular technology";
    lab.textColor = [UIColor whiteColor];
    [imgv addSubview:lab];
    
   
    NSString *content =  @"\t耳纹科技是一家全球化创新公司，2013年由戚如嬅自然医学博士归国创立，现总部位于中国深圳，现已发展成一个全球创新共同体，创新机构分布在多个国家和地区。耳纹以戚如嬅来命名，其发明专利耳纹远程识别人体健康及耳纹生物认证全部提供社会公益免费使用。励志为中华健康科技复兴而努力。耳纹专注于颠覆式的创新，掌握了远程耳纹识别人体技术、新型空间技术和无线互联技术及相关核心自主知识产权，拥有世界级的创新研发团队，充分融合电子信息领域、数理统计领域等学科的各种先进技术。耳纹的专利申请总量超过100件，授权专利超过60件，其中，在耳纹的专利具有压倒性的优势，申请量占该领域专利申请总量的86%。耳纹对未来的设计，包括深度空间、机器自觉与终极互联三大特征。通过整合全球创新资源，设计未来、实现未来、分享未来进行跨代创新，推动时代变革。\r\r\t目标：实现耳纹科技化，健康生活化。\r\r\t使命：小耳朵，大健康。为健康全人类而奋斗！\r\r\t戚如嬅博士通过多年的研究，发现耳朵对人的好处无处不在。对疑难杂症从形态，颜色，条索纹等能判断出它过去，现在及将来的身体情况。发现原来耳朵和地图一样有每个区域的板块，耳朵就像个倒置的胎儿非常的神奇，刚好对应人体各部位器官。就此研究多年终于发现【耳纹识别远程图像身体诊断系统】耳前二十二个区块链诊断及治疗系统，耳后十二个区块链诊断及治疗系统。【耳纹学识别-远程图像身体诊断系统】的发明是以高科技生态环保、健康、养生技术为主要服务目的！以高科技生态健康产业链为目标，主要服务于热爱健康人群。目标：戚如嬅耳纹科技将不遗余力，努力创造社会价值，将推出系列智能高科技健康产品，让健康科技全球化（B2B），健康科技生活化（B2C），推动健康生活方式和建立可持续发展健康产业服务而努力。\n\n\t耳纹健康识别系统指南\n\n\t耳纹，是一个局部反应整体的微观世界，是检测人体健康状况的是视窗，相当于‘电脑窗口’。耳纹，记载着人体健康状态的全部资讯，包括：主要病症，现病史，既往史，未来史，家族史，遗传史，手术史，外伤史等。\n\t耳纹远程诊断是一种综合诊断系统，通过耳纹诊断方法的研究大量临床实践，通过对疾病的病理，生理，耳纹功能，耳纹阳性反应变化规律之观察，透过临床对照与经验总结，耳纹远程诊断法现在可诊断200多种疾病和500多种症状。不但可以定位诊断，定性诊断，而且可以鉴别诊断。\n\t耳纹系统是建立在胚胎学，解剖学，遗传学，免疫学，神经学，交感神经，周围神经系统，病理形态学，体液学和生物电理论等基础之上。\n\t耳纹远程诊断系统的依据：当人体生理病理发生改变时，与疾病相关的耳纹出现各种各样的阳性反应点，这些阳性反应点的变化是多层次的，是多种形式多样化的。当人体正常健康状态时，耳纹穴只是代表一个点，一个功能点或一个解剖部位，不呈现任何阳性反应。是平坦的，色泽正常的，不伴有组织化学或微量元素的变化。\n\t当人体疾病发生时，穴位由点可变成区，沟，或依解剖相关群点学说之病理，生理，病因和临床症状学的改变，而出现线，沟，轴，经，三角，环的形态变化。这些穴位的特定变化，都是耳纹诊断过程中必须要注意的。\n\t在耳纹诊断中，基本是以穴位部位区域，区块检测为主。\n\t耳纹诊断，是依照22个区块进行的，这22个区域的研制，是根据胚胎倒影学说丶解剖学丶骨骼肌肉运动系统丶内脏组织器官分布规律和耳纹穴相应部位丶耳纹穴相关群点，耳纹穴生理功能设计出来的，是20余年临床实践研究和经验的积累总结的。本探测路线的特点，将耳前165个穴位定制出不同形态丶不同排列分布，剖析出耳廓的主要区域走形干线。通过22个区块的研究，不但发现耳纹穴的具体分布规律，而且在耳纹穴的检测诊断中，只要按此区域检测，就不会遗漏任何一个身体部位，与疾病时反应在耳纹区域的阳性反应点。\n\t临床实践中，有了22个区块系统，加上技巧分析辩证。不但可以诊断疾病的部位，疾病的性质，而且可以用来鉴别诊断。耳纹，为人类的健康保驾护航。\n\n\t服务项目：\n\n耳纹健康生物识别，耳纹健康管理及生物科技产品的技术开发等。\n\n\t特别声明:\n\n本软件识别系统提供大众公益使用，由于是远程识别健康情况，对于应用中的准确率不能完全达到100%，仅供大家参考。\n如需详细进一步了解请联系：戚如嬅耳纹科技（深圳）有限公司\n联系方式：深圳市龙岗区布吉百合一期商铺59号\n预约电话：0755—33247531\n13611877133\nEmail:1053927313@qq.com\nwww.qrhewkj.com\n微信：happymama96\r\r\t耳纹专利证书：";
    NSMutableAttributedString *contentAttr = [[NSMutableAttributedString alloc]initWithString:content];
    
    
    //富文本

    NSRange rang1 = [content rangeOfString:@"目标：实现耳纹科技化，健康生活化。"];
    NSRange rang2 = [content rangeOfString:@"使命：小耳朵，大健康。为健康全人类而奋斗！"];
    NSRange rang3 = [content rangeOfString:@"耳纹健康识别系统指南"];
    NSRange rang4 = [content rangeOfString:@"服务项目："];
    NSRange rang5 = [content rangeOfString:@"特别声明:"];
    NSRange rang6 =[content rangeOfString:@"耳纹专利证书："];
    
    [contentAttr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:rang1];
    [contentAttr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:rang2];
    [contentAttr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:rang3];
    [contentAttr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:rang4];
    [contentAttr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:rang5];
    [contentAttr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:rang6];
    
    
    CGFloat h = [content boundingRectWithSize:CGSizeMake(SW-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingUsesDeviceMetrics|NSStringDrawingTruncatesLastVisibleLine  attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil].size.height;
    
    UILabel *textV = [[UILabel alloc]initWithFrame:CGRectMake(20, 220, SW-40, h)];
    textV.font = EWKJfont(15);
    textV.textColor = COLOR(0x51);
    textV.numberOfLines = 0;
    textV.attributedText = contentAttr;
   
    
    
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-bottomHeight-navigationBottom)];
    sc.backgroundColor = [UIColor clearColor];
    [self.view addSubview:sc];
    sc.showsVerticalScrollIndicator = NO;
    [sc addSubview:textV];
                        
    
    //img
    
    for (int i = 0; i<3; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"专利证书%i",i+1]];
        CGFloat imgH = (SW-40)*img.size.height/img.size.width;
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(20, h+240, SW-40,imgH)];
        imgv.image = img;
        [sc addSubview:imgv];
        h = h+20 +imgH;
    }
    
    [sc addSubview:imgv];
    [sc setContentSize:CGSizeMake(SW, h+220)];
    
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
