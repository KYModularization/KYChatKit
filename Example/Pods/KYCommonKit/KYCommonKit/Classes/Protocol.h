//
//  Protocol.h
//  InternetHospital
//
//  Created by Alexander on 2018/10/18.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#ifndef Protocol_h
#define Protocol_h

typedef NS_ENUM(NSInteger, MoreViewStatus) {
    MoreViewStatusOpen,
    MoreViewStatusClose
};

typedef NS_ENUM(NSInteger, FunctionOperation) {
    FunctionOperationVideoCall = -3,         //视频通话
    FunctionOperationLibrary = -2,           //相册
    FunctionOperationCamera = -1,            //拍照
    FunctionOperationDiagnosis = 0,          //诊断
    FunctionOperationInspect = 1,            //检验检查
    FunctionOperationRegist = 2,             //门诊挂号
    FunctionOperationRemind = 3,             //复诊提醒
    FunctionOperationPriscription = 4,       //续方
};

@class ChatCellModel;

@protocol ChatProtocol <NSObject>

- (void)reSendMessage:(ChatCellModel *)data;                        //重发消息
- (void)sendMessage:(TIMMessage *)message;                          //发送消息
- (void)setMoreViewStatus:(MoreViewStatus)status;                   //更多视图状态操作
- (void)moreViewOperation:(FunctionOperation)operation;             //更多视图按钮操作
- (void)watchPicture:(ChatCellModel *)data;                              //查看大图
- (void)chatMenuOperationWithTitle:(NSString *)menuTitle message:(ChatCellModel *)data;//弹出菜单操作
- (void)customMessageOperation:(id)object;                          //自定义消息体点击事件

@end

@protocol RecordPressProtocol <NSObject>

- (void)startRecord:(NSString *)path;
- (void)cancelRecord;
- (void)finishRecord;
- (void)pressDragEnter;
- (void)pressDragExit;

@end

@protocol GroupVisitableProtocol <NSObject> //分组协议

- (void)group:(NSInteger)section isVisitable:(BOOL)isOpen;

- (void)groupSelected:(NSInteger)section selceted: (BOOL)selceted;

@end

#endif /* Protocol_h */
