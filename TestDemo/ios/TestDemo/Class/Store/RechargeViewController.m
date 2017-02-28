//
//  RechargeViewController.m
//  APPFormwork
//
//  Created by jia on 2017/2/20.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "RechargeViewController.h"
#import "RJHTTPClient+Mine.h"
#import "RechargeView.h"

@interface RechargeViewController ()<UITextFieldDelegate>
@property(nonatomic, weak)UIScrollView *scrollView;
@property(nonatomic, weak)UITextField *moneyTextField;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圈存卡充值";
    [self setBackButton];
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [self createMainView];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.moneyTextField isFirstResponder]) {
        [self.moneyTextField resignFirstResponder];
    }
}


/**
 选择充值金额
 */
- (void)chooseRechargeMoney:(UIButton *)button {
    weakify(self);
    [[RechargeView sharedInstance] showWithMoney:button.currentTitle alertBlock:^{
        [weakSelf rechageMoney];
    }];
}


/**
 充值
 */
- (void)rechargeButtonAction {
    if (IsStringEmptyOrNull(self.moneyTextField.text)) {
        ShowAutoHideMBProgressHUD(KKeyWindow, @"请输入充值金额");
        return;
    }
    [self.moneyTextField resignFirstResponder];
    weakify(self);
    [[RechargeView sharedInstance] showWithMoney:self.moneyTextField.text alertBlock:^{
        [weakSelf rechageMoney];
    }];
}

- (void)rechageMoney {
    if (IsStringEmptyOrNull([CurrentUserInfo sharedInstance].backCard)) {
        ShowAutoHideMBProgressHUD(KKeyWindow, @"未绑定银行卡，无法充值");
        return;
    }
    WaittingMBProgressHUD(KKeyWindow, @""); weakify(self);
    [[RJHTTPClient sharedInstance] rechargeWithMoney:self.moneyTextField.text completion:^(WebResponse *response) {
        if (response.code == WebResponseCodeSuccess) {
            SuccessMBProgressHUD(KKeyWindow, StringForKeyInUnserializedJSONDic(response.responseObject, @"data"));
            weakSelf.moneyTextField.text = @"";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } else {
            FailedMBProgressHUD(KKeyWindow, response.message);
        }
    }];
}

- (void)resignMoneyInput {
    [self.moneyTextField resignFirstResponder];
}

- (void)createMainView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, KScreenHeight-64)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignMoneyInput)]];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 170)];
    headerView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:headerView];
    
    UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, 169, headerView.width, 1.0)];
    [headerView addSubview:hLine];
    hLine.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f];
    
    UILabel *textLabel = [UILabel labelWithFrame:CGRectMake(20, 35, headerView.width-40, 25) textColor:KTextDarkColor font:kFontWithDefaultSize textAlignment:NSTextAlignmentCenter text:@"一卡通余额"];
    [headerView addSubview:textLabel];
    
    UILabel *moneyLabel = [UILabel labelWithFrame:CGRectMake(textLabel.left, textLabel.bottom + 15, textLabel.width, 48) textColor:[UIColor redColor] font:kFont(42) textAlignment:NSTextAlignmentCenter text:[NSString stringWithFormat:@"%@元",[CurrentUserInfo sharedInstance].money]];
    [headerView addSubview:moneyLabel];
    
    UILabel *label = [UILabel labelWithFrame:CGRectMake(10, headerView.bottom + 10, scrollView.width-20, 20) textColor:KTextGrayColor font:kFontWithDefaultSize text:@"充值金额"];
    [scrollView addSubview:label];
    
    CGFloat itemWidth = (scrollView.width - 50) / 4.0;
    CGFloat itemHeight = itemWidth * 5.0 / 8.0f;
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, label.bottom + 10, scrollView.width, itemHeight + 25)];
    itemView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:itemView];
    NSArray *titles = @[@"200",@"150",@"100",@"50"];
    for (int i = 0; i<4; i++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(i * (itemWidth + 10) + 10, 15, itemWidth, itemHeight);
        [itemView addSubview:item];
        [item setTitle:titles[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor colorWithRed:0.53f green:0.53f blue:0.53f alpha:1.00f] forState:UIControlStateNormal];
        item.layer.borderColor = [UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f].CGColor;
        item.layer.borderWidth = 1.0;
        [item setTitleColor:KTextBlackColor forState:UIControlStateSelected];
        item.titleLabel.font = kFontWithBigSize;
        [item addTarget:self action:@selector(chooseRechargeMoney:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *label2 = [UILabel labelWithFrame:CGRectMake(label.left, itemView.bottom + 10, label.width, label.height) textColor:KTextGrayColor font:kFontWithDefaultSize text:@"其他金额"];
    [scrollView addSubview:label2];
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, label2.bottom + 10, scrollView.width, 45)];
    inputView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:inputView];
    
    UITextField *moneyTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, inputView.width-20, 35)];
    [inputView addSubview:moneyTF];
    [moneyTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    moneyTF.placeholder = @"请输入您想要的充值金额";
    moneyTF.font = kFontWithBigSize;
    moneyTF.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyTextField = moneyTF;
    moneyTF.delegate = self;
    
    UIButton *sureButton = [UIButton sureButtonWithTitle:@"其他金额充值"];
    sureButton.top = inputView.bottom + 80;
    [scrollView addSubview:sureButton];
    [sureButton addTarget:self action:@selector(rechargeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    scrollView.contentSize = CGSizeMake(self.view.width, sureButton.bottom + 30);
}

#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"."]) {// 限制只能输入一个小数点，且首位不能是小数点
        if (textField.text.length == 0 || [textField.text rangeOfString:@"."].location != NSNotFound) {
            return NO;
        }
    }
    if ([textField.text isEqualToString:@"0"] && [string isEqualToString:@"0"]) {// 限制不能只输入0
        return NO;
    }
    return YES;
}

/** textField 输入 */
- (void)textFieldDidChanged:(UITextField *)textField {
    NSRange range = [textField.text rangeOfString:@"."];
    if (range.location != NSNotFound) {// 限制小数点后只能输入两位
        if (textField.text.length > (range.location + 3)) {
            textField.text = [textField.text substringToIndex:range.location + 3];
        }
    }
    
    if ([textField.text floatValue] > 99999999) {// 限制最大输入的数字是99999999
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            textField.text = @"99999999";
        } else {
            textField.text = @"99999999.0";
        }
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
