//
//  ICEMessageModel.h
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum MessageFrom{
    MessageFromSelf,
    MessageFromOther,
}MessageFrom;

typedef enum MessageType{
    MessageTypeText = 1,
    MessageTypePicture,
    MessageTypeVoice,
}MessageType;

@interface ICEMessageModel : NSObject

@property (nonatomic, assign) MessageFrom messageFrom;//消息来源
@property (nonatomic, assign) MessageType messageType;//消息类型
@property (nonatomic, copy  ) NSString    *avatorImgURL;//用户头像
@property (nonatomic, copy  ) NSString    *userName;//用户名
@property (nonatomic, copy  ) NSString    *sendTime;//发送时间
@property (nonatomic, assign) NSInteger   userID;//用户id
/**
 *  消息内容, 分为三个类型, 语音消息 传递 语音消息地址, 图片消息 传递图片 image
 */
@property (nonatomic, copy) NSDictionary *messageContent;


@property (nonatomic, assign) CGFloat     cellHeight;//高度

- (CGSize)messageContentSize;


@end
