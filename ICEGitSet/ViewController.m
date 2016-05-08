//
//  ViewController.m
//  ICEGitSet
//
//  Created by WLY on 16/4/25.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ViewController.h"
#import "ICEMP3Recorder.h"
#import "ICEAVAudioPlayer.h"
#import "UUProgressHUD.h"
@interface ViewController ()<MP3RecorderDelegate>
@property (nonatomic, strong) ICEAVAudioPlayer  *voicePlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   UUProgressHUD *hud = [UUProgressHUD sharedView];
    
    hud.layer.cornerRadius = 20;
    
    UIButton *start  = [UIButton buttonWithType:UIButtonTypeSystem];
    [start setTitle:@"开始" forState:UIControlStateNormal];
    start.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:start];
    
    
    UIButton *stop  = [UIButton buttonWithType:UIButtonTypeSystem];
    [stop setTitle:@"停止" forState:UIControlStateNormal];
    stop.frame = CGRectMake(100, 250, 100, 100);
    [self.view addSubview:stop];
    
    
    UIButton *cacle  = [UIButton buttonWithType:UIButtonTypeSystem];
    [cacle setTitle:@"开始" forState:UIControlStateNormal];
    cacle.frame = CGRectMake(100, 400, 100, 100);
    [self.view addSubview:cacle];
    
    
    
    ICEMP3Recorder *recorder = [[ICEMP3Recorder alloc] initWithDelegate:self];
    [recorder AudioPowerChange:^(CGFloat power,CGFloat time) {
        DLog(@"%f",time);
//        [self.acrView addSoundMeterItem:power];
//        [UUProgressHUD changeSubTitle:[NSString stringWithFormat:@"%f",time]];
        
    }];
    [start handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        [recorder startRecorder];
        [UUProgressHUD show];
    }];
    
    [stop handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        [recorder endRecorder];
        [UUProgressHUD dismissWithSuccess:@"成功"];
    }];
    
    [cacle handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        [recorder cancelRecorder];
        [UUProgressHUD dismissWithSuccess:@"取消"];

    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



/**  开始录音时的回调 */
- (void)startRecorder:(ICEMP3Recorder *)MP3Recorder{

    DLog(@"开始录音时的回调");
}
/**  取消录音时的回调 */
- (void)cancelReorder:(ICEMP3Recorder *)MP3Recorder{
    DLog(@"取消录音时的回调");

}
/**  录音失败时的回调 */
- (void)faliReorder:(ICEMP3Recorder *)MP3Recorder{

    DLog(@"录音失败时的回调");
}

/**  结束录音时的回调 */
- (void)MP3Recorder:(ICEMP3Recorder *)MP3Recorder
      voiceRecorded:(NSString *)recordPath
             length:(float)recordLength{

    

    DLog(@"结束录音时的回调  %@,\n%f",recordPath,recordLength);
}
/**  开始转换时的回调 */
- (void)startConvert:(ICEMP3Recorder *)MP3Recorder{

    DLog(@"开始转换时的回调 ");
}
/**  完成转换时的回调 */
- (void)finfshConvert:(ICEMP3Recorder *)MP3Recorder
        voiceRecorded:(NSString *)recordPath
               length:(float)recordLength{


    DLog(@"完成转换时的回调 %@",recordPath);
    
    if (_voicePlayer) {
        _voicePlayer = nil;
    };
    self.voicePlayer = [ICEAVAudioPlayer sharedInstance];
    [self.voicePlayer playSongWithUrl:recordPath];

    //
    

}




@end
