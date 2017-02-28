//
//  CheckTableViewCell.h
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/24.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckModel;

@interface CheckTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)cellHideStateLabel;
@property(nonatomic, strong)CheckModel *model;
@end
