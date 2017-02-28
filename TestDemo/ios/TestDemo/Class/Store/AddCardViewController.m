//
//  AddCardViewController.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/28.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "AddCardViewController.h"
#import "VerifyPhoneViewController.h"
#import "AgreeViewController.h"

@interface AddCardViewController ()<UITextFieldDelegate>
@property(nonatomic, weak)UIScrollView *scrollView;
@property(nonatomic, weak)UITextField *bankCardTextField;
@property(nonatomic, weak)UITextField *cardTypeTextField;
@property(nonatomic, weak)UITextField *mobileTextField;
@property(nonatomic, weak)UIButton *agreeBtn;
@end

@implementation AddCardViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resignFirst];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定银行卡";
    [self setBackButton];
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, KScreenHeight-64)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    UITapGestureRecognizer *resignTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirst)];
    [scrollView addGestureRecognizer:resignTap];
    
    self.cardTypeTextField = [self createWithTop:10 title:@"卡类型" line:NO];
    self.cardTypeTextField.text = @"中国银行 信用卡";
    self.cardTypeTextField.enabled = NO;
    self.cardTypeTextField.textColor = [UIColor colorWithRed:0.24f green:0.62f blue:0.93f alpha:1.00f];
    
    UILabel *typeLabel = [UILabel labelWithFrame:CGRectMake(10, 55, scrollView.width-20, 36) textColor:KTextGrayColor font:kFontWithDefaultSize text:@"请填写银行卡信息"];
    [scrollView addSubview:typeLabel];
    
    self.bankCardTextField = [self createWithTop:typeLabel.bottom title:@"银行卡" line:YES];
    self.bankCardTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.bankCardTextField.placeholder = @"请输入银行卡号";
    [self.bankCardTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    self.bankCardTextField.delegate = self;
    
    self.mobileTextField = [self createWithTop:typeLabel.bottom + 45 title:@"手机号" line:NO];
    self.mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.mobileTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    self.mobileTextField.placeholder = @"请输入绑定银行卡的手机号";
    
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(self.view.width/2.0 - 65, typeLabel.bottom + 130, 20, 20);
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"agree_normal_sel"] forState:UIControlStateSelected];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"agree_normal"] forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"agree_right"] forState:UIControlStateSelected];
    [agreeBtn setImage:createImageWithColor([UIColor clearColor]) forState:UIControlStateNormal];
    agreeBtn.selected = YES;
    agreeBtn.tag = 100;
    [scrollView addSubview:agreeBtn];
    [agreeBtn addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.agreeBtn = agreeBtn;
    
    UIButton *agreementBtn = [[UIButton alloc] initWithFrame:CGRectMake(agreeBtn.right + 3, agreeBtn.top, 120, 20)];
    [scrollView addSubview:agreementBtn];
    agreementBtn.titleLabel.font = kFontWithSmallSize;
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:@"同意《用户协议》"];
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.36f green:0.53f blue:0.81f alpha:1.00f] range:NSMakeRange(2, 6)];
    [attribute addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(2, 6)];
    [agreementBtn setAttributedTitle:attribute forState:UIControlStateNormal];
    agreementBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [agreementBtn addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextBtn = [UIButton sureButtonWithTitle:@"提交信息"];
    nextBtn.top = agreeBtn.bottom + 35;
    [scrollView addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    scrollView.contentSize = CGSizeMake(self.view.width, nextBtn.bottom + 30);
#ifdef RJDebug
    self.bankCardTextField.text = @"236";
    self.mobileTextField.text = @"13263525242";
#endif
    
}

- (void)resignFirst {
    [self.cardTypeTextField resignFirstResponder];
    [self.bankCardTextField resignFirstResponder];
    [self.mobileTextField resignFirstResponder];
}

- (void)agreeButtonAction:(UIButton *)button {
    if (button.tag == 100) {
        button.selected = !button.selected;
    } else {
        AgreeViewController *help = [[AgreeViewController alloc] init];
        [self.navigationController pushViewController:help animated:YES];
    }
}

- (void)nextButtonAction:(UIButton *)button {
    NSArray *bankArray = [self.bankCardTextField.text componentsSeparatedByString:@" "];
    NSString *bankCard = [bankArray componentsJoinedByString:@""];
    if (IsStringEmptyOrNull(bankCard)) {
        ShowAutoHideMBProgressHUD(KKeyWindow, @"请输入银行卡号");
        return;
    }
    if (IsStringEmptyOrNull(self.mobileTextField.text)) {
        ShowAutoHideMBProgressHUD(KKeyWindow, @"请输入手机号");
        return;
    }
    if (!IsNormalMobileNum(self.mobileTextField.text)) {
        ShowAutoHideMBProgressHUD(KKeyWindow, @"请输入正确的手机号");
        return;
    }
    if (!self.agreeBtn.selected) {
        ShowAutoHideMBProgressHUD(KKeyWindow, @"请仔细阅读并同意用户协议");
        return;
    }
    
    VerifyPhoneViewController *verify = [[VerifyPhoneViewController alloc] init];
    verify.phoneString = self.mobileTextField.text;
    verify.bankCard = bankCard;
    [self.navigationController pushViewController:verify animated:YES];
}

- (UITextField *)createWithTop:(CGFloat)top title:(NSString *)title line:(BOOL)line {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, top, self.view.width, 45)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:backView];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 15.0/2.0, backView.width-20, 30)];
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backView addSubview:tf];
    
    UILabel *leftLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 80, 30) textColor:KTextBlackColor font:kFontWithDefaultSize text:title];
    tf.leftView = leftLabel;
    tf.leftViewMode = UITextFieldViewModeAlways;
    
    if (line) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 44, backView.width-10, 1.0)];
        [backView addSubview:line];
        line.backgroundColor = [UIColor colorWithRed:0.88f green:0.88f blue:0.88f alpha:1.00f];
    }
    
    return tf;
    
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


- (void)textFieldDidChanged:(UITextField *)textField {
    if (textField == self.mobileTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    } else if (textField == self.bankCardTextField) {
        if (self.bankCardTextField.text.length > 19) {
            self.bankCardTextField.text = [self.bankCardTextField.text substringToIndex:19];
        }
    }
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
