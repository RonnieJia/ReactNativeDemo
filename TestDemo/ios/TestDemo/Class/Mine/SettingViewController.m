//
//  SettingViewController.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/24.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "SettingViewController.h"
#import "HelpViewController.h"
#import "SuggestViewController.h"
#import "HTTPWebAPIUrl.h"
#import "AppEntrance.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSArray *dataArray;
@end

@implementation SettingViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setBackButton];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, KScreenHeight-64-45)];
    [self.view addSubview:tableView];
    tableView.bounces = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    [self createFootView];
}

- (void)createFootView {
    UIButton *logout = [UIButton buttonWithType:UIButtonTypeCustom];
    logout.frame = CGRectMake(0, self.view.height-45-64, self.view.width, 45);
    logout.backgroundColor = [UIColor colorWithRed:0.86f green:0.18f blue:0.18f alpha:1.00f];
    [logout setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [logout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logout];
}

- (void)logout {
    ClearUser();
    [AppEntrance changeRootViewControllerToLogin];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 15)];
    foot.backgroundColor = [UIColor colorWithRed:0.88f green:0.88f blue:0.88f alpha:1.00f];
    return foot;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 25)];
    head.backgroundColor = [UIColor colorWithRed:0.88f green:0.88f blue:0.88f alpha:1.00f];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"settingcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textColor = KTextBlackColor;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SuggestViewController *suggest = [[SuggestViewController alloc] init];
        [self.navigationController pushViewController:suggest animated:YES];
    } else if (indexPath.row == 1) {
        NSString *request = [NSString stringWithFormat:@"%@/instructions/new_version_about.html",kBaseUrl];
        HelpViewController *help = [[HelpViewController alloc] initWithTitle:@"使用帮助" loadRequest:request];
        [self.navigationController pushViewController:help animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"意见反馈",@"使用帮助"];
    }
    return _dataArray;
}

@end
