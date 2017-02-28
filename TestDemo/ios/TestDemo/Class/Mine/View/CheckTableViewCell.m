//
//  CheckTableViewCell.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/24.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "CheckTableViewCell.h"
#import "CheckModel.h"

@interface CheckTableViewCell()
@property(nonatomic, weak)UIImageView *iconImageView;
@property(nonatomic, weak)UILabel *titleLabel;
@property(nonatomic, weak)UILabel *moneyLabel;
@property(nonatomic, weak)UILabel *dateLabel;
@property(nonatomic, weak)UILabel *stateLabel;
@end

@implementation CheckTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"checkCell";
    CheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CheckTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        iconImage.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:iconImage];
        self.iconImageView = iconImage;
        
        UILabel *titleL = [UILabel labelWithFrame:CGRectMake(iconImage.right+10, iconImage.top, KScreenWidth-iconImage.right - 80, 25) textColor:KTextBlackColor font:kFontWithDefaultSize text:@"充值"];
        [self.contentView addSubview:titleL];
        self.titleLabel = titleL;
        
        UILabel *moneyL = [UILabel labelWithFrame:CGRectMake(titleL.right, titleL.top, 60, titleL.height) textColor:KTextBlackColor font:kFontWithDefaultSize text:@""];
        [self.contentView addSubview:moneyL];
        self.moneyLabel = moneyL;
        
        UILabel *dateL = [UILabel labelWithFrame:CGRectMake(titleL.left, titleL.bottom + 5, titleL.width, titleL.height) textColor:[UIColor darkGrayColor] font:kFontWithDefaultSize text:@""];
        [self.contentView addSubview:dateL];
        self.dateLabel = dateL;
        
        UILabel *stateL = [UILabel labelWithFrame:CGRectMake(moneyL.left, dateL.top, moneyL.width, dateL.height) textColor:KTextGrayColor font:kFontWithDefaultSize text:@"正常"];
        [self.contentView addSubview:stateL];
        self.stateLabel = stateL;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 79, KScreenWidth, 1.0)];
        line.backgroundColor = KSepLineColor;
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)cellHideStateLabel {
    self.stateLabel.hidden = YES;
}

- (void)setModel:(CheckModel *)model {
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"icon_default"]];
    self.titleLabel.text = model.title;
    self.dateLabel.text = model.date;
    self.moneyLabel.text = model.price;
    self.stateLabel.text = model.state;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
