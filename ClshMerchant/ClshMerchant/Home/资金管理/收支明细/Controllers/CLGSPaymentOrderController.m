//
//  CLGSPaymentOrderController.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/25.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSPaymentOrderController.h"
#import "CLGSWithdrawalsDetailFirstCell.h"
#import "CLGSPaymentOrderSecondCell.h"
#import "CLSHAccountBalanceModel.h"

@interface CLGSPaymentOrderController ()
{
    CLSHAccountIncomeDetailModel *incomeAndExpendDetailModel;  ///<收支详情数据模型
    NSMutableDictionary *params;    ///<收支详情参数
}

@end

@implementation CLGSPaymentOrderController

static NSString *const firstCellID = @"firstCell";
static NSString *const secondCellID = @"secondCell";

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = backGroundColor;
    self.tableView.scrollEnabled=NO;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CLGSWithdrawalsDetailFirstCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:firstCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLGSPaymentOrderSecondCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:secondCellID];
    
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    if ([[pushJudge objectForKey:@"push"] isEqualToString:@"push"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:(UIBarButtonItemStylePlain) target:self action:@selector(rebackToforeViewControllerAction)];
    }
}

- (void)rebackToforeViewControllerAction{
    
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"push"];
    [pushJudge synchronize];//记得立即同步
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <loadData>
- (void)loadData
{
    incomeAndExpendDetailModel = [[CLSHAccountIncomeDetailModel alloc] init];
    params = [NSMutableDictionary dictionary];
    //传入对应的ID
    params[@"id"] = self.typeID;
    [incomeAndExpendDetailModel fetchAccountIncomeDetailData:params callBack:^(BOOL isSuccess, id result){
        if (isSuccess) {
            incomeAndExpendDetailModel = result;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
    
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLGSWithdrawalsDetailFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:firstCellID];
    CLGSPaymentOrderSecondCell *secondCell = [tableView dequeueReusableCellWithIdentifier:secondCellID];
    if (indexPath.section == 0) {
        if (!firstCell) {
            firstCell = [[CLGSWithdrawalsDetailFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellID];
        }
        firstCell.amount = self.amount;
        firstCell.type = self.type;
        firstCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return firstCell;
    }else
    {
        if (!secondCell) {
            secondCell = [[CLGSPaymentOrderSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellID];
        }
        secondCell.incomeAndExpendDetailModel = incomeAndExpendDetailModel;
        secondCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return secondCell;
    }
    return nil;
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 120*AppScale;
    }
    return 170*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10*AppScale;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - setter getter
-(void)setTypeID:(NSString *)typeID
{
    _typeID = typeID;
}

-(void)setType:(NSString *)type
{
    _type = type;
    if ([type isEqualToString:@"debit"]) {
        [self.navigationItem setTitle:@"支出详情"];
    }else
    {
        [self.navigationItem setTitle:@"收入详情"];
    }
}

- (void)setAmount:(CGFloat)amount
{
    _amount = amount;
}

@end
