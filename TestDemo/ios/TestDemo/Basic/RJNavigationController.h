//
//  RJNavigationController.h
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/23.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#if defined __cplusplus
extern "C" {
#endif
    
    //自定义的返回按钮
    extern inline UIButton *FMNavBarBackButtonWithTargetAndAntion(id target, SEL action);
    
#if defined __cplusplus
};
#endif


@interface RJNavigationController : UINavigationController

@end
