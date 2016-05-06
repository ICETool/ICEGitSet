//
//  GMXPickImgVAction.h
//  WLYDoctor_iPad
//
//  Created by WLY on 16/2/25.
//  Copyright © 2016年 WLY. All rights reserved.
//

#define PickerGroupName @"ICE" //新建的相册名

#import <Foundation/Foundation.h>
/**
 *  获取图片的回调
 *
 *  @param imageInfo @{@"errCod" : @(0/1), @"errMsg" : @"保存成功" , @"image" : image};
 */
typedef void (^GetImageBlock) (NSDictionary *imageInfo);

@interface ICEPickerController : UIView

@property (nonatomic, assign) BOOL needEdit;//是否需要编辑  yes:需要 默认NO


/**
 *  从相册获取图片
 *
 *  @param viewController 当前视图控制器
 *  @param completion     获取到图片后的回调
 */
- (void)getPictureFromePictureBrowseWithViewController:(UIViewController *)viewController
                                            completion:(GetImageBlock)completion;

/**
 *  从相机获取图片
 *
 *  @param viewController 当前视图控制器
 *  @param completion     获取到图片后的回调
 */
- (void)getPictureFromeCamearWithViewController:(UIViewController *)viewController
                                     completion:(GetImageBlock)completion;




@end
