//
//  VerifyButton.m
//  APPFormwork
//
//  Created by jia on 2017/2/7.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "VerifyButton.h"

@interface VerifyButton()
@property(nonatomic, assign)NSInteger time;
@property(nonatomic, assign)NSInteger showTime;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSTimer *timer;
@end

@implementation VerifyButton

+ (VerifyButton *)verifyButtonWithFrame:(CGRect)frame title:(NSString *)title titleFont:(CGFloat)font titleColor:(UIColor *)color backgroundColor:(UIColor *)bColor time:(NSInteger)time {
    VerifyButton *button = [VerifyButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"%zds",time] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.backgroundColor = bColor;
    button.time = time;
    button.title = title;
    return button;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.showTime = self.time;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeButtonTitle) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)changeButtonTitle {
    [self setTitle:[NSString stringWithFormat:@"%zds",--self.showTime] forState:UIControlStateSelected];
    if (self.showTime == 0) {
        if ([self.timer isValid]) {
            [self.timer invalidate];
        }
        self.timer = nil;
        self.selected = NO;
        [self setTitle:[NSString stringWithFormat:@"%zds",self.time] forState:UIControlStateSelected];
    }
}

@end
