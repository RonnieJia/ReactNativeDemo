//
//  RJHTTPClient+Login.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/11/4.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "RJHTTPClient+Login.h"

@implementation RJHTTPClient (Login)

- (NSURLSessionDataTask *)userLoginWithUserName:(NSString *)uName pwd:(NSString *)pwd completion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    AddObjectForKeyIntoDictionary(uName, @"user_name", paramters);
    AddObjectForKeyIntoDictionary(pwd, @"password", paramters);
    AddObjectForKeyIntoDictionary(@"002", @"code", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            completion([WebResponse userLoginResponse:result]);
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}


@end
