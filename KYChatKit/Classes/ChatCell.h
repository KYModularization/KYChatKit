//
//  ChatCell.h
//  InternetHospital
//
//  Created by Alexander on 2018/10/17.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "ChatBaseCell.h"
#import "YLDPopMenuView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, Y_MessageStatus) {
    Y_MessageStatus_Sending,
    Y_MessageStatus_Success,
    Y_MessageStatus_Failed
};

@interface ChatCellModel : NSObject

@property (nonatomic, assign) Y_MessageStatus messageStatus;
@property (nonatomic, copy) NSDictionary *header;
@property (nonatomic, assign) BOOL isSender;
@property (nonatomic, strong) TIMMessage *message;

@end


@interface ChatCell : ChatBaseCell <PopMenuProtocol>

@property (nonatomic, strong) ChatCellModel *model;
@property (nonatomic, strong) UIImageView *senderHeader;
@property (nonatomic, strong) UIImageView *receiveHeader;
@property (nonatomic, strong) YLDPopMenuView *senderView;
@property (nonatomic, strong) YLDPopMenuView *receiveView;
@property (nonatomic, strong) UIActivityIndicatorView *sendActivityIndicator;
@property (nonatomic, strong) UIButton *reSend;
@property (nonatomic, weak) id <ChatProtocol> delegate;


@end

NS_ASSUME_NONNULL_END
