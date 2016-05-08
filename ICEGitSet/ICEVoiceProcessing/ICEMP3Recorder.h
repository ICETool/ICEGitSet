//
//  GMXMP3Recorder.h
//  GMXChatdemo
//
//  Created by WLY on 16/2/19.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MAX_RECORD_DURATION 60.0   //最大录音时间
#define WAVE_UPDATE_FREQUENCY   0.1  //回调时间间隔
#define SILENCE_VOLUME   45.0  //静音音量



/**
 *  音调回调
 *
 *  @param power 0~ -160
 */
typedef void (^AudioPowerChangeBlock) (CGFloat power,CGFloat time);


@class ICEMP3Recorder;
@protocol MP3RecorderDelegate <NSObject>

@optional


/**  录音失败时的回调 */
- (void)faliReorder:(ICEMP3Recorder *)MP3Recorder;

/**  结束录音时的回调 */
- (void)MP3Recorder:(ICEMP3Recorder *)MP3Recorder
      voiceRecorded:(NSString *)recordPath
             length:(float)recordLength;
/**  开始转换时的回调 */
- (void)startConvert:(ICEMP3Recorder *)MP3Recorder;
/**  完成转换时的回调 */
- (void)finfshConvert:(ICEMP3Recorder *)MP3Recorder
        voiceRecorded:(NSString *)recordPath
               length:(float)recordLength;



@end

@interface ICEMP3Recorder : NSObject


- (instancetype)initWithDelegate:(id<MP3RecorderDelegate>)delegate;

- (void)removeArcView;
/**  开始录音时*/
- (void)startRecorder;
/**  结束录音时 */
- (void)endRecorder;
/**  取消录音时 */
- (void)cancelRecorder;

/**
 *  录音音调回调
 *
 *  @param change  -160 ~ 0
 */
- (void)AudioPowerChange:(AudioPowerChangeBlock)change;



@end
