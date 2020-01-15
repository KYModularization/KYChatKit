//
//  LYJPopMenu.h
//  KYKJInternetDoctor
//
//  Created by KuaiYi on 2019/9/29.
//  Copyright © 2019 快医科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LYJPopMenuDoneBlock)(NSInteger selectedIndex);
/**
 *  FTPopOverMenuDismissBlock
 */
typedef void (^LYJPopMenuDismissBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface LYJPopMenuView : UIControl

@end

@interface LYJPopMenu : NSObject

+ (void) showForSender:(UIView *)sender
         withMenuArray:(NSArray *)menuArray
             doneBlock:(LYJPopMenuDoneBlock)doneBlock
          dismissBlock:(LYJPopMenuDismissBlock)dismissBlock;

/**
 *  dismiss method
 */
+ (void) dismiss;

@end

NS_ASSUME_NONNULL_END
