//
//  ICEVoiceMessageModel.h
//  ICEGitSet
//
//  Created by WLY on 16/5/6.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICEVoiceMessageModel : NSObject
/**
 *  语音url
 */
@property (nonatomic, strong) NSData  *voiceData;

@property (nonatomic, copy)   NSString *voiceURL;

@property (nonatomic, assign) CGFloat voiceLengte;

@end
