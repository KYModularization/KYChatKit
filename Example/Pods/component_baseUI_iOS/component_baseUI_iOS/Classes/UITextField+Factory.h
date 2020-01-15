//
//  UITextField+Factory.h
//  ChainedMode
//
//  Created by 杨大爷 on 2018/8/26.
//  Copyright © 2018年 杨大爷. All rights reserved.
//  TextField

#import <UIKit/UIKit.h>

@interface TextFieldMaker : NSObject

- (TextFieldMaker *(^)(CGRect))frame;
- (TextFieldMaker *(^)(NSString *))text;
- (TextFieldMaker *(^)(NSAttributedString *))attributedText;
- (TextFieldMaker *(^)(UIFont *))font;
- (TextFieldMaker *(^)(UIColor *))textColor;
- (TextFieldMaker *(^)(NSTextAlignment))textAlignment;
- (TextFieldMaker *(^)(UITextBorderStyle))borderStyle;
- (TextFieldMaker *(^)(NSString *))placeholder;
- (TextFieldMaker *(^)(NSAttributedString *))attributedPlaceholder;
- (TextFieldMaker *(^)(BOOL))SizeToFit;
- (TextFieldMaker *(^)(id <UITextFieldDelegate>))delegate;
- (TextFieldMaker *(^)(UIImage *))backgroundImage;
- (TextFieldMaker *(^)(UIColor *))backgroundColor;
- (TextFieldMaker *(^)(UITextFieldViewMode))clearMode;
- (TextFieldMaker *(^)(UIView *))leftView;
- (TextFieldMaker *(^)(UITextFieldViewMode))leftViewMode;
- (TextFieldMaker *(^)(UIView *))rightView;
- (TextFieldMaker *(^)(UITextFieldViewMode))rightViewMode;
- (TextFieldMaker *(^)(UIKeyboardType))keyboardType;
- (TextFieldMaker *(^)(UIReturnKeyType))returnKeyType;
- (TextFieldMaker *(^)(BOOL))enablesReturnKeyAutomatically;
- (TextFieldMaker *(^)(BOOL))secureTextEntry;
- (TextFieldMaker *(^)(UIView *))addToSuperView;

@end

@interface UITextField (Factory)

+ (instancetype)makeTextField:(void(^)(TextFieldMaker *make))textFieldMaker;

@end
