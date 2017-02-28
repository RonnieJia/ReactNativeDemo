//
//  FontAndColorConfig.h
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/30.
//  Copyright © 2016年 RJ. All rights reserved.
//

#ifndef FontAndColorConfig_h
#define FontAndColorConfig_h

/************** font ******************/
#define kFont(size)                             [UIFont systemFontOfSize:size]
#define kFontWithBigbigestSize                  [UIFont systemFontOfSize:32]
#define kFontWithBigestSize                     [UIFont systemFontOfSize:24]
#define kFontWithBigSize                        [UIFont systemFontOfSize:18]
#define kFontWithDefaultSize                    [UIFont systemFontOfSize:16]
#define kFontWithSmallSize                      [UIFont systemFontOfSize:14]
#define kFontWithSmallestSize                   [UIFont systemFontOfSize:12]


/************** color ******************/
#define kTabBarBgColor                          [UIColor whiteColor]
#define kNavTitleColor                          [UIColor blackColor]
#define kNavBarBgColo                           [UIColor whiteColor]
#define kViewControllerBgColor                  [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f]
#define KSepLineColor                           [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]

#define KSureBtnBgColor                         [UIColor colorWithRed:0.84f green:0.07f blue:0.00f alpha:1.00f]
#define KGrayBackViewColor                      [UIColor colorWithRed:0.96f green:0.96f blue:0.98f alpha:1.00f]
// 发布的borderColor
#define KIssueGrayBorder                        [UIColor colorWithRed:0.73f green:0.73f blue:0.73f alpha:1.00f]

#define KTextGrayColor                          [UIColor colorWithRed:0.55f green:0.55f blue:0.55f alpha:1.00f]
#define KTextDarkColor                          [UIColor colorWithRed:0.31f green:0.29f blue:0.29f alpha:1.00f]
#define KTextBlackColor                         [UIColor blackColor]
#define KTextOrangeColor                        [UIColor colorWithRed:0.98f green:0.40f blue:0.15f alpha:1.00f]
/************** size ******************/

#define KScreenWidth          [UIScreen mainScreen].bounds.size.width
#define KScreenHeight         [UIScreen mainScreen].bounds.size.height
#define KNavBarHeight         64.0f
#define KAUTOSIZE(num)        (num * [UIScreen mainScreen].bounds.size.width / 375.0f)

/************** other ******************/
#define KKeyWindow            [UIApplication sharedApplication].keyWindow




#pragma mark - navigationBarItem的type
typedef enum : NSUInteger {
    NavBarTypeLeft,
    NavBarTypeRight,
} NavBarType;

typedef enum : NSUInteger {
    PayTypeAli = 1,
    PayTypeWechat = 2,
    PayTypeYue = 3,
} PayType;
#endif /* FontAnfColorConfig_h */
