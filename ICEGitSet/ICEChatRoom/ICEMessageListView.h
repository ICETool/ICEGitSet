//
//  ICEMessageListView.h
//  ICEChatDemo
//
//  Created by WLY on 16/5/4.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
 *  消息列表
 */
#import <UIKit/UIKit.h>

@class ICEMessageModel;
@interface ICEMessageListView : UIView




/**
 *  设置初始消息
 *
 *  @param messages 消息数组
 */
- (void)setMessages:(NSArray *)messages;

/**
 *  添加多条新消息
 *
 *  @param messages 消息数组
 */
- (void)addMessages:(NSArray *)messages;

/**
 *  添加一条新消息
 */
- (void)addOneMessage:(ICEMessageModel *)message;


/**
 *  显示最后一条消息
 */
- (void)scrollerToBottom;

@end
