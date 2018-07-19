//
//  MyShoppingCartCtrl.m
//  EarLinesTech
//
//  Created by apple   on 2018/4/20.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "MyShoppingCartCtrl.h"
#import "ShoppingCartCell.h"

@interface MyShoppingCartCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@end

@implementation MyShoppingCartCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)addUI{
    self.navigationTitle.text = @"购物车";
    self.view.backgroundColor = COLOR(0xf0);
    [self addRightItem];
    
    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom) style:UITableViewStylePlain];
    [_tab registerNib:[UINib nibWithNibName:@"ShoppingCartCell" bundle:nil] forCellReuseIdentifier:@"ShoppingCartCell"];
    _tab.delegate = self;
    _tab.dataSource = self;
    _tab.backgroundColor = [UIColor clearColor];
    _tab.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tab];
    
    
    
    //底部结算
    UIView *bootomV = [[UIView alloc]initWithFrame:CGRectMake(0, SH-58-bottomHeight, SW, 58)];
    bootomV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bootomV];
    
    UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.frame = CGRectMake(20, (58-20)/2, 20, 20);
    [allBtn setImage:[UIImage imageNamed:@"shop_list_dit1"] forState:UIControlStateSelected];
    [allBtn setImage:[UIImage imageNamed:@"shop_list_dit"] forState:UIControlStateNormal];
    [allBtn addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];
    [bootomV addSubview:allBtn];
    
    UILabel *quanxuan = [[UILabel alloc]initWithFrame:CGRectMake(49, 0, 150, 58)];
    quanxuan.textAlignment = NSTextAlignmentLeft;
    quanxuan.font = EWKJfont(15);
    quanxuan.textColor = COLOR(0x33);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@"全选 合计： 0.00元"];
    [attr addAttribute:NSForegroundColorAttributeName value:RGB(0xff,0X07, 0X00) range:NSMakeRange(6, attr.length-6)];
    quanxuan.attributedText = attr;
    [bootomV addSubview:quanxuan];
    
    UIButton * delete = [ UIButton buttonWithType:UIButtonTypeCustom];
    delete.frame = CGRectMake(SW-150, (58-33)/2, 55, 33);
    delete.layer.cornerRadius = 3;
    delete.layer.borderColor = COLOR(0x66).CGColor;
    delete.layer.borderWidth = 1;
    delete.backgroundColor = [UIColor whiteColor];
    [delete setTitle:@"删除" forState:UIControlStateNormal];
    delete.titleLabel.font = EWKJfont(13);
    [delete setTitleColor:COLOR(0x66) forState:UIControlStateNormal];
    [bootomV addSubview:delete];
    [delete addTarget:self action:@selector(delegateShop) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * jiesuan = [ UIButton buttonWithType:UIButtonTypeSystem];
    jiesuan.frame = CGRectMake(SW-75, (58-33)/2, 55, 33);
    jiesuan.layer.cornerRadius = 3;
    jiesuan.layer.borderColor = RGB(0xd8, 0x08, 0x02).CGColor;
    jiesuan.layer.borderWidth = 1;
    jiesuan.backgroundColor = [UIColor whiteColor];
    [jiesuan setTitle:@"结算" forState:UIControlStateNormal];
    jiesuan.titleLabel.font = EWKJfont(13);
    [jiesuan setTitleColor:RGB(0xd8, 0x08, 0x02) forState:UIControlStateNormal];
    [bootomV addSubview:jiesuan];
    [jiesuan addTarget:self action:@selector(jisuanShop) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)delegateShop{
    
}
-(void)jisuanShop{
    
}
-(void)allSelect:(UIButton*)sender{
    sender.selected = !sender.isSelected;
}

-(void)addRightItem{
    UIBarButtonItem *btn0 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Personal_Center_list_2"] style:UIBarButtonItemStylePlain target:self action:@selector(ringhtItemClick)];
    self.navigationItem.rightBarButtonItem = btn0;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}
-(void)ringhtItemClick{
    
}


#pragma mark - tabdelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [ShoppingCartCell cartCell];
    }
    if (indexPath.row == 0) {
        cell.markBtn.selected = YES;
    }
    cell.imgv.image = [UIImage imageNamed:@"people"];
    cell.describleLab.text = @"原汁海胆";
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString:@"￥159.00"];
    [attr addAttribute:NSFontAttributeName value:EWKJfont(11) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:EWKJfont(13) range:NSMakeRange(1, attr.length-1)];
    cell.priceLab.attributedText = attr;
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
