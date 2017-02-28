//
//  RJImagePickerManager.h
//  TestDemo
//
//  Created by jia on 2017/2/28.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UploadImage)(NSString *imgUrl);

@interface RJImagePickerManager : NSObject
+ (instancetype)sharedInstance;
- (void)showWithCallBack:(UploadImage)callBack;
@end
