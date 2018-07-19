

#import "ProvinceTF.h"
#import "Province.h"

@interface ProvinceTF()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
@property (strong,nonatomic) NSArray * provinces;
@property (assign,nonatomic) NSInteger indexForProvince;
@property (strong,nonatomic) NSMutableArray * chooseArr;
@end


@implementation ProvinceTF

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}

-(void)setUP{
    UIPickerView *provincePK = [[UIPickerView alloc]init];
    provincePK.dataSource = self;
    provincePK.delegate  = self;
    self.delegate  = self;
    self.inputView = provincePK;
    provincePK.backgroundColor = [UIColor whiteColor];
//    self.placeholder = @"点击选择省市";
}

-(NSArray *)provinces {
    if (_provinces == nil) {
        _provinces = [Province provinceList];
    }
    return _provinces;
}
-(NSMutableArray *)chooseArr {
    if (_chooseArr == nil) {
        _chooseArr = [NSMutableArray array];
        Province *pro = self.provinces.firstObject;
        [_chooseArr addObject:pro.name];
        [_chooseArr addObject:pro.cities.firstObject];
    }
    return _chooseArr;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return self.provinces.count;
    }
    else {
        Province *pro = self.provinces[_indexForProvince];
        return pro.cities.count;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        Province *pro = self.provinces[row];
        return pro.name;
    }
    
    Province *pro = self.provinces[_indexForProvince];
    return pro.cities[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        Province *pro = self.provinces[row];
        NSString *name = pro.name;
        
        [self.chooseArr replaceObjectAtIndex:0 withObject:name];
        [self.chooseArr replaceObjectAtIndex:1 withObject:pro.cities.firstObject];
        
        self.text = [NSString stringWithFormat:@"%@%@",self.chooseArr[0],self.chooseArr[1] ];
        _indexForProvince = row;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }else {
        Province *pro = self.provinces[_indexForProvince];
        NSString *cityName = pro.cities[row];
        [self.chooseArr replaceObjectAtIndex:1 withObject:cityName];
        self.text = [NSString stringWithFormat:@"%@%@",self.chooseArr[0],self.chooseArr[1] ];
    }
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return NO;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.text = [NSString stringWithFormat:@"%@%@",self.chooseArr[0],self.chooseArr[1] ];
    return YES;
}

@end
