//
//  OrderViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/23.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "SureOrderViewController.h"
#import "OrderCell.h"
#import "AddressViewController.h"
#import "PayViewController.h"
#import "checkOutDataModels.h"
#import "UIImageView+WebCache.h"
#import "MallDetailViewController.h"

@interface SureOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *orderTab;
@property(nonatomic,strong)UIView *header;
@property(nonatomic,strong)UIView *footer;
@property(nonatomic,strong)UILabel *payMoneyLab;
@property(nonatomic,strong)UILabel *needPayMonyLab;
@property(nonatomic,strong)checkOutModel *checkModel;
@property(nonatomic,strong)UILabel *adressLab;
@property(nonatomic,strong)UITextField *notesTF;
@property(nonatomic,assign)CGFloat money;
@end

@implementation SureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestCheckOut];
}
-(void)addUI{
  

   
    self.navigationTitle.text = @"确认订单";
    _orderTab  =[[UITableView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom-bottomHeight) style:UITableViewStylePlain];
    _orderTab.delegate = self;
    _orderTab.dataSource = self;
    _orderTab.backgroundColor =  COLOR(243);
    _orderTab.tableHeaderView = [self headerV];
    _orderTab.tableFooterView = [self footerV];
    [_orderTab registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"OrderCell"];
    
    [self.view addSubview:_orderTab];
    [self botooMenu];
    
   
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
    [_orderTab addGestureRecognizer:tap];
    
    
}

-(void)endEditing{
    [self.view endEditing:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - tabledalegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _checkModel.merchants.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Merchants *merchant = _checkModel.merchants[section];
    return merchant.items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     Merchants *merchant = _checkModel.merchants[indexPath.section];
    cell.mallCartItem = merchant.items[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   UIView *bg  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 50)];
    bg.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 2, 46, 46)];
    
    Merchants *merchant = _checkModel.merchants[section];
    
    [imgv sd_setImageWithURL:[NSURL URLWithString:merchant.imageUrl]];
    [bg addSubview:imgv];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(70, 15, 300, 20)];
    name.text = merchant.merchantName ;
    name.font = EWKJfont(13);
    name.textColor = COLOR(0x33);
    [bg addSubview:name];
    return bg;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Merchants *merchant = _checkModel.merchants[indexPath.section];
//   CartItem *  mallCartItem = merchant.items[indexPath.row];
//    MallDetailViewController *detail = [[MallDetailViewController alloc]init];
//    detail.productID = (int)mallCartItem.productId;
//    [self.navigationController pushViewController:detail animated:NO];
//    
//}

-(void)botooMenu{
    UIView *bg =  [[UIView alloc]initWithFrame:CGRectMake(0, SH-bottomHeight-50, SW, 50)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    UILabel *rmb = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SW-115, 50)];
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString:@"需付： 00.00元"];
    [attr addAttributes:@{NSFontAttributeName:EWKJfont(18),NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(3, attr.length-3)];
    [attr addAttributes:@{NSFontAttributeName:EWKJfont(12),NSForegroundColorAttributeName:COLOR(0x33)} range:NSMakeRange(0, 3)];
    rmb.attributedText = attr;
    _needPayMonyLab =rmb;
    [bg addSubview:rmb];
    
    UIButton *buy = [UIButton buttonWithType:UIButtonTypeCustom];
    buy.frame = CGRectMake(SW-150, 0, 150, 50);
    [buy setBackgroundImage:[UIImage imageNamed:@"Head_portrait_bg"] forState:0];
    [buy setTitle:@"立即支付" forState:0];
    [buy setTitleColor:[UIColor whiteColor] forState:0];
    [bg addSubview:buy];
    [buy addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    
   
}

-(UIView*)headerV{
    if (_header == nil) {
        _header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 50)];
        _header.backgroundColor = [UIColor whiteColor];
      
        
        
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
        imgv.image = [UIImage imageNamed:@"landmark"];
        [_header addSubview:imgv];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(50, 15, 300, 20)];
        name.font = EWKJfont(13);
        name.textColor = COLOR(0x33);
        [_header addSubview:name];
        _adressLab = name;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SW-25, 15, 10, 20);
        [btn setBackgroundImage:[UIImage imageNamed:@"Personal_l"] forState:0];
        [_header addSubview:btn];
        
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addAdress)];
        UIView *topTouch= [[UIView alloc]initWithFrame:CGRectMake(SW-50, 15, 50, 20)];
        topTouch.backgroundColor = [UIColor clearColor];
        [_header addSubview:topTouch];
        [topTouch addGestureRecognizer:tap];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SW, 1)];
        line.backgroundColor  = COLOR(243);
        [_header addSubview:line];
    }
    return _header;
}

-(UIView*)footerV{
    
    if (!_footer) {
        _footer  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 120)];
        _footer.backgroundColor = COLOR(243);
        
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SW, 50)];
        bg.backgroundColor = [UIColor whiteColor];
        [_footer addSubview:bg];
        
        UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, SW-30, 50)];
        tf.font = EWKJfont(12);
        tf.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"选填： 买家留言 （50字以内）" attributes:@{NSForegroundColorAttributeName:COLOR(0x99)}];
        tf.delegate = self;
        [bg addSubview:tf];
        tf.delegate = self;
        _notesTF = tf;
        
        UIView *bg1= [[UIView alloc]initWithFrame:CGRectMake(0, 70, SW, 50)];
        bg1.backgroundColor = [UIColor whiteColor];
        [_footer addSubview:bg1];
        
        UILabel *name1= [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 50)];
        name1.textColor = COLOR(0x33);
        name1.font =EWKJfont(13);
        name1.text = @"商品小计";
        [bg1 addSubview:name1];
        
        _payMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(SW-100, 0, 80, 50)];
        _payMoneyLab.textColor = COLOR(0x33);
        _payMoneyLab.font =EWKJfont(13);
        _payMoneyLab.textAlignment = NSTextAlignmentRight;
        [bg1 addSubview:_payMoneyLab];
        _payMoneyLab.text = @"￥0.00";
        
       
    }
    return _footer;
}

-(void)addAdress{
    AddressViewController *adress = [[AddressViewController alloc]init];
    [self.navigationController pushViewController:adress animated:NO];
}

-(void)buy{
//     pay.PaymentMethod = 0;免费产品就不用跳支付页面了,
    
    
    PayViewController *pay= [[PayViewController alloc]init];
    pay.notes =_notesTF.text;
    pay.AddressId = _checkModel.address.internalBaseClassIdentifier;
    pay.money = _money;
    [self.navigationController pushViewController:pay animated:NO];
}

#pragma mark - 结算产品
-(void)requestCheckOut{
    [[EWKJRequest request]requestWithAPIId:order1 httphead:nil bodyParaDic:nil completed:^(id datas) {
        WeakSelf
        weakSelf.checkModel = [checkOutModel modelObjectWithDictionary:datas[Data]];
        [weakSelf.orderTab reloadData];
        
        NSString *addressName = nil;
        if (weakSelf.checkModel.address.addressFullName.length) {
            addressName = weakSelf.checkModel.address.addressFullName;
        }else if (weakSelf.checkModel.address.address1.length){
            addressName = weakSelf.checkModel.address.address1;
        }else{
            addressName = @"添加收货地址";
        }
        weakSelf.adressLab.text = addressName;
        [weakSelf caculateMoney];
    } error:^(NSError *error, NSInteger statusCode) {
        
    }];
}

#pragma mark -- 计算金额
-(void)caculateMoney{
    CGFloat money = 0;
    for (int i =0; i<_checkModel.merchants.count; i++) {
         Merchants *merchant = _checkModel.merchants[i];
        for (int j =0 ; j<merchant.items.count; j++) {
            CartItem *car = merchant.items[j];
            money += car.price*car.qty;
        }
    }
    _money = money;
    _payMoneyLab.text = [NSString stringWithFormat:@"￥%.2f",money];
   
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"需付：  %.2f元",money]];
    [attr addAttributes:@{NSFontAttributeName:EWKJfont(18),NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(3, attr.length-3)];
    [attr addAttributes:@{NSFontAttributeName:EWKJfont(12),NSForegroundColorAttributeName:COLOR(0x33)} range:NSMakeRange(0, 3)];
    _needPayMonyLab.attributedText = attr;
}

#pragma mark- tf delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location >50) {
        return NO;
    }else{
        return YES;
        
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
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
