//
//  CheckModel.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/24.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "CheckModel.h"

@implementation CheckModel
+ (instancetype)modelWithJSONDict:(NSDictionary *)dict {
    CheckModel *model = [[CheckModel alloc] init];
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        model.billId = StringForKeyInUnserializedJSONDic(dict, @"bill_id");
        model.date = StringForKeyInUnserializedJSONDic(dict, @"date");
        model.img = StringForKeyInUnserializedJSONDic(dict, @"img");
        model.price = StringForKeyInUnserializedJSONDic(dict, @"price");
        model.state = StringForKeyInUnserializedJSONDic(dict, @"state");
        model.title = StringForKeyInUnserializedJSONDic(dict, @"title");
        model.type = StringForKeyInUnserializedJSONDic(dict, @"交易类型");
    }
    return model;
}
+ (NSArray *)arrayWithJSONDict:(NSDictionary *)dict {
    NSMutableArray *array = [NSMutableArray array];
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSArray *billItemArray = ObjForKeyInUnserializedJSONDic(dict, @"bill_item");
        for (NSDictionary *checkDict in billItemArray) {
            CheckModel *model = [CheckModel modelWithJSONDict:checkDict];
            [array addObject:model];
        }
    }
    return array;
}
@end
