//
//  RJHTTPClient.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/23.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "RJHTTPClient.h"

@implementation RJHTTPClient
+ (instancetype)sharedInstance {
    static RJHTTPClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
        _sharedInstance.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedInstance.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return _sharedInstance;
}


- (NSURLSessionDataTask *)getPath:(NSString *)path paramters:(NSDictionary *)paramters completion:(ResultDataBlock)completion {
    
    return [self GET:path parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError * error;
        
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:enc];
        
        NSData * data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];//这样解决的乱码问题。
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error ];
        
        RJLog(@"%@",jsonDict);
        completion(YES, jsonDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(NO, error);
        RJLog(@"%@",error);
    }];
}

- (NSURLSessionDataTask *)postPath:(NSString *)path paramters:(NSDictionary *)paramters completion:(ResultDataBlock)completion {
    RJLog(@"path:%@\n paramters:%@",path,paramters);
    return [self POST:path parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError * error;
        
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:enc];
        
        NSData * data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];//这样解决的乱码问题。
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error ];
        
        RJLog(@"%@",jsonDict);
        completion(YES, jsonDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RJLog(@"%@",error);
        completion(NO, error);
    }];
}

- (NSURLSessionDataTask *)postPath:(NSString *)path paramters:(NSDictionary *)paramters uploadPicture:(UIImage *)picture completion:(ResultDataBlock)completion {
    return [self POST:path parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (picture) {
            NSData *data = UIImageJPEGRepresentation(picture, 0.5);
            NSString *name = [NSString stringWithFormat:@"photoFile"];
            NSString *fileName = [NSString stringWithFormat:@"header.jpg"];
            if (data) {
                [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError * error;
        
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:enc];
        
        NSData * data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];//这样解决的乱码问题。
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error ];
        
        RJLog(@"%@",jsonDict);
        completion(YES, jsonDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RJLog(@"%@",error);
        completion(NO, error);
    }];
}

@end
