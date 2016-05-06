//
//  ICEMessageCell.h
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
 *  展示用户信息的cell基类
 */



#import "ICEMessageBaseCell.h"
#import "ICEMessageContentModel.h"



@interface ICEMessageCell : ICEMessageBaseCell

@property (nonatomic, assign) MessageFrom messageFrom;//消息来源
@property (nonatomic, assign) MessageType messageType;//消息类型
@property (nonatomic, strong) UIImageView *avatarImgv;//头像
@property (nonatomic, strong) UILabel     *nameLabel;//姓名
@property (nonatomic, strong) UIView      *messageContentView;//消息
@property (nonatomic, strong) ICEMessageModel *messageModel;//消息实体
@property (nonatomic, strong) ICEMessageContentModel *MessageContentModel;//消息内容实体

/**
 *  初始化方法
 */
- (void)initialize;
@end
