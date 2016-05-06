//
//  ICEMEssageBaseCell.m
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEMessageBaseCell.h"

@interface ICEMessageBaseCell ()
@property (nonatomic, strong) ICEMessageModel *messageModel;

@end


@implementation ICEMessageBaseCell





- (UIImageView *)avatarImgv{

    if (!_avatarImgv) {
        _avatarImgv = [[UIImageView alloc] init];
        [self.contentView addSubview:_avatarImgv];
      

    }
    return _avatarImgv;
}

- (UILabel *)nameLabel{

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UIView *)messageContentView{
    if (!_messageContentView) {
        _messageContentView = [[UIView alloc] init];
        [self.contentView addSubview:_messageContentView];
        
    }
    return _messageContentView;
    
}



/**
 *  布局视图位置
 */
- (void)p_configureInfoView{

    [self.avatarImgv removeFromSuperview];
    [self.nameLabel removeFromSuperview];
    [self.messageContentView removeFromSuperview];
     self.avatarImgv = nil;
     self.nameLabel = nil;
     self.messageContentView = nil;
    
    switch (self.messageFrom) {
        case MessageFromSelf: {
         //布局
            [self.avatarImgv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(CELLSpacing);
                make.right.mas_equalTo(- CELLSpacing);
                make.size.mas_equalTo(CGSizeMake(CELLAvator_w, CELLAvator_w));
            }];
            [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(CELLSpacing);
                make.left.mas_equalTo(CELLAvator_w + CELLSpacing * 1.5);
                make.right.mas_equalTo(- (CELLSpacing * 1.5 + CELLAvator_w));
                make.height.mas_equalTo(CELLNameLabel_H);
            }];
            
            [self.messageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(CELLSpacing / 2);
                make.left.mas_equalTo(self.nameLabel.mas_left);
                make.right.mas_equalTo(self.nameLabel.mas_right);
                make.bottom.mas_equalTo(- CELLSpacing);
            }];
            
            //界面显示
            self.nameLabel.textAlignment = NSTextAlignmentRight;
            
            
            break;
        }
        case MessageFromOther: {
            //布局
            [self.avatarImgv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(CELLSpacing);
                make.left.mas_equalTo(- CELLSpacing);
                make.size.mas_equalTo(CGSizeMake(CELLAvator_w, CELLAvator_w));
            }];
            [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(CELLSpacing * 1.5);
                make.left.mas_equalTo(CELLAvator_w + CELLSpacing * 1.5);
                make.right.mas_equalTo(- (CELLSpacing * 1.5 + CELLAvator_w));
                make.height.mas_equalTo(CELLNameLabel_H);
            }];
            
            [self.messageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(CELLSpacing / 2);
                make.left.mas_equalTo(self.nameLabel.mas_left);
                make.right.mas_equalTo(self.nameLabel.mas_right);
                make.bottom.mas_equalTo(- 2 * CELLSpacing);
            }];
            
            //界面显示
            self.nameLabel.textAlignment = NSTextAlignmentLeft;
            
            
            break;
        }
    }

}

/**
 *  根据消息内容设置单元格
 */
- (void)setValueWithModel:(ICEMessageModel *)message{

    self.messageFrom = message.messageFrom;
    self.messageType = message.messageType;
    
    [self p_configureInfoView];
    
    self.nameLabel.text = message.userName;
        [self.avatarImgv sd_setImageWithURL:[NSURL URLWithString:message.avatorImgURL] placeholderImage:[UIImage imageNamed:@"default_photoM1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            image = [image circleImage];
        }];
    

}

@end
