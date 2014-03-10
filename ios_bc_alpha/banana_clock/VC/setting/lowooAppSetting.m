//
//  lowooAppSetting.m
//  banana_clock
//
//  Created by MAC on 13-3-18.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooAppSetting.h"

#define languageHeight  0
#define appSettingViewHeight 44

@implementation lowooAppSetting

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    [self.imageViewRight setImage:GetPngImage(@"topicon05")];
    self.stringTitle = @"GENERAL";
    [self changeTitle];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeHUDview) name:@"internationalMaskRelease" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _framScrollView = CGRectMake(0, -3, SCREEN_WIDTH, SCREEN_HEIGHT-59-53);
    _framLanguage = CGRectMake(0, SCREEN_HEIGHT-30, 320, SCREEN_HEIGHT);
    
    [self initScrollView];
    [self languageView];
}

- (void)initScrollView{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:_framScrollView];
        _scrollview.backgroundColor = [UIColor clearColor];
        if (iPhone5_0||iPhone5) {
            _scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, _scrollview.frame.size.height-40);
        }else{
            _scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-90);
        }
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        
        //声音
        _viewButtonSound = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, appSettingViewHeight, 276, 55)];
        _viewButtonSound.button.userInteractionEnabled = NO;
        [_scrollview addSubview:_viewButtonSound];
        _switchSound = [[UISwitch alloc]initWithFrame:CGRectMake(209+[BASE height15_ISO7], 12+appSettingViewHeight, 79, 27)];
        _switchSound.tag = 0;
        [_switchSound addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [_scrollview addSubview:_switchSound];
        if ([[lowooMusic sharedLowooMusic] isMusicAllow]) {
            [_switchSound setOn:YES];
        }else{
            [_switchSound setOn:NO];
        }
        
        //开场动画
        _viewButtonMove = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, appSettingViewHeight+1*54, 276, 55)];
        [_scrollview addSubview:_viewButtonMove];
        _viewButtonMove.button.userInteractionEnabled = NO;
        _switchMove = [[UISwitch alloc] initWithFrame:CGRectMake(209+[BASE height15_ISO7], 12+appSettingViewHeight+1*54, 79, 27)];
        _switchMove.tag = 4;
        [_switchMove addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [_switchMove setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:OPENING_ANIMATION] boolValue]];
        [_scrollview addSubview:_switchMove];
        
        //help
        _viewButtonHelp = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, appSettingViewHeight+2*54, 276, 55)];
        [_scrollview addSubview:_viewButtonHelp];
        _viewButtonHelp.button.userInteractionEnabled = NO;
        _switchHelp = [[UISwitch alloc] initWithFrame:CGRectMake(209+[BASE height15_ISO7], 12+appSettingViewHeight+2*54, 79, 27)];
        _switchHelp.tag = 5;
        [_switchHelp addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [_switchHelp setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:HELP_CENTER] boolValue]];
        [_scrollview addSubview:_switchHelp];
        
        //国际化
        _viewButtonInternational = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, appSettingViewHeight+3*54+10, 276, 55)];
        _viewButtonInternational.button.userInteractionEnabled = YES;
        [_viewButtonInternational.button addTarget:self action:@selector(internationalAction) forControlEvents:UIControlEventTouchUpInside];
        [_scrollview addSubview:_viewButtonInternational];

        _viewButtonInternational.imageView.image = GetPngImage(@"jiantou");
        
        [self.view addSubview:_scrollview];
    }

    
    
    if (LANGUAGE_CHINESE) {
        _viewButtonSound.viewIntroduce.labelChinese.text = @"音效";
        _viewButtonSound.viewIntroduce.labelChineseEnglish.text = @"Sound";
        
        _viewButtonHelp.viewIntroduce.labelChinese.text = @"帮助中心";
        _viewButtonHelp.viewIntroduce.labelChineseEnglish.text = @"Help Center";

        _viewButtonMove.viewIntroduce.labelChinese.text = @"开场动画";
        _viewButtonMove.viewIntroduce.labelChineseEnglish.text = @"Opening Animation";
        
        _viewButtonInternational.viewIntroduce.labelChinese.text = @"语言";
        _viewButtonInternational.viewIntroduce.labelChineseEnglish.text = @"Language";
    }else{
        _viewButtonSound.viewIntroduce.labelEnglish.text = @"Sound";
        _viewButtonHelp.viewIntroduce.labelEnglish.text = @"Help Center";
        _viewButtonMove.viewIntroduce.labelEnglish.text = @"Opening Animation";
        _viewButtonInternational.viewIntroduce.labelEnglish.text = @"Language";
    }
}

- (void)languageView{
    _viewlanguage = nil;
    _viewlanguage = [[UIView alloc] initWithFrame:_framLanguage];
    [self.view addSubview:_viewlanguage];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT-100)];
    [scrollView setContentSize:CGSizeMake(320, SCREEN_HEIGHT-100+1)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [_viewlanguage addSubview:scrollView];
    
    //中文
    _viewButtonChinese = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 70+languageHeight, 276, 55)];
    _viewButtonChinese.button.userInteractionEnabled = YES;
    _viewButtonChinese.button.tag = 0 ;
    [_viewButtonChinese.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _viewButtonChinese.viewIntroduce.labelEnglish.text = @"简体中文";
    [_viewButtonChinese.imageView setFrame:CGRectMake(237, _viewButtonChinese.imageView.frame.origin.y, 15, 15)];
    _viewButtonChinese.imageView.image = GetPngImage(@"week_selected");
    [scrollView addSubview:_viewButtonChinese];

    //英文
    _viewButtonEnglish = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 70+54+languageHeight, 276, 55)];
    _viewButtonEnglish.button.userInteractionEnabled = YES;
    _viewButtonEnglish.button.tag = 1;
    [_viewButtonEnglish.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _viewButtonEnglish.viewIntroduce.labelEnglish.text = @"English";
    [_viewButtonEnglish.imageView setFrame:CGRectMake(237, _viewButtonEnglish.imageView.frame.origin.y, 15, 15)];
    _viewButtonEnglish.imageView.image = GetPngImage(@"week_selected");
    [scrollView addSubview:_viewButtonEnglish];
    

    
    
    if (LANGUAGE_CHINESE) {
        _viewButtonChinese.imageView.hidden = NO;
        _viewButtonEnglish.imageView.hidden = YES;
    }else{
        _viewButtonEnglish.imageView.hidden = NO;
        _viewButtonChinese.imageView.hidden = YES;
    }
}

#pragma mark ----------- 切换语言 -------------
- (void)buttonAction:(UIButton_custom *)sender{
    if (sender.tag==0) {
        if (_viewButtonChinese.imageView.hidden == YES) {
            _viewButtonChinese.imageView.hidden = NO;
            _viewButtonEnglish.imageView.hidden = YES;
            [self rightButtonTouchUpInside];
        }
    }else if (sender.tag == 1){
        if (_viewButtonEnglish.imageView.hidden == YES) {
            _viewButtonChinese.imageView.hidden = YES;
            _viewButtonEnglish.imageView.hidden = NO;
            [self rightButtonTouchUpInside];
        }
    }
}

- (void)internationalAction{
    self.stringTitle = @"LANGUAGE";
    [self changeTitle];
    
    _framScrollView.origin.y = _framScrollView.origin.y - SCREEN_HEIGHT;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _scrollview.frame = _framScrollView;
                     } completion:^(BOOL finished) {
                         
                     }];
    

    _framLanguage.origin.y = _framLanguage.origin.y - SCREEN_HEIGHT;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _viewlanguage.frame = _framLanguage;
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

- (void)removeHUDview{
    [liboTOOLS dismissHUD];
    [self initScrollView];
    _framScrollView.origin.y = _framScrollView.origin.y + SCREEN_HEIGHT;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _scrollview.frame = _framScrollView;
                     } completion:^(BOOL finished) {
                         
                     }];
    
    
    _framLanguage.origin.y = _framLanguage.origin.y + SCREEN_HEIGHT;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _viewlanguage.frame = _framLanguage;
                     } completion:^(BOOL finished) {
                         
                     }];
    
    
    [self.imageViewRight setFrame:CGRectMake(8+[BASE navigationBarButton], 9, 23, 23)];
    [self.imageViewRight setImage:GetPngImage(@"topicon05")];
    self.stringTitle = @"GENERAL";
    [self changeTitle];
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.viewRightButton.alpha = 0;
                     } completion:^(BOOL finished) {
                         self.viewRightButton.hidden = YES;
                     }];
}

- (void)doChangelanguage{
    
    
    if (LANGUAGE_CHINESE) {
        [[NSUserDefaults standardUserDefaults] setObject:@"english" forKey:@"international"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"chinese" forKey:@"international"];
    }
    
    //单独线程  可能不管用
    [[NSNotificationCenter defaultCenter] postNotificationName:@"international" object:nil userInfo:nil];
    
    self.stringTitle = @"LANGUAGE";
    [self changeTitle];
}

- (void)rightButtonTouchUpInside{
    
    if (_viewButtonChinese.imageView.hidden == NO) {
        [liboTOOLS showHUD:@"正在设置语言..."];
    }else{
        [liboTOOLS showHUD:@"Setting Language..."];
    }
    
    [self performSelector:@selector(doChangelanguage) withObject:nil afterDelay:.5];
}

#pragma mark-------leftBtnPressed-------------
- (void)leftButtonDidTouchedUpInside{
    if (_scrollview.frame.origin.y<-20) {
        _framScrollView.origin.y = _framScrollView.origin.y + SCREEN_HEIGHT;
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _scrollview.frame = _framScrollView;
                         } completion:^(BOOL finished) {
                             
                         }];
        

        _framLanguage.origin.y = _framLanguage.origin.y + SCREEN_HEIGHT;
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _viewlanguage.frame = _framLanguage;
                         } completion:^(BOOL finished) {
                             
                         }];
        

        [self.imageViewRight setFrame:CGRectMake(8+[BASE navigationBarButton], 9, 23, 23)];
        [self.imageViewRight setImage:GetPngImage(@"topicon05")];
        self.stringTitle = @"GENERAL";
        [self changeTitle];
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.viewRightButton.alpha = 0;
                         } completion:^(BOOL finished) {
                             self.viewRightButton.hidden = YES;
                         }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)internationalMaskRelease{
    self.stringTitle = @"GENERAL";
    [self changeTitle];
    [liboTOOLS dismissHUD];
}

-(void)switchAction:(UISwitch *)sender{
    switch (sender.tag) {
        case 0://声音
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:sender.on] forKey:MUSIC_ALLOW];
            break;
        case 1://勋章
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:sender.on] forKey:MEDAL_HIDDEN];
            [[NSNotificationCenter defaultCenter] postNotificationName:MEDAL_HIDDEN object:[NSNumber numberWithBool:sender.on] userInfo:nil];
            break;
        case 2://显示好友叫醒时间段
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:sender.on] forKey:TIME_HIDDEN];
            [[NSNotificationCenter defaultCenter] postNotificationName:TIME_HIDDEN object:[NSNumber numberWithBool:sender.on] userInfo:nil];
            break;
        case 3://点击音效
            //[[NSUserDefaults standardUserDefaults] setBool:[NSNumber numberWithBool:sender.on] forKey:BUTTON_SOUND];
        case 4://开始动画
            [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:OPENING_ANIMATION];
            break;
        case 5://帮助
            [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:HELP_CENTER];
            [[time_title shareInstance] setHelp];
            break;
        default:
            break;
    }
}





@end
