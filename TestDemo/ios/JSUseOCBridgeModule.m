//
//  JSUseOCBridgeModule.m
//  TestDemo
//
//  Created by jia on 2017/2/27.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "JSUseOCBridgeModule.h"
#import "RJImagePickerManager.h"
#import <React/RCTConvert.h>

@implementation JSUseOCBridgeModule

+ (instancetype)sharedInstance {
  static JSUseOCBridgeModule *shared = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shared = [[JSUseOCBridgeModule alloc] init];
  });
  return shared;
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(changeUserIcon:(RCTResponseSenderBlock)callBack) {
  [[RJImagePickerManager sharedInstance] showWithCallBack:^(NSString *imgUrl) {
    callBack(@[[NSNull null], imgUrl]);
  }];
  
//  callBack(@[[NSNull null], @"http://a.hiphotos.baidu.com/image/pic/item/b999a9014c086e068d8c874b00087bf40ad1cb8e.jpg"]);
}

//桥接到Javascript的方法返回值类型必须是void。React Native的桥接操作是异步的，所以要返回结果给Javascript，必须通过回调或者触发事件来进行
RCT_EXPORT_METHOD(OCFunc:(NSString *)dataString) {
  NSLog(@"%@",dataString);
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:dataString delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
  dispatch_async(dispatch_get_main_queue(), ^{
    [alert show];
  });
}



@end
