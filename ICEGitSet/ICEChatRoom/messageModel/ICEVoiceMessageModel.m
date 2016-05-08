//
//  ICEVoiceMessageModel.m
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEVoiceMessageModel.h"

@implementation ICEVoiceMessageModel

- (NSData *)voiceData{

    if (!_voiceData) {
        _voiceData = [NSData data];
    }
    return _voiceData;
}



@end
