//
//  MessageCell.m
//  InternetHospital
//
//  Created by Alexander on 2018/10/17.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "ChatBaseCell.h"

@implementation ChatBaseCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = CLEAR_COLOR;
        self.contentView.backgroundColor = CLEAR_COLOR;
    }
    return self;
}

@end
