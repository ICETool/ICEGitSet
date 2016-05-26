//
//  ICEWebsocket.m
//  ICEGitSet
//
//  Created by WLY on 16/5/26.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEWebsocket.h"
#import "SRWebSocket.h"
#import "NSDictionary+ICEAdd.h"



@interface ICEWebsocket ()<SRWebSocketDelegate>

/**
 *  websocket
 */
@property (nonatomic, strong) SRWebSocket *webSocket;

@end


@implementation ICEWebsocket



/**
 *  单利创建websocket (所用的url 在宏中设置)
 */
+ (instancetype)shareWebSocket{

    static ICEWebsocket *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[ICEWebsocket alloc] init];
    });
    return obj;
}


/**
 *  设置链接状态
 */
- (void)p_setLinkState:(LinkState)linkState{
    if (_linkState != linkState) {
        _linkState = linkState;
        
        //发送状态变化通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationICEWebSocketLinkStateChange object:nil userInfo:@{@"LinkState" : @(_linkState)}];
    }
}


/**
 *  打开 (成功或者失败后回调)
 */
- (void)open{
    
    if (!self.webSocket) {
        self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:kWebSocketURL]];
        self.webSocket.delegate = self;
        [self.webSocket open];
        [self p_setLinkState:LinkStateUnderway];
    }
}
/**
 *  关闭
 */
- (void)close{
    
    if (self.webSocket) {
        
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setValue:@(2) forKey:@"messageType"];
        [dictionary setValue:@(4)  forKey:@"socketType"];
        [dictionary setValue:@(self.userID) forKey:@"userId"];
        [self.webSocket sendString:[[dictionary copy] jsonStringEncoded]];
        [self.webSocket closeWithCode:1000 reason:@"手动关闭"];
    }
}



#pragma mark - websocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    
    DLog(@"链接成功,并发送一条消息");
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@(1) forKey:@"messageType"];
    [dictionary setValue:@(4)  forKey:@"socketType"];
    [dictionary setValue:@(self.userID) forKey:@"userId"];
    
    [self.webSocket sendString:[[dictionary copy] jsonStringEncoded]];

    [self p_setLinkState:LinkStateSuccess];
}



- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    
    self.webSocket.delegate = nil;
    self.webSocket = nil;
    
    [self p_setLinkState:LinkStateFailed];
    //链接失败后应该重新链接
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kReLinkTime), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self open];
    });
    DLog(@"链接失败");
}
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    
    //接受到消息后发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationICEWebSocketReceiveMessage object:nil userInfo:message];
    
    DLog(@"接受消息: %@",message);
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    
    DLog(@"关闭  原因: %@",reason);
    [self p_setLinkState:LinkStateFailed];
}



@end
