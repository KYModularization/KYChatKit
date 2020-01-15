//
//  ChatTimeStampCell.m
//  KYKJInternetDoctor
//
//  Created by Alexander on 2019/3/11.
//  Copyright © 2019年 快医科技. All rights reserved.
//

#import "ChatTimeStampCell.h"

@interface ChatTimeStampCell ()

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ChatTimeStampCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    UIView *bgView = [UIView new];
    bgView.backgroundColor = UIColorWithHex(0xE5E7EE);
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).mas_offset(10);
        make.bottom.equalTo(self.contentView).mas_offset(-10);
        make.height.mas_equalTo(25);
    }];
    
    _timeLabel = [UILabel makeLabel:^(LabelMaker *make) {
        make.font(FONT(14)).textColor(TEXT_GRAY_COLOR_2).textAlignment(NSTextAlignmentCenter).addToSuperView(bgView);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).mas_offset(10);
        make.right.equalTo(bgView).mas_offset(-10);
        make.centerY.equalTo(bgView);
    }];
    [self.contentView layoutIfNeeded];
    bgView.layer.cornerRadius = 4.f;
}

#pragma mark - setter
- (void)setTips:(NSString *)tips
{
    _tips = tips;
    
    _timeLabel.text = _tips;
}

@end
