//
//  MyOrderCtrl.m
//  EarLinesTech
//
//  Created by apple   on 2018/4/20.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "MyOrderCtrl.h"
#import "EWKJOrderCell.h"

CGFloat cellh = 80;

@interface MyOrderCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)CGFloat btnW ;
@property (nonatomic,strong)UIView *currentTopLine;
@property (nonatomic,strong) UIView *noneBG;
@property (nonatomic,strong) UIView *topBG;
@property (nonatomic,strong) EWKJBtn *currentBtn;
@property(nonatomic,strong)UITableView *tab;
@end

@implementation MyOrderCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)addUI{
    self.navigationTitle.text = @"我的订单";
    self.view.backgroundColor = COLOR(249);
    
    CGFloat top = navigationBottom;
    CGFloat magin = 2;
    CGFloat h = 30;
   
    NSArray * topBtnTitles = @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成",@"退换货"];
    CGFloat w = (SW-2*magin)/topBtnTitles.count;
    _btnW = w;
    
    UIView *topbg = [[UIView alloc]initWithFrame:CGRectMake(0, top, SW, h)];
    topbg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topbg];
    _topBG = topbg;
    
    WeakSelf
    for (int i = 0 ; i< topBtnTitles.count; i++) {
        EWKJBtn * topBtn = [[EWKJBtn alloc]initWithFrame:CGRectMake(magin+w*i, 0, w, h) img:nil title:topBtnTitles[i] touchEvent:^(EWKJBtn *btn) {
            [weakSelf topBtnClick:btn];
        } andbtnType:BTNTYPETEXT];
        topBtn.lab.font = EWKJboldFont(12);
        topBtn.lab.textColor = COLOR(0x33);
        [topbg addSubview:topBtn];
        topBtn.tag = i;
        
        if (i == _orderState-100 ) {
            if(i ==4){
                _orderState ++;
            }else{
                
                _currentBtn = topBtn;
                UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(magin+i*w, h-2, w, 2)];
                bottomLine.backgroundColor = RGB(0xd8,8, 2);
                [topbg addSubview:bottomLine];
                _currentTopLine = bottomLine;
            }
        }
    }
    
    top = top+h+10;
    //没有数据的时候显示
//    _noneBG = [[UIView alloc]initWithFrame:CGRectMake(0, top, SW, SH -top)];
//    _noneBG.backgroundColor =  [UIColor whiteColor];
//    [self.view addSubview:_noneBG];
//    CGFloat nonewidth = 150;
//    EWKJBtn *noneIMGV = [[EWKJBtn alloc]initWithFrame:CGRectMake((SW-nonewidth)/2, 32, nonewidth, nonewidth) img:[UIImage imageNamed:@"none"] title:@"什么都还没有哦～" touchEvent:nil andbtnType:BTNTYPEUD];
//    noneIMGV.lab.font = EWKJfont(14);
//    noneIMGV.lab.textColor = COLOR(0x99);
//    [_noneBG addSubview:noneIMGV];
    
    
    
    
    //有数据的时候
    _tab =  [[UITableView alloc]initWithFrame:CGRectMake(0, top, SW,SH-top) style:UITableViewStylePlain];
    _tab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tab];
    _tab.delegate = self;
    _tab.dataSource = self;
    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tab registerNib:[UINib nibWithNibName:@"EWKJOrderCell" bundle:nil] forCellReuseIdentifier:@"EWKJOrderCell"];
    
}

-(void)topBtnClick:(EWKJBtn*)sender{
    //底线先滑过去
    if(sender != _currentBtn ){
        _currentBtn = sender;
        _orderState = sender.tag;
        WeakSelf
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.currentTopLine.frame = CGRectMake(2+weakSelf.btnW*sender.tag,28,weakSelf.btnW, 2);
        }];
        
    }
    
}



#pragma mark -  tabdelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EWKJOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EWKJOrderCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [EWKJOrderCell orderCell];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.imgV.image = [UIImage imageNamed:@"people"];
    cell.describleLab.text  = @"原汁海胆罐头158g包邮即食大连好渔郎海胆黄";
    cell.wuliuLab.text = @"买家已付款";
    cell.countLab.text = @"x1";
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString:@"￥159.00"];
    [attr addAttribute:NSFontAttributeName value:EWKJfont(11) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:EWKJfont(13) range:NSMakeRange(1, attr.length-1)];
    cell.priceLab.attributedText = attr;
    cell.bottomLine.backgroundColor = COLOR(249);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellh+10;
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
