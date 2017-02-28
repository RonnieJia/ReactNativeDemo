//
//  RJHTTPClient+Home.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/11/4.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "RJHTTPClient+Home.h"
#import "CurrentUserInfo.h"
#import "AppEntrance.h"
#import "NSMutableDictionary+Paramters.h"

@implementation RJHTTPClient (Home)

- (NSURLSessionDataTask *)fetchUserInfoWithCompletion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    CurrentUserInfo *user = [CurrentUserInfo sharedInstance];
    [paramters addUserNameAndSecurityWithCode:@"003"];
    AddObjectForKeyIntoDictionary(user.userId, @"user_id", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
                ShowAutoHideMBProgressHUD(KKeyWindow, response.message);
            } else {
                if (response.code == WebResponseCodeSuccess) {
                    [[CurrentUserInfo sharedInstance] userInfo:ObjForKeyInUnserializedJSONDic(response.responseObject, @"data")];
                }
                completion(response);
            }
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}

@end
