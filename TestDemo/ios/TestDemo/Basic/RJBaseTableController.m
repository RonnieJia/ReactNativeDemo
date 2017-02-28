//
//  RJBaseTableController.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/31.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "RJBaseTableController.h"

@interface RJBaseTableController ()
@property (nonatomic, copy)NavBarItemAction leftAction;
@property (nonatomic, copy)NavBarItemAction rightAction;
@end

@implementation RJBaseTableController

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewControllerBgColor;
}

- (void)setNavBarBtnWithType:(NavBarType)type title:(NSString *)title action:(NavBarItemAction)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 44);
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kNavTitleColor forState:UIControlStateNormal];
    btn.titleLabel.font = kFontWithDefaultSize;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    if (type == NavBarTypeLeft) {
        [btn addTarget:self action:@selector(leftNavBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, item];
        self.leftAction = [action copy];
    } else {
        [btn addTarget:self action:@selector(rightNavBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItems = @[item, negativeSpacer];
        self.rightAction = [action copy];
    }
}

- (void)setNavBarBtnWithType:(NavBarType)type norImg:(UIImage *)norImg selImg:(UIImage *)selImg action:(NavBarItemAction)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 44);
    btn.backgroundColor = [UIColor clearColor];
    if (norImg) {
        [btn setImage:norImg forState:UIControlStateNormal];
    }
    if (selImg) {
        [btn setImage:selImg forState:UIControlStateHighlighted];
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    if (type == NavBarTypeLeft) {
        [btn addTarget:selImg action:@selector(leftNavBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, item];
        self.leftAction = [action copy];
    } else {
        [btn addTarget:self action:@selector(rightNavBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItems = @[item, negativeSpacer];
        self.rightAction = [action copy];
    }
    
}

- (void)leftNavBarItemAction:(UIButton *)button {
    if (self.leftAction) {
        self.leftAction();
    }
}
- (void)rightNavBarItemAction:(UIButton *)button {
    if (self.rightAction) {
        self.rightAction();
    }
}



- (void)setBackButton {
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 60, 44);
    [back setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
    back.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [back addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]
                                 initWithCustomView:back];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backItem];
}

- (void)backBtnAction {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
