//
//  ICEMEssageBaseCell.h
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
 *  消息单元格基类:
 *  包含所有消息cell的必要信息. 消息cell基类针对用户头像的信息是否显示,分为两类:  * 提醒类cell 不显示用户信息
     * 消息类cell 显示用户信息
 */

#import <UIKit/UIKit.h>
#import "ICEChatDemoDefine.h"
#import "ICEMessageModel.h"
#import "UIImageView+WebCache.h"




@interface ICEMessageBaseCell : UITableViewCell






/**
 *  设置消息内容
 */
- (void)setValueWithModel:(ICEMessageModel *)message;


@end
