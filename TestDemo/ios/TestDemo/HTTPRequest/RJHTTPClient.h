//
//  RJHTTPClient.h
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/23.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "HTTPWebAPIUrl.h"
#import "WebResponse.h"

typedef void(^ResultDataBlock)(BOOL isSccuess, id result);
typedef void(^HTTPCompletion)(WebResponse *response);

@interface RJHTTPClient : AFHTTPSessionManager
+ (instancetype)sharedInstance;
- (NSURLSessionDataTask *)getPath:(NSString *)path paramters:(NSDictionary *)paramters completion:(ResultDataBlock)completion;
- (NSURLSessionDataTask *)postPath:(NSString *)path paramters:(NSDictionary *)paramters completion:(ResultDataBlock)completion;
- (NSURLSessionDataTask *)postPath:(NSString *)path paramters:(NSDictionary *)paramters uploadPicture:(UIImage *)picture completion:(ResultDataBlock)completion;
@end
