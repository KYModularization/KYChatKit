//
//  ChatImageCell.m
//  InternetHospital
//
//  Created by Alexander on 2018/10/17.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "ChatImageCell.h"

@interface ChatImageCell ()

@property (nonatomic, strong) UIImageView *senderImage;
@property (nonatomic, strong) UIImageView *receiveImage;
@property (nonatomic, strong) UILabel *progressLabel;

@end

@implementation ChatImageCell
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
    
    _senderImage.layer.cornerRadius = 4;
    _receiveImage.layer.cornerRadius = 4;
}

- (void)setSubviews
{
    _senderImage = [UIImageView new];
    _senderImage.backgroundColor = WHITE_COLOR;
    _senderImage.hidden = YES;
    _senderImage.clipsToBounds = YES;
    _senderImage.userInteractionEnabled = YES;
    [self.senderView addSubview:_senderImage];

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_senderImage addGestureRecognizer:tap1];
    
    [self.sendActivityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(self.senderImage);
        make.right.equalTo(self.senderImage.mas_left).mas_offset(-15);
    }];
    
    [self.reSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.centerY.equalTo(self.senderImage);
        make.right.equalTo(self.senderImage.mas_left).mas_offset(-15);
    }];
    
    _receiveImage = [UIImageView new];
    _receiveImage.backgroundColor = WHITE_COLOR;
    _receiveImage.hidden = YES;
    _receiveImage.userInteractionEnabled = YES;
    _receiveImage.clipsToBounds = YES;
    [self.receiveView addSubview:_receiveImage];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_receiveImage addGestureRecognizer:tap2];
    
    self.senderView.backgroundColor = self.receiveView.backgroundColor = CLEAR_COLOR;
    self.senderView.titles = MenuTitleDelete;
    self.receiveView.titles = MenuTitleDelete;
}

- (void)tapAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(watchPicture:)])
    {
        [self.delegate watchPicture:self.model];
    }
}

- (void)setModel:(ChatCellModel *)model
{
    [super setModel:model];
    
    TIMImageElem *elem = (TIMImageElem *)[self.model.message getElem:0];
    TIMImage *image = nil;
    for (TIMImage *img in elem.imageList)
    {
        if (img.type == TIM_IMAGE_TYPE_THUMB)
        {
            image = img;
            break;
        }
    }
    
    if (self.model.isSender)
    {
        _senderImage.hidden = NO;
        _receiveImage.hidden = YES;
        [_receiveImage mas_remakeConstraints:^(MASConstraintMaker *make) {}];
        if (image == nil)
        {
            UIImage *img = [UIImage imageWithContentsOfFile:elem.path];
            if (img.size.width <= 140)
            {
                [_senderImage mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.senderView).priorityHigh();
                    make.width.mas_equalTo(img.size.width);
                    make.height.mas_equalTo(img.size.height);
                }];
            }
            else
            {
                CGFloat f = 140.f / img.size.width;
                [_senderImage mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.senderView).priorityHigh();
                    make.width.mas_equalTo(140);
                    make.height.mas_equalTo(img.size.height * f);
                }];
            }
            _senderImage.image = img;
        }
        else
        {
            if (image.width <= 140)
            {
                [_senderImage mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.senderView).priorityHigh();
                    make.width.mas_equalTo(image.width);
                    make.height.mas_equalTo(image.height);
                }];
            }
            else
            {
                CGFloat f = 140.f / image.width;
                [_senderImage mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(140);
                    make.height.mas_equalTo(image.height * f);
                    make.edges.equalTo(self.senderView).priorityHigh();
                }];
            }
            [_senderImage sd_setImageWithURL:[NSURL URLWithString:image.url] placeholderImage:[UIImage imageWithContentsOfFile:elem.path]];
        }
    }
    else
    {
        _senderImage.hidden = YES;
        _receiveImage.hidden = NO;
        [_senderImage mas_remakeConstraints:^(MASConstraintMaker *make) {}];
        if (image.width == 0 || image.height == 0)
        {
            [self.receiveImage mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.receiveView).priorityHigh();
                make.width.height.mas_equalTo(140);
            }];
        }
        else
        {
            if (image.width <= 140)
            {
                [self.receiveImage mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.receiveView).priorityHigh();
                    make.width.mas_equalTo(image.width);
                    make.height.mas_equalTo(image.height);
                }];
            }
            else
            {
                CGFloat f = 140.f / image.width;
                [self.receiveImage mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.receiveView).priorityHigh();
                    make.width.mas_equalTo(140);
                    make.height.mas_equalTo(image.height * f);
                }];
            }
        }
        [_receiveImage sd_setImageWithURL:[NSURL URLWithString:image.url]];
    }
    [self.contentView layoutIfNeeded];
}

@end
