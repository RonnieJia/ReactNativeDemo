//
//  AppEntrance.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/30.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "AppEntrance.h"
#import "RJTabBarController.h"
#import "RJNavigationController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "StoreViewController.h"
#import "CardViewController.h"
#import "LoginViewController.h"
#import "RJHTTPClient+Login.h"
#import "AppDelegate.h"
#import "EmptyViewController.h"

@implementation AppEntrance
+ (void)changeRootViewControllerToTabBarController {
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.window.rootViewController = [self makeTabbarController];
}

+(void)changeRootViewControllerToLogin {
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.window.rootViewController = [self makeLoginViewController];
}

+ (void)setRootViewController {
    ClearHomeBanner();// 清除首页banner的缓存
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    BOOL isFirstRun = !([[NSUserDefaults standardUserDefaults] boolForKey:@"RJAppNotFirstRun_zhg"]);
    if (isFirstRun) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"RJAppNotFirstRun_zhg"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        appdelegate.window.rootViewController = [self makeLoginViewController];
    } else {
        if (IsSaveUser()) {// 自动登录
            appdelegate.window.rootViewController = [EmptyViewController new];
            [[RJHTTPClient sharedInstance] userLoginWithUserName:GetUserName() pwd:GetUserPwd() completion:^(WebResponse *response) {
                if (response.code == WebResponseCodeSuccess) {
                    [CurrentUserInfo sharedInstance].userName = GetUserName();
                    appdelegate.window.rootViewController = [AppEntrance makeTabbarController];
                } else {
                    appdelegate.window.rootViewController = [AppEntrance makeLoginViewController];
                }
            }];
        } else {
            appdelegate.window.rootViewController = [AppEntrance makeLoginViewController];
        }
    }
}

+ (UIViewController *)makeLoginViewController {
    LoginViewController *login = [[LoginViewController alloc] init];
    return [[RJNavigationController alloc] initWithRootViewController:login];
}

+ (UIViewController *)makeTabbarController {
    HomeViewController *home = [HomeViewController new];
    UINavigationController *homeNav = [[RJNavigationController alloc] initWithRootViewController:home];
    
    MineViewController *mine = [MineViewController new];
    UINavigationController *mineNav = [[RJNavigationController alloc] initWithRootViewController:mine];
    
    StoreViewController *store = [StoreViewController new];
    UINavigationController *storeNav = [[RJNavigationController alloc] initWithRootViewController:store];
    
    CardViewController *card = [CardViewController new];
    UINavigationController *cardNav = [[RJNavigationController alloc] initWithRootViewController:card];
    
    RJTabBarController *tabbar = [[RJTabBarController alloc] init];
    tabbar.viewControllers = @[homeNav, storeNav, cardNav, mineNav];
    
    
    homeNav.tabBarItem = [RJTabBarController addButtonWithNormalImage:[UIImage imageNamed:@"tabbar0"] selectedImage:[UIImage imageNamed:@"tabbar0s"] title:@"首页"];
    mineNav.tabBarItem = [RJTabBarController addButtonWithNormalImage:[UIImage imageNamed:@"tabbar3"] selectedImage:[UIImage imageNamed:@"tabbar3s"] title:@"个人中心"];
    storeNav.tabBarItem = [RJTabBarController addButtonWithNormalImage:[UIImage imageNamed:@"tabbar1"] selectedImage:[UIImage imageNamed:@"tabbar1s"] title:@"圈存中心"];
    cardNav.tabBarItem = [RJTabBarController addButtonWithNormalImage:[UIImage imageNamed:@"tabbar2"] selectedImage:[UIImage imageNamed:@"tabbar2s"] title:@"卡务中心"];
    return tabbar;
}
@end
