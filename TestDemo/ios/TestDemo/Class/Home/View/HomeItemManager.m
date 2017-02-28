//
//  HomeItemManager.m
//  TestDemo
//
//  Created by jia on 2017/2/27.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "HomeItemManager.h"
#import "HomeItem.h"

#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>

@interface HomeItemManager()
@property(nonatomic, weak)HomeItem *item;
@end

@implementation HomeItemManager

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(title, NSString)

RCT_EXPORT_VIEW_PROPERTY(icon, NSString)

RCT_EXPORT_VIEW_PROPERTY(desc, NSString)

RCT_EXPORT_VIEW_PROPERTY(btnTag, NSInteger)

RCT_EXPORT_VIEW_PROPERTY(onClickBtn, RCTBubblingEventBlock)


- (UIView *)view {
  HomeItem *item = [[HomeItem alloc] initWithFrame:CGRectZero icon:nil title:nil desc:nil];
  self.item = item;
  [item addTarget:self selector:@selector(itemClick:) tag:item.tag];
  return item;
}

- (NSArray *)customDirectEventTypes {
  return @[@"onClickBtn"];
}

- (void)itemClick:(UIButton *)button {
  self.item.onClickBtn(@{@"target":@(button.tag),@"value":@(button.tag)});
//  if (button.tag == 1) {
//    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"changeURL://"]];
//    if (canOpen) {
//      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"changeURL://"]];
//    } else {
//      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/zhong-guo-yin-xing-bin-fen/id525635672?mt=8"]];
//    }
//  } else if (button.tag == 2) {//BOCOPPayKit
//    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"BOCOPPayKit://"]];
//    if (canOpen) {
//      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"BOCOPPayKit://"]];
//    } else {
//      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/zhong-yin-yi-shang/id793675900?mt=8"]];
//    }
//  }
  
}
@end
