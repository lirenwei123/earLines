//
//  ScoreDetailViewController.m
//  EarLinesTech
//
//  Created by  RWLi on 2018/6/10.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "ScoreDetailViewController.h"
#import "ScoreModel.h"
#import "PointDetailCell.h"





@interface ScoreDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *models;
@property(nonatomic,strong)UITableView *tab;
@end

@implementation ScoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationTitle.text = @"积分明细";
    [self request];

    _tab =  [[UITableView alloc]initWithFrame:CGRectMake(0, navigationBottom, SW, SH-navigationBottom-statusBarHeight)];
    _tab.backgroundColor = COLOR(240);
    _tab.delegate  =self;
    _tab.dataSource = self;
    [_tab registerNib:[UINib nibWithNibName:@"PointDetailCell" bundle:nil] forCellReuseIdentifier:@"scoreCell"];
    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tab.tableFooterView = [[UIView alloc]init];
    

    [self.view addSubview:_tab];
    
}

-(void)request{
    if (!_models) {
        _models = @[].mutableCopy;
    }else{
        [_models removeAllObjects];
    }
    WeakSelf
    NSString *url = [NSString stringWithFormat:@"%@user/pointstatements?pageSize=%d&pageIndex=%d",httpHead,50,1];
    [HttpRequest lrw_getWithURLString:url parameters:nil success:^(id responseObject) {
        NSArray *datas = responseObject[Data];
        if (datas.count) {
            for (int i = 0; i <datas.count; i++) {
                [weakSelf.models addObject:[ScoreModel modelObjectWithDictionary:datas[i]]];
            }
            [weakSelf.tab reloadData];
        }else{
            [weakSelf haveNoSocre];
        }
    } failure:^(NSError *error, NSInteger errorCode) {
        
    }];
}

#pragma mark-  tabDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _models.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PointDetailCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"scoreCell" forIndexPath:indexPath];
    cell.item = _models[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
   
}


-(void)haveNoSocre{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((SW-150)/2, navigationBottom+30, 150, 20)];
    lab.text =@"没有积分明细数据!";
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
