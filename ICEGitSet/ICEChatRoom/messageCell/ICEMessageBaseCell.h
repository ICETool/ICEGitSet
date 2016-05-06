//
//  ICEMEssageBaseCell.h
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICEMessageModel.h"
#import "UIImageView+WebCache.h"


#define  CELLSpacing  15 //间距
#define  CELLAvator_w  60 //头像大小
#define  CELLNameLabel_H 15//姓名栏 高度



@interface ICEMessageBaseCell : UITableViewCell

@property (nonatomic, assign) MessageFrom messageFrom;//消息来源
@property (nonatomic, assign) MessageType messageType;//消息类型
@property (nonatomic, strong) UIImageView *avatarImgv;//头像
@property (nonatomic, strong) UILabel     *nameLabel;//姓名
@property (nonatomic, strong) UIView      *messageContentView;//消息




- (void)setValueWithModel:(ICEMessageModel *)message;
@end
