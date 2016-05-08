//
//  UUAVAudioPlayer.h
//  BloodSugarForDoc
//
//  Created by shake on 14-9-1.
//  Copyright (c) 2014年 shake. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>


@protocol ICEAVAudioPlayerDelegate <NSObject>

- (void)ICEAVAudioPlayerBeiginLoadVoice;
- (void)ICEAVAudioPlayerBeiginPlay;
- (void)ICEAVAudioPlayerDidFinishPlay;

@end

@interface ICEAVAudioPlayer : NSObject
@property (nonatomic ,strong)  AVAudioPlayer *player;
@property (nonatomic, assign)id <ICEAVAudioPlayerDelegate>delegate;
+ (ICEAVAudioPlayer *)sharedInstance;

-(void)playSongWithUrl:(NSString *)songUrl;
-(void)playSongWithData:(NSData *)songData;

- (void)stopSound;
@end
