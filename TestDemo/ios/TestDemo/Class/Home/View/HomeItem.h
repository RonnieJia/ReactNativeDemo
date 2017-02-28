//
//  HomeItem.h
//  APPFormwork
//
//  Created by jia on 2017/2/16.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface HomeItem : UIView

@property(nonatomic, copy)RCTBubblingEventBlock onClickBtn;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *desc;
@property(nonatomic, strong) NSString *icon;
@property(nonatomic, assign)NSInteger btnTag;

- (instancetype)initWithFrame:(CGRect)frame icon:(NSString *)icon title:(NSString *)title desc:(NSString *)desc;
- (void)addTarget:(id)target selector:(SEL)selector tag:(NSInteger)tag;
@end
