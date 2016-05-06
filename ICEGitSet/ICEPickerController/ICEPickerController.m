//
//  GMXPickImgVAction.m
//  WLYDoctor_iPad
//
//  Created by WLY on 16/2/25.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ICEPickerController.h"
#import "ICEPhotoLibrary.h"

@interface ICEPickerController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) GetImageBlock getImageBLock;


@end

@implementation ICEPickerController

- (instancetype)init{

    self = [super init];
    if (self) {
    
        self.needEdit = NO;
    }
    
    return self;
}

#pragma mark - 从 相册/相机 获取图片

- (void)p_openCamearOnViewConreoller:(UIViewController *)viewController{
    

    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //设置拍照后的图片可被编辑
        picker.allowsEditing = self.needEdit;
        //资源类型为照相机
        picker.sourceType = sourceType;
        
        [viewController presentViewController:picker animated:YES completion:^{
            picker.delegate = self;
        }];
    }else {
        NSLog(@"该设备无摄像头");
    }
    
    
}

- (void)p_showImagePictureOnViewController:(UIViewController *)viewController{
    

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //设置选择后的图片可被编辑
    picker.allowsEditing = self.needEdit;
    [viewController presentViewController:picker animated:YES completion:^{
        picker.delegate = self;
        
    }];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    NSString *key = UIImagePickerControllerOriginalImage;
    //拍照时 保存照片
    if (picker.sourceType == 1) {
        if (self.needEdit) {
            key = UIImagePickerControllerEditedImage;
        }
        
        
     UIImage *image = info[key] ;
        //保存照片
        [ICEPhotoLibrary saveImage:image toAlbum:nil success:^(NSString *imageURL) {
            self.getImageBLock( @{@"errCod" : @(1), @"errMsg" : @"保存成功",@"imageURL":imageURL});
        } failure:^{
            self.getImageBLock( @{@"errCod" : @(1), @"errMsg" : @"保存失败"});
        }];
        
    }else{
        
        NSURL *url = info[@"UIImagePickerControllerReferenceURL"];
        NSString *urlStr = url.absoluteString;
        self.getImageBLock( @{@"errCod" : @(1), @"errMsg" : @"保存成功",@"imageURL":urlStr});
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{


    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)getPictureFromePictureBrowseWithViewController:(UIViewController *)viewController
                                            completion:(GetImageBlock)completion{
    
    [self p_showImagePictureOnViewController:viewController];
    self.getImageBLock = completion;
}

- (void)getPictureFromeCamearWithViewController:(UIViewController *)viewController completion:(GetImageBlock)completion{
    
    [self p_openCamearOnViewConreoller:viewController];
    self.getImageBLock = completion;
}



@end
