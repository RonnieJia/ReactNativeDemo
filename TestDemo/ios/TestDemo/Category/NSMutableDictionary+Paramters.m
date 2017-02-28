//
//  NSMutableDictionary+Paramters.m
//  APPFormwork
//
//  Created by jia on 2017/2/20.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "NSMutableDictionary+Paramters.h"

@implementation NSMutableDictionary (Paramters)
- (void)addUserNameAndSecurity {
    AddObjectForKeyIntoDictionary([CurrentUserInfo sharedInstance].userName, @"user_name", self);
    AddObjectForKeyIntoDictionary([CurrentUserInfo sharedInstance].securityId, @"security_id", self);
}
- (void)addUserNameAndSecurityAndASNWithCode:(NSString *)code {
    [self addUserNameAndSecurityWithCode:code];
    AddObjectForKeyIntoDictionary([CurrentUserInfo sharedInstance].asn, @"asn", self);
}

- (void)addUserNameAndSecurityWithCode:(NSString *)code {
    [self addUserNameAndSecurity];
    AddObjectForKeyIntoDictionary(code, @"code", self);
}
@end
