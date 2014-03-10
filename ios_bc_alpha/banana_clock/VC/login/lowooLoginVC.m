//
//  lowooLoginVC.m
//  banana clock
//
//  Created by MAC on 12-9-18.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooLoginVC.h"
#import "APService.h"
#import "UITabBarController_custom.h"
#import "LocalNotification.h"
#import "lowooAppDelegate.h"
@class lowooAppDelegate;

@implementation lowooLoginVC

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_textFieldEmail resignFirstResponder];
    [_textFieldPassword resignFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[[activityView sharedActivityView] removeHUD];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self resetFrame];
    [self animateView:0];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self resetFrame];
}

- (void)resetFrame{
    if (!IOS_7) {
        if (self.view.frame.size.height==480) {
            [_imageViewBack setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [_imageViewTop setFrame:CGRectMake(184, [BASE statusBarHeight]+20, 136, 44)];
        }
        else{
            [_imageViewBack setFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [_imageViewTop setFrame:CGRectMake(184, [BASE statusBarHeight], 136, 44)];
        }
    }
    
    if (iPhone5||iPhone5_0) {
        [_imageViewPeople setFrame:CGRectMake(0, 52, 320, 237)];
        [_imageViewTextField setFrame:CGRectMake(0, 285, 320, 107)];
    }else{
        [_imageViewPeople setFrame:CGRectMake(0, 20, 320, 237)];
        [_imageViewTextField setFrame:CGRectMake(0, 227, 320, 107)];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogin:) name:@"doLogin" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpFailed:) name:@"httpFailed_login" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sinaWiboLogin:) name:@"weiboLogin" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfo:) name:@"userInfo" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    //运行动画
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:FIRST_START] isEqual: @"NO"]){
        [self cartoon_end];
    }else{
        [self playSound];//注册推送音乐
        if ([[self currentLanguage] isEqualToString:@"zh-Hans"]||[[self currentLanguage] isEqualToString:@"zh-Hant"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"chinese" forKey:@"international"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"english" forKey:@"international"];
        }
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:MUSIC_ALLOW];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:MEDAL_HIDDEN];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:TIME_HIDDEN];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:MUSIC_ALLOW];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:HELP_CENTER];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SYSTEM_BOOT_0];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"baseurl"];//首次使用的主机地址
        self.navigationController.navigationBarHidden = YES;
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        lowooCarToon *carToon = [[lowooCarToon alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        carToon.delegate = self;
        [self.view addSubview:carToon];
    }
}

- (void)playSound{
    for (int i=1; i<32; i++) {
        NSString *path = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%d",i] ofType:@"caf"];
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
        AudioServicesRemoveSystemSoundCompletion(soundID);
    }
    //好友叫醒提醒
    NSString *path = [[NSBundle mainBundle]pathForResource:@"friendFollow" ofType:@"caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    AudioServicesRemoveSystemSoundCompletion(soundID);
}

#pragma mark ------------ 获取系统语言 -------------
- (NSString *)currentLanguage{
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    return [languages objectAtIndex:0];
}

#pragma mark ------------ lowooCarToonDelegate -------------
- (void)carToonRemove:(UIView *)view{
    [view removeFromSuperview];
    view = nil;
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:FIRST_START];
    [self cartoon_end];
}

- (void)cartoon_end{
    [self initVC];
    //尝试自动登录
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"autoLogin"]) {//新浪微博自动登录
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autoLogin"] isEqualToString:@"sina"]) {
            _viewLoginMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            UIImageView *imageviewlogin = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            imageviewlogin.image = GetPngImage(@"Default-568h@2x");
            if (iPhone5||iPhone5_0) {
                
            }else{
                imageviewlogin.image = GetPngImage(@"Default@2x");
                if (IOS_7) {
                    
                }else{
                    [_viewLoginMask setFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT)];
                }
            }
            [_viewLoginMask addSubview:imageviewlogin];
            [self.view addSubview:_viewLoginMask];
            [self.view bringSubviewToFront:_viewLoginMask];

            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData]) {
                liboTOOLS *tool = [[liboTOOLS alloc] init];
                [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                             [[userModel sharedUserModel] getUserInformationWithKey:USER_SINA_ID] ,@"sinaid",
                                                                             [tool MD5:[NSString stringWithFormat:@"%@",[[userModel sharedUserModel] getUserInformationWithKey:USER_SINA_ID]]],@"status",
                                                                             @"2",@"login",
                                                                              nil] requestType:weiboLogin];

             }else{
                 [self buttonWeiboAction];
             }
            
        }//用户名密码自动登录
        else if ([[userModel sharedUserModel] getUserInformationWithKey:USER_PASSWORD] && ![[[userModel sharedUserModel] getUserInformationWithKey:USER_PASSWORD] isEqualToString:@""]) {
            _viewLoginMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            UIImageView *imageviewlogin = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            imageviewlogin.image = GetPngImage(@"Default-568h@2x");
            if (iPhone5||iPhone5_0) {
                
            }else{
                if (IOS_7) {
                    imageviewlogin = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    imageviewlogin.image = GetPngImage(@"Default@2x");
                }else{
                    imageviewlogin = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    [_viewLoginMask setFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    imageviewlogin.image = GetPngImage(@"Default@2x");
                }
            }
            [_viewLoginMask addSubview:imageviewlogin];
            [self.view addSubview:_viewLoginMask];
            [self.view bringSubviewToFront:_viewLoginMask];
            
            _textFieldEmail.text = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UID];
            _textFieldPassword.text = [[userModel sharedUserModel] getUserInformationWithKey:USER_PASSWORD];
            
            
            NSDictionary *AFdict = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID], USER_UID, [[userModel sharedUserModel] getUserInformationWithKey:USER_PASSWORD], USER_PASSWORD, [[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"token", nil];
            [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:AFdict requestType:loginURL];
        }

    }

    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_UID] && ![[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID] isEqualToString:@""]) {
        [_textFieldEmail setText:[[NSUserDefaults standardUserDefaults] objectForKey:USER_UID]];
    }
}

- (void)initVC{
    for (UIView *aview in self.view.subviews) {
        [aview removeFromSuperview];
    }
    
    _imageViewBack = [[UIImageView alloc] init];
    if (iPhone5||iPhone5_0) {
        [_imageViewBack setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_imageViewBack setImage:GetPngImage(@"logbc5")];
    }else{
        [_imageViewBack setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_imageViewBack setImage:GetPngImage(@"logbc4")];
    }
    [self.view addSubview:_imageViewBack];
    
    //移动图层
    _viewMove = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_viewMove];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.backgroundColor = [UIColor clearColor];
    [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT)];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [_viewMove addSubview:_scrollView];
    
    //移动人物
    _imageViewPeople = [[UIImageView alloc] init];
    if (iPhone5||iPhone5_0) {
        [_imageViewPeople setFrame:CGRectMake(0, 52, 320, 237)];
        [_imageViewPeople setImage:GetPngImage(@"loginPeople")];
    }else{
        [_imageViewPeople setFrame:CGRectMake(0, 20, 320, 237)];
        [_imageViewPeople setImage:GetPngImage(@"loginPeople")];
    }
    [_viewMove addSubview:_imageViewPeople];
    
    //weibo
    _viewWeibo = [[UIView alloc] initWithFrame:(CGRect){0,0,SCREEN_WIDTH,SCREEN_HEIGHT}];
    [_scrollView addSubview:_viewWeibo];
    
    UIButton_custom *buttonWeibo = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonWeibo setFrame:CGRectMake(65, 304, 190, 70) image:[BASE International:@"upCN1"] image:[BASE International:@"upCN2"]];
    [buttonWeibo addTarget:self action:@selector(buttonWeiboAction)];
    [_viewWeibo addSubview:buttonWeibo];
    
    UIButton_custom *buttonAcctount = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonAcctount setFrame:CGRectMake(65, 382, 190, 70) image:[BASE International:@"downCN1"] image:[BASE International:@"downCN2"]];
    [buttonAcctount addTarget:self action:@selector(buttonAccountAction)];
    [_viewWeibo addSubview:buttonAcctount];
    
    
    _viewAccount = [[UIView alloc] initWithFrame:(CGRect){SCREEN_WIDTH,0,SCREEN_WIDTH,SCREEN_HEIGHT}];
    [_scrollView addSubview:_viewAccount];
    
    _imageViewTextField = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageViewTextField.image = GetPngImage(@"loginTextField");
    [_viewAccount addSubview:_imageViewTextField];
    
    
    //键盘返回
    UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [control addTarget:self action:@selector(selfViewTaped) forControlEvents:UIControlEventTouchUpInside];
    [_viewAccount addSubview:control];
    
    //输入框
    _textFieldEmail = [[textFieldLogin alloc] initWithFrame:CGRectZero];
    _textFieldEmail.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_textFieldEmail setFont:[UIFont systemFontOfSize:16.0f]];
    [_textFieldEmail setDelegate:self];
    [_textFieldEmail setReturnKeyType:UIReturnKeyNext];
    [_textFieldEmail setBackgroundColor:[UIColor clearColor]];
    [_textFieldEmail setTag:11];
    [_viewAccount addSubview:_textFieldEmail];
    
    _textFieldPassword = [[textFieldLogin alloc]initWithFrame:CGRectZero];
    [_textFieldPassword setFont:[UIFont systemFontOfSize:16.0f]];
    [_textFieldPassword setDelegate:self];
    [_textFieldPassword setReturnKeyType:UIReturnKeyDone];
    [_textFieldPassword setBackgroundColor:[UIColor clearColor]];
    [_textFieldPassword setSecureTextEntry:YES];
    [_textFieldPassword setTag:12];
    _textFieldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_viewAccount addSubview:_textFieldPassword];
    //创建用户
    UnderLineLabel *labelCreate = [[UnderLineLabel alloc] initWithFrame:CGRectZero];
    [labelCreate setBackgroundColor:[UIColor clearColor]];
    labelCreate.highlightedColor = [UIColor clearColor];
    labelCreate.textColor = [UIColor blackColor];
    labelCreate.shouldUnderline = YES;
    [labelCreate setFont:[UIFont systemFontOfSize:11]];
    [labelCreate addTarget:self action:@selector(creatBtn:)];
    [_viewAccount addSubview:labelCreate];
    UIButton *buttonCreate = [[UIButton alloc] initWithFrame:CGRectZero];
    [buttonCreate addTarget:self action:@selector(creatBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_viewAccount addSubview:buttonCreate];
    
    //忘记密码
    UnderLineLabel *labelForget = [[UnderLineLabel alloc] initWithFrame:CGRectZero];
    [labelForget setBackgroundColor:[UIColor clearColor]];
    labelForget.highlightedColor = [UIColor clearColor];
    labelForget.textColor = [UIColor blackColor];
    labelForget.shouldUnderline = YES;
    [labelForget setFont:[UIFont systemFontOfSize:11]];
    [labelForget addTarget:self action:@selector(buttonForgetTouchUpinside:)];
    [_viewAccount addSubview:labelForget];
    UIButton *buttonForget = [[UIButton alloc] initWithFrame:CGRectZero];
    [_viewAccount addSubview:buttonForget];
    [buttonForget addTarget:self action:@selector(buttonForgetTouchUpinside:) forControlEvents:UIControlEventTouchUpInside];
    
    //登录按钮
    UIButton_custom *buttonLogin = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonLogin setFrame:CGRectZero];
    [buttonLogin setImageNormal:GetPngImage([BASE International:@"loginbtnCNa"])];
    [buttonLogin setImageHighlited:GetPngImage([BASE International:@"loginbtnCNb"])];
    [buttonLogin addTarget:self action:@selector(buttonLoginTouchUpinside:) forControlEvents:UIControlEventTouchUpInside];
    [_viewAccount addSubview:buttonLogin];
    
    //顶部不动图片
    _imageViewTop = [[UIImageView alloc] initWithFrame:CGRectMake(184, [BASE statusBarHeight], 136, 44)];
    _imageViewTop.image = GetPngImage(@"loginTop");
    [self.view addSubview:_imageViewTop];
    
    UIButton *buttonApp = [[UIButton alloc] initWithFrame:CGRectMake(184, [BASE statusBarHeight], 70, 50)];
    buttonApp.backgroundColor = [UIColor clearColor];
    [buttonApp addTarget:self action:@selector(webSiteApp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonApp];
    
    UIView *viewLowoo = [[UIView alloc] initWithFrame:CGRectMake(255, [BASE statusBarHeight], 70, 50)];
    [self.view addSubview:viewLowoo];
    UITapGestureRecognizer *tapLowoo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(webSiteLowoo)];
    [tapLowoo setNumberOfTapsRequired:2];
    [viewLowoo addGestureRecognizer:tapLowoo];
    
    
    if (iPhone5_0||iPhone5) {
        [_textFieldEmail setFrame:CGRectMake(95, 299, 155, 30)];
        [_textFieldPassword setFrame:CGRectMake(95, 351, 155, 30)];
        [buttonLogin setFrame:CGRectMake(87, 430, 146, 59)];
        [_imageViewTextField setFrame:CGRectMake(0, 285, 320, 107)];
    }else{
        if (IOS_7) {
            [_textFieldEmail setFrame:CGRectMake(95, 243+[BASE height15_ISO6], 152, 30)];
            [_textFieldPassword setFrame:CGRectMake(95, 293+[BASE height15_ISO6], 152, 30)];
        }else{
            [_textFieldEmail setFrame:CGRectMake(95, 233+[BASE height15_ISO6], 152, 30)];
            [_textFieldPassword setFrame:CGRectMake(95, 283+[BASE height15_ISO6], 152, 30)];
        }
        
        [buttonLogin setFrame:CGRectMake(87, 355, 146, 59)];
        [buttonWeibo setFrame:CGRectMake(65, 259, 190, 70)];
        [buttonAcctount setFrame:CGRectMake(65, 337, 190, 70)];
        [_imageViewTextField setFrame:CGRectMake(0, 227, 320, 107)];
    }
    if (LANGUAGE_CHINESE) {
        [_textFieldEmail setPlaceholder:@"登陆邮箱"];
        [_textFieldPassword setPlaceholder:@"密码"];
        labelCreate.text = @"创建用户";
        labelForget.text = @"忘记密码？";
        
        if (iPhone5_0||iPhone5) {
            [labelCreate setFrame:CGRectMake(85, 392, 50, 15)];
            [labelForget setFrame:CGRectMake(140, 392, 60, 15)];
            [buttonCreate setFrame:CGRectMake(85, 390, 50, 20)];
            [buttonForget setFrame:CGRectMake(165, 390, 60, 20)];
        }else{
            [labelCreate setFrame:CGRectMake(85, 332, 50, 15)];
            [labelForget setFrame:CGRectMake(140, 332, 60, 15)];
            [buttonCreate setFrame:CGRectMake(85, 330, 50, 20)];
            [buttonForget setFrame:CGRectMake(165, 330, 60, 20)];
        }
    }else{
        [_textFieldEmail setPlaceholder:@"Login E-mail"];
        [_textFieldPassword setPlaceholder:@"Password"];
        labelCreate.text = @"Create a user";
        labelForget.text = @"Forgot Password?";
        
        if (iPhone5_0||iPhone5) {
            [labelCreate setFrame:CGRectMake(85, 392, 93, 15)];
            [labelForget setFrame:CGRectMake(165, 392, 119, 15)];
            [buttonCreate setFrame:CGRectMake(85, 390, 93, 20)];
            [buttonForget setFrame:CGRectMake(165, 390, 119, 20)];
        }else{
            [labelCreate setFrame:CGRectMake(85, 332, 93, 15)];
            [labelForget setFrame:CGRectMake(165, 332, 119, 15)];
            [buttonCreate setFrame:CGRectMake(85, 330, 93, 20)];
            [buttonForget setFrame:CGRectMake(165, 330, 119, 20)];
        }
    }
    [self resetFrame];
}


- (void)httpFailed:(NSNotification *)sender{
    _viewLoginMask.hidden = YES;
    [self initVC];
}



#pragma mark -----------  跳转至网站  ——-----------
- (void)webSiteApp{
    lowooWebVC *webVC = [[lowooWebVC alloc]init];
    webVC.urlString = [NSString stringWithFormat:@"http://bc.lowoo.cc"];
    webVC.navTitle = @"lowoo";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)webSiteLowoo{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"使用此主机地址" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertView.tag = 10;
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"base_server_url"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"base_server_url"] length]>0) {
        [[alertView textFieldAtIndex:0] setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"base_server_url"]];
    }else{
        [[alertView textFieldAtIndex:0] setText:@"http://bc.lowis.me"];
        [[NSUserDefaults standardUserDefaults] setObject:@"http://bc.lowis.me" forKey:@"base_server_url"];
    }
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10) {
        if (buttonIndex == 0) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"baseurl"];
        }else{
            if ([[alertView textFieldAtIndex:0] text].length>0) {
                [[NSUserDefaults standardUserDefaults] setObject:[[alertView textFieldAtIndex:0] text] forKey:@"base_server_url"];
            }
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"baseurl"];
        }
    }
}

#pragma mark----------selfViewTaped----------
-(void)selfViewTaped{
    [_textFieldEmail resignFirstResponder];
    [_textFieldPassword resignFirstResponder];
    [self animateView:0];
}

#pragma mark-----------UITextFieldDelegate-----------
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSInteger tag = textField.tag;
    [self animateView:tag];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSInteger tag = textField.tag;
    if (tag == 12) {
        [textField resignFirstResponder];
        [self animateView:0];
        [self buttonAccountAction];
        return YES;
    }
    [self animateView:(tag + 1)];
    [_textFieldPassword becomeFirstResponder];
    return YES;
}

-(void)animateView:(NSUInteger)tag{
    CGRect rect = _viewMove.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.30];
    int height = -100;
    if (iPhone5||iPhone5_0) {
        
    }else{
        height = -150;
    }
    if (tag > 0) {
        rect.origin.y = height-30.0f*(tag-10);
    } else {
        rect.origin.y = 0;
    }
    _viewMove.frame = rect;
    [UIView commitAnimations];
}

-(void)login{
    [self selfViewTaped];
    
    if (_textFieldEmail.text == nil || _textFieldPassword.text == nil || [_textFieldEmail.text isEqualToString:@""] || [_textFieldPassword.text isEqualToString:@""]) {
        [liboTOOLS alertViewMSG:[BASE International:@"用户名或密码不能为空！"]];
        _textFieldPassword.text = @"";
        [[activityView sharedActivityView] removeHUD];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"autoLogin"];
    if ([[lowooHTTPManager getInstance] isExistenceNetwork]) {
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:_textFieldEmail.text, @"uid", _textFieldPassword.text, @"password", nil] requestType:loginURL];
    }
}

#pragma mark-----------HTTPPRequest--------------
- (void)didLogin:(NSNotification *)sender{
    if (![BASE isNotNull:sender.userInfo]) {
        [[activityView sharedActivityView] removeHUD];
        [liboTOOLS alertViewMSG:[BASE International:@"网络连接失败"]];
        return;
    }

    if ([[sender.userInfo objectForKey:@"state"] intValue]==1) {
        [[userModel sharedUserModel] setUserInformation:[sender.userInfo objectForKey:@"id"] forKey:USER_ID];
        [[NSUserDefaults standardUserDefaults] setObject:[sender.userInfo objectForKey:USER_ID] forKey:USER_ID];
        [[NSUserDefaults standardUserDefaults] synchronize];
//        [APService setTags:[NSSet setWithObjects:[sender.userInfo objectForKey:@"id"],nil] alias:[sender.userInfo objectForKey:@"id"] callbackSelector:nil object:self];
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:nil requestType:userInfo];
    }else{
        [[activityView sharedActivityView] removeHUD];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SYSTEM_BOOT_0];
        [liboTOOLS alertViewMSG:[BASE International:@"用户名或密码不正确"]];
        _textFieldPassword.text = @"";
        _viewLoginMask.hidden = YES;
    }
}

- (void)tabBarVC{
    [APService setTags:[NSSet setWithObjects:USERID ,nil] alias:USERID callbackSelector:nil object:self];
    
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:userpropsinfo];//下载道具
    //[[activityView sharedActivityView] removeHUD];
    LOWOO_APP(app);
//    UITabBarController_custom *tabBarController = [[UITabBarController_custom alloc] init];
//    for (UIViewController *vc in app.navTabBarController.viewControllers) {
//        [vc.view removeFromSuperview];
//        [vc removeFromParentViewController];
//    }
//    [app.navTabBarController removeFromParentViewController];
//    app.navTabBarController = nil;
//    app.navTabBarController  = [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
//    app.navTabBarController.viewControllers = @[tabBarController];
//    app.navTabBarController.navigationBarHidden = YES;
//
//    
//    [app.window setRootViewController:app.navTabBarController];
    [app changeVC:1];
    [liboTOOLS dismissHUD];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)creatBtn:(id)sender {
    lowooRegisterVC *registerVC = [[lowooRegisterVC alloc]init];
    registerVC.delegate = self;
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark---------- RegisterDelegate ---------
- (void)didRegist:(NSString *)name pass:(NSString *)passWord{
    self.textFieldEmail.text = name;
    self.textFieldPassword.text = passWord;
    [self login];
}

#pragma mark-----------忘记密码--------------
- (void)buttonForgetTouchUpinside:(UIButton_custom *)sender {
    lowooWebVC *webVC = [[lowooWebVC alloc]init];
    NSString *requestUrl;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"] boolValue]) {
        requestUrl = [NSString stringWithFormat:@"%@/index.php?option=com_users&view=reset",BASEURL];
    }else{
        requestUrl = [NSString stringWithFormat:@"%@/index.php?option=com_users&view=reset",[[NSUserDefaults standardUserDefaults] objectForKey:@"base_server_url"]];
    }
    webVC.urlString = requestUrl;
    webVC.navTitle = [BASE International:@"找回密码"];
    
    forgetPassword *password = [[forgetPassword alloc] init];
    [self.navigationController pushViewController:password animated:YES];
}

#pragma mark------------登录-----------
- (void)buttonLoginTouchUpinside:(UIButton_custom *)sender {
    [[activityView sharedActivityView] showHUD:-1];
    [self login];
}

#pragma mark ------------ sina -----------
- (void)buttonWeiboAction{
    if ([[lowooHTTPManager getInstance] isExistenceNetwork]) {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"autoLogin"] isEqualToString:@"sina"]){
            [[activityView sharedActivityView] showHUD:-1];
        }
        
        [[userModel sharedUserModel] setUserInformation:@"" forKey:USER_ID];
        _sina = [[lowooSinaWeibo alloc] init];
        _sina.delegate = self;
        [_sina doMicrobloggingCertification];//微博认证
    }
}

- (void)sinaLogInDidCancel:(lowooSinaWeibo *)sina{
    [[activityView sharedActivityView] removeHUD];
    _viewLoginMask.hidden = YES;
    [_viewLoginMask removeFromSuperview];
    sina.delegate = nil;
    sina = nil;
}

- (void)sinaWeiboLoginFaild:(lowooSinaWeibo *)sina{
    [[activityView sharedActivityView] removeHUD];
    _viewLoginMask.hidden = YES;
    [_viewLoginMask removeFromSuperview];
    sina.delegate = nil;
    sina = nil;
    [liboTOOLS alertViewMSG:@"新浪微博认证失败"];
}

- (void)SinaLogIn:(NSDictionary *)dictionary{
    liboTOOLS *tool = [[liboTOOLS alloc] init];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:
                                                    [dictionary objectForKey:@"idstr"],@"sinaid",
                                                    [dictionary objectForKey:@"name"], @"name",
                                                    [dictionary objectForKey:@"gender"], @"gender",
                                                    [dictionary objectForKey:@"location"], @"location",
                                                    [dictionary objectForKey:@"avatar_large"], @"avatar_large",
                                                    [tool MD5:[dictionary objectForKey:@"idstr"]],@"status",
                                                    @"1",@"login",
                                                    nil] requestType:weiboLogin];
    _sina.delegate = nil;
    _sina = nil;
}

//服务器返回微博登陆信息
- (void)sinaWiboLogin:(NSNotification *)sender{
    [[activityView sharedActivityView] removeHUD];
    if ([BASE isNotNull:sender.userInfo]) {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"autoLogin"] isEqualToString:@"sina"]){
            [[activityView sharedActivityView] showHUD:-1];
        }
        if ([[sender.userInfo objectForKey:@"state"] intValue]==1) {//成功获取用户id
            [[userModel sharedUserModel] setUserInformation:[sender.userInfo objectForKey:@"id"] forKey:USER_ID];
            [[NSUserDefaults standardUserDefaults] setObject:[sender.userInfo objectForKey:@"id"] forKey:USER_ID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:nil requestType:userInfo];
            
            if ([[sender.userInfo objectForKey:@"secondstate"] intValue]==2) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SYSTEM_BOOT_0];
            }
            [[NSUserDefaults standardUserDefaults] setObject:@"sina" forKey:@"autoLogin"];
        }else{
            if (LANGUAGE_CHINESE) {
                [liboTOOLS alertViewMSG:[sender.userInfo objectForKey:@"msg"]];
            }else{
                [liboTOOLS alertViewMSG:[sender.userInfo objectForKey:@"e_msg"]];
            }
            [[activityView sharedActivityView] removeHUD];
            [_viewLoginMask removeFromSuperview]; _viewLoginMask = nil;
        }
       
    }else{
        [_viewLoginMask removeFromSuperview]; _viewLoginMask = nil;
    }
}

//后台返回用户信息
- (void)userInfo:(NSNotification *)sender{
    if (![BASE isNotNull:sender.userInfo]) {
        return;
    }

    [[userModel sharedUserModel] setUserInformation:_textFieldEmail.text forKey:USER_UID];
    [[NSUserDefaults standardUserDefaults] setObject:_textFieldEmail.text forKey:USER_UID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[userModel sharedUserModel] setUserInformation:_textFieldPassword.text forKey:USER_PASSWORD];
    userModel *model = [userModel sharedUserModel];
    [model setUserInformation:[sender.userInfo objectForKey:@"coin"] forKey:USER_COIN];
    [model setUserInformation:[sender.userInfo objectForKey:@"email"] forKey:USER_EMAIL];
    [model setUserInformation:[sender.userInfo objectForKey:@"id"] forKey:USER_ID];
    [[NSUserDefaults standardUserDefaults] setObject:[sender.userInfo objectForKey:@"id"] forKey:USER_ID];
    [model setUserInformation:[sender.userInfo objectForKey:@"uid"] forKey:USER_UID];
    [model setUserInformation:[sender.userInfo objectForKey:@"location"] forKey:USER_CITY];
    [model setUserInformation:[sender.userInfo objectForKey:@"name"] forKey:USER_NAME];
    [model setUserInformation:[sender.userInfo objectForKey:@"sex"] forKey:USER_SEX];
    [model setUserInformation:[sender.userInfo objectForKey:USER_SHARELIST] forKey:USER_SHARELIST];
    [model setUserInformation:[sender.userInfo objectForKey:@"phoneNumber"] forKey:USER_PHONENUMBER];
    [model setUserInformation:[sender.userInfo objectForKey:@"sinaNumber"] forKey:SINA_NAME];
    [model setUserInformation:[sender.userInfo objectForKey:@"user_face"] forKey:@"user_face"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[model getUserInformationWithKey:LOCAL_NOTIFICATION]];
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
    }
    [dict setObject:[[sender.userInfo objectForKey:@"day_time"] objectForKey:@"time_start"] forKey:USER_BEGINTIME];
    [dict setObject:[[sender.userInfo objectForKey:@"day_time"] objectForKey:@"time_stop"] forKey:USER_ENDTIME];
    [model setUserInformation:dict forKey:LOCAL_NOTIFICATION];

    if ([[lowooHTTPManager getInstance] isExistenceNetwork]) {
        if ([[userModel sharedUserModel] getUserInformationWithKey:@"moon_network"] && ![[[userModel sharedUserModel] getUserInformationWithKey:@"moon_network"] isEqualToString:@""]) {//上传本地闹铃
            [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:
             [NSDictionary dictionaryWithObjectsAndKeys:[[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:@"moon"],@"moon", nil] requestType:moon_sun];
            [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:
             [NSDictionary dictionaryWithObjectsAndKeys:[[userModel sharedUserModel] getUserInformationWithKey:@"timestart"], @"timestart",
              [[userModel sharedUserModel] getUserInformationWithKey:@"timestop"], @"timestop", nil] requestType:setcalledtime];
            [[userModel sharedUserModel] setUserInformation:@"" forKey:@"moon"];
            [[userModel sharedUserModel] setUserInformation:@"" forKey:@"timestart"];
            [[userModel sharedUserModel] setUserInformation:@"" forKey:@"timestop"];
        }else{//同步网络闹铃
            NSDictionary *dict = [[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION];

            if (!dict) {
                dict = [[NSDictionary alloc] init];
            }
            NSMutableDictionary *muDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
            if ([[sender.userInfo objectForKey:@"random"] count]>0) {
                NSArray *array = [[sender.userInfo objectForKey:@"random"] objectAtIndex:0];
                [muDict setObject:array forKey:@"array"];
            }
            
            if ([sender.userInfo objectForKey:@"day_time"]) {
                NSInteger stamp = [[[sender.userInfo objectForKey:@"day_time"] objectForKey:@"time_stop"] intValue];
                liboTOOLS *tool = [[liboTOOLS alloc] init];

                NSInteger int1 = stamp/36000;
                stamp = stamp%36000;
                NSInteger int2 = stamp/3600;
                stamp = stamp%3600;
                NSInteger int3 = stamp/600;
                stamp = stamp%600;
                NSInteger int4 = stamp/60;
                NSString *stringStamp = [tool time_TO_timestamp:int1*10+int2 minute:int3*10+int4];
                [muDict setObject:stringStamp forKey:USER_ENDTIME];
            }
            if ([sender.userInfo objectForKey:@"mon"]) {
                [muDict setObject:[sender.userInfo objectForKey:@"mon"] forKey:@"moon"];
            }
            
            
            [[userModel sharedUserModel] setUserInformation:[NSDictionary dictionaryWithDictionary:muDict] forKey:LOCAL_NOTIFICATION];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[LocalNotification sharedLocalNotification] setLocalNotification];
            });
        }
    }
    [self tabBarVC];
}

- (void)buttonAccountAction{
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
}

#pragma mark ------------- UIScrollViewDelegate --------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x==0) {
        _textFieldPassword.text = @"";
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _viewLoginMask = nil;
    _textFieldEmail = nil;
    _textFieldPassword = nil;
    lowooAppDelegate *delegate = (lowooAppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.sinaWeibo.delegate = nil;
    //_sina = nil;
}



@end
