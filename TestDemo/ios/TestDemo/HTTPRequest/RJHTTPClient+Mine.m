//
//  RJHTTPClient+Mine.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/11/4.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "RJHTTPClient+Mine.h"
#import "NSMutableDictionary+Paramters.h"
#import "AppEntrance.h"

@implementation RJHTTPClient (Mine)

- (NSURLSessionDataTask *)fetchUserCheckListWithPage:(NSInteger)page completion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    CurrentUserInfo *user = [CurrentUserInfo sharedInstance];
    [paramters addUserNameAndSecurityWithCode:@"004"];
    AddObjectForKeyIntoDictionary(user.userType, @"user_type", paramters);
    AddObjectForKeyIntoDictionary(user.userId, @"user_id", paramters);
    AddObjectForKeyIntoDictionary(@(page), @"page", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
                ShowAutoHideMBProgressHUD(KKeyWindow, response.message);
            } else {
                completion(response);
            }
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}

- (NSURLSessionDataTask *)fetchUserRechargeListWithPage:(NSInteger)page
                                             completion:(HTTPCompletion)completion{
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    CurrentUserInfo *user = [CurrentUserInfo sharedInstance];
    [paramters addUserNameAndSecurityAndASNWithCode:@"030"];
    AddObjectForKeyIntoDictionary(user.userId, @"user_id", paramters);
    AddObjectForKeyIntoDictionary(@(page), @"page", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
                ShowAutoHideMBProgressHUD(KKeyWindow, response.message);
            } else {
                completion(response);
            }
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}

- (NSURLSessionDataTask *)changePwd:(NSString *)oldPwd newPwd:(NSString *)pwd completion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    CurrentUserInfo *user = [CurrentUserInfo sharedInstance];
    [paramters addUserNameAndSecurityWithCode:@"006"];
    AddObjectForKeyIntoDictionary(oldPwd, @"old_password", paramters);
    AddObjectForKeyIntoDictionary(pwd, @"new_password", paramters);
    AddObjectForKeyIntoDictionary(user.userId, @"user_id", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
                ShowAutoHideMBProgressHUD(KKeyWindow, response.message);
            } else {
                completion(response);
            }
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}

- (NSURLSessionDataTask *)lossWithPhone:(NSString *)phone pwd:(NSString *)pwd completion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters addUserNameAndSecurityWithCode:@"031"];
    AddObjectForKeyIntoDictionary(pwd, @"cardPwd", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
                ShowAutoHideMBProgressHUD(KKeyWindow, response.message);
            } else {
                completion(response);
            }
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}

- (NSURLSessionDataTask *)cancelLossWithPhone:(NSString *)phone pwd:(NSString *)pwd completion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters addUserNameAndSecurityWithCode:@"032"];
    AddObjectForKeyIntoDictionary(pwd, @"cardPwd", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
                ShowAutoHideMBProgressHUD(KKeyWindow, response.message);
            } else {
                completion(response);
            }
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}

- (NSURLSessionDataTask *)fetchTransferUserNameWithOppUserName:(NSString *)oppname completion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    CurrentUserInfo *user = [CurrentUserInfo sharedInstance];
    [paramters addUserNameAndSecurityWithCode:@"035"];
    AddObjectForKeyIntoDictionary(oppname, @"oppUserName", paramters);
    AddObjectForKeyIntoDictionary(user.userId, @"user_id", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
                ShowAutoHideMBProgressHUD(KKeyWindow, response.message);
            } else {
                completion(response);
            }
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}

- (NSURLSessionDataTask *)transferWithOther:(NSString *)otherID
                                    cardPWD:(NSString *)pwd
                                     amount:(NSString *)amount
                                 completion:(HTTPCompletion)completion{
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters addUserNameAndSecurityWithCode:@"033"];
    AddObjectForKeyIntoDictionary(otherID, @"oppUserName", paramters);
    AddObjectForKeyIntoDictionary(amount, @"amount", paramters);
    AddObjectForKeyIntoDictionary(pwd, @"cardPwd", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
            }
            completion(response);
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}

- (NSURLSessionDataTask *)storeListWithPage:(NSInteger)page completion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    CurrentUserInfo *user = [CurrentUserInfo sharedInstance];
    [paramters addUserNameAndSecurityAndASNWithCode:@"029"];
    AddObjectForKeyIntoDictionary(user.userId, @"user_id", paramters);
    AddObjectForKeyIntoDictionary(@(page), @"page", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
            }
            completion(response);
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}

- (NSURLSessionDataTask *)resignBankCardWithCompletion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters addUserNameAndSecurityAndASNWithCode:@"027"];
    AddObjectForKeyIntoDictionary(IsStringEmptyOrNull([CurrentUserInfo sharedInstance].backCard)?@"null":[CurrentUserInfo sharedInstance].backCard, @"bankCard", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
            }
            completion(response);
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];

}

- (NSURLSessionDataTask *)rechargeWithMoney:(NSString *)money completion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters addUserNameAndSecurityAndASNWithCode:@"028"];
    AddObjectForKeyIntoDictionary(money, @"trade_amount", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
            }
            completion(response);
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}

- (NSURLSessionDataTask *)fetchVerifyCodeWithBankCard:(NSString *)bankCard
                                               mobile:(NSString *)mobile
                                           completion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters addUserNameAndSecurityAndASNWithCode:@"025"];
    AddObjectForKeyIntoDictionary(bankCard, @"bankCard", paramters);
    AddObjectForKeyIntoDictionary(mobile, @"mobile", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
            }
            completion(response);
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];

}
- (NSURLSessionDataTask *)verifyCode:(NSString *)code
                            bamkCard:(NSString *)bankCard
                          completion:(HTTPCompletion)completion{
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters addUserNameAndSecurityAndASNWithCode:@"026"];
    AddObjectForKeyIntoDictionary(bankCard, @"bankCard", paramters);
    AddObjectForKeyIntoDictionary(code, @"mobileCode", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
            }
            completion(response);
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}

- (NSURLSessionDataTask *)uploadUserIcon:(UIImage *)image completion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters addUserNameAndSecurityWithCode:@"036"];
    return [self postPath:kImageUrl paramters:paramters uploadPicture:image completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
            }
            completion(response);
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
}

- (NSURLSessionDataTask *)suggestWithText:(NSString *)suggest completion:(HTTPCompletion)completion {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    [paramters addUserNameAndSecurityWithCode:@"037"];
    AddObjectForKeyIntoDictionary(suggest, @"advice", paramters);
    return [self postPath:kAppUrl paramters:paramters completion:^(BOOL isSccuess, id result) {
        if (isSccuess) {
            WebResponse *response = [WebResponse respnseWithResult:result];
            if (response.code == WebResponseCodeLogout) {
                [AppEntrance changeRootViewControllerToLogin];
            }
            completion(response);
        } else {
            completion([WebResponse responseWithError:result]);
        }
    }];
    
}

@end
