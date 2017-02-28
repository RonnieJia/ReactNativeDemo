//
//  UIButton+Custom.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/31.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "UIButton+Custom.h"

@implementation UIButton (Custom)
+ (UIButton *)sureButtonWithTitle:(NSString *)title {
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(35, 0, KScreenWidth-70, 45);
    sureBtn.layer.cornerRadius = 4.0f;
    [sureBtn setBackgroundImage:createImageWithColor([UIColor colorWithRed:0.86f green:0.18f blue:0.18f alpha:1.00f]) forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setTitle:title forState:UIControlStateNormal];
    
    return sureBtn;
}
@end
