//
//  ICEPhotoLibrary.h
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * 保存媒体的block
 */
typedef void(^SaveSuccessBlock) (NSString *imageURL);
typedef void(^FailureBlock) ();
/**
 *  获取媒体的block
 */
typedef void(^LoadSuccessBlock) (UIImage *image);

/**
 *  创建相册成功的回调
 */
typedef void (^CreatNewGroupBlock) ();

@interface ICEPhotoLibrary : NSObject

/**
 *  保存图片到指定的相册
 *
 *  @param image     要保存的图片
 *  @param albumName 相册名(如果为空 则保存到系统默认的相册下)
 *  @param success   成功的回调
 *  @param falied    失败的回调
 */
+ (void)saveImage:(UIImage *)image
        toAlbum:(NSString *)albumName
          success:(SaveSuccessBlock)success
           failure:(FailureBlock)falied;



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
         faliure:(FailureBlock)falied;



/**
 *  创建相册
 *
 *  @param albumName 新相册名
 *  @param reslut    创建结果
 */
+ (void)creatNewAssetsGroupAlbunWithName:(NSString *)albumName
                             resultBlock:(CreatNewGroupBlock *)reslut;
@end
