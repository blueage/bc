//
//  lowooViewController.h
//  banana_clock
//
//  Created by MAC on 13-3-31.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lowooHTTPManager.h"
#import "lowooAlertViewDemo.h"
#import "time&title.h"
#import "THLabel.h"


@interface lowooViewController : UIViewController

@property (nonatomic, strong) lowooHTTPManager *manager;
@property (nonatomic, strong) NSDictionary *dictionaryReturn;//返回数据
@property (nonatomic, strong) NSArray *arrayReturn;//返回数据

@property (nonatomic, strong) time_title *timeTitle;
@property (nonatomic, strong) NSString *stringTitle;//通用title
@property (nonatomic, strong) UIView *viewTitle;
@property (nonatomic, strong) UIView *viewLeftButton;//左按键
@property (nonatomic, strong) UIButton_custom *leftBtn;
@property (nonatomic, strong) UIImageView *imageViewLeft;
@property (nonatomic, strong) UIView *viewRightButton;//右按键
@property (nonatomic, strong) UIButton_custom *buttonRight;
@property (nonatomic, strong) UIImageView *imageViewRight;
@property (nonatomic, strong) NSString *memoryAddress;
@property (nonatomic) BOOL boolPush;


- (void)leftButtonDidTouchedUpInside;
- (void)rightButtonTouchUpInside;
- (void)updataNetworkData;//必须被子类覆盖，已使用不同的参数进行网络交互
- (void)changeTitle;
- (void)changeTitleWith:(NSString *)title;
- (void)changeLanguage;
- (void)initNavigationBar;
- (void)offline;
- (void)setBoolPushYES;

@end
