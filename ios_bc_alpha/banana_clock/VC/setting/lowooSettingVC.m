//
//  lowooSettingVC.m
//  banana clock
//
//  Created by MAC on 12-9-26.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooSettingVC.h"
#import "lowooAppDelegate.h"
#import "myAccount.h"
#import "APService.h"
#import "lowooStory.h"


#define VERTEX_DISTANCE  35

@implementation lowooSettingVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    
    self.stringTitle = @"SETTING";
    [self changeTitle];
    self.navigationController.navigationBarHidden = NO;
    
    [self.tabBarController hidesBottomBarViewWhenPushed:NO];
    [self.tabBarController hidesTimeTitleWhenPushed:NO];
    self.viewLeftButton.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.viewLeftButton.hidden = YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initView];
}

- (void)initView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -5, 320, SCREEN_HEIGHT-110)];
        _scrollView.showsVerticalScrollIndicator = NO;
        
        //个人信息
        _viewIntroduceButtonProfile = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 0*54+VERTEX_DISTANCE, 276, 55)];
        _viewIntroduceButtonProfile.button.userInteractionEnabled = YES;
        _viewIntroduceButtonProfile.button.tag = 0;
        [_viewIntroduceButtonProfile.button addTarget:self action:@selector(buttonTouchUpInside:)];
        [_scrollView addSubview:_viewIntroduceButtonProfile];
        //二维码
        _viewIntroduceButtonQR = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 1*54+VERTEX_DISTANCE, 276, 55)];
        _viewIntroduceButtonQR.button.userInteractionEnabled = YES;
        _viewIntroduceButtonQR.button.tag = 1;
        [_viewIntroduceButtonQR.button addTarget:self action:@selector(buttonTouchUpInside:)];
        [_scrollView addSubview:_viewIntroduceButtonQR];
        //账号绑定
        _viewIntroduceButtonAccount = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 2*54+VERTEX_DISTANCE, 276, 55)];
        _viewIntroduceButtonAccount.button.userInteractionEnabled = YES;
        _viewIntroduceButtonAccount.button.tag = 2;
        [_viewIntroduceButtonAccount.button addTarget:self action:@selector(buttonTouchUpInside:)];
        [_scrollView addSubview:_viewIntroduceButtonAccount];
        //黑名单
        _viewIntroduceButtonBlackList = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 3*54+VERTEX_DISTANCE, 276, 55)];
        _viewIntroduceButtonBlackList.button.userInteractionEnabled = YES;
        _viewIntroduceButtonBlackList.button.tag = 3;
        [_viewIntroduceButtonBlackList.button addTarget:self action:@selector(buttonTouchUpInside:)];
        [_scrollView addSubview:_viewIntroduceButtonBlackList];
        
        //设置
        _viewIntroduceButtonSetting = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 4*54+VERTEX_DISTANCE, 276, 55)];
        _viewIntroduceButtonSetting.button.userInteractionEnabled = YES;
        _viewIntroduceButtonSetting.button.tag = 4;
        [_viewIntroduceButtonSetting.button addTarget:self action:@selector(buttonTouchUpInside:)];
        [_scrollView addSubview:_viewIntroduceButtonSetting];
        //香蕉故事
        _viewIntroduceButtonBananaStory = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 5*54+VERTEX_DISTANCE+10, 276, 55)];
        _viewIntroduceButtonBananaStory.button.userInteractionEnabled = YES;
        _viewIntroduceButtonBananaStory.button.tag = 5;
        [_viewIntroduceButtonBananaStory.button addTarget:self action:@selector(buttonTouchUpInside:)];
        [_scrollView addSubview:_viewIntroduceButtonBananaStory];
        //关于
        _viewIntroduceButtonAbout = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 6*54+VERTEX_DISTANCE+10, 276, 55)];
        _viewIntroduceButtonAbout.button.userInteractionEnabled = YES;
        _viewIntroduceButtonAbout.button.tag = 6;
        [_viewIntroduceButtonAbout.button addTarget:self action:@selector(buttonTouchUpInside:)];
        [_scrollView addSubview:_viewIntroduceButtonAbout];
        //退出
        _buttonLogOut = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonLogOut setFrame:CGRectMake(20, (6+1)*55+36+VERTEX_DISTANCE, 280, 53)];
        [_buttonLogOut addTarget:self action:@selector(logOutBtnTouchUpInside:)];
        [_scrollView addSubview:_buttonLogOut];
    }

    
    if (LANGUAGE_CHINESE) {
        _viewIntroduceButtonProfile.viewIntroduce.labelChinese.text = @"个人信息";
        _viewIntroduceButtonProfile.viewIntroduce.labelChineseEnglish.text = @"Profile";
        
        _viewIntroduceButtonQR.viewIntroduce.labelChinese.text = @"二维码名片";
        _viewIntroduceButtonQR.viewIntroduce.labelChineseEnglish.text = @"QR Code Card";
        
        _viewIntroduceButtonAccount.viewIntroduce.labelChinese.text = @"账号绑定";
        _viewIntroduceButtonAccount.viewIntroduce.labelChineseEnglish.text = @"My Accounts";
        
        _viewIntroduceButtonBlackList.viewIntroduce.labelChinese.text = @"黑名单";
        _viewIntroduceButtonBlackList.viewIntroduce.labelChineseEnglish.text = @"Black List";
        
        _viewIntroduceButtonSetting.viewIntroduce.labelChinese.text = @"通用";
        _viewIntroduceButtonSetting.viewIntroduce.labelChineseEnglish.text = @"General";
        
        _viewIntroduceButtonBananaStory.viewIntroduce.labelChinese.text = @"香蕉故事";
        _viewIntroduceButtonBananaStory.viewIntroduce.labelChineseEnglish.text = @"Banana Story";
        
        _viewIntroduceButtonAbout.viewIntroduce.labelChinese.text = @"关于笨闹闹";
        CGRect framelabel = _viewIntroduceButtonAbout.viewIntroduce.labelChinese.frame;
        framelabel.size.width += 50;
        _viewIntroduceButtonAbout.viewIntroduce.labelChinese.frame = framelabel;
        _viewIntroduceButtonAbout.viewIntroduce.labelChineseEnglish.text = @"About banana clock";
        
        [_buttonLogOut setImageNormal:GetPngImage(@"setting_quita")];
        [_buttonLogOut setImageHighlited:GetPngImage(@"setting_quitb")];
    }else{
        _viewIntroduceButtonProfile.viewIntroduce.labelEnglish.text = @"Profile";
        _viewIntroduceButtonQR.viewIntroduce.labelEnglish.text = @"QR Code Card";
        _viewIntroduceButtonAccount.viewIntroduce.labelEnglish.text = @"My Accounts";
        _viewIntroduceButtonBlackList.viewIntroduce.labelEnglish.text = @"Black List";
        _viewIntroduceButtonSetting.viewIntroduce.labelEnglish.text = @"General";
        _viewIntroduceButtonBananaStory.viewIntroduce.labelEnglish.text = @"Banana Story";
        _viewIntroduceButtonAbout.viewIntroduce.labelEnglish.text = @"About banana clock";
        
        [_buttonLogOut setImageNormal:GetPngImage(@"setting_quitaEnglish")];
        [_buttonLogOut setImageHighlited:GetPngImage(@"setting_quitbEnglish")];
    }

    if (iPhone5||iPhone5_0) {
        [_scrollView setContentSize:CGSizeMake(320, 530)];
    }else{
        if (IOS_7) {
            [_scrollView setContentSize:CGSizeMake(320, 520)];
        }else{
            [_scrollView setContentSize:CGSizeMake(320, 530)];
        }
    }
    
    [self.view addSubview:_scrollView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"internationalMaskRelease" object:nil userInfo:nil];
}

- (void)buttonTouchUpInside:(UIButton_custom *)sender{
    if (self.boolPush) {
        return;
    }
    [self setBoolPushYES];
    if (sender.tag==0) {//个人信息
        [[activityView sharedActivityView] showHUD:-1];
        _personalDetails = [[lowooPersonalDetails alloc] init];
        _personalDetails.selfSetting = YES;
        _personalDetails.delegate = self;
        _personalDetails.dataSoure = self;
        [_personalDetails updataNetworkData];
        //[self.navigationController pushViewController:personalDetails animated:YES];
    }else if(sender.tag==1){//二维码
        lowooTwo_dimensionCodeCard *two_dimensionCodeCard = [[lowooTwo_dimensionCodeCard alloc]init];
        [self.navigationController pushViewController:two_dimensionCodeCard animated:YES];
    }else if(sender.tag==2){//账号绑定
        myAccount *accountBinding = [[myAccount alloc] init];
        [self.navigationController pushViewController:accountBinding animated:YES];
    }else if(sender.tag==3){//黑名单
        lowooBlackList *blackList = [[lowooBlackList alloc]init];
        [self.navigationController pushViewController:blackList animated:YES];
    }else if(sender.tag==4){//设置
        lowooAppSetting *appSetting = [[lowooAppSetting alloc]init];
        [self.navigationController pushViewController:appSetting animated:YES];
    }else if(sender.tag==5){//香蕉故事
        [self setHidesBottomBarWhenPushed:YES];
        lowooStory *bananaStory = [[lowooStory alloc]init];
        [self.navigationController pushViewController:bananaStory animated:YES];
    }else if(sender.tag==6){//关于
        lowooAboutBananaClock *aboutBananaClock = [[lowooAboutBananaClock alloc]init];
        [self.navigationController pushViewController:aboutBananaClock animated:YES];
    }
}

- (void)viewLoaded:(lowooPersonalDetails *)viewController{
    [self.navigationController pushViewController:_personalDetails animated:YES];
    _personalDetails.dataSoure = nil;
}

- (void)viewDismiss:(lowooPersonalDetails *)viewController{
    _personalDetails.delegate = nil;
    [_personalDetails removeFromParentViewController]; _personalDetails = nil;
}

- (void)logOutBtnTouchUpInside:(UIButton_custom *)sender{
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: [[NSUserDefaults standardUserDefaults] objectForKey:DeviceTokenRegisteredKEY],@"token", nil] requestType:offline];
    [APService setTags:[NSSet setWithObjects:@"offline",nil] alias:@"offline" callbackSelector:nil object:self];
    [[userModel sharedUserModel] bananaUserLogout];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];//注销闹铃
}





@end
