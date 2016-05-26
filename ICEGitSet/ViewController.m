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
/**
 *  <WLYDiagnoseListModel: 0x13ff5c8b0> {
 address = "北京市北京市";
 amount = 0;
 diagnoseFrom = 0;
 diagnoseState = 0;
 diagnosetType = 2;
 diagnosisRecordId = 37579;
 headImage = "http://101.200.0.204:8089/pages/assets/images/patient-3.png";
 hospital = "测试医院";
 indicateStr = <NSConcreteMutableAttributedString: 0x13ff5c3e0>;
 localInfoStr = <NSConcreteMutableAttributedString: 0x13ff5cf90>;
 localRemoteState = 0;
 patientName = "ZHAO YONG XING";
 payTime = "2016-05-26 13:17:58";
 referralType = 0;
 studyList = [
 <WLYStudyListModel: 0x13ff5c9c0> {
 departmentCategoryId = "0";
 departmentCategoryName = "Fengqiu Furen Hospital^Head ";
 diagnoseFrom = 0;
 diagnoseState = 0;
 diagnosetType = 0;
 modality = "MR";
 modalityId = "0";
 studyDescription = "Fengqiu Furen Hospital^Head ";
 studyInstanceUid = "1.3.12.2.1107.5.2.40.39713.30000015110201014018300000031.2"
 }
 ];
 userAge = "027Y";
 userName = <nil>;
 userSex = "男"
 }
 
 
 userid
 779
 */


/**
 *  打开
 var message = "{messageType:1,socketType:4,userId:'"+loginUserId+"'}";
 websocket.send(message);
    关闭
 message = "{messageType:2,socketType:4,userId:'"+loginUserId+"'}";
 //console.log("sendMessage-->"+message);
 websocket.send(message);

 */



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
