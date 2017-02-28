//
//  VerifyButton.h
//  APPFormwork
//
//  Created by jia on 2017/2/7.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyButton : UIButton
+ (VerifyButton *)verifyButtonWithFrame:(CGRect)frame title:(NSString *)title titleFont:(CGFloat)font titleColor:(UIColor *)color backgroundColor:(UIColor *)bColor time:(NSInteger)time;
@end
