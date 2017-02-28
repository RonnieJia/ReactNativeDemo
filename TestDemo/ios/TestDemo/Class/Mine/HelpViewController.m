//
//  HelpViewController.m
//  APPFormwork
//
//  Created by jia on 2017/2/6.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "HelpViewController.h"
#import <WebKit/WebKit.h>

@interface HelpViewController ()<WKNavigationDelegate,WKUIDelegate>
@property(nonatomic, weak)WKWebView *webView;
@property(nonatomic, weak)UIButton *reloadBtn;
@property(nonatomic, strong)NSString *loadRequest;
@end

@implementation HelpViewController

- (instancetype)initWithTitle:(NSString *)title loadRequest:(NSString *)request {
    self = [super init];
    if (self) {
        self.title = title;
        self.loadRequest = request;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButton];
    /*
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    */
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, KScreenHeight-64)];
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadRequest]]];
    self.webView = webView;
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    [webView sizeToFit];
    
    UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reloadBtn setTitle:@"加载失败，点击重试" forState:UIControlStateNormal];
    [reloadBtn setTitleColor:KTextGrayColor forState:UIControlStateNormal];
    reloadBtn.titleLabel.font = kFontWithDefaultSize;
    [self.view addSubview:reloadBtn];
    reloadBtn.frame = CGRectMake(0, 0, self.view.width, 100);
    reloadBtn.centerY = self.view.height/2.0f;
    reloadBtn.hidden = YES;
    self.reloadBtn = reloadBtn;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    WaittingMBProgressHUD(KKeyWindow, @"");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    FinishMBProgressHUD(KKeyWindow);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    FinishMBProgressHUD(KKeyWindow);
    self.reloadBtn.hidden = NO;
}

- (void)relaodWebView {
    self.reloadBtn.hidden = YES;
    if (self.webView.isLoading) {
        [self.webView stopLoading];
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadRequest]]];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    ShowAutoHideMBProgressHUD(KKeyWindow, message);
    if ([message isEqualToString:@"提交成功"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
    completionHandler();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
