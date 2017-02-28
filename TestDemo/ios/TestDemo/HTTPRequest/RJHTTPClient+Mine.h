//
//  RJHTTPClient+Mine.h
//  APPFormwork
//
//  Created by 辉贾 on 2016/11/4.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "RJHTTPClient.h"

@interface RJHTTPClient (Mine)


/**
 获取账单列表

 @param page 1
 */
- (NSURLSessionDataTask *)fetchUserCheckListWithPage:(NSInteger)page
                                          completion:(HTTPCompletion)completion;

/**
 我的充值记录

 @param page 页码
 */
- (NSURLSessionDataTask *)fetchUserRechargeListWithPage:(NSInteger)page
                                             completion:(HTTPCompletion)completion;
/**
 修改密码
 */
- (NSURLSessionDataTask *)changePwd:(NSString *)oldPwd
                             newPwd:(NSString *)pwd
                         completion:(HTTPCompletion)completion;
/**
 挂失
 */
- (NSURLSessionDataTask *)lossWithPhone:(NSString *)phone
                                    pwd:(NSString *)pwd
                             completion:(HTTPCompletion)completion;
/** 
 解挂
 */
- (NSURLSessionDataTask *)cancelLossWithPhone:(NSString *)phone
                                          pwd:(NSString *)pwd
                                   completion:(HTTPCompletion)completion;

/**
 转账时，查找对应卡号人名字接口
 */
- (NSURLSessionDataTask *)fetchTransferUserNameWithOppUserName:(NSString *)oppname
                                                    completion:(HTTPCompletion)completion;

/**
 转账
 */
- (NSURLSessionDataTask *)transferWithOther:(NSString *)otherID
                                    cardPWD:(NSString *)pwd
                                     amount:(NSString *)amount
                                 completion:(HTTPCompletion)completion;
/**  圈存记录 */
- (NSURLSessionDataTask *)storeListWithPage:(NSInteger)page
                                 completion:(HTTPCompletion)completion;

/**
 解约
 */
- (NSURLSessionDataTask *)resignBankCardWithCompletion:(HTTPCompletion)completion;


/**
 充值

 @param money 充值金额
 */
- (NSURLSessionDataTask *)rechargeWithMoney:(NSString *)money
                                 completion:(HTTPCompletion)completion;

/**
 获取手机验证码

 @param bankCard 银行卡号
 @param mobile 手机号
 */
- (NSURLSessionDataTask *)fetchVerifyCodeWithBankCard:(NSString *)bankCard
                                               mobile:(NSString *)mobile
                                           completion:(HTTPCompletion)completion;

/**
 校验手机验证码

 @param code 验证码
 @param bankCard 银行卡号
 */
- (NSURLSessionDataTask *)verifyCode:(NSString *)code
                            bamkCard:(NSString *)bankCard
                          completion:(HTTPCompletion)completion;


/**
 上传头像

 @param image 头像
 */
- (NSURLSessionDataTask *)uploadUserIcon:(UIImage *)image completion:(HTTPCompletion)completion;

/**
 意见反馈

 @param suggest 意见
 */
- (NSURLSessionDataTask *)suggestWithText:(NSString *)suggest completion:(HTTPCompletion)completion;

@end
