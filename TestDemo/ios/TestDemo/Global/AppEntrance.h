//
//  AppEntrance.h
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/30.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppEntrance : NSObject
+ (void)setRootViewController;
+ (void)changeRootViewControllerToTabBarController;
+ (void)changeRootViewControllerToLogin;
@end
