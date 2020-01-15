//
//  YLDMenuLabel.h
//  InternetHospital
//
//  Created by Alexander on 2018/10/22.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuTitle) {
    MenuTitleCopy = 1 << 0,
    MenuTitleDelete = 1 << 1,
    MenuTitleRevoke = 1 << 2,
    MenuTitleEdit = 1 << 3

};

@protocol PopMenuProtocol <NSObject>

- (void)menuSelected:(NSString *)menuTitle;

@end

NS_ASSUME_NONNULL_BEGIN

@interface YLDPopMenuView : UIView

@property (nonatomic, weak) id <PopMenuProtocol> delegate;
@property (nonatomic, assign) MenuTitle titles;
@property (nonatomic, copy) NSString *stringForCopy;   //如果视图上存在label且需要copy功能，赋值label.text的同时需要给该属性赋值，以便提供copy功能
@property (nonatomic, strong) NSNumber *IsAgreeNewEMRVersionNum;

@end

NS_ASSUME_NONNULL_END
