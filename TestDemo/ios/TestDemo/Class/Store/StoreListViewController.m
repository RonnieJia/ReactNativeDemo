//
//  StoreListViewController.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/25.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "StoreListViewController.h"
#import "CheckTableViewCell.h"
#import "RJHTTPClient+Mine.h"
#import "CheckModel.h"
#import "AppEntrance.h"

@interface StoreListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)NSString *month;

@end

@implementation StoreListViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的圈存账单";
    [self setBackButton];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, KScreenHeight-64)];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    tableView.rowHeight = 80.0f;
    tableView.backgroundColor  = kNavBarBgColo;
    self.tableView = tableView;
    
    [self fetchCheckList];
}

- (void)fetchCheckList {
    WaittingMBProgressHUD(KKeyWindow, @"");
    weakify(self);
    [[RJHTTPClient sharedInstance] storeListWithPage:1 completion:^(WebResponse *response) {
        if (response.code == WebResponseCodeSuccess) {
            FinishMBProgressHUD(KKeyWindow);
            [weakSelf.dataArray removeAllObjects];
            NSDictionary *dataDict = ObjForKeyInUnserializedJSONDic(response.responseObject, @"data");
            if (dataDict && [dataDict isKindOfClass:[NSDictionary class]]) {
                NSArray *billInfo = ObjForKeyInUnserializedJSONDic(dataDict, @"bill_info");
                if (billInfo && [billInfo isKindOfClass:[NSArray class]] && billInfo.count > 0) {
                    NSDictionary *billItemDict = [billInfo firstObject];
                    if (billItemDict && [billItemDict isKindOfClass:[NSDictionary class]]) {
                        [weakSelf.dataArray addObjectsFromArray:[CheckModel arrayWithJSONDict:billItemDict]];
                        weakSelf.month = StringForKeyInUnserializedJSONDic(billItemDict, @"month");
                    }
                }
            }
            [weakSelf.tableView reloadData];
        } else {
            FailedMBProgressHUD(KKeyWindow, response.message);
        }
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckTableViewCell *cell = [CheckTableViewCell cellWithTableView:tableView];
    [cell cellHideStateLabel];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 50)];
    headView.backgroundColor = [UIColor colorWithRed:0.86f green:0.18f blue:0.18f alpha:1.00f];
    
    UILabel *sectionLabel = [UILabel labelWithFrame:CGRectMake(10, 10, KScreenWidth-20, 30) textColor:[UIColor whiteColor] font:kFontWithBigSize text:self.month];
    [headView addSubview:sectionLabel];
    
    return headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
