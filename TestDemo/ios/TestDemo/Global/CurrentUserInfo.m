//
//  CurrentUserInfo.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/11/4.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "CurrentUserInfo.h"
#import "HTTPWebAPIUrl.h"

@implementation CurrentUserInfo
+ (CurrentUserInfo *)sharedInstance {
    static CurrentUserInfo *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CurrentUserInfo alloc] init];
    });
    return _sharedInstance;
}


- (void)userLogin:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        self.userId = StringForKeyInUnserializedJSONDic(dict, @"user_id");
        self.userType = StringForKeyInUnserializedJSONDic(dict, @"user_type");
        self.securityId = StringForKeyInUnserializedJSONDic(dict, @"security_id");
    }
}

- (void)userInfo:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSDictionary *info = ObjForKeyInUnserializedJSONDic(dict, @"userinfo");
        if (info && [info isKindOfClass:[NSDictionary class]]) {
            self.asn = StringForKeyInUnserializedJSONDic(info, @"asn");
            self.backCard = StringForKeyInUnserializedJSONDic(info, @"bankCard");
            self.idno = StringForKeyInUnserializedJSONDic(info, @"idno");
            self.issue_date = StringForKeyInUnserializedJSONDic(info, @"issue_date");
            self.issue_name = StringForKeyInUnserializedJSONDic(info, @"issue_name");
            self.money = StringForKeyInUnserializedJSONDic(info, @"money");
            self.name = StringForKeyInUnserializedJSONDic(info, @"name");
            if (!IsStringEmptyOrNull(StringForKeyInUnserializedJSONDic(info, @"user_img"))) {
                self.user_img = [NSString stringWithFormat:@"%@/%@",KImgBaseUrl, StringForKeyInUnserializedJSONDic(info, @"user_img")];
            } else {
                self.user_img = @"";
            }
            
            self.user_type = StringForKeyInUnserializedJSONDic(info, @"user_type");
        }
    }
}

@end
