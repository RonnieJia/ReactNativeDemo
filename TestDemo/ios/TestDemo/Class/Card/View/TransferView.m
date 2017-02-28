//
//  TransferView.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/28.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "TransferView.h"

@interface TransferView()
@property(nonatomic, weak)UIView *containerView;
@property(nonatomic, weak)UILabel *titleLabel;
@property(nonatomic, weak)UILabel *descLabel;
@property(nonatomic, weak)UILabel *nameLabel;
@property(nonatomic, copy)TransferBlock block;
@end

@implementation TransferView
+ (instancetype)sharedInstance {
    static TransferView *shardInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shardInstance = [[TransferView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return shardInstance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIColor *textColor = [UIColor colorWithRed:0.86f green:0.18f blue:0.18f alpha:1.00f];
        
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSelf)];
        [self addGestureRecognizer:tap];
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, self.width-30, 225)];
        [self addSubview:containerView];
        containerView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];
        containerView.layer.cornerRadius = 6.0f;
        containerView.centerY = self.centerY;
        [containerView addGestureRecognizer:[UITapGestureRecognizer new]];
        self.containerView = containerView;
        
        UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(15, 15, containerView.width-30, 25) textColor:textColor font:kFontWithBigestSize textAlignment:NSTextAlignmentCenter text:@"确认转账"];
        self.titleLabel = titleLabel;
        [containerView addSubview:titleLabel];

        UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(15, titleLabel.bottom + 15, titleLabel.width, 1.0)];
        [containerView addSubview:sepLine];
        sepLine.backgroundColor = KSepLineColor;
        
        UILabel *label1 = [UILabel labelWithFrame:CGRectMake(titleLabel.left, sepLine.bottom + 15, titleLabel.width, 25) textColor:KTextDarkColor font:kFontWithBigSize textAlignment:NSTextAlignmentCenter text:@"确认转账给:"];
        self.descLabel = label1;
        [containerView addSubview:label1];
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(titleLabel.left, label1.bottom + 20, titleLabel.width, 30) textColor:KTextBlackColor font:kFontWithBigbigestSize textAlignment:NSTextAlignmentCenter text:nil];
        [containerView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(10, nameLabel.bottom + 20, (containerView.width - 40)/2.0, 45);
        [containerView addSubview:cancelBtn];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:KTextBlackColor forState:UIControlStateNormal];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.titleLabel.font = kFontWithBigSize;
        cancelBtn.layer.cornerRadius = 6.0f;
        cancelBtn.layer.masksToBounds = YES;
        [cancelBtn addTarget:self action:@selector(hideSelf) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(20 + cancelBtn.right, nameLabel.bottom + 20, (containerView.width - 40)/2.0, 45);
        [containerView addSubview:sureBtn];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.backgroundColor = textColor;
        sureBtn.titleLabel.font = kFontWithBigSize;
        sureBtn.layer.cornerRadius = 6.0f;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)hideSelf {
    [self removeFromSuperview];
}

- (void)sureBtnClick {
    if (self.block) {
        self.block();
    }
    [self hideSelf];
}

- (void)showWithName:(NSString *)userName transfer:(TransferBlock)block {
    self.containerView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];
    self.titleLabel.text = @"确认转账";
    self.descLabel.text = @"确认转账给:";
    self.descLabel.font = kFontWithBigSize;
    self.block = [block copy];
    self.nameLabel.text = userName;
    self.nameLabel.font = kFontWithBigbigestSize;
    [KKeyWindow addSubview:self];
}

- (void)showVerifyPhone:(NSString *)phone transfer:(TransferBlock)block {
    self.containerView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];
    self.titleLabel.text = @"确认手机号";
    self.descLabel.text = @"我们将发送验证码到这个手机号:";
    self.descLabel.font = kFontWithDefaultSize;
    self.nameLabel.text = phone;
    self.nameLabel.font = kFontWithBigSize;
    self.block = [block copy];
    [KKeyWindow addSubview:self];
    
}
@end
