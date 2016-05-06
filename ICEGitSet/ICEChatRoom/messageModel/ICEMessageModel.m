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

- (ICEMessageContentModel *)messageContent{

    if (!_messageContent) {
        _messageContent = [[ICEMessageContentModel alloc] init];
    }
    return _messageContent;
}

- (CGFloat)cellHeight{

    CGFloat cell_h = 5.5 * CELLSpacing;
    CGSize bubbleSize ;
    bubbleSize = [ICETextMessageCell  getBubbleSize:[ICETextMessageCell textMessageContentSize:self.messageContent.content]];
    
    return cell_h += bubbleSize.height;
    
}

// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }


@end
