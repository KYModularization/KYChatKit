//
//  ChatToolView.h
//  InternetHospital
//
//  Created by Alexander on 2018/10/17.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatInputView : UIView

@property (nonatomic, weak) id <ChatProtocol, RecordPressProtocol> delegate;
@property (nonatomic, assign) MoreViewStatus status;

@end

NS_ASSUME_NONNULL_END
