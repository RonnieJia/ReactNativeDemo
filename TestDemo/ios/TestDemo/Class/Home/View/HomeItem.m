//
//  HomeItem.m
//  APPFormwork
//
//  Created by jia on 2017/2/16.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "HomeItem.h"
#import "UIImageView+WebCache.h"

@interface HomeItem()
@property(nonatomic, weak)UIButton *button;
@property(nonatomic, weak)UILabel *titleLabel;
@property(nonatomic, weak)UILabel *descLabel;
@property(nonatomic, weak)UIImageView *iconImgView;
@end

@implementation HomeItem

- (instancetype)initWithFrame:(CGRect)frame icon:(NSString *)icon title:(NSString *)title desc:(NSString *)desc {
    self = [super initWithFrame:frame];
    if (self) {
        self.left = ceil(self.left);
        self.layer.cornerRadius = 6.0f;
        self.layer.borderColor = [UIColor colorWithRed:0.79f green:0.79f blue:0.79f alpha:1.00f].CGColor;
        self.layer.borderWidth = 1.0f;
        self.clipsToBounds = YES;
      
      
        CGFloat itemWidth = (KScreenWidth-30)/2.0f;
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        [self addSubview:iconView];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        iconView.image = [UIImage imageNamed:icon];
        iconView.userInteractionEnabled = YES;
        iconView.clipsToBounds = YES;
        self.iconImgView = iconView;
      
        UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(iconView.right + 5, iconView.top, itemWidth-10-iconView.right, 20) textColor:KTextBlackColor font:kFontWithDefaultSize text:title];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *descLabel = [UILabel labelWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom + 5, titleLabel.width, 15) textColor:KTextGrayColor font:kFontWithSmallSize text:desc];
        [self addSubview:descLabel];
        self.descLabel = descLabel;
        descLabel.adjustsFontSizeToFitWidth = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, (KScreenWidth-30)/2.0, 50);
        [self addSubview:btn];
        self.button = btn;
    }
    return self;
}

- (void)setBtnTag:(NSInteger)btnTag {
  _btnTag = btnTag;
  self.button.tag = btnTag;
}

- (void)setTitle:(NSString *)title {
  _title = title;
  self.titleLabel.text = title;
}
- (void)setDesc:(NSString *)desc {
  _desc = desc;
  self.descLabel.text = desc;
}

- (void)setIcon:(NSString *)icon {
  _icon = icon;
  if ([icon hasPrefix:@"http"]) {
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:createImageWithColor(KSepLineColor)];
  } else {
    self.iconImgView.image = [UIImage imageNamed:icon];
  }
}

- (void)addTarget:(id)target selector:(SEL)selector tag:(NSInteger)tag {
    [self.button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

@end
