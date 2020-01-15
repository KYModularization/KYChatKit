//
//  ChatAudioCell.m
//  InternetHospital
//
//  Created by Alexander on 2018/10/17.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "ChatAudioCell.h"
#import "YLDAudioManager.h"

#define Duration 1.5f

@interface ChatAudioCell ()

@property (nonatomic, strong) UIImageView *senderAudio;
@property (nonatomic, strong) UIImageView *receiveAudio;
@property (nonatomic, strong) UIImageView *right;
@property (nonatomic, strong) UIImageView *left;
@property (nonatomic, strong) UIButton *senderBtn;
@property (nonatomic, strong) UIButton *receiveBtn;
@property (nonatomic, strong) UILabel *senderTimeLabel;
@property (nonatomic, strong) UILabel *receiveTimeLabel;
@property (nonatomic, strong) UIView *unRead;

@end

@implementation ChatAudioCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _senderBtn.layer.cornerRadius = _receiveBtn.layer.cornerRadius = 5.f;
    _unRead.layer.cornerRadius = 3.f;
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
    
    _senderBtn = [UIButton makeButton:^(ButtonMaker * _Nonnull make) {
        make.backgroundColor(MAIN_COLOR).addAction(self, @selector(playAudioAction:), UIControlEventTouchUpInside).addToSuperView(self.senderView);
    }];
    [_senderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.senderView);
        make.height.mas_equalTo(40).priorityHigh();
        make.width.mas_equalTo(0);
    }];
    
    _senderAudio = [UIImageView new];
    _senderAudio.image = IMAGE(@"发出的语音");
    _senderAudio.animationImages = @[IMAGE(@"白1"), IMAGE(@"白2"), IMAGE(@"发出的语音")];
    _senderAudio.animationDuration = Duration;
    [_senderAudio stopAnimating];
    [self.senderView addSubview:_senderAudio];
    [_senderAudio mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(18);
        make.centerY.equalTo(self.senderView);
        make.right.equalTo(self.senderView).mas_offset(-5);
    }];
    
    _senderTimeLabel = [UILabel makeLabel:^(LabelMaker *make) {
        make.textColor(WHITE_COLOR).font(FONT(14)).addToSuperView(self.senderView);
    }];
    [_senderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.senderView);
        make.right.equalTo(self.senderAudio.mas_left).mas_offset(-5);
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
    
    _left = [UIImageView new];
    _left.image = IMAGE(@"白角");
    _left.hidden = YES;
    [self.contentView addSubview:_left];
    [_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.height.mas_equalTo(10);
        make.left.equalTo(self.receiveHeader.mas_right).mas_offset(5);
    }];
    
    _receiveBtn = [UIButton makeButton:^(ButtonMaker * _Nonnull make) {
        make.backgroundColor(WHITE_COLOR).addAction(self, @selector(playAudioAction:), UIControlEventTouchUpInside).addToSuperView(self.receiveView);
    }];
    [_receiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.receiveView);
        make.height.mas_equalTo(40).priorityHigh();
        make.width.mas_equalTo(0);
    }];
    
    _receiveAudio = [UIImageView new];
    _receiveAudio.image = IMAGE(@"椭圆 3");
    _receiveAudio.animationImages = @[IMAGE(@"蓝1"), IMAGE(@"蓝2"), IMAGE(@"椭圆 3")];
    _receiveAudio.animationDuration = Duration;
    [_receiveAudio stopAnimating];
    [self.receiveView addSubview:_receiveAudio];
    [_receiveAudio mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(18);
        make.centerY.equalTo(self.receiveView);
        make.left.equalTo(self.receiveView).mas_offset(5);
    }];
    
    _receiveTimeLabel = [UILabel makeLabel:^(LabelMaker *make) {
        make.textColor(MAIN_COLOR).font(FONT(14)).addToSuperView(self.receiveView);
    }];
    _receiveTimeLabel.hidden = YES;
    [_receiveTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.receiveView);
        make.left.equalTo(self.receiveAudio.mas_right).mas_offset(5);
    }];
    
    _unRead = [UIView new];
    _unRead.backgroundColor = [UIColor redColor];
    _unRead.hidden = YES;
    [self.contentView addSubview:_unRead];
    [_unRead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(6);
        make.top.equalTo(self.receiveView);
        make.left.equalTo(self.receiveView.mas_right).mas_offset(10);
    }];
    
    self.senderView.titles = MenuTitleDelete;
    self.receiveView.titles = MenuTitleDelete;
}

- (void)playAudioAction:(UIButton *)button
{
    TIMSoundElem *elem = (TIMSoundElem *)[self.model.message getElem:0];
    NSString *fileName = [NSString stringWithFormat:@"%@.aac", elem.uuid];
    NSString *recordPath = [DOCUMENT_PATH stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    YLDAudioManager *audioManager = [YLDAudioManager shareManager];
    if ([fileManager fileExistsAtPath:recordPath])
    {
        [audioManager playAudio:recordPath start:^{
            if (button == self.senderBtn)
            {
                [self.senderAudio startAnimating];
            }
            else
            {
                [self.receiveAudio startAnimating];
            }
        } completed:^{
            if (button == self.senderBtn)
            {
                [self.senderAudio stopAnimating];
            }
            else
            {
                [self.receiveAudio stopAnimating];
            }
        }];
    }
    else
    {
        [elem getSound:recordPath succ:^{
            [self.model.message setCustomInt:1];
            self.unRead.hidden = YES;
            [audioManager playAudio:recordPath start:^{
                if (button == self.senderBtn)
                {
                    [self.senderAudio startAnimating];
                }
                else
                {
                    [self.receiveAudio startAnimating];
                }
            } completed:^{
                if (button == self.senderBtn)
                {
                    [self.senderAudio stopAnimating];
                }
                else
                {
                    [self.receiveAudio stopAnimating];
                }
            }];
        } fail:^(int code, NSString *msg) {
            
        }];
    }
}

- (void)setModel:(ChatCellModel *)model
{
    [super setModel:model];
    
    TIMSoundElem *elem = (TIMSoundElem *)[self.model.message getElem:0];
    if (self.model.isSender)
    {
        _left.hidden = _receiveTimeLabel.hidden = _unRead.hidden = YES;
        _right.hidden = _senderTimeLabel.hidden = NO;
        _receiveTimeLabel.text = @"";
        _senderTimeLabel.text = [NSString stringWithFormat:@"%d \"", elem.second > 60 ? 60 :elem.second];
        [_senderBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60 + elem.second * 2);
        }];
    }
    else
    {
        _left.hidden = _receiveTimeLabel.hidden = NO;
        _right.hidden = _senderTimeLabel.hidden = YES;
        _senderTimeLabel.text = @"";
        _receiveTimeLabel.text = [NSString stringWithFormat:@"%d \"", elem.second > 60 ? 60 :elem.second];
        _unRead.hidden = self.model.message.customInt;
        [_receiveBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60 + elem.second * 2);
        }];
    }

    if (self.model.messageStatus == Y_MessageStatus_Success)
    {
        _senderTimeLabel.hidden = NO;
    }
    else
    {
        _senderTimeLabel.hidden = YES;
    }
    [self.contentView layoutIfNeeded];
}

@end
