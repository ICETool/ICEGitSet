//
//  ICEPickerMessageCell.m
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEPickerMessageCell.h"


@implementation ICEPickerMessageCell



//初始话
- (void)initialize{
    self.placeImage = [UIImage imageNamed:PickerMessage_DefineImage];
    
    self.imageMessage = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.imageMessage.userInteractionEnabled = YES;
    self.imageMessage.image = self.placeImage;
    [self.messageContentView addSubview:self.imageMessage];
}

//设置布局
- (void)setLayout{

    switch (self.messageFrom) {
        case MessageFromSelf: {
            [self.imageMessage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(CELL_PickerMessaegeContetn_H);
                make.right.mas_equalTo(- CELLSpacing);
                make.height.mas_equalTo(CELL_PickerMessaegeContetn_H);
            }];
            break;
        }
        case MessageFromOther: {
            [self.imageMessage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(CELL_PickerMessaegeContetn_H);
                make.left.mas_equalTo(CELLSpacing);
                make.height.mas_equalTo(CELL_PickerMessaegeContetn_H);
            }];
            break;
        }
    }
    
}


/**
 *  通过url获取图片 (本地相册 或者网络),并更新约束
 */
- (void)setImageMessageView:(NSString *)url{

    [self.pickerMessageModel imageMessage:^(UIImage *image) {
        
        if (image) {
            
            self.imageMessage.image = image;
            CGSize size = image.size;
            CGFloat width = CELL_PickerMessaegeContetn_H / size.height * size.width;
            [self.imageMessage mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(width);
            }];
        }else{
            
            self.imageMessage.image = [UIImage imageNamed:PickerMessage_failureImage];
        }
    }];
}


- (void)setValueWithModel:(ICEMessageModel *)message{

    self.pickerMessageModel = message.pickerMessage;
    
    [super setValueWithModel:message];
    [self initialize];
    [self setLayout];
    
    [self setImageMessageView:self.pickerMessageModel.imageURL];
}

@end
