//
//  StoreViewController.m
//  APPFormwork
//
//  Created by 辉贾 on 2017/1/21.
//  Copyright © 2017年 RJ. All rights reserved.
//

#import "StoreViewController.h"
#import "SettingViewController.h"
#import "StoreListViewController.h"
#import "HelpViewController.h"
#import "RJHTTPClient+Home.h"
#import "RJHTTPClient+Mine.h"
#import "RechargeViewController.h"
#import "CardEditViewController.h"
#import <React/RCTRootView.h>
#import <React/RCTBundleURLProvider.h>

@interface StoreViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (nonatomic, weak)UITextField *moneyTextField;
@property (nonatomic, weak)UILabel *cardLabel;
@property (nonatomic, weak)UILabel *nameLabel;
@property (nonatomic, weak)UIImageView *iconImageView;
@property (nonatomic, weak)UIButton *cardStateBtn;
@property (nonatomic, weak)RCTRootView *rootView;
@end

@implementation StoreViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchUserInfo];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.moneyTextField isFirstResponder]) {
        [self.moneyTextField resignFirstResponder];
    }
}

- (void)fetchUserInfo {
    WaittingMBProgressHUD(KKeyWindow, @"");
    weakify(self);
    [[RJHTTPClient sharedInstance] fetchUserInfoWithCompletion:^(WebResponse *response) {
        if (response.code == WebResponseCodeSuccess) {
            FinishMBProgressHUD(KKeyWindow);
          CurrentUserInfo *user = [CurrentUserInfo sharedInstance];
          NSString *replaceString = @"*********************************";
          NSString *idNo = user.idno;
          if (user.idno.length > 10) {
            NSInteger len = user.idno.length - 10;
            idNo = [user.idno stringByReplacingCharactersInRange:NSMakeRange(6, len) withString:[replaceString substringToIndex:len]];
          }
          
          weakSelf.rootView.appProperties = @{@"userName":user.name, @"icon":user.user_img,  @"money":user.money, @"idno":idNo};
        } else {
            FailedMBProgressHUD(KKeyWindow, response.message);
        }
    }];
}

- (void)displayUserInfo {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[CurrentUserInfo sharedInstance].user_img] placeholderImage:createImageWithColor([UIColor lightGrayColor])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圈存中心";
  weakify(self);
  [self setNavBarBtnWithType:NavBarTypeRight title:@"设置" action:^{
    SettingViewController *setting = [[SettingViewController alloc] init];
    setting.hidesBottomBarWhenPushed=YES;
    [weakSelf.navigationController pushViewController:setting animated:YES];
    
  }];
  [self createMainView];
  
  /*
   
   
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
    self.nameLabel = nameLabel;
    
    UILabel *cardLabel = [UILabel labelWithFrame:CGRectMake(20, nameLabel.bottom + 5, nameLabel.width, 20) textColor:[UIColor blueColor] font:kFontWithSmallSize textAlignment:NSTextAlignmentCenter text:UserName([CurrentUserInfo sharedInstance].idno)];
    [hearView addSubview:cardLabel];
    self.cardLabel = cardLabel;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, hearView.bottom, self.view.width, 1.0)];
    [scrollView addSubview:line];
    line.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f];
    
    CGFloat itemW = (self.view.width-30)/2.0;
    for (int i = 0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [scrollView addSubview:button];
        button.frame = CGRectMake(ceil((i % 2) * (itemW + 10) + 10), (i/2) * (itemW + 10) + hearView.bottom + 20, itemW, itemW);
        NSString *iconName = [NSString stringWithFormat:@"store%zd",i+1];
        if (i == 2) {
            iconName = IsStringEmptyOrNull([CurrentUserInfo sharedInstance].backCard) ? @"store3" : @"store3_1";
            self.cardStateBtn = button;
        }
        [button setBackgroundImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    scrollView.contentSize = CGSizeMake(self.view.width, hearView.bottom + 50 + itemW * 2);
   */
}

- (void)createMainView {
  NSURL *jsCodeLocation;
  
  //  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
  jsCodeLocation = [NSURL URLWithString:@"http://192.168.3.90:8081/index.ios.bundle?platform=ios&dev=true&minify=false"];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"Store"
                                               initialProperties:@{@"navigator":self.navigationController}
                                                   launchOptions:nil];
//  self.rootView = rootView;
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  rootView.frame = self.view.bounds;
  self.rootView = rootView;
  [self.view addSubview:rootView];
  
}

- (void)buttonAction:(UIButton *)button {
    if (button.tag == 100) {//充值
        if (IsStringEmptyOrNull([CurrentUserInfo sharedInstance].backCard)) {
            ShowAutoHideMBProgressHUD(KKeyWindow, @"您还未绑定圈存卡!");
        }else {
            RechargeViewController *recharge = [[RechargeViewController alloc] init];
            recharge.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:recharge animated:YES];
        }
    } else if (button.tag == 101) {// 账单
        StoreListViewController *storeList = [[StoreListViewController alloc] init];
        storeList.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:storeList animated:YES];
    } else if (button.tag == 102) {// 绑定/解绑
        CardEditViewController *card = [[CardEditViewController alloc] init];
        card.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:card animated:YES];
    } else {// 银行卡
      NSString *images = @"http://image.baidu.com/";
      HelpViewController *help = [[HelpViewController alloc] initWithTitle:@"银行卡申请表" loadRequest:images];//[NSString stringWithFormat:@"%@/test/bankCardInfo.html",kBaseUrl]];
        help.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:help animated:YES];
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
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;

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
