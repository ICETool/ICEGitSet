//
//  ICEMessageModel.h
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//

/**
   单个消息 数据模型
 */
#import <YYModel/YYModel.h>
#import "ICEChatDemoDefine.h"


#import <Foundation/Foundation.h>
#import "ICETextMessageModel.h"
#import "ICEPickerMessageModel.h"



@interface ICEMessageModel : NSObject

@property (nonatomic, assign) MessageSendSuccessStatus    messageSendSuccessStatus;//消息发送成功的状态
/**
 *  消息来源
 */
@property (nonatomic, assign) MessageFrom                 messageFrom;
/**
 *  消息类型 (图片 文本 语音)
 */
@property (nonatomic, assign) MessageType                 messageType;
/**
 *  消息发送者的头像
 */
@property (nonatomic, copy  ) NSString                    *avatorImgURL;
/**
 *  消息发送者的用户名
 */
@property (nonatomic, copy  ) NSString                    *userName;
/**
 *  消息的发送时间
 */
@property (nonatomic, copy  ) NSString                    *sendTime;
/**
 *  消息发送者的id
 */
@property (nonatomic, assign) NSInteger                   userID;
/**
 *  文本消息实体
 */
@property (nonatomic, strong) ICETextMessageModel         *textMessage;

/**
 *  图片消息实体
 */
@property (nonatomic, strong) ICEPickerMessageModel       *pickerMessage;

/**
 *  单元格高度
 */
- (CGFloat)cellHeight;

@end
