//
//  ChatToolView.m
//  InternetHospital
//
//  Created by Alexander on 2018/10/17.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "ChatInputView.h"

@interface ChatInputView () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;     //文本输入框
@property (nonatomic, strong) UIButton *audio;          //语音输入按钮
@property (nonatomic, strong) YLDButton *sender;

@end

@implementation ChatInputView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _status = MoreViewStatusClose;
        [self setSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _textView.layer.cornerRadius = 4;
    _textView.layer.borderWidth = .5f;
    _textView.layer.borderColor = LINE_COLOR.CGColor;
    
    _audio.layer.cornerRadius = 4;
    _audio.layer.borderWidth = .5f;
    _audio.layer.borderColor = LINE_COLOR.CGColor;
}

- (void)setSubviews
{
    self.backgroundColor = WHITE_COLOR;
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = LINE_COLOR;
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    _sender = [YLDButton makeButton:^(ButtonMaker * _Nonnull make) {
        make.titleForState(@"发送", UIControlStateNormal).titleFont(FONT(16)).titleColorForState(TEXT_GRAY_COLOR_2, UIControlStateDisabled).titleColorForState(MAIN_COLOR, UIControlStateNormal).addAction(self, @selector(senderAction), UIControlEventTouchUpInside).addToSuperView(self);
    }];
    _sender.enabled = NO;
    [_sender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(5);
        make.right.equalTo(self).mas_offset(-20);
        make.height.mas_equalTo(34);
    }];
    
    _textView = [UITextView new];
    _textView.backgroundColor = GRAY_BACKGROUND_COLOR;
    _textView.font = FONT(15);
    _textView.textColor = LIGHT_BLACK_COLOR;
    _textView.enablesReturnKeyAutomatically = YES;
    _textView.returnKeyType = UIReturnKeySend;
    _textView.delegate = self;
    [self addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(5);
        make.left.equalTo(self).mas_offset(15);
        make.right.equalTo(self.sender.mas_left).mas_offset(-20);
        make.height.mas_equalTo(34);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange) name:UITextViewTextDidChangeNotification object:_textView];
    
    _audio = [UIButton makeButton:^(ButtonMaker * _Nonnull make) {
        make.backgroundImageForState([UIImage imageWithColor:UIColorWithHex(0xEFF0F4)], UIControlStateNormal).backgroundImageForState([UIImage imageWithColor:UIColorWithHex(0xE5E7EE)], UIControlStateHighlighted).titleForState(@"按住说话", UIControlStateNormal).titleForState(@"松开结束", UIControlStateHighlighted).titleColorForState(TEXT_GRAY_COLOR_2, UIControlStateNormal).titleFont(FONT(16)).addToSuperView(self);
        make.addAction(self, @selector(touchDownAction), UIControlEventTouchDown).
        addAction(self, @selector(dragEnterAction), UIControlEventTouchDragEnter).
        addAction(self, @selector(dragExitAction), UIControlEventTouchDragExit).
        addAction(self, @selector(touchUpOutsideAction), UIControlEventTouchUpOutside).
        addAction(self, @selector(touchUpInsideAction), UIControlEventTouchUpInside);
    }];
    _audio.clipsToBounds = YES;
    _audio.adjustsImageWhenHighlighted = YES;
    _audio.hidden = YES;
    [self addSubview:_audio];
    [_audio mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(5);
        make.left.equalTo(self).mas_offset(15);
        make.right.equalTo(self).mas_offset(-15);
        make.height.mas_equalTo(34);
    }];
    
    UIButton *changeInput = [UIButton makeButton:^(ButtonMaker * _Nonnull make) {
        make.imageForState(IMAGE(@"voice"), UIControlStateNormal).imageForState(IMAGE(@"keybord"), UIControlStateSelected).addAction(self, @selector(changeInputWayAction:), UIControlEventTouchUpInside).addToSuperView(self);
    }];
    [changeInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.bottom.equalTo(self).mas_offset(-8);
        make.left.equalTo(self).mas_offset(20);
        make.top.equalTo(self.textView.mas_bottom).mas_offset(15);
    }];
    
    UIButton *video = [UIButton makeButton:^(ButtonMaker * _Nonnull make) {
        make.imageForState(IMAGE(@"video"), UIControlStateNormal).addAction(self, @selector(videoCallAction), UIControlEventTouchUpInside).addToSuperView(self);
    }];
    [video mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.bottom.equalTo(self).mas_offset(-8);
        make.left.equalTo(changeInput.mas_right).mas_offset(45);
    }];
    
    UIButton *photo = [UIButton makeButton:^(ButtonMaker * _Nonnull make) {
        make.imageForState(IMAGE(@"photo"), UIControlStateNormal).addAction(self, @selector(libraryAction), UIControlEventTouchUpInside).addToSuperView(self);
    }];
    [photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.bottom.equalTo(self).mas_offset(-8);
        make.left.equalTo(video.mas_right).mas_offset(45);
    }];
    
    UIButton *camera = [UIButton makeButton:^(ButtonMaker * _Nonnull make) {
        make.imageForState(IMAGE(@"camera"), UIControlStateNormal).addAction(self, @selector(cameraAction), UIControlEventTouchUpInside).addToSuperView(self);
    }];
    [camera mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.bottom.equalTo(self).mas_offset(-8);
        make.left.equalTo(photo.mas_right).mas_offset(45);
    }];
    
    if ([[[UserModel shareModel].roles firstObject] isEqualToString:@"doctor"])
    {
        UIButton *more = [UIButton makeButton:^(ButtonMaker * _Nonnull make) {
            make.imageForState(IMAGE(@"more"), UIControlStateNormal).addAction(self, @selector(moreAction), UIControlEventTouchUpInside).addToSuperView(self);
        }];
        [more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(24);
            make.bottom.equalTo(self).mas_offset(-8);
            make.right.equalTo(self).mas_offset(-20);
        }];
    }
#pragma clang diagnostic pop
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = LINE_COLOR;
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
}

-(void)textViewDidChange
{
    static CGFloat maxHeight = 130.0f;
    CGRect frame = _textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [_textView sizeThatFits:constraintSize];
    if (size.height >= maxHeight)
    {
        size.height = maxHeight;
        _textView.scrollEnabled = YES;
    }
    else
    {
        _textView.scrollEnabled = NO;
    }
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height);
    }];
    [self layoutIfNeeded];
    
    _sender.enabled = [_textView.text length];
}

- (void)changeInputWayAction:(UIButton *)button
{
    button.selected = !button.isSelected;
    
    if (button.selected)
    {
        [_textView resignFirstResponder];
        if (_delegate && [_delegate respondsToSelector:@selector(setMoreViewStatus:)])
        {
            if (_status == MoreViewStatusOpen)
            {
                _status = MoreViewStatusClose;
            }
            [_delegate setMoreViewStatus:_status];
        }
        _textView.hidden = YES;
        _audio.hidden = NO;
    }
    else
    {
        [_textView becomeFirstResponder];
        _textView.hidden = NO;
        _audio.hidden = YES;
    }
}

- (void)moreAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(setMoreViewStatus:)])
    {
        if (_status == MoreViewStatusClose)
        {
            _status = MoreViewStatusOpen;
        }
        else
        {
            _status = MoreViewStatusClose;
        }
        [_delegate setMoreViewStatus:_status];
    }
}

- (void)videoCallAction     //视频通话
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewOperation:)])
    {
        [_delegate moreViewOperation:FunctionOperationVideoCall];
    }
}

- (void)libraryAction       //相册
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewOperation:)])
    {
        [_delegate moreViewOperation:FunctionOperationLibrary];
    }
}

- (void)cameraAction       //相机
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewOperation:)])
    {
        [_delegate moreViewOperation:FunctionOperationCamera];
    }
}

- (void)senderAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(sendMessage:)])
    {
        TIMTextElem *elem = [TIMTextElem new];
        [elem setText:_textView.text];
        TIMMessage *message = [TIMMessage new];
        [message addElem:elem];
        [_delegate sendMessage:message];
        _textView.text = @"";
        _sender.enabled = NO;
        [_textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(34);
        }];
        [self layoutIfNeeded];
    }
}

#pragma mark - AudioPressAction
- (void)touchDownAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(startRecord:)])
    {
        NSInteger t = [[NSDate date] timeIntervalSince1970];
        NSString *fileName = [NSString stringWithFormat:@"%ld.aac", (long)t];
        NSString *recordPath = [DOCUMENT_PATH stringByAppendingPathComponent:fileName];
        [_delegate startRecord:recordPath];
    }
}

- (void)dragExitAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(pressDragExit)])
    {
        [_delegate pressDragExit];
    }
}

- (void)dragEnterAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(pressDragEnter)])
    {
        [_delegate pressDragEnter];
    }
}

- (void)touchUpOutsideAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(cancelRecord)])
    {
        [_delegate cancelRecord];
    }
}

- (void)touchUpInsideAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(finishRecord)])
    {
        [_delegate finishRecord];
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [self senderAction];
        return NO;
    }
    return YES;
}

@end
