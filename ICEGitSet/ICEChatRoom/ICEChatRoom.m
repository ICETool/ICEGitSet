//
//  ICEChatDemo.m
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEChatRoom.h"
#import "ICEChatDemoDefine.h"
#import "ICEMessageModel.h"
#import "ICEMessageListView.h"
#import "ICEInputView.h"
#import "ICEKeyboardNotifaction.h"




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
    
    [self p_inputViewUserinteraction];
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

/**
 *  输入视图交互逻辑
 */
- (void)p_inputViewUserinteraction{

    
    __weak typeof(self) weakSelf = self;

    CGRect inputFrame_ShowAddView = ICEInputFrame_ShowAddView;
    CGRect messageListView_ShowAddView = ICEMessageListView_ShowAddView;
    CGRect inputFrame_Normal = ICEInputFrame_Normal;
    CGRect messageListView_Normal = ICEMessageListView_Normal;
    
    [self.inputView addViewShowState:^(BOOL isShowAddView) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [[UIApplication sharedApplication].keyWindow endEditing:YES];

        [UIView beginAnimations:nil context:nil];
        if (isShowAddView) {
            strongSelf.inputView.frame =  inputFrame_ShowAddView;
            strongSelf.messageListView.frame = messageListView_ShowAddView;
        }else{
            strongSelf.inputView.frame =  inputFrame_Normal;
            strongSelf.messageListView.frame = messageListView_Normal;
        }
        [UIView commitAnimations];
    }];
}


#pragma mark - inputDelegate

//文本消息
- (void)inputView:(ICEInputView *)inputView withTextMessage:(NSString *)textMessage{

    ICEMessageModel *model = [[ICEMessageModel alloc] init];
    model.userName = @"自己";
    model.messageFrom = MessageFromSelf;
    model.textMessage.content = textMessage;
    model.messageType = MessageTypeText;
    
    [self.messageListView addOneMessage:model];
    
    ICEMessageModel *model1 = [[ICEMessageModel alloc] init];
    model1.userName = @"自己";
    model1.textMessage.content = textMessage;
    model1.messageFrom = MessageFromOther;
    model1.messageType = MessageTypeText;
    [self.messageListView addOneMessage:model1];
}


//图片消息
- (void)inputView:(ICEInputView *)inputView withPictureMessage:(NSString *)PictureMessage{

    ICEMessageModel *model = [[ICEMessageModel alloc] init];
    model.userName = @"自己";
    model.messageFrom = MessageFromSelf;
    model.pickerMessage.imageURL = PictureMessage;
    model.messageType = MessageTypePicture;
    
    [self.messageListView addOneMessage:model];
    
    ICEMessageModel *model1 = [[ICEMessageModel alloc] init];
    model1.userName = @"自己";
    model1.pickerMessage.imageURL = @"http://img0.imgtn.bdimg.com/it/u=938096994,3074232342&fm=21&gp=0.jpg";
    model1.messageFrom = MessageFromOther;
    model1.messageType = MessageTypePicture;

    [self.messageListView addOneMessage:model1];

}
@end
