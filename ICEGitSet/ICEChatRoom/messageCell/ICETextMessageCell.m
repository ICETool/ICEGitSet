//
//  ICETextMessageView.m
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICETextMessageCell.h"

@interface ICETextMessageCell ()



@end

@implementation ICETextMessageCell


/**
 *  初始化方法
 */
- (void)initialize{
    
    self.bubbleBackgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.messageContentView addSubview:self.bubbleBackgroundView];
    
    self.textMessageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.textMessageLabel.font = CELL_Text_Message_Font;
    self.textMessageLabel.numberOfLines = 0;
    [self.textMessageLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.textMessageLabel setTextAlignment:NSTextAlignmentLeft];
    [self.textMessageLabel setTextColor:[UIColor blackColor]];
    [self.bubbleBackgroundView addSubview:self.textMessageLabel];
    
    
}

/**
 *  设置布局
 */
- (void)setLayout{

    CGSize textMessageSize = [[self class] textMessageContentSize:self.MessageContentModel.content];
    
    CGSize bubbleSize = [[self class] getBubbleSize:textMessageSize];
    self.textMessageLabel.text = self.MessageContentModel.content;
    
    switch (self.messageFrom) {
        case MessageFromSelf: {
            [self.bubbleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.size.mas_equalTo(bubbleSize);
            }];
            
            [self.textMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(CELL_TextMessage_Sapcing);
                make.left.mas_equalTo(CELL_TextMessage_Sapcing);
                make.right.mas_equalTo(- CELL_TextMessage_Sapcing * 1.3);
                make.bottom.mas_equalTo(- CELL_TextMessage_Sapcing);
            }];
            self.bubbleBackgroundView.image = [[UIImage imageNamed:@"sendBubble"] resizedImage];
            self.textMessageLabel.textAlignment = NSTextAlignmentRight;
            break;
        }
        case MessageFromOther: {
            
            
            [self.bubbleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(0);
                make.size.mas_equalTo(bubbleSize);
            }];
            
            [self.textMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(CELL_TextMessage_Sapcing);
                make.left.mas_equalTo(CELL_TextMessage_Sapcing * 1.3);
                make.right.mas_equalTo(- CELL_TextMessage_Sapcing);
                make.bottom.mas_equalTo(- CELL_TextMessage_Sapcing);
            }];

            self.bubbleBackgroundView.image = [[UIImage imageNamed:@"getBubble"] resizedImage];
            self.textMessageLabel.textAlignment = NSTextAlignmentLeft;
            break;
        }
    }
    
    
}

+ (CGSize)getBubbleSize:(CGSize)textLabelSize {
    CGSize bubbleSize = CGSizeMake(textLabelSize.width, textLabelSize.height);
    
    if (bubbleSize.width + CELL_TextMessage_Sapcing * 2.5 > 50) {
        bubbleSize.width = bubbleSize.width + CELL_TextMessage_Sapcing * 3.5;
    } else {
        bubbleSize.width = 50;
    }
    if (bubbleSize.height + CELL_TextMessage_Sapcing * 3 > 35) {
        bubbleSize.height = bubbleSize.height + CELL_TextMessage_Sapcing * 2;
    } else {
        bubbleSize.height = 35;
    }
    
    return bubbleSize;
}

/**
 *  计算文本大小
 *
 */
+ (CGSize)textMessageContentSize:(NSString *)textMessage{
    
    CGSize textSize;
    
    if ([textMessage length] > 0) {
        float maxWidth = CELL_MessageContentView_Width;
        CGRect  textRect  = [textMessage
                             boundingRectWithSize:CGSizeMake(maxWidth, 8000)
                             options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:Message_Font_Size]}
                             context:nil];
        textRect.size.height = ceilf(textRect.size.height);
        textRect.size.width = ceilf(textRect.size.width);
        textSize = CGSizeMake(textRect.size.width + 5, textRect.size.height + 5);
    } else {
        textSize = CGSizeZero;
    }
    
    return textSize ;
    
}

/**
 *  图片拉伸
 */
- (UIImage *)p_imageResizedImageWithImage:(UIImage *)image {
    //设置拉伸的范围
    CGFloat x_value = image.size.width / 2 - 1;
    CGFloat y_value = image.size.height / 2 - 1;
    NSLog(@"%f",image.size.height);
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(y_value, x_value, y_value, x_value)];
    
}




- (void)setValueWithModel:(ICEMessageModel *)message{

    [super setValueWithModel:message];
    
    [self initialize];

    [self setLayout];
    
}
@end
