//
//  ICEInputView.h
//  ICEChatDemo
//
//  Created by WLY on 16/5/4.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ICEMessageModel;
@class ICEInputView;
typedef void(^VoiceBtnBlock) (BOOL isVoice);

typedef void (^SendMessageBlock) (ICEMessageModel *message);


@protocol InputViewDelegate <NSObject>
/**
 *  发送文本消息回调
 */
- (void)inputView:(ICEInputView *)inputView withTextMessage:(NSString *)textMessage;
/**
 *  发送文本消息回调
 */
- (void)inputView:(ICEInputView *)inputView withPictureMessage:(NSDictionary *)PictureMessage;
/**
 *  发送语音消息回调
 */
- (void)inputView:(ICEInputView *)inputView withVoieMessage:(NSDictionary *)VoiceMessage;

@end

@interface ICEInputView : UIView
@property (nonatomic, strong) UIButton *stateBtn;//副主视图装填按钮

@property (nonatomic, assign) id<InputViewDelegate> delegate;

/**
 *  发送消息回调
 *
 *  @param message 一条消息
 */
- (void)sendMessage:(SendMessageBlock)message;

@end
