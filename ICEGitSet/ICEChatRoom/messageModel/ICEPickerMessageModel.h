//
//  ICEPickerMessageModel.h
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
 *  图片消息内容数据模型
 */

#import <Foundation/Foundation.h>
#import "ICEChatDemoDefine.h"

typedef void(^LoadImgBlock) (UIImage *image);

@interface ICEPickerMessageModel : NSObject

/**
 *  消息类型
 */
@property (nonatomic, assign) MessageFrom messageFrom;
/**
 *  图片路径
 */
@property (nonatomic, copy) NSString *imageURL;
/**
 *  图片
 */
@property (nonatomic, strong) UIImage *image;



/**
 *  图片回调
 */
- (void)imageMessage:(LoadImgBlock)imageBlock;


@end
