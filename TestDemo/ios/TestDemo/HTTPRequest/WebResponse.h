//
//  WebResponee.h
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/23.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -WebResponseCode(服务器WebAPI响应状态代码)
//From: 服务器端下发文档
typedef NS_ENUM(NSInteger, WebResponseCode)
{
    WebResponseCodeNetError             = 0,         //网络请求错误
    WebResponseCodeParamError           = 1,         //请求参数错误
    WebResponseCodeLogout               = 2,         //在其他设备登录
    WebResponseCodeSuccess              = 200,       //服务器返回成功
    WebResponseCodeFailed               = 300,       //服务器返回失败
    WebResponseCodeTokenError           = 302,       //令牌错误
};


@interface WebResponse : NSObject
/*  code:   表示API操作的结果状态, 见WebResponseCode
 */
@property (nonatomic, assign) WebResponseCode     code;

@property (nonatomic, strong) NSString *message;

/*  codeDescription:   是对code的解释说明. 文本内容几乎都是由服务器端返回
 */
@property (nonatomic, strong) NSString  *codeDescription;

/*  responseObject:    服务器返回的数据对象
 */
@property (nonatomic, strong) id  responseObject;
+ (instancetype)webResponseWithJSONData:(id)data;


+ (instancetype)responseWithError:(NSError *)error;


// 只需要请求结果的处理
+ (instancetype)respnseWithResult:(NSDictionary *)dict;


/******************** 登录注册 **********************/
// 登录
+ (instancetype)userLoginResponse:(NSDictionary *)dict;

@end
