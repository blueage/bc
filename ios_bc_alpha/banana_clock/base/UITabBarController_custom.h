//
//  UITabBarController_custom.h
//  banana_clock
//
//  Created by MAC on 13-10-9.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lowooLoginVC.h"
#import "lowooWeakupVC.h"
#import "clockVC.h"
#import "lowooFriendsVC.h"
#import "FriendsVC.h"
#import "lowooProps.h"
#import "lowooSettingVC.h"
#import "lowooCarToon.h"
#import "lowooGame.h"
#import "lowooNavigationView.h"
#import "UINavigationController_custom.h"
#import "systemBoot.h"

@interface UITabBarController_custom : UITabBarController<lowooCarToonDelegate,lowooGameDelegate,time_titleDelegate>

@property (nonatomic, strong) UIView *viewTabBar;
@property (nonatomic, strong) NSMutableArray *arrayTabButton;
@property (nonatomic, strong) NSMutableArray *arrayViewController;
@property (nonatomic, strong) NSArray *arrayImages;
@property (nonatomic, strong) NSArray *arrayImagesDown;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic, strong) systemBoot *boot;

@property (nonatomic, strong) time_title *timeTitle;
@property (nonatomic, strong) lowooNavigationView *viewNavigationView;
@property (nonatomic, strong) NSString *stringCallFid;
@property (nonatomic, strong) NSString *stringTid;
@property (nonatomic, strong) NSMutableArray *arrayGame;
@property (nonatomic, assign) BOOL boolSomeoneCall;

@property (nonatomic, strong) UINavigationController *nav1;
@property (nonatomic, strong) UINavigationController *nav2;
@property (nonatomic, strong) UINavigationController *nav3;
@property (nonatomic, strong) UINavigationController *nav4;

@property (nonatomic, strong) UIImageView *imageViewMessageNotificationRED;
- (void)hidesBottomBarViewWhenPushed:(BOOL)hidden;
- (void)hidesTimeTitleWhenPushed:(BOOL)hidden;
- (id)UITabBarController_custom_view;


@end
