//
//  ICEPickerMessageCell.h
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
 *  图片消息cell
 */
#import "ICEMessageCell.h"
#import "ICEPickerMessageModel.h"


typedef void(^GetImageBlock) (UIImage *image);

@interface ICEPickerMessageCell : ICEMessageCell

@property (nonatomic, strong) UIImageView *imageMessage;
@property (nonatomic, strong) UIImage *placeImage;//默认图片(接受到图片时 等待请求期间显示的图片)
@property (nonatomic, strong) UIImage *failureImage;//请求失败时显示的图片
/**
 *  图片消息实体
 */
@property(nonatomic, strong) ICEPickerMessageModel *pickerMessageModel;




@end
