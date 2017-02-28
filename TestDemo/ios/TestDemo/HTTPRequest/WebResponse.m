//
//  WebResponee.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/23.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "WebResponse.h"
#import "CurrentUserInfo.h"
#import "HTTPWebAPIUrl.h"
#import "AppEntrance.h"

@implementation WebResponse

+ (instancetype)webResponseWithCode:(WebResponseCode)code codeDescription:(NSString *)codeDescription {
    WebResponse *response = [[WebResponse alloc] init];
    response.code = code;
    response.codeDescription = codeDescription;
    return response;
}
+ (instancetype)netCannotConnect {
    return [self webResponseWithCode:WebResponseCodeNetError codeDescription:@"当前网络不可用"];
}

+ (instancetype)webResponseWithJSONData:(id)data {
    WebResponse *response = [[WebResponse alloc] init];
    if (data) {
        response.responseObject = data;
    }
    return response;
}

+ (instancetype)responseWithError:(NSError *)error {
    WebResponse *response = [[WebResponse alloc] init];
    if (error.code == 3840) {
        response.message = @"返回数据格式不正确";
    } else if (error.code == -1009) {
        response.message = @"当前网络不可用";
    } else if (error.code == -1001) {
        response.message = @"连接超时";
    }
    response.code = WebResponseCodeFailed;
    return response;
}

- (void)JSONDataError {
    self.code = WebResponseCodeFailed;
    self.message = @"数据返回有误";
}

+ (instancetype)respnseWithResult:(NSDictionary *)dict {
    WebResponse *resoponse = [[WebResponse alloc] init];
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSString *state = StringForKeyInUnserializedJSONDic(dict, @"rsp");
        NSInteger reason = IntForKeyInUnserializedJSONDic(dict, @"reason");
        if ([state isEqualToString:@"fail"] || [state hasPrefix:@"fail"]) {
            resoponse.message = StringForKeyInUnserializedJSONDic(dict, @"data");
            if (reason == 2 && [resoponse.message hasPrefix:@"安全码校验失败,请重新登录"]) {
                resoponse.code = WebResponseCodeLogout;
            } else {
                resoponse.code = WebResponseCodeFailed;
            }
        } else {
            resoponse.code = WebResponseCodeSuccess;
            resoponse.responseObject = dict;
        }
    } else {
        [resoponse JSONDataError];
    }
    return resoponse;
}

+ (instancetype)userLoginResponse:(NSDictionary *)dict {
    WebResponse *resoponse = [[WebResponse alloc] init];
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSString *state = StringForKeyInUnserializedJSONDic(dict, @"rsp");
        if ([state isEqualToString:@"fail"] || [state hasPrefix:@"fail"]) {
            resoponse.message = StringForKeyInUnserializedJSONDic(dict, @"data");
            resoponse.code = WebResponseCodeFailed;
        } else {
            resoponse.code = WebResponseCodeSuccess;
            // 保存用户数据
            [[CurrentUserInfo sharedInstance] userLogin:ObjForKeyInUnserializedJSONDic(dict, @"data")];
        }
    } else {
        [resoponse JSONDataError];
    }
    return resoponse;
}

@end
