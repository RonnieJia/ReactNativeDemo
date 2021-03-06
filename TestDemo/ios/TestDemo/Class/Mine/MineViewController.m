//
//  MineViewController.m
//  APPFormwork
//
//  Created by 辉贾 on 2016/10/30.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "SettingViewController.h"
#import "MineRechargeController.h"
#import "MineCheckController.h"
#import "RJHTTPClient+Home.h"
#import "RJHTTPClient+Mine.h"

@interface MineViewController ()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic, weak)UIImageView *iconImageView;
@property(nonatomic, weak)UILabel *moneyLabel;
@property(nonatomic, weak)UILabel *workLabel;
@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchUserInfo];
}

- (void)fetchUserInfo {
    WaittingMBProgressHUD(KKeyWindow, @"");
    weakify(self);
    [[RJHTTPClient sharedInstance] fetchUserInfoWithCompletion:^(WebResponse *response) {
        if (response.code == WebResponseCodeSuccess) {
            FinishMBProgressHUD(KKeyWindow);
            [weakSelf refreshUserMoney];
        } else {
            FailedMBProgressHUD(KKeyWindow, response.message);
        }
    }];
}

- (void)refreshUserMoney {
    self.moneyLabel.text = [NSString stringWithFormat:@"(%@元)",[CurrentUserInfo sharedInstance].money];
    self.workLabel.text = [NSString stringWithFormat:@"(%@)",[CurrentUserInfo sharedInstance].issue_name];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[CurrentUserInfo sharedInstance].user_img] placeholderImage:createImageWithColor([UIColor lightGrayColor])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    weakify(self);
    [self setNavBarBtnWithType:NavBarTypeRight title:@"设置" action:^{
        SettingViewController *setting = [[SettingViewController alloc] init];
        setting.hidesBottomBarWhenPushed=YES;
        [weakSelf.navigationController pushViewController:setting animated:YES];
        
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, KScreenHeight-64-49)];
    [self.view addSubview:scrollView];
    
    UIView *hearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
    hearView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:hearView];
    
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 64, 64)];
    [hearView addSubview:iconImgView];
    iconImgView.layer.borderColor = [UIColor colorWithRed:0.83f green:0.83f blue:0.83f alpha:1.00f].CGColor;
    iconImgView.layer.borderWidth = 1.0f;
    iconImgView.layer.cornerRadius = 32.0f;
    iconImgView.clipsToBounds = YES;
    iconImgView.userInteractionEnabled = YES;
    [iconImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadUserIcon)]];
    iconImgView.centerX = ceil(self.view.width/2.0);
    self.iconImageView = iconImgView;
    
    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(20, iconImgView.bottom + 10, self.view.width-40, 25) textColor:KTextBlackColor font:kFontWithDefaultSize textAlignment:NSTextAlignmentCenter text:[CurrentUserInfo sharedInstance].name];
    [hearView addSubview:nameLabel];
    
    UILabel *cardLabel = [UILabel labelWithFrame:CGRectMake(20, nameLabel.bottom + 5, nameLabel.width, 20) textColor:[UIColor blueColor] font:kFontWithSmallSize textAlignment:NSTextAlignmentCenter text:UserName([CurrentUserInfo sharedInstance].idno)];
    [hearView addSubview:cardLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, hearView.bottom, self.view.width, 1.0)];
    [scrollView addSubview:line];
    line.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f];
    
    CGFloat itemW = (self.view.width-30)/2.0;
    for (int i = 0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [scrollView addSubview:button];
        button.frame = CGRectMake(ceil((i % 2) * (itemW + 10) + 10), (i/2) * (itemW + 10) + hearView.bottom + 20, itemW, itemW);
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"mine%zd",i+1]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"mine%zd",i+1]] forState:UIControlStateHighlighted];
        
        UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(5, 13/17.0 * itemW, button.width-10, 16)];
        textView.backgroundColor = [UIColor whiteColor];
        [button addSubview:textView];
        UILabel *textLabel = [UILabel labelWithFrame:textView.bounds textColor:KTextGrayColor font:kFontWithSmallestSize textAlignment:NSTextAlignmentCenter text:nil];
        [textView addSubview:textLabel];
        if (i == 0) {
            self.moneyLabel = textLabel;
            textLabel.text = [NSString stringWithFormat:@"(%@元)",[CurrentUserInfo sharedInstance].money];
        } else if (i == 2) {
            self.workLabel = textLabel;
            textLabel.text = [NSString stringWithFormat:@"(%@)",[CurrentUserInfo sharedInstance].issue_name];
        }
        
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    scrollView.contentSize = CGSizeMake(self.view.width, hearView.bottom + 50 + itemW * 2);
}

- (void)buttonAction:(UIButton *)button {
    if (button.tag == 100) {//
    } else if (button.tag == 101) {// 消费账单
        MineCheckController *check = [[MineCheckController alloc] init];
        check.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:check animated:YES];
    } else if (button.tag == 102) {//
    } else {// 充值记录
        MineRechargeController *recharge = [[MineRechargeController alloc] init];
        recharge.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:recharge animated:YES];
    }
}


- (void)uploadUserIcon {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    [action showInView:KKeyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
#if TARGET_IPHONE_SIMULATOR
        ShowAutoHideMBProgressHUD(KKeyWindow, @"请在真机测试摄像头功能");
#else
        //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        //    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //    }
        //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
        //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
        //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];//进入照相界面
#endif
        
    } else if(buttonIndex == 0) {
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.delegate = self;
        pickerImage.allowsEditing = YES;
        [self presentViewController:pickerImage animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        WaittingMBProgressHUD(self.tabBarController.view, @"");weakify(self);
        [[RJHTTPClient sharedInstance] uploadUserIcon:image completion:^(WebResponse *response) {
            if (response.code == WebResponseCodeSuccess) {
                SuccessMBProgressHUD(self.tabBarController.view, @"上传成功");
                weakSelf.iconImageView.image = image;
                [weakSelf fetchUserInfo];
            } else {
                FailedMBProgressHUD(self.tabBarController.view, response.message);
            }
        }];
    } else {
        ShowAutoHideMBProgressHUD(self.tabBarController.view, @"请选择图片上传");
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
