//
//  RechargeView.h
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/25.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertBlock)();

@interface RechargeView : UIView
+ (instancetype)sharedInstance;
- (void)showResign:(AlertBlock)block;
- (void)showWithMoney:(NSString *)money alertBlock:(AlertBlock)block;
@end
