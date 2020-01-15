//
//  ChatTopView.m
//  KYKJInternetDoctor
//
//  Created by Alexander on 2018/11/6.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "ChatTopView.h"

@interface ChatTopView ()

@property (nonatomic, strong) UIImageView *header;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation ChatTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _header.layer.cornerRadius = 12.5f;
}

- (void)setSubviews
{
    self.backgroundColor = WHITE_COLOR;
    
    _header = [UIImageView new];
    _header.clipsToBounds = YES;
    [self addSubview:_header];
    [_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(25.f);
        make.left.equalTo(self).mas_offset(15);
    }];
    
    _infoLabel = [YLDLabel makeLabel:^(LabelMaker *make) {
        make.font(FONT(15)).textColor(LIGHT_BLACK_COLOR).addToSuperView(self);
    }];
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.header.mas_right).mas_offset(10);
    }];
    
    UIImageView *arrow = [UIImageView new];
    arrow.image = IMAGE(@"zhankai_gray");
    [self addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(24);
        make.right.equalTo(self).mas_offset(-10);
    }];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
#pragma clang diagnostic pop
    [self addGestureRecognizer:tap];
}

- (void)setInfo:(NSDictionary *)info
{
    _info = info;
    [_header sd_setImageWithURL:[NSURL URLWithString:_info[@"patientAvatar"]]placeholderImage:IMAGE(info[@"patientDefault"])];
    _infoLabel.text = [NSString stringWithFormat:@"%@  %@  %@岁", _info[@"patientName"], [_info[@"genderType"] isEqualToString:@"MAN"] ? @"男" : @"女", _info[@"patientAge"]];
}

@end
