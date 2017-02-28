//
//  RJHTTPClient+Home.h
//  APPFormwork
//
//  Created by 辉贾 on 2016/11/4.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "RJHTTPClient.h"

@interface RJHTTPClient (Home)

/**
 获取个人信息
 */
- (NSURLSessionDataTask *)fetchUserInfoWithCompletion:(HTTPCompletion)completion;

@end
