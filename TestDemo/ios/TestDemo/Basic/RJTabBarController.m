//
//  RJTabBarController.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/23.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "RJTabBarController.h"
#import "AppDelegate.h"

#define kTableBarFontSize                       [UIFont systemFontOfSize:10.0]
#define kTabBarTitleNormalColor                 [UIColor lightGrayColor]
#define kTabBarTitleSelectColor                 [UIColor blackColor]

@interface RJTabBarController ()

@end

@implementation RJTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+ (RJTabBarController *)curTabbarController{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    RJTabBarController* tabControl = (RJTabBarController*)appDelegate.window.rootViewController;
    
    return tabControl;
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //去掉当前选择button上的阴影
    if ([self.tabBar respondsToSelector:@selector(setSelectionIndicatorImage:)]) {
        self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"TabItem_SelectionIndicatorImage.png"];//设置选中时图片
    }
    
    //去掉顶部阴影条
    if ([UITabBar instancesRespondToSelector:@selector(setShadowImage:)]) {// > iOS 6.0
        [self.tabBar setShadowImage:[UIImage imageNamed:@"TabItem_SelectionIndicatorImage"]];
    }
    
    //设置背景
    UIColor* color = kTabBarBgColor;
    self.tabBar.barTintColor = color;
    
    //title颜色
    [[UITabBarItem appearance] setTitleTextAttributes:
     @{ NSFontAttributeName: kTableBarFontSize,
        NSForegroundColorAttributeName: kTabBarTitleNormalColor}
                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:
     @{ NSFontAttributeName: kTableBarFontSize,
        NSForegroundColorAttributeName: [UIColor colorWithRed:0.86f green:0.18f blue:0.18f alpha:1.00f]}
                                             forState:UIControlStateSelected];
    
    //title位置
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0, -2.0)];
    
    [[UITabBar appearance] setShadowImage:createImageWithColor([UIColor colorWithRed:226/255.0f green:226/255.0f blue:226/255.0f alpha:0.8f])];
    
    [[UITabBar appearance] setBackgroundImage:createImageWithColor(kTabBarBgColor)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



+ (UITabBarItem* )addButtonWithNormalImage:(UIImage *)normalImage
                             selectedImage:(UIImage*)selectedImage
                                     title:(NSString*)title
{
    UITabBarItem *tabBarItem = nil;
    UIImage *image=[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:image];
    
    
    NSMutableDictionary *atts=[NSMutableDictionary dictionary];
    // 更改文字大小
//    atts[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    // 更改文字颜色
    atts[NSForegroundColorAttributeName]=[UIColor colorWithRed:0.57f green:0.57f blue:0.57f alpha:1.00f];
    [tabBarItem setTitleTextAttributes:atts forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAtts=[NSMutableDictionary dictionary];
    selectedAtts[NSForegroundColorAttributeName]=[UIColor colorWithRed:0.86f green:0.18f blue:0.18f alpha:1.00f];
    [tabBarItem setTitleTextAttributes:selectedAtts forState:UIControlStateSelected];
    
    return tabBarItem;
    
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self becomeFirstResponder];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [self becomeFirstResponder];
    [super viewDidAppear:animated];
}

@end
