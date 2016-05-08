//
//  ICEMessageModel.m
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEMessageModel.h"
#import "ICETextMessageCell.h"

@implementation ICEMessageModel

- (ICETextMessageModel *)textMessage{

    if (!_textMessage) {
        _textMessage = [[ICETextMessageModel alloc] init];
    }
    return _textMessage;
}

- (ICEPickerMessageModel *)pickerMessage{

    if (!_pickerMessage) {
        _pickerMessage = [[ICEPickerMessageModel alloc] init];
    }
    return _pickerMessage;
}

- (ICEVoiceMessageModel *)voiceMessage{

    if (!_voiceMessage) {
        _voiceMessage = [[ICEVoiceMessageModel alloc] init];
    }
    return _voiceMessage;
}

- (CGFloat)cellHeight{

    CGFloat cell_h = 5.5 * CELLSpacing;
    CGFloat content_h = 0 ;
    
    switch (self.messageType) {
        case MessageTypeText: {
          content_h = [ICETextMessageCell  getBubbleSize:[ICETextMessageCell textMessageContentSize:self.textMessage.content]].height;
            break;
        }
        case MessageTypePicture: {
            content_h = CELL_PickerMessaegeContetn_H;
            break;
        }
        case MessageTypeVoice: {
            content_h += 40;
            break;
        }
    }
    
    return cell_h += content_h;
    
}

// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }


@end
