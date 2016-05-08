//
//  ICEVoiceMessageCell.m
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEVoiceMessageCell.h"
#import "ICEVoiceMessageModel.h"
#import <AVFoundation/AVFoundation.h>


@interface ICEVoiceMessageCell ()<AVAudioPlayerDelegate>
@property (nonatomic, strong) UIImageView *voiceBackView;//消息气泡
@property (nonatomic, strong) UIImageView *voice;//消息图片
@property (nonatomic, strong) UILabel *lengthLabel;//语音时长
@property (nonatomic, strong) ICEVoiceMessageModel *voiceMessage;//语音消息实体
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation ICEVoiceMessageCell


- (void)initialize{

    self.voiceBackView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.voiceBackView.userInteractionEnabled = YES;
    [self.messageContentView addSubview:self.voiceBackView];
    
    self.voice = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.voice.userInteractionEnabled = YES;
    [self.voiceBackView addSubview:self.voice];
    
    self.lengthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.lengthLabel.userInteractionEnabled = YES;
    self.lengthLabel.font = CELL_Voice_Label_Font;
    [self.voiceBackView addSubview:self.lengthLabel];
    
    self.voice.animationDuration = 1;
    self.voice.animationRepeatCount = 0;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.voiceBackView addGestureRecognizer:tap];
    
    
    //红外线感应监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sensorStateChange:)
                                                 name:UIDeviceProximityStateDidChangeNotification
                                               object:nil];

}


-(void)setLayout{

    CGFloat width = [self p_getVoiceBackviewWidth];
    CGSize lengthLabelSize = CGSizeMake(40, 20);
    NSString *lengthStr = [NSString stringWithFormat:@"%.fs",self.voiceMessage.voiceLengte];
    self.lengthLabel.text = lengthStr;
    
    switch (self.messageFrom) {
        case MessageFromSelf: {
            self.voiceBackView.image = [UIImage imageNamed:@"chatto_bg_normal"];
            self.voice.animationImages = @[
                                           [UIImage imageNamed:@"chat_animation_white3"],
                                            [UIImage imageNamed:@"chat_animation_white2"],
                                            [UIImage imageNamed:@"chat_animation_white1"]];
            self.voice.image = [UIImage imageNamed:@"chat_animation_white3"];
            [self.voiceBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.width.mas_equalTo(width);

            }];
            
            [self.voice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.voiceBackView.mas_right).with.offset(-10);
                make.centerY.mas_equalTo(self.voiceBackView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(CELL_Voice_Width,CELL_Voice_Width));
            }];
            
            
            [self.lengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.voiceBackView.mas_left).with.offset(10);
                make.centerY.mas_equalTo(self.voiceBackView.mas_centerY);
                make.size.mas_equalTo(lengthLabelSize);
            }];
            self.lengthLabel.textAlignment = NSTextAlignmentLeft;
            
            break;
        }
        case MessageFromOther: {
            self.voiceBackView.image = [UIImage imageNamed:@"chatfrom_bg_normal"];
            self.voice.animationImages = @[
                                           [UIImage imageNamed:@"chat_animation3"],
                                           [UIImage imageNamed:@"chat_animation2"],
                                           [UIImage imageNamed:@"chat_animation1"]];
            self.voice.image = [UIImage imageNamed:@"chat_animation3"];
            [self.voiceBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.width.mas_equalTo(width);
                
            }];
            
            [self.voice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.voiceBackView.mas_left).with.offset(10);
                make.centerY.mas_equalTo(self.voiceBackView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(CELL_Voice_Width,CELL_Voice_Width));
            }];
            
            
            [self.lengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.voiceBackView.mas_right).with.offset(- 10);
                make.centerY.mas_equalTo(self.voiceBackView.mas_centerY);
                make.size.mas_equalTo(lengthLabelSize);
            }];
            

            self.lengthLabel.textAlignment = NSTextAlignmentRight;
            
            break;
        }
    }
}


- (CGFloat)p_getVoiceBackviewWidth{


    CGFloat width = (CELL_VoiceBackView_Width_MAX - CELL_VoiceBackView_Width_MIN) / 60 * self.voiceMessage.voiceLengte ;
    
    width = width > CELL_VoiceBackView_Width_MIN ? width : CELL_VoiceBackView_Width_MIN;
    return width;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{

    if (self.player) {
        self.player.delegate = nil;
        self.player = nil;
        
    }
    self.player = [[AVAudioPlayer alloc] initWithData:self.voiceMessage.voiceData error:nil];
    self.player.delegate = self;
    [self.player play];
    
    [self.voice startAnimating];
    //打开红外线
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    

}

#pragma mark - playerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{

    //关闭红外线感应
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    
    [self.voice stopAnimating];

}

//处理监听触发事件
-(void)sensorStateChange:(NSNotificationCenter *)notification;
{
    if ([[UIDevice currentDevice] proximityState] == YES){
        NSLog(@"Device is close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    else{
        NSLog(@"Device is not close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}

- (void)setValueWithModel:(ICEMessageModel *)message{

    self.voiceMessage = message.voiceMessage;

    [super setValueWithModel:message];
    [self initialize];
    [self setLayout];
    
}

- (void)dealloc{

    self.player = nil;
}

@end
