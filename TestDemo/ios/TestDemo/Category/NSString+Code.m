//
//  NSString+Code.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/23.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "NSString+Code.h"

@implementation NSString (Code)
- (NSString *)stringWithUniCodeString:(NSString *)unicode {
        NSString *tempStr1 = [unicode stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
        NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@""withString:@"\\"];
        NSString *tempStr3 = [[@"" stringByAppendingString:tempStr2] stringByAppendingString:@""];
                              NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
                              NSString* returnStr = [NSPropertyListSerialization
                                                     propertyListFromData:tempData
                                                                                    mutabilityOption:NSPropertyListImmutable
                                                                                              format:NULL
                                                                                    errorDescription:NULL];
                              NSLog(@"%@",returnStr);
                              return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
                              
}
@end
