//
//  MessageListener.m
//  InternetHospital
//
//  Created by Alexander on 2018/10/17.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "MessageListener.h"

@implementation MessageListener
- (void)onNewMessage:(NSArray*)msgs
{
    [[NSNotificationCenter defaultCenter] postNotificationName:Y_Notification_Message_Receive object:msgs];
}

@end
