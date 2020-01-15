//
//  ChatMoreView.m
//  InternetHospital
//
//  Created by Alexander on 2018/10/18.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "ChatMoreView.h"

@interface ChatMoreView ()

@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation ChatMoreView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _buttons = [NSMutableArray array];
        self.backgroundColor = WHITE_COLOR;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        button.titleEdgeInsets = UIEdgeInsetsMake(button.frame.size.height/2+5, (button.frame.size.width-button.titleLabel.intrinsicContentSize.width)/2-button.imageView.frame.size.width, -25, (button.frame.size.width-button.titleLabel.intrinsicContentSize.width)/2);
        
        button.imageEdgeInsets = UIEdgeInsetsMake(0, (button.frame.size.width-button.imageView.frame.size.width)/2, button.titleLabel.intrinsicContentSize.height, (button.frame.size.width-button.imageView.frame.size.width)/2);
    }];
}

- (void)selectedItem:(UIButton *)button
{
    NSInteger index = [_buttons indexOfObject:button];
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewOperation:)])
    {
        
        [_delegate moreViewOperation:index];
    }
}

- (void)setItems:(NSMutableArray *)items
{
    _items = items;
    CGFloat width = SCREEN_WIDTH/4;
    __block UIButton *temp = nil;
    [_items enumerateObjectsUsingBlock:^(NSString * _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton makeButton:^(ButtonMaker * _Nonnull make) {
            make.imageForState(IMAGE(str), UIControlStateNormal).titleForState(str, UIControlStateNormal).titleColorForState(LIGHT_BLACK_COLOR, UIControlStateNormal).titleFont(FONT(14)).addAction(self, @selector(selectedItem:), UIControlEventTouchUpInside).addToSuperView(self);
            
        }];
        NSInteger row = 0;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(110);
            make.width.mas_equalTo(width);
            if (temp == nil)
            {
                make.top.equalTo(self);
                make.left.equalTo(self);
            }
            else
            {
                if (idx/4 > row) {
                    make.top.equalTo(temp.mas_bottom);
                    make.left.equalTo(self);
                }else{
                    make.top.equalTo(self);
                    make.left.equalTo(temp.mas_right);
                }
                
            }
            
        }];
        row = idx/4;
        temp = button;
        [self.buttons addObject:button];
    }];
}

@end
