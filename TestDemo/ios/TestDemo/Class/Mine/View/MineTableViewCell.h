//
//  MineTableViewCell.h
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/24.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)displayWithImage:(NSString *)image text:(NSString *)text;
@end
