//
//  MineTableViewCell.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/24.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "MineTableViewCell.h"

@interface MineTableViewCell()
@property(nonatomic, weak)UIImageView *iconImageView;
@property(nonatomic, weak)UILabel *titleLabel;
@property(nonatomic, weak)UIView *lineView;
@end

@implementation MineTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"cellIdforMine";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 20, 20)];
        [self.contentView addSubview:iconImgView];
        self.iconImageView = iconImgView;
        
        UILabel *titleL = [UILabel labelWithFrame:CGRectMake(50, 0, KScreenWidth-70, 25) textColor:[UIColor blackColor] font:kFontWithDefaultSize text:@"fjfjla"];
        [self.contentView addSubview:titleL];
        self.titleLabel = titleL;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 0, KScreenWidth-40, 1.0)];
        line.backgroundColor = KSepLineColor;
        [self.contentView addSubview:line];
        self.lineView = line;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.centerY = self.height/2.0;
    self.titleLabel.centerY = self.iconImageView.centerY;
    self.lineView.bottom = self.height;
}

- (void)displayWithImage:(NSString *)image text:(NSString *)text {
    if (!IsStringEmptyOrNull(image)) {
        self.imageView.image = [UIImage imageNamed:image];
    }
    if ([text hasPrefix:@"身份证号"]) {
        if (text.length > 20) {
            NSString *showText = [text stringByReplacingCharactersInRange:NSMakeRange(11, 8) withString:@"********"];
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:showText];
            [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(5, text.length-5)];
            self.titleLabel.attributedText = attribute;
        } else {
            self.titleLabel.text = text;
        }
        
    } else {
        self.titleLabel.text = text;
    }
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
