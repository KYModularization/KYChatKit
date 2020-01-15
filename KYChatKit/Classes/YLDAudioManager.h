//
//  AudioRecorderManager.h
//  InternetHospital
//
//  Created by Alexander on 2018/10/19.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RecordProtocol <NSObject>

- (void)finishRecord:(NSString *)path time:(int)second;

@end

@interface YLDAudioManager : NSObject

@property (nonatomic, weak) id <RecordProtocol> delegate;

+ (instancetype)shareManager;

- (void)startRecord:(NSString *)recordPath;
- (void)cancelRecord;
- (void)stopRecord;
- (void)playAudio:(NSString *)audioPath start:(void(^)(void))start completed:(void(^)(void))completed;
- (void)dragEnter;
- (void)dragExit;

@end

NS_ASSUME_NONNULL_END
