//
//  HomeViewController.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/30.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "HomeViewController.h"
#import "RJHTTPClient+Home.h"
#import "RJHTTPClient+Mine.h"
#import <React/RCTRootView.h>
#import <React/RCTBundleURLProvider.h>

@interface HomeViewController ()
@property(nonatomic, weak)RCTRootView *rootView;
@end


@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圈存自助";
    [self createMainView];
}

- (void)fetchUserInfo {
    WaittingMBProgressHUD(KKeyWindow, @"");
    weakify(self);
    [[RJHTTPClient sharedInstance] fetchUserInfoWithCompletion:^(WebResponse *response) {
        if (response.code == WebResponseCodeSuccess) {
          FinishMBProgressHUD(KKeyWindow);
          CurrentUserInfo *user = [CurrentUserInfo sharedInstance];
          NSString *replaceString = @"*********************************";
          NSString *idNo = user.idno;
          if (user.idno.length > 10) {
            NSInteger len = user.idno.length - 10;
            idNo = [user.idno stringByReplacingCharactersInRange:NSMakeRange(6, len) withString:[replaceString substringToIndex:len]];
          }
          
          weakSelf.rootView.appProperties = @{@"userName":user.name, @"icon":user.user_img, @"userType":user.user_type, @"money":user.money,@"userIssue":user.issue_name,@"idno":idNo};
        } else {
            FailedMBProgressHUD(KKeyWindow, response.message);
        }
    }];
}


- (void)createMainView {
  NSURL *jsCodeLocation;
  
//  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
  jsCodeLocation = [NSURL URLWithString:@"http://192.168.3.90:8081/index.ios.bundle?platform=ios&dev=true&minify=false"];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"Home"
                                               initialProperties:@{@"navigator":self.navigationController}
                                                   launchOptions:nil];
  self.rootView = rootView;
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  rootView.frame = self.view.bounds;
  [self.view addSubview:rootView];
//    NSArray *homeBanners = @[@"http://www.tjhaval.com:7363/great_wall/images/advert/img1.jpg",
//                             @"http://www.tjhaval.com:7363/great_wall/images/advert/img2.jpg",
//                             @"http://www.tjhaval.com:7363/great_wall/images/advert/img3.jpg"];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
