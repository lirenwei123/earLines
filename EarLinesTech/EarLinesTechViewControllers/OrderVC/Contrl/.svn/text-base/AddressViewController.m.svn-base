//
//  AddressViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/24.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "AddressViewController.h"
#import "addressCell.h"
#import "AddAddressViewController.h"
#import "addressModel.h"


@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *adressTab;
@property(nonatomic,strong)UIView *headerBGV;
@property(nonatomic,strong)NSMutableArray *addressModels;

@property(nonatomic,strong)addressModel *defualtmodel;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)addUI{
    _addressModels = @[].mutableCopy;
    self.navigationTitle.text = @"选择收货地址";
    if(_type == adressFlag_select){
        [self addRightBtnWithtitle:@"管理"];
    }
    _adressTab = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom-bottomHeight-10) style:UITableViewStylePlain];
    _adressTab.delegate = self;
    _adressTab.dataSource= self;
    _adressTab.tableFooterView = [[UIView alloc]init];
    _adressTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_adressTab];
    

        
        UIButton *addAddress = [UIButton buttonWithType:UIButtonTypeCustom];
        addAddress.frame = CGRectMake(0, SH-bottomHeight-50, SW, 50);
        [addAddress setBackgroundImage:[UIImage imageNamed:@"Head_portrait_bg"] forState:0];
        [addAddress setTitle:@"+ 添加收货地址" forState:0];
        [addAddress setTitleColor:[UIColor whiteColor] forState:0];
        [self.view addSubview:addAddress];
        [addAddress addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_headerBGV removeFromSuperview];
    [self requestAddressList];
}
#pragma mark - 请求地址列表

-(void)requestAddressList{
    WeakSelf
    [_addressModels removeAllObjects];
    [[EWKJRequest request]requestWithAPIId:addressApi4 httphead:nil bodyParaDic:nil completed:^(id datas) {
        NSArray *addresses = datas[Data];
        WeakSelf
        if (addresses.count) {
            for (int i =0; i<addresses.count; i++) {
                addressModel *model = [addressModel modelObjectWithDictionary:addresses[i]];
                [weakSelf.addressModels addObject:model];
            }
        }else{
            [weakSelf haveNoAddress];
        }
         [weakSelf.adressTab reloadData];
    } error:^(NSError *error, NSInteger statusCode) {
        [weakSelf TipWithErrorCode:statusCode];
    }];
}

#pragma mark -添加地址
-(void)addAddress{
    [self.navigationController pushViewController:[[AddAddressViewController alloc]init] animated:NO];
    
}
#pragma mark - 删除地址
-(void)requestDeleteAddress:(addressModel *)address{
    WeakSelf
    [[EWKJRequest request]requestWithAPIId:addressApi6 httphead:[NSString stringWithFormat:@"%.0f",address.internalBaseClassIdentifier] bodyParaDic:nil completed:^(id datas) {
        [weakSelf alertWithString:@"删除地址成功"];
        [weakSelf requestAddressList];
    } error:^(NSError *error, NSInteger statusCode) {
        
    }];
}
#pragma mark -设置默认地址
-(void)requestDefeaultAddress:(addressModel *)address{
    WeakSelf
    [[EWKJRequest request]requestWithAPIId:addressApi8 httphead:[NSString stringWithFormat:@"%.0f",address.internalBaseClassIdentifier] bodyParaDic:nil completed:^(id datas) {
        if (weakSelf.type == adressFlag_select) {
            [weakSelf.navigationController popViewControllerAnimated:NO];
        }
    } error:^(NSError *error, NSInteger statusCode) {
        
    }];
}
-(void)haveNoAddress{
    
    if(_headerBGV == nil){
    _headerBGV = [[UIView alloc]initWithFrame:CGRectMake(0, navigationBottom+20, SW, 80)];

    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((SW-100)/2, 0, 100, 20)];
    lab.text =@"还没有地址";
    lab.textColor= COLOR(0x99);
    lab.font = EWKJfont(12);
    lab.textAlignment = NSTextAlignmentCenter;
    [_headerBGV addSubview:lab];
    
    UIView *linel = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(lab.frame)-60, 10, 50, 1)];
        linel.backgroundColor = COLOR(0xe3);
    [_headerBGV addSubview:linel];
    UIView *liner = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, 10, 50, 1)];
    liner.backgroundColor =  COLOR(0xe3);
    [_headerBGV addSubview:liner];
    }
    return [self.view addSubview:_headerBGV];
}
//管理地址
-(void)rightNavitemCLick{
    if (_addressModels.count) {
        AddressViewController *adress = [[AddressViewController alloc]init];
        adress.type = adressFlag_manage;
        [self.navigationController pushViewController:adress animated:NO];
    }else{
        [self alertWithString:@"还没有添加地址"];
    }
   
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _addressModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _type == adressFlag_select?94:144;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    addressCell *cell = nil;
    if (_type == adressFlag_select) {
        cell= [addressCell addressCell];
        cell.item  = _addressModels[indexPath.row];
    }else{
        addressModel *item = _addressModels[indexPath.row];
        cell = [addressCell mannageAdressCell];
          cell.item  = item;
        if (item.defaultAddressInd) {
            _defualtmodel = item;
        }
        WeakSelf
        cell.editAddressBlock = ^(addressModel *address) {
            AddAddressViewController *edit = [[AddAddressViewController alloc]init];
            edit.address = weakSelf.addressModels[indexPath.row];
            edit.edit = YES;
            [self.navigationController pushViewController:edit animated:NO];
        };
        cell.deleteAddressBlock = ^(addressModel *address) {
            [weakSelf requestDeleteAddress:weakSelf.addressModels[indexPath.row]];
        };
        cell.defaultAddressIndBlock = ^(BOOL defaultId) {
            [weakSelf requestDefeaultAddress:weakSelf.addressModels[indexPath.row]];
        };
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
        addressModel *model = _addressModels[indexPath.row];
    if (model.internalBaseClassIdentifier != _defualtmodel.internalBaseClassIdentifier) {
        
        [self requestDefeaultAddress:model];
        
        if (_type == adressFlag_manage) {
            addressModel *item = _addressModels[indexPath.row];
            item.defaultAddressInd = YES;
            _defualtmodel.defaultAddressInd = NO;
            _defualtmodel = item;
            [_adressTab reloadData];
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
