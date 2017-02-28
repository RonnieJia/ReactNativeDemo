//
//  RJBaseViewController.h
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/23.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^NavBarItemAction)();

@interface RJBaseViewController : UIViewController
- (void)setNavBarBtnWithType:(NavBarType)type title:(NSString *)title action:(NavBarItemAction)action;
- (void)setNavBarBtnWithType:(NavBarType)type norImg:(UIImage *)norImg selImg:(UIImage *)selImg action:(NavBarItemAction)action;

- (void)setBackButton;
- (void)backBtnAction;
@end
