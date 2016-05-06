//
//  ICEMessageContentModel.h
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
  文本消息内容数据模型
 */
#import <Foundation/Foundation.h>
#import "ICEChatDemoDefine.h"



@interface ICETextMessageModel : NSObject

@property (nonatomic, strong) NSString *content;//消息内容

@property (nonatomic, assign) MessageType messageType;//消息类型

@end
