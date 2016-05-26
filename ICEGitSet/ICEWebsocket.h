//
//  ICEWebsocket.h
//  ICEGitSet
//
//  Created by WLY on 16/5/26.
//  Copyright © 2016年 ICE. All rights reserved.
//

/**  需要引入的框架
 libicucore.dylib
 CFNetwork.framework
 Security.framework
 Foundation.framework
 */


#import <Foundation/Foundation.h>

#define kWebSocketURL @"ws://101.200.0.204:81/websocket"
#define kReLinkTime   (3ull * NSEC_PER_SEC)//断开后重复链接时间间隔

#define kNotificationICEWebSocketLinkStateChange @"NotificationICEWebSocketLinkStateChange" //通知中心,链接状态的变化通知
#define kNotificationICEWebSocketReceiveMessage  @"NotificationICEWebSocketReceiveMessage" //接受到消息的通知

/**
 链接状态
 */
typedef enum LinkState{
    LinkStateFailed = 0,//链接失败  (包含链接断开)
    LinkStateUnderway = 1,//连接中
    LinkStateSuccess = 2,//链接成功
}LinkState;


@interface ICEWebsocket : NSObject

/**
 *  链接状态 (LinkState/链接失败/连接中)
 */
@property (nonatomic, assign, readonly) LinkState linkState;

/**
 *  当前用户id (第一次调用时设置)
 */
@property (nonatomic, assign) NSInteger userID;

/**
 *  单利创建websocket (所用的url 在宏中设置)
 */
+ (instancetype)shareWebSocket;

/**
 *  打开 (成功或者失败后回调)
 */
- (void)open;
/**
 *  关闭
 */
- (void)close;

@end
