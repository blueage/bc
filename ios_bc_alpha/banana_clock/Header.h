//
//  Header.h
//  banana_clock
//
//  Created by MAC on 13-3-18.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#ifndef banana_clock_Header_h
#define banana_clock_Header_h

#import "lowooMusic.h"
#import "viewHead.h"
#import "userModel.h"
#import "activityView.h"
#import "lowooHTTPManager.h"
#import "BASE.h"
#import "UITableViewCell_custom.h"
#import "UIButton_custom.h"
#import "UITabBarController+custom.h"
#import "UIImageView_custom.h"
#import "UINavigationBar_custom.h"
#import "MMProgressHUD.h"
#import "MMProgressHUDOverlayView.h"
#import "liboTOOLS.h"
#import "modelAchievement.h"
#import "modelMedal.h"
#import "modelUser.h"
#import "modelUserDetail.h"
#import "modelProp.h"

//微博
#define AppKey             @"3472615128"
#define AppSecret          @"10184e00d7adb40583328e37e41c6d46"
#define AppRedirectURI     @"http://sinaweibosso.3472615128"
#define sina_weibo_authData            @"SinaWeiBoAuthData"
#define sina_accessTokenKey            @"accessTokenKey"
#define sina_expirationDateKey         @"expirationDateKey"
#define sina_userIDKey                 @"userIDKey"
#define sina_refresh_token             @"refresh_token"
#define SINA_NAME                      @"sinaName"
//微信
#define WXAppID   @"wx7dd8b41dcf0f8dc6"
#define WXAppKey  @"5fc6a89e33de7c1ebc35526193842ce3"
//人人
//#define renrenAPPID        @"242981"
//#define renrenAPPKEY       @"41f090645eed404583af30f5f4049c72"
//#define renrenSecretKey    @"958661aafb0f442982c7ea4039bf77b3"
#define renrenAPPID        @"243840"
#define renrenAPPKEY       @"cb75ee88c7f641ff85ee012ceaeb5f2c"
#define renrenSecretKey    @"2eaf363a0ed249478f14cf7f88e484eb"

#define MEDAL_CHINESE               @"medal_chinese"
#define MEDAL_ENGLISH               @"medal_english"
#define MEDAL_CONTENT               @"medal_content"
#define MEDAL_CONTENT_B             @"medal_content_b"

#define COLOR_CHINESE               [UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1]
#define COLOR_ENGLISH               [UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:0.7]
#define COLOR_CONTENT_NO            [UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:0.7]
#define COLOR_CONTENT_YES           [UIColor colorWithRed:200/255.0 green:169/255.0 blue:0/255.0 alpha:0.9]
#define COLOR_DAY                   [UIColor colorWithRed:200/255.0 green:169/255.0 blue:0/255.0 alpha:0.9]
#define COLOR_EXPANDED_NO           [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.7]
#define COLOR_EXPANDED_YES          [UIColor colorWithRed:232/255.0 green:180/255.0 blue:0/255.0 alpha:0.9]

#define CELLSTATE     @"cellState"

typedef enum {
    cellHadWeakup = 0,
    cellCanBeCalled,
    cellCallIn,
    cellRest,
}cellState;





#define MUSIC_ALLOW   @"music_allow"
#define OPENING_ANIMATION @"Opening Animation"
#define HELP_CENTER     @"help_center"
#define TIME_HIDDEN @"timeHidden"
#define MEDAL_HIDDEN @"medalHidden"
#define USER_STORE_ACCESS_TOKEN     @""
#define DeviceTokenRegisteredKEY   [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]
#define LOCAL_NOTIFICATION     @"localNotification"





#define USER_BEGINTIME           @"beginTime"
#define USER_ENDTIME             @"endTime"
#define USER_PHONENUMBER         @"userphonenumber"
#define USER_CITY                @"location"
#define USER_COIN                @"coin"
#define USER_UID                 @"uid"
#define USER_NAME                @"name"
#define USER_ID                  @"id"
#define USER_SINA_ID             @"userSinaId"
#define USER_EMAIL               @"email"
#define USER_SEX                 @"sex"
#define USER_SHARELIST           @"sharelist"
#define USERID                   [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]
#define USER_PASSWORD            @"password"
#define APP_URL                  @""
#define BASEURL                  @"http://bc.lowoo.cc"
#define MEMORY_ADDRESS           @"memeoryAddress"


#define LOWOO_APP(appDelegate)     lowooAppDelegate *appDelegate = (lowooAppDelegate *)[UIApplication sharedApplication].delegate;

//设置线宽，如果是retina屏，lineWidth设为1,实际显示的宽度是2个像素
#define SETLINEWIDTH(ctx,w) CGContextSetLineWidth(ctx, w/[UIScreen mainScreen].scale)


//时间
#define TIME  40
//满分
#define SCORE 15
//香蕉数量
#define BANANANUMBER  28
//判断得分高度
#define BED_HEIGHT 130
//判断撞击地面高度
#define GROUND_HEIGHT  210
//最小滑动距离
#define MINIMUM_SLIDING_DISTANCE  80

//屏幕细分
#define NAVIGATIONBAR_HEIGHT (IOS_7? 43.0f : 43.0f)
#define TABBAR_HEIGHT  59.0f
#define ContentHeight (SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT)


//屏幕大小
#define SCREEN [[UIScreen mainScreen]bounds];
//CGrect screenBounds = [ [UIScreen mainScreen] bounds];//返回的是带有状态栏的Rect
//对于iphone4来说screenBounds=0，0，320，480
//CGRect viewBounds = [ [UIScreen mainScreen] applicationFrame];//不包含状态栏的Rect
//对于iphone4来说，viewBounds=0，20，320，460
#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
//#define SCREEN_HEIGHT   [[UIScreen mainScreen] applicationFrame].size.height
//判断iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5_0 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320,568), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS_7 ([[[UIDevice currentDevice] systemVersion] intValue]>6 ? YES : NO)

//在ARC项目中使用 performSelector: withObject: 函数出现“performSelector may cause a leak because its selector is unknown”。
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//判断ipad还是iphone
#define IS_IPAD  ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] &&[[UIDevice currentDevice] userInterfaceIdion] == UIUserInterfaceIdiomPad)

//安全释放对象
#define RELEASE_SAFELY(__POINTER) { if(__POINTER){[__POINTER release]; __POINTER = nil;}}


#define FIRST_START         @"first_start"
#define SYSTEM_BOOT_0       @"systemBoot0"
//#define SYSTEM_BOOT_1       @"systemBoot1"
//#define SYSTEM_BOOT_2       @"systemBoot2"
//#define SYSTEM_BOOT_3       @"systemBoot3"
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)


#define ACHIEVEMENT_CHINESE         @"achievement_chinese"
#define ACHIEVEMENT_ENGLISH         @"achievement_english"
#define ACHIEVEMENT_CONTENT         @"achievement_content"

#define MEDAL_CHINESE               @"medal_chinese"
#define MEDAL_ENGLISH               @"medal_english"
#define MEDAL_CONTENT               @"medal_content"

#define LANGUAGE_CHINESE       [[[NSUserDefaults standardUserDefaults] objectForKey:@"international"] isEqualToString:@"chinese"]
#define BUTTON_SLEEP(button)      button.userInteractionEnabled = NO;sleep(.2);button.userInteractionEnabled = YES;
#define RGB(A,B,C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0] //然后用RGB(25,25,25)就可以了


#endif


#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d   \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#define GetPngImage(a) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:a ofType:@"png"]]
#define GetJpgImage(a) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:a ofType:@"jpg"]]

