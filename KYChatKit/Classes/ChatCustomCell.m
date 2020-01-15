//
//  ChatPreCell.m
//  InternetHospital
//
//  Created by Alexander on 2018/10/31.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "ChatCustomCell.h"


@interface ChatCustomCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation ChatCustomCell
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
//    UIImageView *right = [UIImageView new];
//    right.image = IMAGE(@"白角_右");
//    [self.contentView addSubview:right];
//    [right mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView);
//        make.width.height.mas_equalTo(10);
//        make.right.equalTo(self.senderHeader.mas_left).mas_offset(-5);
//    }];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = WHITE_COLOR;
    [self.senderView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.senderView);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [bgView addGestureRecognizer:tap];
    
    _titleLabel = [UILabel makeLabel:^(LabelMaker *make) {
        make.textColor(UIColorWithHex(0xFE9B00)).font(BOLD_FONT(15)).text(@"点击进行预问诊").addToSuperView(bgView);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(bgView).mas_offset(10);
    }];
    
    UIImageView *open = [UIImageView new];
    open.image = IMAGE(@"orange_arrow");
    [bgView addSubview:open];
    [open mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.top.equalTo(bgView).mas_offset(5);
        make.right.equalTo(bgView).mas_offset(-5);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = LINE_COLOR;
    [bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(.5f);
        make.left.equalTo(bgView).mas_offset(10);
        make.right.equalTo(bgView).mas_offset(-10);
        make.top.equalTo(open.mas_bottom).mas_offset(10);
    }];
    
    _detailLabel = [UILabel makeLabel:^(LabelMaker *make) {
        make.textColor(TEXT_GRAY_COLOR_2).font(FONT(13)).numberOfLines(0).addToSuperView(bgView);
    }];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).mas_offset(10);
        make.right.bottom.equalTo(bgView).mas_offset(-10);
        make.left.equalTo(bgView).mas_offset(10);
    }];
}

- (void)tapAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customMessageOperation:)])
    {
        TIMCustomElem *elem = (TIMCustomElem *)[self.model.message getElem:0];
        NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:elem.data options:NSJSONReadingMutableLeaves error:nil];
        [self.delegate customMessageOperation:dictionary];
    }
}

#pragma mark - setter
- (void)setModel:(ChatCellModel *)model
{
    [super setModel:model];

    TIMCustomElem *elem = (TIMCustomElem *)[self.model.message getElem:0];
    NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:elem.data options:NSJSONReadingMutableLeaves error:nil];
    self.titleLabel.text = dictionary[@"title"];
    self.detailLabel.text = dictionary[@"sendMessage"];
}

@end
