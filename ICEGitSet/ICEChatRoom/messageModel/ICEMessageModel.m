//
//  ICEMessageModel.m
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEMessageModel.h"

@implementation ICEMessageModel




- (CGSize)messageContentSize{
    
//    switch (self.messageType) {
//        case MessageTypeText: {
//            return [self p_textMessageContentSize:self.messageContent[@(MessageTypeText)]];
//        }
//        case MessageTypePicture: {
//            return [self p_pictrueMessageContentSize:self.messageContent[@(MessageTypePicture)]];
//        }
//        case MessageTypeVoice: {
//            return [self p_voiceMessageContentSize:self.messageContent[@(MessageTypeVoice)]];
//        }
//    }
    return [self p_textMessageContentSize:self.messageContent[@(MessageTypeText)]];
}

/**
 *  计算文本大小
 *
 */
- (CGSize)p_textMessageContentSize:(NSString *)textMessage{
    
    CGFloat max_w = 200 ;
    return [textMessage boundingRectWithSize:CGSizeMake(max_w, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size;
    
}


@end
