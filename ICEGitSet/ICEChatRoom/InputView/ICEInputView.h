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
/**
 *  其他视图显示状态回调
 */
typedef void (^AddViewBlock) (BOOL isShowAddView);

@protocol InputViewDelegate <NSObject>
/**
 *  发送文本消息回调
 */
- (void)inputView:(ICEInputView *)inputView withTextMessage:(NSString *)textMessage;
/**
 *  发送图片消息回调
 */
- (void)inputView:(ICEInputView *)inputView withPictureMessage:(NSString *)PictureMessage;
/**
 *  发送语音消息回调
 */
- (void)inputView:(ICEInputView *)inputView withVoieMessage:(NSDictionary *)VoiceMessage;



@end

@interface ICEInputView : UIView
@property (nonatomic, strong) UIButton *stateBtn;//副主视图装填按钮

@property (nonatomic, assign) id<InputViewDelegate> delegate;




/**
 *  显示视图 显示状态交互回调
 */
- (void)addViewShowState:(AddViewBlock)completion;

@end
