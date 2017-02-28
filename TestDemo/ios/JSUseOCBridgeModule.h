//
//  JSUseOCBridgeModule.h
//  TestDemo
//
//  Created by jia on 2017/2/27.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@protocol JSDelegate <NSObject>

@optional
- (void)callFunc2:(NSString *)string;

@end

@interface JSUseOCBridgeModule : NSObject<RCTBridgeModule>

+ (instancetype)sharedInstance;

@property(nonatomic, weak)id<JSDelegate> delegate;

@end
