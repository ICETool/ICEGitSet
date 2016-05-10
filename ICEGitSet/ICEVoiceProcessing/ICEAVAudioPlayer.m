//
//  UUAVAudioPlayer.m
//  BloodSugarForDoc
//
//  Created by shake on 14-9-1.
//  Copyright (c) 2014年 shake. All rights reserved.
//

#import "ICEAVAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

static BOOL usable_begain = NO;
static BOOL usable_paly = NO;
static BOOL usable_finish = NO;
@interface ICEAVAudioPlayer ()<AVAudioPlayerDelegate>

@end

@implementation ICEAVAudioPlayer

+ (ICEAVAudioPlayer *)sharedInstance
{
    static ICEAVAudioPlayer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}



- (void)usabelDelegate{

    usable_begain = [self.delegate respondsToSelector:@selector(ICEAVAudioPlayerBeiginLoadVoice)];
    usable_paly = [self.delegate respondsToSelector:@selector(ICEAVAudioPlayerBeiginPlay)];
    usable_finish = [self.delegate respondsToSelector:@selector(ICEAVAudioPlayerDidFinishPlay)];
}

-(void)playSongWithUrl:(NSString *)songUrl
{
 
    [self usabelDelegate];
        dispatch_async(dispatch_queue_create("playSoundFromUrl", NULL), ^{
        
        if (usable_paly) {
            [self.delegate ICEAVAudioPlayerBeiginLoadVoice];
        }
            if (_player) {
                [_player stop];
                _player.delegate = nil;
                _player = nil;
            }
            NSError *playerError;
            
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:songUrl] error:&playerError];
            
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.player play];
        });
    });
}

-(void)playSongWithData:(NSData *)songData
{
    [self usabelDelegate];
    [self setupPlaySound];
    [self playSoundWithData:songData];
}

-(void)playSoundWithData:(NSData *)soundData{
    if (_player) {
        [_player stop];
        _player.delegate = nil;
        _player = nil;
    }
    NSError *playerError;
    
    _player = [[AVAudioPlayer alloc]initWithData:soundData error:&playerError];
    _player.volume = 1.0f;
    if (_player == nil){
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    _player.delegate = self;
    [_player play];

    if (usable_begain) {
        [self.delegate ICEAVAudioPlayerBeiginPlay];
    }
}

-(void)setupPlaySound{
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (usable_paly) {
        [self.delegate ICEAVAudioPlayerDidFinishPlay];
    }
}

- (void)stopSound
{
    if (_player && _player.isPlaying) {
        [_player stop];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application{

    if (usable_finish) {
        [self.delegate ICEAVAudioPlayerDidFinishPlay];
    }
}

@end