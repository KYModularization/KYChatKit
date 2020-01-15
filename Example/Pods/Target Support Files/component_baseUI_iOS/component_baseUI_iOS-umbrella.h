#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "Factory.h"
#import "UIButton+Factory.h"
#import "UILabel+Factory.h"
#import "UITableView+Factory.h"
#import "UITextField+Factory.h"

FOUNDATION_EXPORT double component_baseUI_iOSVersionNumber;
FOUNDATION_EXPORT const unsigned char component_baseUI_iOSVersionString[];

