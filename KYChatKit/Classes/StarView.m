//
//  StarView.m
//  KYKJInternetDoctor
//
//  Created by Alexander on 2018/11/12.
//  Copyright © 2018年 快医科技. All rights reserved.
//

#import "StarView.h"

@interface StarView ()

@property (nonatomic, strong) NSMutableArray *stars;

@end

@implementation StarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _stars = [NSMutableArray array];
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    UIImageView *temp;
    for (NSInteger i = 0; i < 5; i++)
    {
        UIImageView *img = [UIImageView new];
        img.image = [UIImage imageNamed:@"医生页全星"];
        [self addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(18);
            make.top.bottom.equalTo(self);
            if (i == 0)
            {
                make.left.equalTo(self);
            }
            else
            {
                if (i == 4)
                {
                    make.right.equalTo(self);
                }
                make.left.equalTo(temp.mas_right);
            }
        }];
        [_stars addObject:img];
        temp = img;
    }
}

- (void)setScore:(NSString *)score
{
    _score = score;
    
    NSInteger s = [self.score floatValue];
    [_stars enumerateObjectsUsingBlock:^(UIImageView * _Nonnull img, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < s)
        {
            img.image = IMAGE(@"医生页全星");
        }
        else
        {
            img.image = IMAGE(@"医生页空星");
        }
    }];
}

@end
