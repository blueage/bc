//
//  lowooLoginVC.h
//  banana clock
//
//  Created by MAC on 12-9-18.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lowooRegisterVC.h"
#import "lowooWebVC.h"
#import "forgetPassword.h"
#import "lowooAlertViewDemo.h"
#import "UnderLineLabel.h"
#import "lowooCarToon.h"
#import "lowooSinaWeibo.h"
#import "textFieldLogin.h"

@protocol lowooLoginVCDelegate <NSObject>
- (void)didLogin;
@end

@interface lowooLoginVC : UIViewController<UITextFieldDelegate,UIWebViewDelegate,lowooCarToonDelegate,UIScrollViewDelegate,lowooRegisterVCDelegate,UIAlertViewDelegate,lowooSinaWeiboDelegate>

@property (nonatomic, weak) id<lowooLoginVCDelegate>delegate;
@property (nonatomic, strong) UIView *viewLoginMask; //UIImageView *imageviewlogin;//覆盖登陆界面
@property (nonatomic, strong) textFieldLogin *textFieldEmail;
@property (nonatomic, strong) textFieldLogin *textFieldPassword;
@property (nonatomic, strong) UIView *viewMove;
@property (nonatomic, strong) UIView *viewWeibo;
@property (nonatomic, strong) UIView *viewAccount;
@property (nonatomic, strong) UIImageView *imageViewBack;
@property (nonatomic, strong) UIImageView *imageViewTop;
@property (nonatomic, strong) UIImageView *imageViewPeople;
@property (nonatomic, strong) UIImageView *imageViewTextField;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) lowooSinaWeibo *sina;

@end
