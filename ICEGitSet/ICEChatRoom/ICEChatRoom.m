//
//  ICEChatDemo.m
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEChatRoom.h"
#import "ICEMessageModel.h"
#import "ICEMessageListView.h"
#import "ICEInputView.h"
#import "ICEKeyboardNotifaction.h"

#define  NAVI_H  64
#define  ICEInput_h 150

#define ICEInputFrame_Normal  CGRectMake(0, self.height - 50, self.width,                   ICEInput_h)//正常状态下的输入视图frame
#define ICEInputFrame_ShowKeyBoard CGRectMake(0, self.height - 50 - keyBoard_h, self.width, ICEInput_h)//显示键盘状态下的输入视图frame
#define ICEInputFrame_ShowAddView  CGRectMake(0, self.height - ICEInput_h, self.width,              ICEInput_h)//显示辅助视图状态下的输入视图frame
#define ICEMessageListView_Normal  CGRectMake(0, 0, self.width, self.height   -                           50)//正常状态下的聊天列表frame
#define ICEMessageListView_ShowKeyBoard CGRectMake(0, 0, self.width, self.height - 50 -     keyBoard_h)//显示键盘状态下的聊天列表frame
#define ICEMessageListView_HideAddView CGRectMake(0, 0, self.width, self.height -                   50)//显示副主视图状态下的聊天类表frame



static CGFloat keyBoard_h = 0;

@interface ICEChatRoom ()<KeyBoardDlegate,InputViewDelegate>

@property (nonatomic, strong) ICEMessageListView *messageListView;//消息列表
@property (nonatomic, strong) ICEInputView       *inputView;//输入视图

@end


@implementation ICEChatRoom

- (instancetype)init{

    self = [super init];
    if (self) {
        [self p_subviews];
    }
    return self;
}


- (void)didMoveToSuperview{

    [super didMoveToSuperview];
    [self p_subviews];
    [self p_interaction];
    DLog(@"======================================");
}

- (void)dealloc{

    [ICEKeyboardNotifaction removeKeyBoardHide:self];
    [ICEKeyboardNotifaction removekeyBoardShow:self];
}

#pragma mark - lazy load


/**
 *  消息列表
 */
- (ICEMessageListView *)messageListView{

    if (!_messageListView) {
        _messageListView = [[ICEMessageListView alloc] init];
        
    }
    return _messageListView;
}

/**
 *  输入视图
 */
- (ICEInputView *)inputView{

    if (!_inputView) {
        _inputView = [[ICEInputView alloc] init];
        _inputView.delegate = self;
        
    }
    return  _inputView;
    
}
#pragma makr - subviews

/**
 *  布局子视图
 */
- (void)p_subviews{

    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.inputView];
    self.inputView.frame = ICEInputFrame_Normal;
    
    [self addSubview:self.messageListView];
    self.messageListView.frame = ICEMessageListView_Normal;

}

#pragma mark - 交互逻辑
#pragma mark - keyboardDelegate
/**
 *  界面交互
 */
- (void)p_interaction{

    //注册键盘弹出和隐藏通知
    [ICEKeyboardNotifaction registerKeyBoardShow:self];
    [ICEKeyboardNotifaction registerKeyBoardHide:self];
}

/**
 *  键盘弹出
 */
- (void)keyboardWillShowNotification:(NSNotification *)notification{


    CGRect frame = [ICEKeyboardNotifaction returnKeyBoardWindow:notification];
    keyBoard_h = frame.size.height;
    double animationDuration = [ICEKeyboardNotifaction returnKeyBoardDuration:notification];
    UIViewAnimationCurve animationCurve = [ICEKeyboardNotifaction returnKeyBoardAnimationCurve:notification];
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:(UIViewAnimationOptions)
                                animationCurve << 16
                     animations:^{

        self.inputView.stateBtn.selected = NO;
        self.inputView.frame =  ICEInputFrame_ShowKeyBoard;
        self.messageListView.frame = ICEMessageListView_ShowKeyBoard;
        [self.messageListView scrollerToBottom];
    } completion:^(BOOL finished) {
        
    }];
}
/**
 *  键盘隐藏
 */
- (void)keyboardWillHideNotification:(NSNotification *)notification{

    double animationDuration = [ICEKeyboardNotifaction returnKeyBoardDuration:notification];
    UIViewAnimationCurve animationCurve = [ICEKeyboardNotifaction returnKeyBoardAnimationCurve:notification];
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:(UIViewAnimationOptions)
                                 animationCurve << 16
                     animations:^{
        
        self.inputView.frame =  ICEInputFrame_Normal;
        self.messageListView.frame = ICEMessageListView_Normal;
    } completion:^(BOOL finished) {
                         
    }];
}


#pragma mark - inputDelegate
- (void)inputView:(ICEInputView *)inputView withTextMessage:(NSString *)textMessage{

    ICEMessageModel *model = [[ICEMessageModel alloc] init];
    model.userName = @"自己";
    model.messageFrom = MessageFromSelf;
    model.messageContent.content = textMessage;
    model.messageContent.messageType = MessageTypeText;
    
    [self.messageListView addOneMessage:model];
    
    ICEMessageModel *model1 = [[ICEMessageModel alloc] init];
    model1.userName = @"自己";
    model1.messageContent.content = textMessage;
    model1.messageFrom = MessageFromOther;
    [self.messageListView addOneMessage:model1];
}
@end
