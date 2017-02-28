//
//  NSMutableDictionary+Paramters.h
//  APPFormwork
//
//  Created by jia on 2017/2/20.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Paramters)
- (void)addUserNameAndSecurityWithCode:(NSString *)code;
- (void)addUserNameAndSecurityAndASNWithCode:(NSString *)code;
- (void)addUserNameAndSecurity;
@end
