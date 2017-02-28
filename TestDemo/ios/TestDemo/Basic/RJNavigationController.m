//
//  RJNavigationController.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/23.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "RJNavigationController.h"

#define kImgNavbarBackItem                [UIImage imageNamed:@"BackItem.png"]

@interface RJNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property(nonatomic,weak) UIViewController* currentShowVC;

@end

@implementation RJNavigationController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //去掉底部阴影条
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) {// > iOS 6.0
        [self.navigationBar setShadowImage:[UIImage imageNamed:@"TabItem_SelectionIndicatorImage"]];
    }
    
    //设置背景
    UIColor* color = kNavBarBgColo;
    self.navigationBar.barTintColor = color;
    self.navigationBar.backgroundColor = color;
    self.navigationBar.translucent = NO;//    Bar的模糊效果

    //设置返回按钮颜色
    [self.navigationBar setTintColor:[UIColor blackColor]];
    
    NSDictionary *titleAtt = @{NSForegroundColorAttributeName: kNavTitleColor,
                               NSFontAttributeName:[UIFont systemFontOfSize:20]};
    [self.navigationBar setTitleTextAttributes:titleAtt];

    //支持滑动返回
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
        self.currentShowVC = viewController;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //在根视图不响应手势，避免和侧滑产生冲突
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}

@end

#pragma mark - Inline Functions

inline UIButton *FMNavBarBackButtonWithTargetAndAntion(id target, SEL action)
{
    if (target == nil && action == nil)
        return nil;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.bounds = CGRectMake(0, 0, 55.00, 44.00);
    [backBtn setImage:kImgNavbarBackItem forState:UIControlStateNormal];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return backBtn;
}
