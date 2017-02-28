//
//  CardEditViewController.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/2/20.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "CardEditViewController.h"
#import "AddCardViewController.h"
#import "RJHTTPClient+Mine.h"
#import "RJHTTPClient+Home.h"
#import "RechargeView.h"

@interface CardEditViewController ()
@property(nonatomic, weak)UILabel *cardLabel;
@end

@implementation CardEditViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchUserInfo];
}

- (void)fetchUserInfo {
    WaittingMBProgressHUD(KKeyWindow, @"");
    weakify(self);
    [[RJHTTPClient sharedInstance] fetchUserInfoWithCompletion:^(WebResponse *response) {
        if (response.code == WebResponseCodeSuccess) {
            FinishMBProgressHUD(KKeyWindow);
            [weakSelf displayUserInfo];
        } else {
            FailedMBProgressHUD(KKeyWindow, response.message);
        }
    }];
}

- (void)displayUserInfo {
    if (IsStringEmptyOrNull([CurrentUserInfo sharedInstance].backCard)) {
        self.cardLabel.text = @"无";
        self.cardLabel.font = kFontWithBigestSize;
    } else {
        self.cardLabel.text = UserName([CurrentUserInfo sharedInstance].backCard);
        self.cardLabel.font = kFontWithDefaultSize;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定/解除银行卡";
    [self setBackButton];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 160)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UILabel *textLabel = [UILabel labelWithFrame:CGRectMake(20, 35, self.view.width-40, 25) textColor:KTextDarkColor font:kFontWithDefaultSize textAlignment:NSTextAlignmentCenter text:@"当前圈存卡"];
    [headerView addSubview:textLabel];
    
    UILabel *cardLabel = [UILabel labelWithFrame:CGRectMake(20, textLabel.bottom + 20, textLabel.width, 45) textColor:[UIColor blueColor] font:kFontWithDefaultSize textAlignment:NSTextAlignmentCenter text:nil];
    [headerView addSubview:cardLabel];
    self.cardLabel = cardLabel;
    
    if (IsStringEmptyOrNull([CurrentUserInfo sharedInstance].backCard)) {
        cardLabel.text = @"无";
        cardLabel.font = kFontWithBigestSize;
    } else {
        cardLabel.text = UserName([CurrentUserInfo sharedInstance].backCard);
        cardLabel.font = kFontWithDefaultSize;
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.height-1, headerView.width, 1.0)];
    line.backgroundColor = KSepLineColor;
    [headerView addSubview:line];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.bottom + 30, self.view.width, 91)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton *resignBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resignBtn.frame = CGRectMake(10, 0, bottomView.width-10, 45);
    [bottomView addSubview:resignBtn];
    [resignBtn setTitle:@"解绑银行卡" forState:UIControlStateNormal];
    [resignBtn setTitleColor:KTextDarkColor forState:UIControlStateNormal];
    resignBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    resignBtn.titleLabel.font = kFontWithDefaultSize;
    [resignBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(10, resignBtn.bottom, resignBtn.width, 1.0)];
    sepLine.backgroundColor = KSepLineColor;
    [bottomView addSubview:sepLine];
    
    UIButton *bondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bondBtn.frame = CGRectMake(10, sepLine.bottom, sepLine.width, 45);
    [bottomView addSubview:bondBtn];
    [bondBtn setTitle:@"绑定银行卡" forState:UIControlStateNormal];
    bondBtn.tag = 100;
    [bondBtn setTitleColor:KTextDarkColor forState:UIControlStateNormal];
    bondBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    bondBtn.titleLabel.font = kFontWithDefaultSize;
    [bondBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonAction:(UIButton *)button {
    if (button.tag == 100) {
        if (!IsStringEmptyOrNull([CurrentUserInfo sharedInstance].backCard)) {
            ShowAutoHideMBProgressHUD(KKeyWindow, @"您已绑定银行卡");
            return;
        }
        AddCardViewController *add = [[AddCardViewController alloc] init];
        [self.navigationController pushViewController:add animated:YES];
    } else {
        if (IsStringEmptyOrNull([CurrentUserInfo sharedInstance].backCard)) {
            ShowAutoHideMBProgressHUD(KKeyWindow, @"您还未绑定银行卡");
        } else {
            weakify(self);
            [[RechargeView sharedInstance] showResign:^{
                [weakSelf resignBankCard];
            }];
        }
    }
}

/**
 解除绑定银行卡
 */
- (void)resignBankCard {
    WaittingMBProgressHUD(KKeyWindow, @"");
    [[RJHTTPClient sharedInstance] resignBankCardWithCompletion:^(WebResponse *response) {
        if (response.code == WebResponseCodeSuccess) {
            SuccessMBProgressHUD(KKeyWindow, StringForKeyInUnserializedJSONDic(response.responseObject, @"data"));
            [CurrentUserInfo sharedInstance].backCard = @"";
        } else {
            FailedMBProgressHUD(KKeyWindow, response.message);
        }
    }];
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
