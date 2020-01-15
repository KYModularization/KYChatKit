//
//  ChatCell.m
//  InternetHospital
//
//  Created by Alexander on 2018/10/17.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCellModel
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _messageStatus = Y_MessageStatus_Sending;
    }
    return self;
}

@end


@implementation ChatCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setBaseSubViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _senderView.layer.cornerRadius = _receiveView.layer.cornerRadius = 5.f;
    _senderHeader.layer.cornerRadius = _receiveHeader.layer.cornerRadius = 20.f;
}

- (void)setBaseSubViews
{
    _senderHeader = [UIImageView new];
    _senderHeader.clipsToBounds = YES;
    _senderHeader.hidden = YES;
    [self.contentView addSubview:_senderHeader];
    [_senderHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.right.equalTo(self.contentView).mas_offset(-15);
        make.top.equalTo(self.contentView);
    }];
    
    _receiveHeader = [UIImageView new];
    _receiveHeader.clipsToBounds = YES;
    _receiveHeader.hidden = YES;
    [self.contentView addSubview:_receiveHeader];
    [_receiveHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.top.equalTo(self.contentView);
    }];
    
    _senderView = [YLDPopMenuView new];
    _senderView.delegate = self;
    _senderView.clipsToBounds = YES;
    _senderView.hidden = YES;
    _senderView.backgroundColor = MAIN_COLOR;
    [self.contentView addSubview:_senderView];
    [_senderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.greaterThanOrEqualTo(self.receiveHeader.mas_right).mas_offset(10);
        make.right.equalTo(self.senderHeader.mas_left).mas_offset(-10);
        make.bottom.equalTo(self.contentView).mas_offset(-25);
    }];
    
    _receiveView = [YLDPopMenuView new];
    _receiveView.delegate = self;
    _receiveView.clipsToBounds = YES;
    _receiveView.hidden = YES;
    _receiveView.backgroundColor = WHITE_COLOR;
    [self.contentView addSubview:_receiveView];
    [_receiveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.receiveHeader.mas_right).mas_offset(10);
        make.right.lessThanOrEqualTo(self.senderHeader.mas_left).mas_offset(-10);
        make.bottom.equalTo(self.contentView).mas_offset(-25);
    }];

    _sendActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _sendActivityIndicator.backgroundColor = CLEAR_COLOR;
    _sendActivityIndicator.hidesWhenStopped = YES;
    [_sendActivityIndicator stopAnimating];
    [self.contentView addSubview:_sendActivityIndicator];
    
    _reSend = [UIButton makeButton:^(ButtonMaker * _Nonnull make) {
        make.imageForState(IMAGE(@"感叹号"), UIControlStateNormal).addAction(self, @selector(reSendAction), UIControlEventTouchUpInside);
    }];
    _reSend.hidden = YES;
    [self.contentView addSubview:_reSend];
}

- (void)reSendAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(reSendMessage:)])
    {
        [_delegate reSendMessage:self.model];
    }
}

- (void)menuSelected:(NSString *)menuTitle
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatMenuOperationWithTitle:message:)])
    {
        [_delegate chatMenuOperationWithTitle:menuTitle message:self.model];
    }
}

- (void)setModel:(ChatCellModel *)model
{
    _model = model;

    switch (_model.messageStatus)
    {
        case Y_MessageStatus_Sending:
        {
            [_sendActivityIndicator startAnimating];
            _reSend.hidden = YES;
        }
            break;
            
        case Y_MessageStatus_Success:
        {
            [_sendActivityIndicator stopAnimating];
            _reSend.hidden = YES;
        }
            break;
            
        case Y_MessageStatus_Failed:
        {
            [_sendActivityIndicator stopAnimating];
            _reSend.hidden = NO;
        }
            break;
    }
    
    if (_model.isSender)
    {
        _receiveView.hidden = _receiveHeader.hidden = YES;
        _senderView.hidden = _senderHeader.hidden = NO;
        [_senderHeader sd_setImageWithURL:[NSURL URLWithString:_model.header[@"sender"]] placeholderImage:IMAGE(@"doctor_default")];
    }
    else
    {
        _receiveView.hidden = _receiveHeader.hidden = NO;
        _senderView.hidden = _senderHeader.hidden = YES;
        [_receiveHeader sd_setImageWithURL:[NSURL URLWithString:_model.header[@"receiver"]] placeholderImage:IMAGE(@"patient_default")];
    }

}
    

@end

