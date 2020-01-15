//
//  CommonMacro.h
//  BskyDoctorProject
//
//  Created by 王玉宝 on 2017/4/1.
//  Copyright © 2017年 zhangyi. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

//打印定义
#ifdef DEBUG

    //-- 区分设备和模拟器,
    //解决Product -> Scheme -> Run -> Arguments -> OS_ACTIVITY_MODE为disable时，真机下 Xcode Debugger 不打印的bug ---
    #if TARGET_OS_IPHONE
    /*iPhone Device*/
    #define KYLog(format, ...) printf("%s:Dev: %s [Line %d]\n%s\n\n", [DATE_STRING UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
    #else
    /*iPhone Simulator*/
    #define KYLog(format, ...) NSLog((@":Sim: %s [Line %d]\n%@\n\n"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:format, ##__VA_ARGS__])
    #endif

//# define KYLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
    # define KYLog(...);
#endif

///------ 应用程序版本号version ------
#define kAppVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

///------ iOS系统版本号 ------
#define iOS_Version ([[[UIDevice currentDevice] systemVersion] floatValue])

///------ <强烈推荐❤️>优酷大神ibireme的 Weak-Strong Dance
///省掉多处编写__weak __typeof(self) weakSelf = self; __strong __typeof(weakSelf) strongSelf = weakSelf;代码的麻烦 ------
/**
 使用说明
 Synthsize a weak or strong reference.
 
 Example:
     @weakify(self)
     [self doSomething^{
         @strongify(self)
         if (!self) return;
         ...
     }];
 
 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

///------ 区分ARC和非ARC ------
#if  __has_feature(objc_arc)
//ARC
#else
//非ARC
#endif


///------ 区分设备和模拟器 ------
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

///------ other ------
#define kAppDelegate ([[UIApplication sharedApplication] delegate])
#define kAppWindow (kAppDelegate.window)
#define kAppRootViewController (kAppWindow.rootViewController)


#define UserDefaults ([NSUserDefaults standardUserDefaults])
#define NotificationCenter ([NSNotificationCenter defaultCenter])

///------ 获取当前语言 ------
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

///当前日期字符串
#define DATE_STRING \
({NSDateFormatter *fmt = [[NSDateFormatter alloc] init];\
[fmt setDateFormat:@"YYYY-MM-dd hh:mm:ss"];\
[fmt stringFromDate:[NSDate date]];})

///iPhone 手机没装 iTunes Store 时也可以跳转到 AppStore，id 为你的 App 在iTunes Store上生成的链接里面的对应id, itunes connect 上的 App 信息里面也可以找到该 id
//评论页
#define kAppReviewOnAppStore @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id="
//详情页
#define kAppDetailOnAppStore @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id="

/// TODO: Relpace this with its application identifier
// 这是 APP 在 Appstore 上的唯一标识
#define kOnItunesConnectAppID   @"你的 App 在itunesConnect 上的 id"

///------ 沙盒路径 ------
#define PATH_OF_HOME        NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

///------ 尺寸 ------
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenRect   [UIScreen mainScreen].bounds
#define kNavigationBarHeight 47.
#define kStatusBarHeight     20.

///------ Ratio(Point)基于iPhone6 ------
#define kRatioX6 ([UIScreen mainScreen].bounds.size.width / 375.)
#define kRatioY6 ([UIScreen mainScreen].bounds.size.height / 667.)
#define kCountRY6(a) (a)*([UIScreen mainScreen].bounds.size.height / 667.)

///------ Ratio(Point)基于iPhone5s ------
#define kRatioX5 ([UIScreen mainScreen].bounds.size.width / 320)
#define kRatioY5 ([UIScreen mainScreen].bounds.size.height / 568)

///------ iOS Device Type ------
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

///------ RGB颜色 ------
#define RGBA(r, g, b, a) ([UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:a])
#define RandomColor ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1])

///------ 有效性验证<字符串、数组、字典等> ------
#define VALID_STRING(str)      ((str) && ([(str) isKindOfClass:[NSString class]]) && ([(str) length] > 0))
#define VALID_ARRAY(arr)       ((arr) && ([(arr) isKindOfClass:[NSArray class]]) && ([(arr) count] > 0))
#define VALID_DICTIONARY(dict) ((dict) && ([(dict) isKindOfClass:[NSDictionary class]]) && ([(dict) count] > 0))
#define VALID_NUMBER(number)   ((number) && ([(number) isKindOfClass:NSNumber.class]))

/** 登录状态变更的通知 */
#define KNOTIFICATION_LOGINCHANGE @"LOGIN_STATE_CHANGE"
#define kSHORT_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/**主题色*/
#define THEME_COLOR [UIColor colorWithRed:0.20 green:0.81 blue:0.69 alpha:1.00]

/**NSUserDefault**/
#define UserDefault_Diagnosis_Save @"UserDefault_Diagnosis_Save" //保存诊断草稿

#define UserDefault_Check_Save @"UserDefault_Check_Save"  //保存检验检查草稿

#define File_CheckOrDiagnosis_Save @"File_CheckOrDiagnosis_Save"  //保存草稿文件名

#define IsAgreeNewEMRVersion @"IsAgreeNewEMRVersion" //诊断使用新版还是旧版的


//加载图片
#define IMAGE(name) [UIImage imageNamed:name]
//DocumentPath
#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//key_window
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow
//HEXColor
#define UIColorWithHex(s) [UIColor colorWithRed:((s & 0xFF0000) >> 16)/255.f green:((s & 0xFF00) >> 8)/255.f blue:(s & 0xFF)/255.f alpha:1.f]
//RGBA
#define UIColorWithRGBA(r,g,b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]
//主色
#define MAIN_COLOR UIColorWithHex(0x1DBDD4)
//主色不可点
#define DISABLED_COLOR UIColorWithHex(0x8EDEE9)
//主色高亮
#define HIGHLIGHTED_COLOR UIColorWithHex(0x1BAFC4)
//白色
#define WHITE_COLOR [UIColor whiteColor]
//透明色
#define CLEAR_COLOR [UIColor clearColor]
//黑色
#define BLACK_COLOR [UIColor blackColor]
//文本浅黑
#define LIGHT_BLACK_COLOR UIColorWithHex(0x4D535F)
//文本黑
#define TEXT_BLACK_COLOR UIColorWithHex(0x383F47)
//文本灰1
#define TEXT_GRAY_COLOR_1 UIColorWithHex(0xB4BDCA)
//文本灰2
#define TEXT_GRAY_COLOR_2 UIColorWithHex(0x949CAC)
//灰色背景色
#define GRAY_BACKGROUND_COLOR UIColorWithHex(0xF2F5F9)
//分割线
#define LINE_COLOR UIColorWithHex(0xDFE1EA)
//font
#define FONT(x) [UIFont systemFontOfSize:x]
//bold_font
#define BOLD_FONT(x) [UIFont boldSystemFontOfSize:x]
//数字font
#define NUM_FONT(x) [UIFont fontWithName:@"AvenirLTStd-Medium" size:x]
//数字bold
#define NUM_BOLD_FONT(x) [UIFont fontWithName:@"AvenirLTStd-Heavy" size:x]
//创建可变字典
#define NMD(parameter) NSMutableDictionary *parameter = [NSMutableDictionary dictionary]
//创建可变数组
#define NMA(parameter) NSMutableArray *parameter = [NSMutableArray array]
//push
#define PUSH(v) [self.navigationController pushViewController:v animated:YES]
//pop
#define POP [self.navigationController popViewControllerAnimated:YES]
//present
#define PRESENT(v) [self presentViewController:v animated:YES completion:nil];
//dismiss
#define DISMISS [self dismissViewControllerAnimated:YES completion:nil]
//是否登录
#define IS_LOGIN [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]
//发送登录请求
#define POST_LOG_NOTIFICATION [[NSNotificationCenter defaultCenter] postNotificationName:Y_Notification_Account_Offline object:nil]

#define Y_Notification_Reload_Group @"Y_Notification_Reload_Group"          //重新从服务器拉去分组信息
#define Y_Notification_Visit_Patient_Apply @"Y_Notification_Visit_Patient_Apply"          //获取申请患者
#define Y_Notification_Sync_Group @"Y_Notification_Sync_Group"              //本地同步分组信息
//全屏约束
#define FULL_SCREEN_CONSTRAINTS(v) [v mas_makeConstraints:^(MASConstraintMaker *make) {\
make.top.equalTo(self.navBar.mas_bottom);\
if (@available(iOS 11.0, *))\
{\
make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);\
make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);\
make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);\
}\
else\
{\
make.left.bottom.right.equalTo(self.view);\
}\
}];


#endif /* CommonMacro_h */
