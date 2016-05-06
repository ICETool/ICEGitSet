
//
//  ICEPhotoLibrary.m
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEPhotoLibrary.h"
#import <AssetsLibrary/AssetsLibrary.h>
@import Photos;

#define ICE_Version  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] //系统版本


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define user_Photos  SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")







@implementation ICEPhotoLibrary



/**
 *  保存图片到指定的相册
 *
 *  @param image     要保存的图片
 *  @param albumName 相册名
 *  @param success   成功的回调
 *  @param falied    失败的回调
 */
+ (void)saveImage:(UIImage *)image
          toAlbum:(NSString *)albumName
          success:(SaveSuccessBlock)success
          failure:(FailureBlock)falied{

        ALAssetsLibrary* library = [[ALAssetsLibrary alloc]init];
        
        if (!albumName) {
            //保存到系统默认相册
            [library writeImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
                
                if (!error) {
                    if (success) {
                        success(assetURL.absoluteString);
                    }
                }else{
                    if (falied) {
                        falied(); 
                    }
                }
            }];
        }
    
}



/**
 *  通过相册中图片的url 获取相册中指定的图片
 *
 *  @param imageURL  图片在相册中的url
 *  @param albumName 相册名
 *  @param success   获取成功的回调
 *  @param falied    获取失败的回调
 */
+ (void)getImage:(NSString *)imageURL
       fromAlbum:(NSString *)albumName
         success:(LoadSuccessBlock)success
         faliure:(FailureBlock)falied{
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    
    NSURL *url = [NSURL URLWithString:imageURL];
    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
        // 使用asset来获取本地图片
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        CGImageRef imgRef = [assetRep fullResolutionImage];
        UIImage *image = [UIImage imageWithCGImage:imgRef scale:assetRep.scale orientation:(UIImageOrientation)assetRep.orientation];
        //回调
        if (success) {
            success(image);
        }
        
    } failureBlock:^(NSError *error) {
        
        
        
    }];

}



/**
 *  创建相册
 *
 *  @param albumName 新相册名
 *  @param reslut    创建结果
 */
+ (void)creatNewAssetsGroupAlbunWithName:(NSString *)albumName
                             resultBlock:(CreatNewGroupBlock *)reslut{

      ALAssetsLibrary* library = [[ALAssetsLibrary alloc]init];
    [library addAssetsGroupAlbumWithName:albumName resultBlock:^(ALAssetsGroup *group) {
        //NSString *const ALAssetsGroupPropertyName;
        //NSString *const ALAssetsGroupPropertyType;
        //NSString *const ALAssetsGroupPropertyPersistentID;
        //NSString *const ALAssetsGroupPropertyURL;
        //查看相册的名字
//        NSLog(@"ALAssetsGroupPropertyName:%@",[group valueForProperty:ALAssetsGroupPropertyName]);
//        //查看相册的类型
//        NSLog(@"ALAssetsGroupPropertyType:%@",[group valueForProperty:ALAssetsGroupPropertyType]);
//        //查看相册的存储id
//        NSLog(@"ALAssetsGroupPropertyPersistentID:%@",[group valueForProperty:ALAssetsGroupPropertyPersistentID]);
//        //查看相册存储的位置地址
//        NSLog(@"ALAssetsGroupPropertyURL:%@",[group valueForProperty:ALAssetsGroupPropertyURL]);
//        groupURL = [group valueForProperty:ALAssetsGroupPropertyURL];
        
    } failureBlock:^(NSError *error) {
        
    }];
}


@end
