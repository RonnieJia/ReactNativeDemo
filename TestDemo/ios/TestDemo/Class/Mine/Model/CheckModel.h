//
//  CheckModel.h
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/24.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckModel : NSObject
@property(nonatomic, strong)NSString *billId;
@property(nonatomic, strong)NSString *date;
@property(nonatomic, strong)NSString *img;
@property(nonatomic, strong)NSString *price;
@property(nonatomic, strong)NSString *state;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *type;

+ (instancetype)modelWithJSONDict:(NSDictionary *)dict;
+ (NSArray *)arrayWithJSONDict:(NSDictionary *)dict;
@end
