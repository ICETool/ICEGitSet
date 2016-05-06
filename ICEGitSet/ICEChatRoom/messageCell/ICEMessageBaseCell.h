//
//  ICEMEssageBaseCell.h
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
 *  消息单元格 基类 不可实例化, 显示的单元格  为其子类
 */

#import <UIKit/UIKit.h>
#import "ICEChatDemoDefine.h"
#import "ICEMessageModel.h"
#import "UIImageView+WebCache.h"
#import "ICEMessageContentModel.h"




@interface ICEMessageBaseCell : UITableViewCell

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

/**
 *  设置消息内容
 */
- (void)setValueWithModel:(ICEMessageModel *)message;


@end
