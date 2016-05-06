//
//  ICEMessageModel.h
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//

/**
 消息实体
 */
#import <YYModel/YYModel.h>
#import "ICEChatDemoDefine.h"


#import <Foundation/Foundation.h>
#import "ICEMessageContentModel.h"




@interface ICEMessageModel : NSObject

@property (nonatomic, assign) MessageFrom            messageFrom;//消息来源
@property (nonatomic, assign) MessageType            messageType;//消息类型
@property (nonatomic, copy  ) NSString               *avatorImgURL;//用户头像
@property (nonatomic, copy  ) NSString               *userName;//用户名
@property (nonatomic, copy  ) NSString               *sendTime;//发送时间
@property (nonatomic, assign) NSInteger              userID;//用户id
/**
 *  消息内容, 分为三个类型, 语音消息 传递 语音消息地址, 图片消息 传递图片 image
 */
@property (nonatomic, strong) ICEMessageContentModel *messageContent;


/**
 *  单元格高度
 */
- (CGFloat)cellHeight;

@end
