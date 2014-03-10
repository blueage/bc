//
//  lowooAppDelegate.h
//  banana_clock
//
//  Created by MAC on 12-12-17.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "videoBC.h"
#import "WXApi.h"
#import "Reachability.h"
#import "lowooLoginVC.h"
#import "UINavigationBar_custom.h"

@class SinaWeibo;
@class lowooSina;

@interface lowooAppDelegate : UIResponder <UIApplicationDelegate,NSURLConnectionDataDelegate,UIAlertViewDelegate,WXApiDelegate,SinaWeiboDelegate>{
    Reachability *hostReach;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly) SinaWeibo *sinaWeibo;
@property (nonatomic, retain) lowooSina *sina;
@property (nonatomic, strong) NSDictionary *dictionaryGame;


- (void)changeVC:(NSInteger )name;

@end
