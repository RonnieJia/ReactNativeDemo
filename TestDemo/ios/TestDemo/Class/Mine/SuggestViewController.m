//
//  SuggestViewController.m
//  APPFormwork
//
//  Created by jia on 2017/2/20.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "SuggestViewController.h"
#import "RJHTTPClient+Mine.h"

@interface SuggestViewController ()<UITextViewDelegate>
@property(nonatomic, weak)UILabel *placeLabel;
@property(nonatomic, weak)UILabel *contentNumLabel;
@property(nonatomic, weak)UITextView *textView;
@end

@implementation SuggestViewController

- (void)viewWillDisappear:(BOOL)animated {
    if ([self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self setBackButton];
    
    weakify(self);
    [self setNavBarBtnWithType:NavBarTypeRight title:@"提交" action:^{
        [weakSelf supprotSuggest];
    }];
    
    UILabel *textLabel = [UILabel labelWithFrame:CGRectMake(10, 15, self.view.width-100, 25) textColor:KTextDarkColor font:kFontWithDefaultSize text:@"您的意见或建议"];
    [self.view addSubview:textLabel];
    
    UILabel *numLabel = [UILabel labelWithFrame:CGRectMake(self.view.width - 90, textLabel.top, 80, textLabel.height) textColor:KTextDarkColor font:kFontWithDefaultSize textAlignment:NSTextAlignmentRight text:@"0/100"];
    self.contentNumLabel = numLabel;
    [self.view addSubview:numLabel];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, textLabel.bottom + 15, self.view.width, 230)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel *placeL = [UILabel labelWithFrame:CGRectMake(14, 22, 200, 20) textColor:KTextDarkColor font:kFontWithDefaultSize text:@"必填内容(100字以内)"];
    [placeL sizeToFit];
    self.placeLabel = placeL;
    [backView addSubview:placeL];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 15, self.view.width-20, 200)];
    textView.backgroundColor = [UIColor clearColor];
    textView.delegate = self;
    textView.font = kFontWithDefaultSize;
    [backView addSubview:textView];
    textView.layer.borderColor = [UIColor colorWithRed:0.25f green:0.60f blue:0.62f alpha:1.00f].CGColor;
    textView.layer.borderWidth = 1.0f;
    textView.layer.cornerRadius = 5.0f;
    textView.clipsToBounds = YES;
    self.textView = textView;
}

- (void)supprotSuggest {
    if (IsStringEmptyOrNull(self.textView.text)) {
        ShowAutoHideMBProgressHUD(KKeyWindow, @"请填写反馈内容");
        return;
    }
    [self.textView resignFirstResponder];
    WaittingMBProgressHUD(KKeyWindow, @"");
    weakify(self);
    [[RJHTTPClient sharedInstance] suggestWithText:self.textView.text completion:^(WebResponse *response) {
        if (response.code == WebResponseCodeSuccess) {
            SuccessMBProgressHUD(KKeyWindow, ObjForKeyInUnserializedJSONDic(response.responseObject, @"data"));
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            FailedMBProgressHUD(KKeyWindow, response.message);
        }
    }];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.placeLabel.hidden=YES;
    } else {
        self.placeLabel.hidden=NO;
    }
    if (textView.text.length > 100) {
        textView.text = [textView.text substringToIndex:100];
    }
    self.contentNumLabel.text = [NSString stringWithFormat:@"%zd/100",textView.text.length];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
