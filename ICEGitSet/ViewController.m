//
//  ViewController.m
//  ICEGitSet
//
//  Created by WLY on 16/4/25.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ViewController.h"
#import "SRWebSocket.h"
#import "ICECategory.h"
#import "NSDictionary+ICEAdd.h"
#import "ICEWebsocket.h"


#define kWebSocketURL @"ws://101.200.0.204:81/websocket"

@interface ViewController ()<SRWebSocketDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [ICEWebsocket shareWebSocket].userID = 779;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelLinkStateChange:) name:kNotificationICEWebSocketLinkStateChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelReceiveMessage:) name:kNotificationICEWebSocketReceiveMessage object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)handelLinkStateChange:(NSNotification *)notifaction{

    DLog(@"%@",notifaction);
}


- (void)handelReceiveMessage:(NSNotification *)notifaction{
    
    DLog(@"%@",notifaction);
}




#pragma mark - SRWebSocketDelegate 写上具体聊天逻辑




- (IBAction)sendMessage:(UIButton *)sender {
    
    DLog(@"%@",self.textView.text);
    
}

- (IBAction)open:(UIButton *)sender {
    
    [[ICEWebsocket shareWebSocket] open];
}


- (IBAction)close:(UIButton *)sender {
    [[ICEWebsocket shareWebSocket] close];
}
@end
