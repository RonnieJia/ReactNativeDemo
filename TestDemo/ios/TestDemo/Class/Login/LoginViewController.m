//
//  LoginViewController.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/30.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "LoginViewController.h"
#import "AppEntrance.h"
#import "RJHTTPClient+Login.h"



@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic, weak)UIScrollView *scrollView;
@property(nonatomic, weak)UIView *inputView;
@property(nonatomic, weak)UITextField *phoneTextField;
@property(nonatomic, weak)UITextField *pwdTextField;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
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
    [self makeMainView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)makeMainView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mainScrollView];
    mainScrollView.bounces = NO;
    [mainScrollView setContentSize:CGSizeMake(self.view.width, mainScrollView.height)];
    self.scrollView = mainScrollView;
    mainScrollView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *resignTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirst)];
    [mainScrollView addGestureRecognizer:resignTap];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [mainScrollView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"login"];
    
    CGFloat top = KScreenHeight < 500 ? 200 : KAUTOSIZE(290);
    self.phoneTextField = [self createTextField:top place:@"手机号/身份证号" image:@"login_name"];
    self.phoneTextField.returnKeyType = UIReturnKeyNext;
    
    self.pwdTextField = [self createTextField:top + KAUTOSIZE(60) place:@"密码" image:@"login_pwd"];
    self.pwdTextField.secureTextEntry = YES;
    self.pwdTextField.returnKeyType = UIReturnKeyDone;
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(KAUTOSIZE(70), top + KAUTOSIZE(150), self.view.width-KAUTOSIZE(140), 40);
    loginBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    loginBtn.layer.cornerRadius = 8.0f;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:KTextBlackColor forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kFontWithBigSize;
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:loginBtn];
    
#ifdef RJDebug
    self.phoneTextField.text = @"8088880000000001668";
    self.pwdTextField.text = @"111111";
#endif
    
}

- (UITextField *)createTextField:(CGFloat)top place:(NSString *)place image:(NSString *)image {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(KAUTOSIZE(60), top, self.view.width-KAUTOSIZE(120), 45)];
    [self.scrollView addSubview:view];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, view.width, 35)];
    [view addSubview:textField];
    textField.placeholder = place;
    [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.textColor = KTextBlackColor;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.adjustsFontSizeToFitWidth = YES;
    textField.delegate = self;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 35)];
    textField.leftView = imageView;
    imageView.image = [UIImage imageNamed:image];
    imageView.contentMode = UIViewContentModeLeft;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(textField.left, textField.bottom, textField.width, 1.0)];
    line.backgroundColor = [UIColor whiteColor];
    [view addSubview:line];
    
    return textField;
}

- (void)resignFirst {
    [self.phoneTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}

#pragma mark - 键盘弹出及收起
- (void)keyboardWasShown:(NSNotification *)noti {
    //键盘高度
    CGFloat keyBoardHeight = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.scrollView.height = KScreenHeight-keyBoardHeight;
}

- (void)keyboardWillBeHidden:(NSNotification *)noti {
    self.scrollView.height = KScreenHeight;
}
#pragma mark - UITextFieldDelegate
- (void)textFiledDidChanged:(UITextField *)textField {
    if (textField.text.length > 11) {
        textField.text = [textField.text substringToIndex:11];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        [textField resignFirstResponder];
        [self.pwdTextField becomeFirstResponder];
        return NO;
    } else if (textField == self.pwdTextField) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

/// 登录
- (void)loginBtnClick:(UIButton *)button {
    if (IsStringEmptyOrNull(self.phoneTextField.text)) {
        ShowAutoHideMBProgressHUD(self.view, @"请输入用户名");
        return;
    }
    if (IsStringEmptyOrNull(self.pwdTextField.text)) {
        ShowAutoHideMBProgressHUD(self.view, @"请输入密码");
        return;
    }
    WaittingMBProgressHUD(KKeyWindow, @"正在登录");
    weakify(self);
    [[RJHTTPClient sharedInstance] userLoginWithUserName:self.phoneTextField.text pwd:self.pwdTextField.text completion:^(WebResponse *response) {
        if (response.code == WebResponseCodeSuccess) {
            [CurrentUserInfo sharedInstance].userName = weakSelf.phoneTextField.text;
            SaveUser(weakSelf.phoneTextField.text, weakSelf.pwdTextField.text);
            [AppEntrance changeRootViewControllerToTabBarController];
        } else {
            FailedMBProgressHUD(KKeyWindow, response.message);
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
