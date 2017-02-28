//
//  TransferView.h
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/28.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TransferBlock)();

@interface TransferView : UIView
+ (instancetype)sharedInstance;
- (void)showWithName:(NSString *)userName transfer:(TransferBlock)block;
- (void)showVerifyPhone:(NSString *)phone transfer:(TransferBlock)block;
@end
