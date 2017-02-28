//
//  RechargeView.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/25.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "RechargeView.h"
#import "RJHTTPClient+Mine.h"

typedef enum : NSUInteger {
    TypeResign,
    TypeRechargr,
} Type;

@interface RechargeView()
@property(nonatomic, weak)UILabel *titleLabel;
@property(nonatomic, weak)UILabel *moneyLabel;
@property(nonatomic, weak)UIButton *cancelBtn;
@property(nonatomic, assign)Type type;
@property(nonatomic, strong)NSString *money;
@property(nonatomic, copy)AlertBlock resignBlock;
@property(nonatomic, copy)AlertBlock rechargeBlock;
@end

@implementation RechargeView
+ (instancetype)sharedInstance {
    static RechargeView *recharge = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        recharge = [[RechargeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return recharge;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenSelf)];
        [self addGestureRecognizer:tap];
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, self.width-40, 180)];
        [self addSubview:containerView];
        containerView.centerY = KScreenHeight/2.0;
        containerView.backgroundColor = [UIColor whiteColor];
        [containerView addGestureRecognizer:[UITapGestureRecognizer new]];
        
        UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(20, 20, containerView.width-40, 30) textColor:KTextBlackColor font:kFontWithBigestSize text:@"充值金额确认"];
        [containerView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *moneyLabel = [UILabel labelWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom + 20, titleLabel.width, 40) textColor:KTextBlackColor font:kFontWithDefaultSize text:nil];
        moneyLabel.numberOfLines = 2;
        [containerView addSubview:moneyLabel];
        self.moneyLabel = moneyLabel;
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(containerView.width-80, moneyLabel.bottom + 20, 60, 30);
        [containerView addSubview:sureBtn];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = kFontWithDefaultSize;
        [sureBtn addTarget:self action:@selector(sureButton) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        changeBtn.frame = CGRectMake(sureBtn.left - 65, sureBtn.top, 60, 30);
        [containerView addSubview:changeBtn];
        [changeBtn setTitle:@"修改" forState:UIControlStateNormal];
        [changeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        changeBtn.titleLabel.font = kFontWithDefaultSize;
        [changeBtn addTarget:self action:@selector(hidenSelf) forControlEvents:UIControlEventTouchUpInside];
        self.cancelBtn = changeBtn;
    }
    return self;
}

- (void)hidenSelf {
    [self removeFromSuperview];
}

- (void)sureButton {
    if (self.type == TypeResign) {
        if (self.resignBlock) {
            self.resignBlock();
        }
    } else if (self.type == TypeRechargr) {
        if (self.rechargeBlock) {
            self.rechargeBlock();
        }
    }
    [self hidenSelf];
}

- (void)showResign:(AlertBlock)block {
    if (block) {
        self.resignBlock = [block copy];
    }
    self.type = TypeResign;
    self.titleLabel.text = @"解除绑定确认";
    NSString *backCard = [CurrentUserInfo sharedInstance].backCard;
    if (IsStringEmptyOrNull(backCard)) {
        backCard = @"null";
    } else {
        if (backCard.length > 4)
            backCard = [backCard substringFromIndex:backCard.length - 4];
    }
    self.moneyLabel.text = [NSString stringWithFormat:@"您确定要解除绑定尾号为:%@的圈存卡吗？",backCard];
    
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [KKeyWindow addSubview:self];
}

- (void)showWithMoney:(NSString *)money alertBlock:(AlertBlock)block {
    if (block) {
        self.rechargeBlock = [block copy];
    }
    self.money = money;
    self.type = TypeRechargr;
    self.titleLabel.text = @"充值金额确认";
    [self.cancelBtn setTitle:@"修改" forState:UIControlStateNormal];
    self.moneyLabel.text = [NSString stringWithFormat:@"即将充值：%@ 元",money];
    [KKeyWindow addSubview:self];
}

@end
