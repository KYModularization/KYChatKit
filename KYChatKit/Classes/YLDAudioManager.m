//
//  AudioRecorderManager.m
//  InternetHospital
//
//  Created by Alexander on 2018/10/19.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "YLDAudioManager.h"
#import "MBProgressHUD.h"

#define MAX_TIME 60
#define MIN_TIME 1.f

@interface YLDAudioManager () <AVAudioPlayerDelegate>

@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) UIImageView *recordMicro;
@property (nonatomic, strong) UIImageView *recordCancle;
@property (nonatomic, strong) UILabel *textLable;

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSOperationQueue *audioDataOperationQueue;

@property (nonatomic, strong) NSTimer *levelTimer;
@property (nonatomic, strong) NSTimer *maxTimer;
@property (nonatomic, assign) NSInteger recordTime;

@property (nonatomic, copy) NSString *currentRecordPath;
@property (nonatomic, copy) NSString *currentPlayPath;

@property (nonatomic, copy) void(^PlayCompleted)(void);

@end

static YLDAudioManager *_manager;

@implementation YLDAudioManager
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil)
        {
            _manager = [super allocWithZone:zone];
        }
    });
    return _manager;
}

+ (instancetype)shareManager
{
    return [self new];
}

- (NSDictionary *)recordingSettings
{
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    [setting setObject:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [setting setObject:[NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
    [setting setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    [setting setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [setting setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [setting setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    return setting;
}

- (void)startRecord:(NSString *)recordPath
{
    [self initHUBViewWithView];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    _currentRecordPath = recordPath;
    NSURL *recordedFile = [NSURL fileURLWithPath:recordPath];
    NSDictionary *dic = [self recordingSettings];
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:recordedFile settings:dic error:nil];
    if(_audioRecorder == nil)
    {
        [self soundRecordFailed];
        return;
    }
    [_audioRecorder prepareToRecord];
    _audioRecorder.meteringEnabled = YES;
    [_audioRecorder record];
    [_audioRecorder recordForDuration:0];
    
    _levelTimer = [NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector: @selector(recordVolumeAction) userInfo:nil repeats:YES];
    
    _maxTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(recordTimeAction) userInfo:nil repeats:YES];
}

- (void)stopRecord
{
    if (_levelTimer)
    {
        [_levelTimer invalidate];
        _levelTimer = nil;
    }
    
    if (_maxTimer)
    {
        _recordTime = 0;
        [_maxTimer invalidate];
        _maxTimer = nil;
    }
    
    [self performSelector:@selector(removeHUD) withObject:nil afterDelay:0.8f];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    
    if (_audioRecorder)
    {
        if (_audioRecorder.currentTime < MIN_TIME)
        {
            [SVProgressHUD dismissWithDelay:2];
            [SVProgressHUD showInfoWithStatus:@"语音时间不能少于1秒"];
            [self cancelRecord];
        }
        else
        {
            int time = round(_audioRecorder.currentTime);
            [_audioRecorder stop];
            _audioRecorder = nil;
            if (_delegate && [_delegate respondsToSelector:@selector(finishRecord:time:)])
            {
                [_delegate finishRecord:_currentRecordPath time:time];
            }
        }
    }
    _currentRecordPath = nil;
}

- (void)cancelRecord
{
    if (_levelTimer)
    {
        [_levelTimer invalidate];
        _levelTimer = nil;
    }
    
    if (_maxTimer)
    {
        _recordTime = 0;
        [_maxTimer invalidate];
        _maxTimer = nil;
    }
    [_audioRecorder stop];
    [_audioRecorder deleteRecording];
    _currentRecordPath = nil;
    [self performSelector:@selector(removeHUD) withObject:nil afterDelay:0.8f];
}

- (void)playAudio:(NSString *)audioPath start:(void(^)(void))start completed:(void(^)(void))completed
{
    _PlayCompleted = completed;
    if (_audioPlayer && _audioPlayer.playing)
    {
        [_audioPlayer stop];
        if ([_currentPlayPath isEqualToString:audioPath])
        {
            if (_PlayCompleted)
            {
                _PlayCompleted();
            }
            return;
        }
    }
    _currentPlayPath = audioPath;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
    NSData *audioData = [NSData dataWithContentsOfFile:audioPath];
    _audioPlayer = [[AVAudioPlayer alloc] initWithData:audioData error:nil];
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateChanged:) name:UIDeviceProximityStateDidChangeNotification object:nil];
    _audioPlayer.volume = 1.0f;
    _audioPlayer.delegate = self;
    [_audioPlayer prepareToPlay];
    if (start)
    {
        start();
    }
    [_audioPlayer play];
}

- (void)dragEnter
{
    _recordMicro.hidden = NO;
    _recordCancle.hidden = YES;
    [_audioRecorder record];
    [_levelTimer setFireDate:[NSDate distantPast]];
    [_maxTimer setFireDate:[NSDate distantPast]];
    _textLable.text = @"手指上滑，暂停录音";
}

- (void)dragExit
{
    _recordMicro.hidden = YES;
    _recordCancle.hidden = NO;
    [_audioRecorder pause];
    [_levelTimer setFireDate:[NSDate distantFuture]];
    [_maxTimer setFireDate:[NSDate distantFuture]];
    _textLable.text = @"松开手指，取消发送";
}

- (void)proximityStateChanged:(NSNotification *)notification
{
    if ([[UIDevice currentDevice] proximityState] == YES)
    {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    else
    {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}

- (void)soundRecordFailed
{
    [_audioRecorder stop];
    [self removeHUD];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:nil];
}

- (void)recordVolumeAction
{
    if (_audioRecorder && _recordMicro)
    {
        [_audioRecorder updateMeters];
        double ff = [_audioRecorder averagePowerForChannel:0];
        ff = ff + 60;
        if (ff > 0 && ff <= 20)
        {
            [_recordMicro setImage:IMAGE(@"record1")];
        }
        else if (ff > 20 && ff <= 40)
        {
            [_recordMicro setImage:IMAGE(@"record2")];
        }
        else if (ff > 40 &&ff <= 50)
        {
            [_recordMicro setImage:IMAGE(@"record3")];
        }
        else if (ff > 50 &&ff <= 60)
        {
            [_recordMicro setImage:IMAGE(@"record4")];
        }
        else
        {
            [_recordMicro setImage:IMAGE(@"record5")];
        }
    }
}

- (void)recordTimeAction
{
    if (_recordTime >= MAX_TIME)
    {
        [SVProgressHUD showInfoWithStatus:@"语音时间不能多于60秒"];
        [self stopRecord];
    }
    else
    {
        _recordTime++;
    }
}

- (void)initHUBViewWithView
{
    [self removeHUD];
    
    UIView *view = [[[UIApplication sharedApplication] windows] lastObject];
    if(!_HUD)
    {
        _HUD = [[MBProgressHUD alloc] initWithView:view];
        _HUD.opacity = 0.4;
        
        UIView *cv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
        
        _recordMicro = [[UIImageView alloc] initWithFrame:CGRectMake(40, 25, 50, 50)];
        [cv addSubview:_recordMicro];
        
        _recordCancle = [[UIImageView alloc] initWithFrame:CGRectMake(40, 25, 50, 50)];
        _recordCancle.image = IMAGE(@"cancel");
        [cv addSubview:_recordCancle];
        _recordCancle.hidden = YES;

        _textLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 130, 20)];
        _textLable.backgroundColor = [UIColor clearColor];
        _textLable.textColor = [UIColor whiteColor];
        _textLable.textAlignment = NSTextAlignmentCenter;
        _textLable.font = [UIFont systemFontOfSize:14.0];
        _textLable.text = @"手指上滑，暂停录音";
        [cv addSubview:_textLable];
        
        _HUD.customView = cv;
        _HUD.mode = MBProgressHUDModeCustomView;
    }
    if ([view isKindOfClass:[UIWindow class]])
    {
        [view addSubview:_HUD];
    }
    else
    {
        [view.window addSubview:_HUD];
    }
    [_HUD show:YES];
}

- (void)removeHUD
{
    if (_HUD)
    {
        [_HUD removeFromSuperview];
        _HUD = nil;
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .2f * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.audioPlayer.playing ? [self.audioPlayer stop] : nil;
        self.audioPlayer.delegate = nil;
        self.audioPlayer = nil;
        if (self.PlayCompleted)
        {
            self.PlayCompleted();
        }
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    });
}

@end
