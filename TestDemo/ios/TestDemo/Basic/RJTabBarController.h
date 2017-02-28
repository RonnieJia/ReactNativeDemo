//
//  RJTabBarController.h
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/23.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJTabBarController : UITabBarController
+ (RJTabBarController *)curTabbarController;

+ (UITabBarItem* )addButtonWithNormalImage:(UIImage *)normalImage
                             selectedImage:(UIImage*)selectedImage
                                     title:(NSString* )title;

@end
