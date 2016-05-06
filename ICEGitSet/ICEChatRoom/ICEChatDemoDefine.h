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
#define  CELL_TextMessage_Sapcing       8   //文本消息中 气泡与消息文本间距
#define  CELL_MessageContentView_Width  200 //消息内容区域最大宽度
#define  CELL_MessageContentView_Height 1000//消息内容区域最大高度

#pragma mark - 字体大小

#define Message_Font_Size      14                               //文本消息 字体大小
#define CELL_Text_Message_Font UIFontWithSize(Message_Font_Size)//文本消息 字体
#define CELL_Name_Font         UIFontWithSize(14)               //消息发送者姓名字体