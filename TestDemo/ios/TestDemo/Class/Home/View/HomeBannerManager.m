//
//  HomeBannerManager.m
//  TestDemo
//
//  Created by jia on 2017/2/28.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "HomeBannerManager.h"
#import "HomeBanner.h"
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>

@interface HomeBannerManager()<SDCycleScrollViewDelegate>

@end

@implementation HomeBannerManager

RCT_EXPORT_MODULE()

//  事件的导出，onClickBanner对应view中扩展的属性
RCT_EXPORT_VIEW_PROPERTY(onClickBanner, RCTBubblingEventBlock)

//  通过宏RCT_EXPORT_VIEW_PROPERTY完成属性的映射和导出
RCT_EXPORT_VIEW_PROPERTY(autoScrollTimeInterval, CGFloat);

RCT_EXPORT_VIEW_PROPERTY(imageURLStringsGroup, NSArray);

RCT_EXPORT_VIEW_PROPERTY(autoScroll, BOOL);

- (UIView *)view {
  HomeBanner *banner = [HomeBanner cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
  banner.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
  banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
  return banner;
}

- (NSArray *)customDirectEventTypes {
  return @[@"onClickBanner"];
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(HomeBanner *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
  if (!cycleScrollView.onClickBanner) {
    return;
  }
  
  cycleScrollView.onClickBanner(@{@"target":cycleScrollView.reactTag,
                                  @"value":@(index + 1)});
}

- (NSDictionary *)constantsToExport {
  return @{@"SDCycleScrollViewPageContolAliment": @{
               @"right": @(SDCycleScrollViewPageContolAlimentRight),
               @"center": @(SDCycleScrollViewPageContolAlimentCenter)
               }};
}

@end
