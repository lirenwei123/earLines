//
//  settingNameCtrl.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/4/19.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "settingNameCtrl.h"
#import "USERBaseClass.h"

@interface settingNameCtrl ()
@property(nonatomic,strong)UITextField *tf;
@property(nonatomic,strong)UIButton *saveBtn;
@end

@implementation settingNameCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)addUI{
    self.navigationTitle.text = @"昵称";
    CGFloat top = navigationBottom;
   self.view.backgroundColor = COLOR(249);
 
    
    top = navigationBottom;
    UIView *bg1=  [[UIView alloc]initWithFrame:CGRectMake(0, top, SW, 48)];
    bg1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg1];
    
    UITextField *tf= [[UITextField alloc]initWithFrame:CGRectMake(25, 0, SW-50, 48)];
    tf.font = EWKJboldFont(15);
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:15]; // 设置font
    attrs[NSForegroundColorAttributeName] = COLOR(0xc8); // 设置颜色
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"请输入你的昵称" attributes:attrs]; // 初始化富文本占位字符串
    tf.attributedPlaceholder = attStr;
    tf.text = _originName;
    [bg1 addSubview:tf];
    _tf = tf;
    
    top+=48;
    
    UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake(25, top, SW-50, 26)];
    tip.textColor = COLOR(0x99);
    tip.text = @"最多输入10个字符，不能包含特殊符号";
    tip.font = EWKJboldFont(12);
    [self.view addSubview:tip];
    
    top += 26+12;
    UIButton *save =  [[UIButton alloc]initWithFrame:CGRectMake(25, top, SW-50, 40)];
    save.backgroundColor = [UIColor redColor];
    save.layer.cornerRadius = 20;
    [save setTitle:@"保存" forState:0];
    [save setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:save];
    _saveBtn = save;
    
    [save addTarget:self action:@selector(saveName) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}
-(void)saveName{
    //保存名字请求
    if (_tf.text.length<1) {
        [self alertWithString:@"请输入您的昵称"];
        return;
    }else if (_tf.text.length >10){
        [self alertWithString:@"昵称最多10个字符"];
        return;
    }
    _saveBtn.enabled = NO;
    NSDictionary *param = @{@"NickName":_tf.text};
    WeakSelf
    [[EWKJRequest request]requestWithAPIId:user21 httphead:nil bodyParaDic:param completed:^(id datas) {
        weakSelf.saveBtn.enabled = YES;
        if (datas) {
            if (weakSelf.setNickName) {
                weakSelf.setNickName(weakSelf.tf.text);
            }
            USERBaseClass *user = [USERBaseClass user];
            user.nickName = weakSelf.tf.text;
            [NSKeyedArchiver archiveRootObject:user toFile:USERINFOPATH];
            [weakSelf alertWithString:@"昵称设置成功！"];
        }
    } error:^(NSError *error,NSInteger code) {
        weakSelf.saveBtn.enabled = YES;
        [weakSelf TipWithErrorCode:code];
       
    }];
   
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
