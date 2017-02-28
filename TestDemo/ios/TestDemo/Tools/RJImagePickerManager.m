//
//  RJImagePickerManager.m
//  TestDemo
//
//  Created by jia on 2017/2/28.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "RJImagePickerManager.h"
#import "RJHTTPClient+Mine.h"
#import "AppDelegate.h"

@interface RJImagePickerManager()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, copy)UploadImage loadImg;
@end

@implementation RJImagePickerManager
+ (instancetype)sharedInstance {
  static RJImagePickerManager *manager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager = [[RJImagePickerManager alloc] init];
  });
  return manager;
}

- (void)showWithCallBack:(UploadImage)callBack {
  self.loadImg = [callBack copy];
  UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
  dispatch_async(dispatch_get_main_queue(), ^{
      [sheet showInView:KKeyWindow];
  });
  
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
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window.rootViewController presentViewController:picker animated:YES completion:nil];
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
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window.rootViewController presentViewController:pickerImage animated:YES completion:nil];
  }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  [picker dismissViewControllerAnimated:YES completion:nil];
  NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
  //判断资源类型
  if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    WaittingMBProgressHUD(KKeyWindow, @"");
    weakify(self);
    image = [UIImage imageNamed:@"timg.jpeg"];
    [[RJHTTPClient sharedInstance] uploadUserIcon:image completion:^(WebResponse *response) {
      if (response.code == WebResponseCodeSuccess) {
        SuccessMBProgressHUD(KKeyWindow, @"上传成功");
        NSDictionary *data = ObjForKeyInUnserializedJSONDic(response.responseObject, @"data");
        NSDictionary *userInfo = ObjForKeyInUnserializedJSONDic(data, @"userinfo");
        if (!IsStringEmptyOrNull(StringForKeyInUnserializedJSONDic(userInfo, @"user_img"))) {
          [CurrentUserInfo sharedInstance].user_img = [NSString stringWithFormat:@"%@/%@",KImgBaseUrl, StringForKeyInUnserializedJSONDic(userInfo, @"user_img")];
        } else {
          [CurrentUserInfo sharedInstance].user_img = @"";
        }
        if (weakSelf.loadImg) {
          weakSelf.loadImg([CurrentUserInfo sharedInstance].user_img);
        }
        
      } else {
        FailedMBProgressHUD(KKeyWindow, response.message);
      }
    }];
  } else {
    ShowAutoHideMBProgressHUD(KKeyWindow, @"请选择图片上传");
  }
  
  
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
