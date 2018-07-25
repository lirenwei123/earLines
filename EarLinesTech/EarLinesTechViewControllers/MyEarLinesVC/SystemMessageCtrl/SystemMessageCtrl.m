//
//  SystemMessageCtrl.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/7/18.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "SystemMessageCtrl.h"
#import "MessageModel.h"
#import "MessageDetailCtrl.h"

@interface SystemMessageCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray *modles;
@end

@implementation SystemMessageCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestMessage];
}

-(void)addUI{
    self.navigationTitle.text = @"系统消息";
    [self addReturn];
    self.view.backgroundColor = COLOR(249);
    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom-bottomHeight) style:UITableViewStylePlain];
    _tab.backgroundColor = COLOR(243);
    _tab.delegate = self;
    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tab.dataSource =  self;
    [self.view addSubview:_tab];
    _tab.tableFooterView = [[UIView alloc]init];
}
-(void)requestMessage{
//    GET api/user/system/messages?pageSize={pageSize}&pageIndex={pageIndex}
    WeakSelf
    
    if (_modles){
         [_modles removeAllObjects];
    }else{
     _modles = @[].mutableCopy;
    }
    
    
    
    NSString * url =[NSString stringWithFormat:@"%@user/system/messages?pageSize=50&pageIndex=1",httpHead];
    [HttpRequest lrw_getWithURLString:url parameters:nil success:^(id responseObject) {
        if (responseObject) {
            NSArray *datas = responseObject[Data];
            
            for (NSDictionary *dict in datas) {
                MessageModel *model = [MessageModel modelObjectWithDictionary:dict];
                [weakSelf.modles addObject:model];
            }
            [weakSelf.tab reloadData];
        }
    } failure:^(NSError *error, NSInteger errorCode) {
        [weakSelf alertWithString:[NSString stringWithFormat:@"%@",error]];
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"message"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"message"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = COLOR(243);
        
         MessageModel *model = _modles[indexPath.row];
        
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SW, 60)];
        bg.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:bg];
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, SW-50, 25)];
        lab1.font = EWKJfont(14);
        lab1.text = model.title;
        [bg addSubview:lab1];
        
        UILabel *lab2= [[UILabel alloc]initWithFrame:CGRectMake(20, 30, SW-50, 25)];
        lab2.font = EWKJfont(12);
        lab2.text = model.createDt;
        lab2.textColor = [UIColor grayColor];
        [bg addSubview:lab2];
    
        
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(SW-30, 22.5, 10, 15)];
        imgv.image = [UIImage imageNamed:@"Personal_l"];
        [bg addSubview:imgv];
        
       
    }
    cell.contentView.frame = CGRectMake(0, 10, SW, 40);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageDetailCtrl *detail = [[MessageDetailCtrl alloc]init];
    detail.message = _modles[indexPath.row];
    [self.navigationController pushViewController:detail animated:NO];
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
