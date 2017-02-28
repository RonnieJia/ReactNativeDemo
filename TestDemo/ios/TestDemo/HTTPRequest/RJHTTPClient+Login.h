//
//  RJHTTPClient+Login.h
//  APPFormwork
//
//  Created by 辉贾 on 2016/11/4.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "RJHTTPClient.h"

@interface RJHTTPClient (Login)
/**
 用户登录

 @param uName 用户名
 @param pwd 密码
 */
- (NSURLSessionDataTask *)userLoginWithUserName:(NSString *)uName pwd:(NSString *)pwd completion:(HTTPCompletion)completion;

@end
