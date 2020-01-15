//
//  YLDChatFinishView.m
//  KYKJInternetDoctor
//
//  Created by Alexander on 2018/11/16.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "ChatFinishView.h"
#import "StarView.h"

@interface ChatFinishView ()

@property (nonatomic, strong) StarView *starView;
@property (nonatomic, strong) UIButton *watchButton;

@end

@implementation ChatFinishView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = WHITE_COLOR;
        [self setSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _watchButton.titleEdgeInsets = UIEdgeInsetsMake(0, -_watchButton.imageView.width, 0, _watchButton.imageView.width);
    _watchButton.imageEdgeInsets = UIEdgeInsetsMake(0, _watchButton.titleLabel.width, 0, -_watchButton.titleLabel.width);
}

- (void)setSubviews
{
    UILabel *title = [UILabel makeLabel:^(LabelMaker *make) {
        make.text(@"本次问诊已结束").textColor(TEXT_GRAY_COLOR_2).font(FONT(15)).addToSuperView(self);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).mas_offset(15);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = TEXT_GRAY_COLOR_2;
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(50);
        make.centerY.equalTo(title);
        make.right.equalTo(title.mas_left).mas_offset(-10);
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = TEXT_GRAY_COLOR_2;
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(50);
        make.centerY.equalTo(title);
        make.left.equalTo(title.mas_right).mas_offset(10);
    }];
    
    _starView = [StarView new];
    _starView.hidden = YES;
    [self addSubview:_starView];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(title.mas_bottom).mas_offset(20);
    }];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    _watchButton = [UIButton makeButton:^(ButtonMaker * _Nonnull make) {
        make.titleFont(FONT(13)).titleForState(@"查看评价", UIControlStateNormal).imageForState(IMAGE(@"zhankai_gray"), UIControlStateNormal).titleColorForState(TEXT_GRAY_COLOR_1, UIControlStateNormal).addAction(self, @selector(watchAction), UIControlEventTouchUpInside).addToSuperView(self);
    }];
#pragma clang diagnostic pop
    _watchButton.hidden = YES;
    [_watchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.starView);
        make.right.equalTo(self).mas_offset(-10);
    }];
}

- (void)setIsEvaluate:(BOOL)isEvaluate
{
    _isEvaluate = isEvaluate;
    
    if (_isEvaluate)
    {
        _starView.hidden = NO;
        _watchButton.hidden = NO;
    }
    else
    {
        _starView.hidden = YES;
        _watchButton.hidden = YES;
    }
}

@end
