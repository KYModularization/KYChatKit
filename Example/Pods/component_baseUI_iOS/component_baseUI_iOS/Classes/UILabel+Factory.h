//
//  UILabel+Factory.h
//  ChainedMode
//
//  Created by 杨大爷 on 2018/8/26.
//  Copyright © 2018年 杨大爷. All rights reserved.
//  Label

#import <UIKit/UIKit.h>

@interface LabelMaker : NSObject

- (LabelMaker *(^)(CGRect))frame;
- (LabelMaker *(^)(UIFont *))font;
- (LabelMaker *(^)(UIColor *))textColor;
- (LabelMaker *(^)(UIColor *))backgroundColor;
- (LabelMaker *(^)(NSTextAlignment))textAlignment;
- (LabelMaker *(^)(NSInteger))numberOfLines;
- (LabelMaker *(^)(NSString *text))text;
- (LabelMaker *(^)(NSAttributedString *attributedText))attributedText;
- (LabelMaker *(^)(BOOL))userInteraction;
- (LabelMaker *(^)(BOOL))enable;
- (LabelMaker *(^)(BOOL))adjustsFontSizeToFitWidth;
- (LabelMaker *(^)(CGFloat))minimumScale;
- (LabelMaker *(^)(UIView *))addToSuperView;

@end

@interface UILabel (Factory)

+ (instancetype)makeLabel:(void(^)(LabelMaker *make))labelMaker;

@end
