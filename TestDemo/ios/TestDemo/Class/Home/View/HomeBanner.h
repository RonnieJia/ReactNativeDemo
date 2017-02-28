//
//  HomeBanner.h
//  TestDemo
//
//  Created by jia on 2017/2/28.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "SDCycleScrollView.h"
#import <React/RCTComponent.h>


@interface HomeBanner : SDCycleScrollView
@property(nonatomic, copy)RCTBubblingEventBlock onClickBanner;
@end
