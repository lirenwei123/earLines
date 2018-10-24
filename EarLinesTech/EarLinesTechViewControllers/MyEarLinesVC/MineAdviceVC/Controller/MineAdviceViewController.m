//
//  MineAdviceViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/6/10.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "MineAdviceViewController.h"

@interface MineAdviceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSArray *RelationsipDatas;
@property(nonatomic,strong)NSArray *saveFirstRelationsipDatas;

@property(nonatomic,assign)BOOL isSecondShip;
@end

@implementation MineAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationTitle.text = @"我的推荐";
    [self request];
    _tab =  [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom-statusBarHeight)];
    _tab.delegate  =self;
    _tab.dataSource = self;
    _tab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tab.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    _tab.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tab];
}


-(void)request{

    NSString *url = [NSString stringWithFormat:@"%@user/relationship?pageSize=%d&pageIndex=%d",httpHead,10,1];
    WeakSelf
    [HttpRequest lrw_getWithURLString:url parameters:nil success:^(id responseObject) {
        weakSelf.RelationsipDatas = responseObject[Data];
        if (weakSelf.RelationsipDatas.count == 0) {
            [weakSelf haveNoRelationsip];
        }
        weakSelf.saveFirstRelationsipDatas = weakSelf.RelationsipDatas.copy;
        [weakSelf.tab reloadData];
        
        
    } failure:^(NSError *error, NSInteger errorCode) {
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _RelationsipDatas.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"advice"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"advice"];
    }
    
    NSDictionary *dict = _RelationsipDatas[indexPath.row];

    cell.textLabel.text = [dict objectForKey:@"NickName"];
    cell.textLabel.textColor = COLOR(51);
    cell.textLabel.font = EWKJfont(13);
    
    cell.detailTextLabel.text = [dict objectForKey:@"Account"];
    cell.detailTextLabel.textColor = COLOR(153);
    cell.detailTextLabel.font = EWKJfont(11);
    

    cell.accessoryType = _isSecondShip?UITableViewCellAccessoryNone: UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSecondShip) {
        return;
    }
     NSDictionary *dict = _RelationsipDatas[indexPath.row];
    NSArray * secondShips = [dict objectForKey:@"SecondLevels"];
    _RelationsipDatas = secondShips;
    _isSecondShip = YES;
    [_tab reloadData];
    
}

-(void)returnCLick{
    if (!_isSecondShip) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        _RelationsipDatas = _saveFirstRelationsipDatas.copy;
        _isSecondShip =NO;
        [_tab reloadData];
    }
}

-(void)haveNoRelationsip{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((SW-150)/2, navigationBottom+30, 150, 20)];
    lab.text =@"您还没有推荐人!";
    lab.textColor= COLOR(0x99);
    lab.font = EWKJfont(12);
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    UIView *linel = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(lab.frame)-60, navigationBottom+40, 50, 1)];
    linel.backgroundColor = COLOR(0xe3);
    [self.view addSubview:linel];
    UIView *liner = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+10, navigationBottom+40, 50, 1)];
    liner.backgroundColor =  COLOR(0xe3);
    [self.view addSubview:liner];
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
