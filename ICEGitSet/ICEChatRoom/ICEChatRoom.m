//
//  ICEChatRoom.m
//  ICEChatDemo
//
//  Created by WLY on 16/5/4.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
 *  消息列表:
 *  输入视图: 
 *
 */


#import "ICEChatRoom.h"
#import "ICEMessageListView.h"
#import "ICEInputView.h"


#define  NAVI_H  64
const static CGFloat inputView_h = 40;

@interface ICEChatRoom ()

@property (nonatomic, strong) ICEMessageListView  *messageListView;//消息列表
@property (nonatomic, strong) ICEInputView        *inputView;//输入视图


@end

@implementation ICEChatRoom

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (void)p_subview{


    
}
/**
 *  聊天列表
 */
- (void)p_messageListView{

    if (!_messageListView) {
        self.messageListView = [[ICEMessageListView alloc] initWithFrame:CGRectMake(0, NAVI_H, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - NAVI_H)];
        
        [self.view addSubview:self.messageListView];
    }
}

/**
 *  输入视图
 */
- (void)p_inputView{

    if (!_inputView) {
        self.inputView = [ICEInputView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
}

@end
