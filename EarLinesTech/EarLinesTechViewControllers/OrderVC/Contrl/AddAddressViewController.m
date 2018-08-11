//
//  AddAddressViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/24.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "AddAddressViewController.h"
#import "BLAreaPickerView.h"
#import "CountryState.h"
#import "Cities.h"

@interface AddAddressViewController ()<BLPickerViewDelegate>
@property(nonatomic,strong)BLAreaPickerView  *pickView;
@property(nonatomic,strong)EWKJBtn * addressBtn;

@property(nonatomic,strong)NSMutableArray *tfs;

@end

@implementation AddAddressViewController
{
    int _provinceId;
    int _stateId;
    int _cityId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestProviceState];
}

-(void)addUI{
    self.navigationTitle.text = @"添加收货地址";
    
    _tfs = @[].mutableCopy;
    NSArray  *titles = @[@"收件人",@"联系电话",@"所在地区",@"详细地址"].copy;
    NSArray *placeholderTitles = @[@"收件人",@"联系电话",@"请选择所在地区",@"街道，楼牌号等"].copy;
    
    
    CGFloat top = navigationBottom;
    CGFloat h = 50;
    for (int i  =0; i<titles.count; i++) {
        
        UILabel *left = [[UILabel alloc]initWithFrame:CGRectMake(15, top+h*i, 80, 50)];
        left.font = EWKJfont(14);
        left.textColor  = COLOR(0x33);
        left.text = titles[i];
        [self.view addSubview:left];
        
        if ([placeholderTitles[i] isEqualToString:@"请选择所在地区"]) {
          
            WeakSelf
            EWKJBtn *address = [[EWKJBtn alloc]initWithFrame:CGRectMake(105, top +h*i, SW-135, h) img:nil title:@"请选择所在地区" touchEvent:^(EWKJBtn *btn) {
                [weakSelf seletAddress];
            } andbtnType:BTNTYPETEXT];
            
            [self.view addSubview:address];
            address.lab.font =  EWKJfont(14);
            address.lab.textAlignment = NSTextAlignmentLeft;
            [self.view addSubview:address];
            _addressBtn = address;
           
          
           

        }else{
            
            UITextField *tf= [[UITextField alloc]initWithFrame:CGRectMake(105, top +h*i, SW-135, h)];
            tf.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:tf];
            tf.font = EWKJfont(14);
            tf.textAlignment = NSTextAlignmentLeft;
            tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderTitles[i] attributes:@{NSForegroundColorAttributeName:COLOR(0x99) }];
            [_tfs addObject:tf];
            
        }
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, top+49+h*i, SW-30, 1)];
        line.backgroundColor = COLOR(0xde);
        [self.view addSubview:line];
        
       
        
        if (i == titles.count -1) {
            UIButton *saveAddress = [UIButton buttonWithType:UIButtonTypeCustom];
            saveAddress.frame = CGRectMake(15, top+50+h*i+20, SW-30, 50);
            [saveAddress setBackgroundImage:[UIImage imageNamed:@"Head_portrait_bg"] forState:0];
            [saveAddress setTitle:@"保存地址" forState:0];
            [saveAddress setTitleColor:[UIColor whiteColor] forState:0];
            [self.view addSubview:saveAddress];
            [saveAddress addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    if (_address) {
        UITextField *tf0  =_tfs[0];
        tf0.text = _address.consigneeName;
        
        UITextField *tf1  =_tfs[1];
        tf1.text = _address.phoneNumber;
        
        UITextField *tf2 = _tfs[2];
        tf2.text = _address.address1;
        
        _addressBtn.lab.text = [_address.addressFullName stringByReplacingOccurrencesOfString:_address.address1 withString:@""];
        
        _provinceId = _address.countryId;
        _stateId = _address.stateId;
        _cityId = _address.cityId;
    }
   
    
}

//选择地址

//保存地址
-(void)saveAddress{

    if ([_tfs[0] text].length <1 ) {
        [self alertWithString:@"请输入收件人姓名"];
        return;
    }else if ([_tfs[1] text].length <1 ){
        [self alertWithString:@"请输入收件人电话"];
        return;
    }else if ([_addressBtn.lab.text isEqualToString:@"请选择所在地区"] ){
        [self alertWithString:@"请选择收货地址"];
        return;
    }else if([_tfs[2] text].length <1 ){
        [self alertWithString:@"请输入街道地址"];
        return;
    }
    WeakSelf
    
 
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@(1),@"Id",
                          [_tfs[0] text],@"ConsigneeName",
                          [_tfs[1] text],@"PhoneNumber",
                          [_tfs[1] text],@"MarkedPhoneNumber",
                          @(_provinceId),@"CountryId",
                          @(_stateId),@"StateId",
                          @(_cityId),@"CityId",
                        [_tfs[2] text],@"Address1",
                           _addressBtn.lab.text ,@"AddressFullName",
                          @1,@"DefaultAddressInd",nil];
    if (_edit) {
        [[EWKJRequest request]requestWithAPIId:addressApi6 httphead:[NSString stringWithFormat:@"%.0f",_address.internalBaseClassIdentifier] bodyParaDic:nil completed:^(id datas) {
            
            [[EWKJRequest request]requestWithAPIId:addressApi5 httphead:nil bodyParaDic:dict.mutableCopy completed:^(id datas) {
                 [weakSelf.navigationController  popViewControllerAnimated:NO];
            } error:^(NSError *error, NSInteger statusCode) {
                
            }];
            
        } error:^(NSError *error, NSInteger statusCode) {
            
        }];
    }else{
        
        [[EWKJRequest request]requestWithAPIId:addressApi5 httphead:nil bodyParaDic:dict.mutableCopy completed:^(id datas) {
             [weakSelf.navigationController  popViewControllerAnimated:NO];
        } error:^(NSError *error, NSInteger statusCode) {
            
        }];
    }
    
    
   
}

-(void)seletAddress{
    
    [self.view endEditing:YES];
    if (!_pickView) {
        
        _pickView = [[BLAreaPickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
        _pickView.pickViewDelegate = self;
        _pickView.cancelButtonColor = COLOR(0x66);
        _pickView.sureButtonColor = RGB(0x11, 0xa8, 0x3c);
       
    }
     [_pickView bl_show];
}


#pragma mark - 请求省市区

-(void)requestProviceState{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:HAVECOUNTRYFILE]) {
        
        [[EWKJRequest request]requestWithAPIId:addressApi9 httphead:nil bodyParaDic:nil completed:^(id datas) {
            NSMutableArray * Countrys = @[].mutableCopy;
            NSArray * diqus  = datas[Data][@"Countries"];
            if (diqus.count) {
                for (int i =0 ; i<diqus.count; i++) {
                    CountryState *cs = [CountryState modelObjectWithDictionary:diqus[i]];
                    [Countrys addObject:cs];
                }
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [NSKeyedArchiver archiveRootObject:Countrys toFile:COUNTRYPATH];
                });
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:HAVECOUNTRYFILE];
            }
            
            
        } error:^(NSError *error, NSInteger statusCode) {
            
        }];
    }
}

#pragma mark - - BLPickerViewDelegate
- (void)bl_selectedAreaResultWithProvince:(NSString *)provinceTitle city:(NSString *)cityTitle area:(NSString *)areaTitle provinceId:(int)provinceId stateId:(int)stateId cityId:(int)cityId{
 
    _provinceId = provinceId;
    _stateId = stateId;
    _cityId = cityId;
    
    _addressBtn.lab.text= [NSString stringWithFormat:@"%@%@%@",provinceTitle,cityTitle,areaTitle];

    
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
