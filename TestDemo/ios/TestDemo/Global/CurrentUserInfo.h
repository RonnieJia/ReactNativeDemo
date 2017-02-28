//
//  CurrentUserInfo.h
//  APPFormwork
//
//  Created by 辉贾 on 2016/11/4.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentUserInfo : NSObject

@property(nonatomic, strong)NSString *userId;
@property(nonatomic, strong)NSString *userType;
@property(nonatomic, strong)NSString *securityId;
@property(nonatomic, strong)NSString *userName;

@property(nonatomic, strong)NSString *asn;
@property(nonatomic, strong)NSString *backCard;
@property(nonatomic, strong)NSString *idno;
@property(nonatomic, strong)NSString *issue_date;
@property(nonatomic, strong)NSString *issue_name;
@property(nonatomic, strong)NSString *money;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *user_img;
@property(nonatomic, strong)NSString *user_type;

+ (CurrentUserInfo *)sharedInstance;

- (void)userLogin:(NSDictionary *)dict;
- (void)userInfo:(NSDictionary *)dict;
@end
