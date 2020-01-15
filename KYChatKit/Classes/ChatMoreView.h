//
//  ChatMoreView.h
//  InternetHospital
//
//  Created by Alexander on 2018/10/18.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatMoreView : UIView

@property (nonatomic, weak) id <ChatProtocol> delegate;
@property (nonatomic, strong) NSMutableArray *items;

@end

NS_ASSUME_NONNULL_END
