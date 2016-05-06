//
//  ICETextMessageView.h
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
 *  文本消息cell
 */

#import "ICEMessageCell.h"
#import "ICEMessageModel.h"
#import "ICETextMessageModel.h"

@interface ICETextMessageCell : ICEMessageCell


/*!
 文本内容的Label
 */
@property(strong, nonatomic) UILabel *textMessageLabel;

/*!
 背景View
 */
@property(nonatomic, strong) UIImageView *bubbleBackgroundView;

@property (nonatomic, strong) ICETextMessageModel *textMessageModel;//文本消息内容实体

/**
 *  计算气泡的size
 */
+ (CGSize)getBubbleSize:(CGSize)textLabelSize;

/**
 *  计算文本大小
 *
 */
+ (CGSize)textMessageContentSize:(NSString *)textMessage;



@end
