//
//  LossViewController.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/25.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "LossViewController.h"
#import "RJHTTPClient+Mine.h"
#import "AppEntrance.h"
#import "TransferView.h"

@interface LossViewController ()<UITextFieldDelegate>
@property(nonatomic, weak)UIScrollView *scrollView;
@property(nonatomic, assign)NSInteger type;
@property(nonatomic, weak)UITextField *userIdTextField;
@property(nonatomic, weak)UITextField *sureTextField;
@property(nonatomic, weak)UITextField *pwdTextField;
@property(nonatomic, weak)UITextField *amountTextField;
@end

@implementation LossViewController
- (instancetype)initWithType:(NSInteger)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resignTextField];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    if (self.type == 1) {
        self.title = @"自助挂失";
    } else if (self.type == 2) {
        self.title = @"自助解挂";
    } else if (self.type == 3) {
        self.title = @"自助转账";
    } else {
        self.title = @"修改密码";
    }
    [self setBackButton];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, KScreenHeight-64)];
    self.scrollView = scroll;
    [scroll addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignTextField)]];
    [self.view addSubview:scroll];
    
    CGFloat buttonTop;
    if (self.type < 3) {
        
        self.userIdTextField = [self createWithTop:10 title:@"当前一卡通：" place:@"手机号/身份证号" line:YES];
        self.userIdTextField.delegate = self;
        
        self.pwdTextField = [self createWithTop:55 title:@"一卡通密码：" place:@"密码" line:NO];
        self.pwdTextField.secureTextEntry = YES;
        
        buttonTop = 200;
    } else if (self.type == 3) {
        self.userIdTextField = [self createWithTop:10 title:@"对方信息：" place:@"手机号/身份证号" line:YES];
        self.userIdTextField.delegate = self;
        
        self.sureTextField = [self createWithTop:55 title:@"信息确认：" place:@"再次输入对方信息" line:YES];
        self.sureTextField.delegate = self;
        
        self.pwdTextField = [self createWithTop:100 title:@"卡号密码：" place:@"请输入您的饭卡密码" line:YES];
        self.pwdTextField.secureTextEntry = YES;
        
        self.amountTextField = [self createWithTop:145 title:@"转账金额：" place:@"请输入转账金额" line: NO];
        
        buttonTop = 280;
    } else if (self.type == 4) {
        self.userIdTextField = [self createWithTop:10 title:@"原始密码：" place:@"请输入原来的密码" line:YES];
        self.userIdTextField.secureTextEntry = YES;
        
        self.pwdTextField = [self createWithTop:55 title:@"新密码：" place:@"请输入新密码" line:YES];
        self.pwdTextField.secureTextEntry = YES;
        
        self.sureTextField = [self createWithTop:100 title:@"确认密码：" place:@"请再次输入新密码" line:NO];
        self.sureTextField.secureTextEntry = YES;
        
        buttonTop = 245;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, buttonTop, self.view.width-60, 45);
    button.layer.cornerRadius = 5.0f;
    button.clipsToBounds = YES;
    button.centerX = self.view.width/2.0f;
    button.backgroundColor = [UIColor colorWithRed:0.86f green:0.18f blue:0.18f alpha:1.00f];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    NSString *buttonTitle = @"转账";
    if (self.type == 1) {
        buttonTitle = @"挂失";
    } else if (self.type == 2) {
        buttonTitle = @"解挂";
    } else if (self.type == 4) {
        buttonTitle = @"确认修改";
    }
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [scroll addSubview:button];
    scroll.contentSize = CGSizeMake(self.view.width, button.bottom + 25);
}

- (UITextField *)createWithTop:(CGFloat)top title:(NSString *)title place:(NSString *)place line:(BOOL)line {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, top, self.view.width, 45)];
    view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view];
    
    UILabel *label = [UILabel labelWithFrame:CGRectMake(0, 0, 100, 20) textColor:KTextBlackColor font:kFontWithDefaultSize text:title];
    [label sizeToFit];
    label.height = 25;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.width-20, 25)];
    textField.leftView = label;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.placeholder = place;
    [view addSubview:textField];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    if (line) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 44, self.view.width-10, 1)];
        [view addSubview:line];
        line.backgroundColor = [UIColor colorWithRed:0.88f green:0.88f blue:0.88f alpha:1.00f];
    }
    return textField;
}

- (void)buttonAction:(UIButton *)button {
    if (![self verifyInput]) {
        return;
    }
    [self resignTextField];
    NSString *userName = [self.userIdTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    weakify(self);
    WaittingMBProgressHUD(KKeyWindow, @"");
    if (self.type == 1) {
        [[RJHTTPClient sharedInstance] lossWithPhone:userName pwd:self.pwdTextField.text completion:^(WebResponse *response) {
            if (response.code == WebResponseCodeSuccess) {
                SuccessMBProgressHUD(KKeyWindow, StringForKeyInUnserializedJSONDic(response.responseObject, @"data"));
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            } else {
                FailedMBProgressHUD(KKeyWindow, response.message);
                if (response.code == WebResponseCodeLogout) {
                    [AppEntrance changeRootViewControllerToLogin];
                }
            }
        }];
    } else if (self.type == 2) {
        [[RJHTTPClient sharedInstance] cancelLossWithPhone:userName pwd:self.pwdTextField.text completion:^(WebResponse *response) {
            if (response.code == WebResponseCodeSuccess) {
                SuccessMBProgressHUD(KKeyWindow, StringForKeyInUnserializedJSONDic(response.responseObject, @"data"));
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            } else {
                FailedMBProgressHUD(KKeyWindow, response.message);
                if (response.code == WebResponseCodeLogout) {
                    [AppEntrance changeRootViewControllerToLogin];
                }
            }
        }];
    } else if (self.type == 3) {
        [[RJHTTPClient sharedInstance] fetchTransferUserNameWithOppUserName:userName completion:^(WebResponse *response) {
            if (response.code == WebResponseCodeSuccess) {
                FinishMBProgressHUD(KKeyWindow);
                NSDictionary *infoDict = ObjForKeyInUnserializedJSONDic(response.responseObject, @"data");
                if (infoDict && [infoDict isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *userInfo = ObjForKeyInUnserializedJSONDic(infoDict, @"userinfo");
                    if (userInfo && [userInfo isKindOfClass:[NSDictionary class]]) {
                        [[TransferView sharedInstance] showWithName:StringForKeyInUnserializedJSONDic(userInfo, @"oppName") transfer:^{
                            [weakSelf makeSureTransfer];
                        }];
                    }
                }
            } else {
                FailedMBProgressHUD(KKeyWindow, response.message);
                if (response.code == WebResponseCodeLogout) {
                    [AppEntrance changeRootViewControllerToLogin];
                }
            }
        }];
        

    } else if (self.type == 4) {
        [[RJHTTPClient sharedInstance] changePwd:self.userIdTextField.text newPwd:self.pwdTextField.text completion:^(WebResponse *response) {
            if (response.code == WebResponseCodeSuccess) {
                SuccessMBProgressHUD(KKeyWindow, StringForKeyInUnserializedJSONDic(response.responseObject, @"data"));
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    ClearUser();
                    [AppEntrance changeRootViewControllerToLogin];
                });
            } else {
                FailedMBProgressHUD(KKeyWindow, response.message);
            }
        }];
    }
}

- (void)resignTextField {
    [self.userIdTextField resignFirstResponder];
    [self.sureTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
    [self.amountTextField resignFirstResponder];
}

- (void)makeSureTransfer {
    weakify(self);
    WaittingMBProgressHUD(KKeyWindow, @"");
    NSString *userName = [self.userIdTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[RJHTTPClient sharedInstance] transferWithOther:userName cardPWD:self.pwdTextField.text amount:self.amountTextField.text completion:^(WebResponse *response) {
        if (response.code == WebResponseCodeSuccess) {
            SuccessMBProgressHUD(KKeyWindow, StringForKeyInUnserializedJSONDic(response.responseObject, @"data"));
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } else {
            FailedMBProgressHUD(KKeyWindow, response.message);
        }
    }];
}

- (BOOL)verifyInput {
    if (self.type == 1 || self.type == 2) {
        if (IsStringEmptyOrNull(self.userIdTextField.text)) {
            ShowAutoHideMBProgressHUD(KKeyWindow, @"请输入当前一卡通");
            return NO;
        }
        if (IsStringEmptyOrNull(self.pwdTextField.text)) {
            ShowAutoHideMBProgressHUD(KKeyWindow, @"请输入一卡通密码");
            return NO;
        }
        return YES;
    } else if (self.type == 3) {
        if (IsStringEmptyOrNull(self.userIdTextField.text)) {
            ShowAutoHideMBProgressHUD(KKeyWindow, @"请输入对方信息");
            return NO;
        }
        if (![self.userIdTextField.text isEqualToString:self.sureTextField.text]) {
            ShowAutoHideMBProgressHUD(KKeyWindow, @"对方信息两次输入不一致");
            return NO;
        }
        if (IsStringEmptyOrNull(self.pwdTextField.text)) {
            ShowAutoHideMBProgressHUD(KKeyWindow, @"请输入饭卡密码");
            return NO;
        }
        if (IsStringEmptyOrNull(self.amountTextField.text)) {
            ShowAutoHideMBProgressHUD(KKeyWindow, @"请输入转账金额");
            return NO;
        }
    } else if (self.type == 4) {
        if (IsStringEmptyOrNull(self.userIdTextField.text)) {
            ShowAutoHideMBProgressHUD(KKeyWindow, @"请输入原密码");
            return NO;
        }
        if (IsStringEmptyOrNull(self.pwdTextField.text)) {
            ShowAutoHideMBProgressHUD(KKeyWindow, @"请输入新密码");
            return NO;
        }
        if (![self.pwdTextField.text isEqualToString:self.sureTextField.text]) {
            ShowAutoHideMBProgressHUD(KKeyWindow, @"新密码两次输入不一致");
            return NO;
        }
    }
    return YES;
}

#pragma mark - 键盘弹出及收起
- (void)keyboardWasShown:(NSNotification *)noti {
    //键盘高度
    CGFloat keyBoardHeight = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.scrollView.height = KScreenHeight-64-keyBoardHeight;
}

- (void)keyboardWillBeHidden:(NSNotification *)noti {
    self.scrollView.height = KScreenHeight-64;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        RJLog(@"删除");
    } else {
        if ((textField.text.length + 1)%5 == 0) {
            textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
        }
        
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
