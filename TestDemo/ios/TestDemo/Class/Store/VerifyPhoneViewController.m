//
//  VerifyPhoneViewController.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/2/6.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "VerifyPhoneViewController.h"
#import "AddCardViewController.h"
#import "RJHTTPClient+Mine.h"
#import "TransferView.h"
#import "VerifyButton.h"



@interface VerifyPhoneViewController ()
@property(nonatomic, weak)UITextField *codeTextField;
@property(nonatomic, weak)UIButton *codeBtn;
@property(nonatomic, strong)NSArray *viewControllers;
@end

@implementation VerifyPhoneViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证手机号";
    [self setBackButton];
    self.viewControllers = [NSArray arrayWithArray:self.navigationController.viewControllers];
    UINavigationController *nav = self.navigationController;
    NSMutableArray *array = [NSMutableArray array];
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[AddCardViewController class]]) {
            continue;
        } else {
            [array addObject:vc];
        }
    }
    nav.viewControllers = array;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, KScreenHeight-64)];
    [self.view addSubview:scrollView];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(20, 75, self.view.width-40, 1)];
    [scrollView addSubview:line1];
    line1.backgroundColor = [UIColor colorWithRed:0.88f green:0.88f blue:0.88f alpha:1.00f];
    
    UITextField *codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(line1.left, line1.bottom + 15, line1.width, 45)];
    [scrollView addSubview:codeTextField];
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    codeTextField.placeholder = @"请输入验证码";
    self.codeTextField = codeTextField;
    
    VerifyButton *fetchBtn = [VerifyButton verifyButtonWithFrame:CGRectMake(0, 0, 100, 45) title:@"获取验证码" titleFont:16.0 titleColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithRed:0.86f green:0.18f blue:0.18f alpha:1.00f] time:60];
    fetchBtn.layer.cornerRadius = 6.0f;
    fetchBtn.layer.masksToBounds = YES;
    codeTextField.rightView = fetchBtn;
    codeTextField.rightViewMode = UITextFieldViewModeAlways;
    [fetchBtn addTarget:self action:@selector(fetchVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn = fetchBtn;
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(line1.left, codeTextField.bottom + 15, line1.width, 1.0)];
    line2.backgroundColor = [UIColor colorWithRed:0.88f green:0.88f blue:0.88f alpha:1.00f];
    [scrollView addSubview:line2];
    
    UIButton *nextBtn = [UIButton sureButtonWithTitle:@"签约"];
    nextBtn.top = line2.bottom + 60;
    [scrollView addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(nextButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)fetchVerifyCode:(UIButton *)button {
    if (button.selected) {
        return;
    }
    weakify(self);
    [[TransferView sharedInstance] showVerifyPhone:self.phoneString transfer:^{
        button.selected = YES;
        [weakSelf getVerifyCode];
    }];
}

- (void)getVerifyCode {
    weakify(self);
    WaittingMBProgressHUD(KKeyWindow, @"");
    [[RJHTTPClient sharedInstance] fetchVerifyCodeWithBankCard:self.bankCard mobile:self.phoneString completion:^(WebResponse *response) {
        if (response.code == WebResponseCodeSuccess) {
            SuccessMBProgressHUD(KKeyWindow, @"发送验证码成功");
        } else {
            weakSelf.codeBtn.selected = NO;
            FailedMBProgressHUD(KKeyWindow, response.message);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.navigationController.viewControllers = self.viewControllers;
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }
    }];
}

- (void)nextButton {
    if (IsStringEmptyOrNull(self.codeTextField.text)) {
        ShowAutoHideMBProgressHUD(KKeyWindow, @"请输入验证码");
        return;
    }
    
    WaittingMBProgressHUD(KKeyWindow, @""); weakify(self);
    [[RJHTTPClient sharedInstance] verifyCode:self.codeTextField.text bamkCard:self.bankCard completion:^(WebResponse *response) {
        if (response.code == WebResponseCodeSuccess) {
            SuccessMBProgressHUD(KKeyWindow, @"绑定银行卡成功");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
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
