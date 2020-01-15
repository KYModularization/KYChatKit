//
//  UserStatusListener.m
//  InternetHospital
//
//  Created by Alexander on 2018/10/17.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "UserStatusListener.h"
#import "JPUSHService.h"

@implementation UserStatusListener
- (void)onForceOffline
{
    if (IS_LOGIN)
    {
        [JPUSHService deleteAlias:nil seq:0];
        [JPUSHService setAlias:@"" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            NSLog(@"iAlias:%@",iAlias);
        } seq:0];

        [YLDAlertView showOfflineAlert];
    }
}

- (void)onReConnFailed:(int)code err:(NSString*)err
{
#ifdef DEBUG
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%d--%@", code, err]];
#endif
}

- (void)onUserSigExpired
{
#ifdef DEBUG
    [SVProgressHUD showInfoWithStatus:@"腾讯云票据过期"];
#endif
}

@end
