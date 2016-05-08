//
//  GMXMP3Recorder.m
//  GMXChatdemo
//
//  Created by WLY on 16/2/19.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ICEMP3Recorder.h"
#import <AVFoundation/AVFoundation.h>
#import "lame.h"


#define SOUND_METER_COUNT  6


@interface ICEMP3Recorder ()<AVAudioRecorderDelegate,AVAudioSessionDelegate>{
    int soundMeters[SOUND_METER_COUNT];
}

@property (nonatomic, assign) id<MP3RecorderDelegate> delegate;
@property(readwrite, nonatomic, assign) CGFloat recordTime;
@property(readwrite, nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioSession *session;
@property(readwrite, nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isRecorder;//是否正在录音

@property (nonatomic, copy) AudioPowerChangeBlock powerBlock;

@end

@implementation ICEMP3Recorder

#pragma mark - 
- (instancetype)initWithDelegate:(id<MP3RecorderDelegate>)delegate{

    self = [super init];
    if (self) {
        self.recordTime = 0;
        self.isRecorder = NO;
        _delegate = delegate;
    }
    return self;
}



#pragma mark - 初始化 录音控件
/**
 *  初始化录音控件
 */
- (void)setRecorder
{
    self.recordTime = 0;
    _recorder = nil;
    NSError *recorderSetupError = nil;
    NSURL *url = [NSURL URLWithString:[self cafPath]];   //路径
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:url
                                            settings:[self getAudioSetting]
                                               error:&recorderSetupError];
    
    if (recorderSetupError) {
        NSLog(@"%@",recorderSetupError);
    }
    _recorder.meteringEnabled = YES;
    _recorder.delegate = self;
    [_recorder prepareToRecord];
    
    [self.recorder recordForDuration:MAX_RECORD_DURATION];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:WAVE_UPDATE_FREQUENCY target:self selector:@selector(changeTimer:) userInfo:nil repeats:YES];

}

/**
 *  获取录音文件设置
 */
- (NSDictionary *)getAudioSetting{
    
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [settings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [settings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [settings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //音频质量,采样质量
    [settings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    

    return settings;
    
}


- (void)setSesstion
{
    _session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [_session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(_session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [_session setActive:YES error:nil];
}



#pragma mark - 录音控制
//开始录音
- (void)startRecorder{
  
    [self setSesstion];
  
    [self setRecorder];
    
    [_recorder record];
    self.isRecorder = YES;
}

//取消录音
- (void)cancelRecorder{
    
    if (self.isRecorder) {
        self.isRecorder = NO;
        [_recorder stop];
        [_recorder deleteRecording];
        [self.timer invalidate];
        
    }
    
}

//结束录音
- (void)endRecorder{
   
    if (self.isRecorder) {
        [_recorder stop];
        
        if (self.recordTime > 1) {
            [self convert_PCMToMP3];
            
            if ([self.delegate respondsToSelector:@selector(MP3Recorder:voiceRecorded:length:)]) {
                [self.delegate MP3Recorder:self voiceRecorded:[self cafPath] length:self.recordTime];
            }
        }else {
            
            [_recorder deleteRecording];
            if ([_delegate respondsToSelector:@selector(faliReorder:)]) {
                [self.delegate faliReorder:self];
            }
        }
        [self.timer invalidate];
        self.isRecorder = NO;
    }
}

- (void)AudioPowerChange:(AudioPowerChangeBlock)change{

    _powerBlock = change;
}

#pragma mark - 音频格式转换

#pragma mark - 文件地址 管理
- (NSString *)cafPath
{
    NSString *cafPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.caf"];
    return cafPath;
}

- (NSString *)mp3Path
{
    NSString *mp3Path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"mp3.mp3"];
    return mp3Path;
}

- (void)deleteFileWithPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager removeItemAtPath:path error:nil])
    {
//        NSLog(@"删除以前的mp3文件");
    }
}

- (void)deleteMp3Cache
{
    [self deleteFileWithPath:[self mp3Path]];
}

- (void)deleteCafCache
{
    [self deleteFileWithPath:[self cafPath]];
}

#pragma mark - 开始转换
/**
 *  war 格式转换为 MP3
 */
- (void)convert_PCMToMP3{

    NSString *cafFilePath = [self cafPath];
    NSString *mp3FilePath = [self mp3Path];
    // remove the old mp3 file
    [self deleteMp3Cache];
    
    if (_delegate && [_delegate respondsToSelector:@selector(startConvert:)]) {
        [_delegate startConvert:self];
    }
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    }
    
    [self deleteCafCache];

    if (_delegate && [_delegate respondsToSelector:@selector(finfshConvert:voiceRecorded:length:)]) {
        [_delegate finfshConvert:self voiceRecorded:[self mp3Path] length:self.recordTime];
    }
}




#pragma mark - 动画视图

/**
 *  更新音波视图 音量
 */
- (void)changeTimer:(NSTimer *)timer{
    [self.recorder updateMeters];
    if (self.recordTime > MAX_RECORD_DURATION) {
        [self endRecorder];
        
        return;
    }
    
    self.recordTime += WAVE_UPDATE_FREQUENCY;
    DLog(@"%f",self.recordTime);
    if (self.powerBlock) {
        self.powerBlock([self.recorder averagePowerForChannel:0],self.recordTime);
    }
}



#pragma mark - Drawing operations
- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
    self.recorder.delegate = nil;
}
@end
