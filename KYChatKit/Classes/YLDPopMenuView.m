//
//  YLDMenuLabel.m
//  InternetHospital
//
//  Created by Alexander on 2018/10/22.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "YLDPopMenuView.h"
#import "LYJPopMenu.h"


@implementation YLDPopMenuView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPressGestureRecognizer];
}

- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        [self becomeFirstResponder];
//        UIMenuController *menu = [UIMenuController sharedMenuController];
//        NSMutableArray *arr = [NSMutableArray array];
//        if (_titles & MenuTitleCopy)
//        {
//            UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyAction)];
//            [arr addObject:copy];
//        }
//        if (_titles & MenuTitleDelete)
//        {
//            UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteAction)];
//            [arr addObject:delete];
//        }
//
//        [menu setTargetRect:self.frame inView:self.superview];
//        [menu setMenuItems:[arr copy]];
//        [menu setMenuVisible:YES animated:YES];
        if (_titles & MenuTitleEdit) {
            @weakify(self)
            if ([self.IsAgreeNewEMRVersionNum isEqualToNumber:@(1)]) {
                [LYJPopMenu showForSender:self withMenuArray:@[@"存为主诉",@"存为现病史",@"存为诊断",@"存为处理意见",@"复制",@"删除"] doneBlock:^(NSInteger selectedIndex) {
                    @strongify(self)
                    [self menuAction:selectedIndex];
                } dismissBlock:^{
                    
                }];
            }else{
                [LYJPopMenu showForSender:self withMenuArray:@[@"存为主诉",@"存为诊断",@"存为处理意见",@"复制",@"删除"] doneBlock:^(NSInteger selectedIndex) {
                    @strongify(self)
                    [self menuAction:selectedIndex];
                } dismissBlock:^{
                    
                }];
            }
            
        }else{
            UIMenuController *menu = [UIMenuController sharedMenuController];
            NSMutableArray *arr = [NSMutableArray array];
            if (_titles & MenuTitleCopy)
            {
                UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyAction)];
                [arr addObject:copy];
            }
            if (_titles & MenuTitleDelete)
            {
                UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteAction)];
                [arr addObject:delete];
            }
            
            [menu setTargetRect:self.frame inView:self.superview];
            [menu setMenuItems:[arr copy]];
            [menu setMenuVisible:YES animated:YES];
        }

    }
}
- (void)menuAction:(NSInteger)selectedIndex
{
    if ([self.IsAgreeNewEMRVersionNum isEqualToNumber:@(1)]){
        switch (selectedIndex) {
            case 0:
                if (_delegate && [_delegate respondsToSelector:@selector(menuSelected:)])
                {
                    [_delegate menuSelected:@"存为主诉"];
                }
                break;
            
            case 1:
                 if (_delegate && [_delegate respondsToSelector:@selector(menuSelected:)])
                 {
                     [_delegate menuSelected:@"存为现病史"];
                 }
            break;
                
            case 2:
                if (_delegate && [_delegate respondsToSelector:@selector(menuSelected:)])
                {
                    [_delegate menuSelected:@"存为诊断"];
                }
                break;
            case 3:
                if (_delegate && [_delegate respondsToSelector:@selector(menuSelected:)])
                {
                    [_delegate menuSelected:@"存为处理意见"];
                }
                break;
            case 4:
                [self copyAction];
                break;
            case 5:
                
                [self deleteAction];
                
                break;
                
            default:
                break;
        }
    }else{
        switch (selectedIndex) {
            case 0:
                if (_delegate && [_delegate respondsToSelector:@selector(menuSelected:)])
                {
                    [_delegate menuSelected:@"存为主诉"];
                }
                break;
            case 1:
                if (_delegate && [_delegate respondsToSelector:@selector(menuSelected:)])
                {
                    [_delegate menuSelected:@"存为诊断"];
                }
                break;
            case 2:
                if (_delegate && [_delegate respondsToSelector:@selector(menuSelected:)])
                {
                    [_delegate menuSelected:@"存为处理意见"];
                }
                break;
            case 3:
                [self copyAction];
                break;
            case 4:
                
                [self deleteAction];
                
                break;
                
            default:
                break;
        }
    }
    
}

- (void)copyAction
{
    [UIPasteboard generalPasteboard].string = _stringForCopy;
}

- (void)deleteAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(menuSelected:)])
    {
        [_delegate menuSelected:@"删除"];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
