//
//  ChatTextCell.m
//  InternetHospital
//
//  Created by Alexander on 2018/10/17.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "ChatTextCell.h"

@interface ChatTextCell ()

@property (nonatomic, strong) UILabel *senderLabel;
@property (nonatomic, strong) UILabel *receiveLabel;
@property (nonatomic, strong) UIImageView *right;
@property (nonatomic, strong) UIImageView *left;

@end

@implementation ChatTextCell
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
    _right = [UIImageView new];
    _right.image = IMAGE(@"绿角");
    _right.hidden = YES;
    [self.contentView addSubview:_right];
    [_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.height.mas_equalTo(10);
        make.right.equalTo(self.senderHeader.mas_left).mas_offset(-5);
    }];
    
    _left = [UIImageView new];
    _left.image = IMAGE(@"白角");
    _left.hidden = YES;
    [self.contentView addSubview:_left];
    [_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.height.mas_equalTo(10);
        make.left.equalTo(self.receiveHeader.mas_right).mas_offset(5);
    }];
    
    [self.contentView sendSubviewToBack:_right];
    [self.contentView sendSubviewToBack:_left];
    
    _senderLabel = [UILabel new];
    _senderLabel.backgroundColor = CLEAR_COLOR;
    _senderLabel.textAlignment = NSTextAlignmentLeft;
    _senderLabel.textColor = WHITE_COLOR;
    _senderLabel.font = FONT(15);
    _senderLabel.numberOfLines = 0;
    _senderLabel.hidden = YES;
    [self.senderView addSubview:_senderLabel];
    [_senderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.senderView).insets(UIEdgeInsetsMake(15, 10, 15, 10));
    }];

    [self.sendActivityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(self.senderView);
        make.right.equalTo(self.senderView.mas_left).mas_offset(-15);
    }];
    
    [self.reSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.centerY.equalTo(self.senderView);
        make.right.equalTo(self.senderView.mas_left).mas_offset(-15);
    }];
    
    _receiveLabel = [UILabel new];
    _receiveLabel.backgroundColor = CLEAR_COLOR;
    _receiveLabel.textAlignment = NSTextAlignmentLeft;
    _receiveLabel.textColor = LIGHT_BLACK_COLOR;
    _receiveLabel.font = FONT(15);
    _receiveLabel.numberOfLines = 0;
    _receiveLabel.hidden = YES;
    [self.receiveView addSubview:_receiveLabel];
    [_receiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.receiveView).insets(UIEdgeInsetsMake(15, 10, 15, 10));
    }];
    
//    self.senderView.titles = MenuTitleCopy | MenuTitleDelete;
//    self.receiveView.titles = MenuTitleCopy | MenuTitleDelete;
    

}

#pragma mark - setter
- (void)setModel:(ChatCellModel *)model
{
    [super setModel:model];
    
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:IsAgreeNewEMRVersion] isEqualToString:@"1"]) {
//        self.senderView.titles = MenuTitleEdit;
//        self.receiveView.titles = MenuTitleEdit;
//    }else{
//        self.senderView.titles = MenuTitleCopy | MenuTitleDelete;
//        self.receiveView.titles = MenuTitleCopy | MenuTitleDelete;
//    }
    
    self.senderView.titles = MenuTitleEdit;
    self.receiveView.titles = MenuTitleEdit;
    
    TIMTextElem *elem = (TIMTextElem *)[self.model.message getElem:0];
    if (self.model.isSender)
    {
        _receiveLabel.hidden = _left.hidden = YES;
        _senderLabel.hidden = _right.hidden = NO;
        _receiveLabel.text = @"";
        _senderLabel.text = self.senderView.stringForCopy = elem.text;
    }
    else
    {
        _receiveLabel.hidden = _left.hidden = NO;
        _senderLabel.hidden = _right.hidden = YES;
        _receiveLabel.text = self.receiveView.stringForCopy = elem.text;
        _senderLabel.text = @"";
    }
}

@end
