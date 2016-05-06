//
//  ICEChatDemoDefine.h
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 消息来源
 */
typedef enum MessageFrom{
    MessageFromSelf,
    MessageFromOther,
}MessageFrom;


/**
 消息类型
 */
typedef enum MessageType{
    MessageTypeText = 1,
    MessageTypePicture,
    MessageTypeVoice,
}MessageType;


/**
 消息发送成功的状态
 */
typedef enum MessageSendSuccessStatus {

    MessageSendSuccessStatusFailed,//发送失败
    MessageSendSuccessStatusSuccess,//发送成功
}MessageSendSuccessStatus;

#pragma mark - 单元格间距


#define  CELLSpacing                    15  //间距
#define  CELLAvator_w                   60  //头像大小
#define  CELLNameLabel_H                15  //姓名栏 高度

#pragma mark - 文本消息
#define  CELL_TextMessage_Sapcing       8   //文本消息中 气泡与消息文本间距
#define  CELL_MessageContentView_Width  200 //消息内容区域最大宽度
#define  CELL_MessageContentView_Height 1000//消息内容区域最大高度


#pragma mark - 图片消息

#define CELL_PickerMessaegeContetn_H    150 //图片消息中图片的大小

#pragma mark - 聊天室 视图宏定义


#define  NAVI_H                            64                //导航栏高度
#define  ICEInput_h (ICEInput_InputView_H + ICEInput_AddView_H)//输入视图高度
#define  ICEInput_InputView_H              50                //输入视图中 单纯输入部分 高度
#define  ICEInput_AddView_H                120               //输入辅助视图 高度


#define ICEInputFrame_Normal  CGRectMake(0, self.height - ICEInput_InputView_H, self.width,            ICEInput_h)//正常状态下的输入视图frame
#define ICEInputFrame_ShowKeyBoard CGRectMake(0, self.height - ICEInput_InputView_H - keyBoard_h, self.width, ICEInput_h)//显示键盘状态下的输入视图frame
#define ICEInputFrame_ShowAddView  CGRectMake(0, self.height - ICEInput_h, self.width,                        ICEInput_h)          //显示辅助视图状态下的输入视图frame
#define ICEMessageListView_Normal  CGRectMake(0, 0, self.width, self.height   -                               ICEInput_InputView_H)//正常状态下的聊天列表frame
#define ICEMessageListView_ShowKeyBoard CGRectMake(0, 0, self.width, self.height - ICEInput_InputView_H -     keyBoard_h)          //显示键盘状态下的聊天列表frame
#define ICEMessageListView_ShowAddView CGRectMake(0, 0, self.width, self.height -                             ICEInput_h)          //显示副主视图状态下的聊天类表frame





#pragma mark - 字体大小

#define Message_Font_Size      14                               //文本消息 字体大小
#define CELL_Text_Message_Font UIFontWithSize(Message_Font_Size)//文本消息 字体
#define CELL_Name_Font         UIFontWithSize(14)               //消息发送者姓名字体



#pragma mark - 默认图片

#define PickerMessage_DefineImage @"picture" //图片消息中的默认图片
#define PickerMessage_failureImage @"send"  //请求失败时显示的图片