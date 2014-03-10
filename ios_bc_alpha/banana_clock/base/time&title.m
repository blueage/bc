//
//  time&title.m
//  banana_clock
//
//  Created by MAC on 13-6-25.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "time&title.h"
#import "lowooHTTPManager.h"
#import "lowooViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BASE.h"
#import "lowooLoginVC.h"
@class lowooAppDelegate;



@implementation time_title

static time_title *timeTitle = nil;

+ (time_title *)shareInstance{
    @synchronized(self){//线程保护  A线程调用到一般 B线程又调用
        if(timeTitle == nil){
            timeTitle = [[self alloc] init];
        }
    }
    return timeTitle;
}

+ (id)allocWithZone:(NSZone *)zone{
    if(timeTitle == nil){
        timeTitle = [super allocWithZone:zone];
    }
    return timeTitle;
}

- (id)copyWithZone:(NSZone *)zone{
    return timeTitle;
}

- (void)start{
    if (!_viewBase) {
        _viewBase = [[UIView alloc] initWithFrame:CGRectMake(50, 20, SCREEN_WIDTH-80, 40)];
        _viewBase.backgroundColor = [UIColor clearColor];
        _viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-80, 40)];
        _viewTitle.backgroundColor = [UIColor clearColor];
        _viewTime = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 40)];
        [_viewBase addSubview:_viewTitle];
        [_viewBase addSubview:_viewTime];
        //title
        _buttonTitle = [[UIButton alloc] initWithFrame:CGRectMake(5, 12, 21, 18)];
        [_buttonTitle setImage:GetPngImage(@"systemBoot") forState:UIControlStateNormal];
        [_buttonTitle setImage:GetPngImage(@"systemBoot") forState:UIControlEventTouchDown];
        _buttonTitle.backgroundColor = [UIColor clearColor];
        [_buttonTitle addTarget:self action:@selector(systemBootAction:) forControlEvents:UIControlEventTouchUpInside];
        //[_viewTitle addSubview:_buttonTitle];
        _viewButtonTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _viewButtonTitle.backgroundColor = [UIColor clearColor];
        [_viewTitle addSubview:_viewButtonTitle];
        [_viewButtonTitle addSubview:_buttonTitle];
        UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(systemBootAction:)];
        [_viewButtonTitle addGestureRecognizer:tap0];
        
        _labelTitle = [[THLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _labelTitle.backgroundColor = [UIColor clearColor];
        _labelTitle.textColor = [UIColor colorWithRed:110/255 green:116/255 blue:129/255 alpha:0.5];
        [_labelTitle setFont:[UIFont boldSystemFontOfSize:17]];
        [_labelTitle setTextAlignment:NSTextAlignmentCenter];
        _labelTitle.shadowColor = [UIColor blackColor];
        _labelTitle.shadowOffset = CGSizeMake(-0.5f, -0.5f);
        [_viewTitle addSubview:_labelTitle];
        //time
        _buttonTime = [[UIButton alloc] initWithFrame:CGRectMake(5, 12, 21, 18)];
        [_buttonTime setImage:GetPngImage(@"systemBoot") forState:UIControlStateNormal];
        [_buttonTime setImage:GetPngImage(@"systemBoot") forState:UIControlEventTouchDown];
        _buttonTime.backgroundColor = [UIColor clearColor];
        [_buttonTime addTarget:self action:@selector(systemBootAction:) forControlEvents:UIControlEventTouchUpInside];
        //[_viewTime addSubview:_buttonTime];
        
        _viewButtonTime = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _viewButtonTime.backgroundColor = [UIColor clearColor];
        [_viewTime addSubview:_viewButtonTime];
        [_viewButtonTime addSubview:_buttonTime];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(systemBootAction:)];
        [_viewButtonTime addGestureRecognizer:tap];

        
        
        _booltimeshow = NO;
        [_timerMedal invalidate];
        _timerMedal = Nil;
        _timerMedal = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timeMedal) userInfo:nil repeats:YES];
        [_timerAnimation invalidate];
        _timerAnimation = Nil;
        _count = 0;
        _timerAnimation = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(transitionCurUp) userInfo:nil repeats:YES];
        _boolanimation = YES;
        _mutableArrayStart = [[NSMutableArray alloc] init];
    }
}

- (void)transitionCurUp{
    _count ++;
    if (_boolanimation) {//显示时间
        if (_viewTitle.alpha == 1) {
            _viewTitle.alpha = 0;
            _viewTime.alpha = 1;
            
            CGSize sizeContent = CGSizeMake(320, 40);
            CGSize size = [_labelTime.text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24] constrainedToSize:sizeContent lineBreakMode:NSLineBreakByCharWrapping];
            
            CGRect frame = _labelTime.frame;
            frame.origin.x = (SCREEN_WIDTH - 100 - (size.width))/2;
            frame.size.width = size.width;
            _labelTime.frame = frame;
            
            [_labelName setFrame:CGRectMake(0, 20, 320 - 100, 20)];
            [_labelMiddle setFrame:CGRectMake(0, 7, 320 - 100, 26/1.5)];
            
//            CGRect frameButton = _buttonTime.frame;
//            frameButton.origin.x = CGRectGetMaxX(_labelTime.frame) + 5;
//            if (CGRectGetMaxX(_labelTime.frame)==0) {//无时间
//                frameButton.origin.x = 140 + 10;
//            }
//            _buttonTime.frame = frameButton;
            CGRect frameViewButton = _viewButtonTime.frame;
            frameViewButton.origin.x = CGRectGetMaxX(_labelTime.frame);
            if (CGRectGetMaxX(_labelTime.frame)==0) {//无时间
                frameViewButton.origin.x = 140 + 5;
            }
            _viewButtonTime.frame = frameViewButton;

        }else{
            if (_count%3 != 0) {
                return;
            }
            _viewTitle.alpha = 1;
            _viewTime.alpha = 0;
        }
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.4;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionFade;
        NSUInteger one = [[_viewBase subviews] indexOfObject:_viewTitle];
        NSUInteger two = [[_viewBase subviews] indexOfObject:_viewTime];
        [_viewBase exchangeSubviewAtIndex:one withSubviewAtIndex:two];
        [[_viewBase layer] addAnimation:animation forKey:@"animation"];
        [UIView commitAnimations];

        _booltimeshow = !_booltimeshow;
    }
    _count ++;
}

//显示标题
- (void)transitionToTitle{
    _boolanimation = NO;
    [_timerAnimation invalidate];
    _timerAnimation = nil;
    _viewTime.alpha = 0;
    _viewTitle.alpha = 1;
    _booltimeshow = YES;

    _booltimeshow = !_booltimeshow;
    
    [self performSelector:@selector(setanimation) withObject:nil afterDelay:5];
}

- (void)setanimation{
    if (![_timerAnimation isValid]) {
        _timerAnimation = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(transitionCurUp) userInfo:nil repeats:YES];
        [_timerAnimation fire];
    }
    _boolanimation = YES;
}

- (void)timeMedal{
    if (_labelMiddle.alpha == 1) {
        _labelMiddle.alpha =0;
    }else{
        _labelMiddle.alpha = 1;
    }
}


#pragma mark--------更新服务器时间---------实时更新
- (void)initUpdateServerTime:(NSNotification *)sender{
//    NSLog(@"%@",sender.userInfo);

    if ([BASE isNotNull:sender.userInfo]) {
        if ([BASE isNotNull:[sender.userInfo objectForKey:@"apply"]]) {
            if ([[sender.userInfo objectForKey:@"apply"] isKindOfClass:[NSDictionary class]]) {
                
                //最近联系人列表
                if ([BASE isNotNull:[[sender.userInfo objectForKey:@"apply"] objectForKey:@"recent"]]) {
                    if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"recent"] isKindOfClass:[NSArray class]]) {
                        if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"recent"] count]>0) {
                            [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:RecentFriendsList];
                        }
                    }
                }
                
                //成功添加好友
                if ([BASE isNotNull:[[sender.userInfo objectForKey:@"apply"] objectForKey:@"f_id"]]) {
                    if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"f_id"] isKindOfClass:[NSArray class]]) {
                        if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"f_id"] count]>0) {
                            [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:refreshFriendList];
                            lowooPOPAddedSuccessfully *add = [[lowooPOPAddedSuccessfully alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                            [[lowooAlertViewDemo sharedAlertViewManager] show:add];
                        }
                    }
                }
                
                //有好友请求
                if ([BASE isNotNull:[[sender.userInfo objectForKey:@"apply"] objectForKey:@"apli"]]) {
                    if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"apli"] isKindOfClass:[NSArray class]]) {
                        if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"apli"] count]>0) {
                            [[lowooMusic sharedLowooMusic] playShortMusic:@"message" Type:@"mp3"];//好友请求 播放音乐
                            [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:refreshFriendList];
                        }
                    }
                }
                
                
                
                
                //好友使用盾
                if ([BASE isNotNull:[[sender.userInfo objectForKey:@"apply"] objectForKey:@"shield"]]) {
                    if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"shield"] isKindOfClass:[NSArray class]]) {
                        if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"shield"] count]>0) {
                            for (NSDictionary *dictionary in [[sender.userInfo objectForKey:@"apply"] objectForKey:@"shield"]) {
                                lowooPOPShield *shield = [[lowooPOPShield alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                                [shield confirmDataWithDictionary:dictionary];
                                [[lowooAlertViewDemo sharedAlertViewManager] show:shield];
                            }
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"bananaNumberChange" object:Nil userInfo:[sender.userInfo objectForKey:@"apply"]];
                        }
                    }
                }
                
                //好友赖床
                if ([BASE isNotNull:[[sender.userInfo objectForKey:@"apply"] objectForKey:@"lazy"]]) {
                    if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"lazy"] isKindOfClass:[NSArray class]]) {
                        if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"lazy"] count]>0) {
                            for (NSDictionary *dictionary in [[sender.userInfo objectForKey:@"apply"] objectForKey:@"lazy"]) {
                                lowooPOPSlob *lazy = [[lowooPOPSlob alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                                [lazy confirmDataWithDictionary:dictionary];
                                [[lowooAlertViewDemo sharedAlertViewManager] show:lazy];
                            }
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"bananaNumberChange" object:nil userInfo:[sender.userInfo objectForKey:@"apply"]];
                        }
                    }
                }
                //好友起床成功
                if ([BASE isNotNull:[[sender.userInfo objectForKey:@"apply"] objectForKey:@"getup"]]) {
                    if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"getup"] isKindOfClass:[NSArray class]]) {
                        if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"getup"] count]>0) {
                            for (NSDictionary *dictionary in [[sender.userInfo objectForKey:@"apply"] objectForKey:@"getup"]) {
                                lowooPOPHadGetUp *getup = [[lowooPOPHadGetUp alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                                [getup confirmDataWithDictionary:dictionary];
                                [[lowooAlertViewDemo sharedAlertViewManager] show:getup];
                            }
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"bananaNumberChange" object:Nil userInfo:[sender.userInfo objectForKey:@"apply"]];
                        }
                    }
                }
            }
        }
        //弹出成就窗口 更新金币数量
        if ([BASE isNotNull:[[sender.userInfo objectForKey:@"apply"] objectForKey:@"achieve"]]) {
            if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"achieve"] isKindOfClass:[NSArray class]]) {
                if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"achieve"] count]>0) {
                    for (NSDictionary *dictionary in [[sender.userInfo objectForKey:@"apply"] objectForKey:@"achieve"]) {
                        lowooPOPAwardedAchievement *achievement = [[lowooPOPAwardedAchievement alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                        modelAchievement *achieve = [[modelAchievement alloc] init];
                        achieve.JSONdictionary = dictionary;
                        [achievement confirmAchieve:achieve];
                        [[lowooAlertViewDemo sharedAlertViewManager] show:achievement];
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"bananaNumberChange" object:Nil userInfo:[sender.userInfo objectForKey:@"apply"]];
                    
                    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:nil requestType:refreshFriendList];
                    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:nil requestType:RecentFriendsList];
                }
            }
        }
        
        
        //弹出勋章窗口 更新金币数量
        if ([BASE isNotNull:[[sender.userInfo objectForKey:@"apply"] objectForKey:@"medal"]]) {
            if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"medal"] isKindOfClass:[NSArray class]]) {
                if ([[[sender.userInfo objectForKey:@"apply"] objectForKey:@"medal"] count]>0) {
                    for (NSDictionary *dictionary in [[sender.userInfo objectForKey:@"apply"] objectForKey:@"medal"]) {
                        lowooPOPAwardedMedals *medal = [[lowooPOPAwardedMedals alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                        modelMedal *medalModel = [[modelMedal alloc] init];
                        medalModel.JSONdictionary = dictionary;
                        [medal confirmMedal:medalModel];
                        [[lowooAlertViewDemo sharedAlertViewManager] show:medal];
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"bananaNumberChange" object:Nil userInfo:[sender.userInfo objectForKey:@"apply"]];
                    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:nil requestType:refreshFriendList];
                    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:nil requestType:RecentFriendsList];
                }
            }
        }
        
        //推送
        if ([BASE isNotNull:[sender.userInfo objectForKey:@"token"]]) {
            if ([[sender.userInfo objectForKey:@"token"] isKindOfClass:[NSArray class]]) {
                if ([[sender.userInfo  objectForKey:@"token"] count]>0) {
                    //叫醒处理
                    NSLog(@"%@",sender.userInfo);
                    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"getupGame" object:nil userInfo:[[sender.userInfo objectForKey:@"token"] objectAtIndex:0]];
                }
            }
        }
        
        
        //下线推送
        if ([BASE isNotNull:[sender.userInfo objectForKey:@"quit"]]) {
            if ([[sender.userInfo objectForKey:@"quit"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dictionary in [sender.userInfo objectForKey:@"quit"]) {
                    if (LANGUAGE_CHINESE) {
                        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"你已离线" message:@"该账号已在其他设备上登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [alertview show];
                    }else{
                        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Offline" message:@"This account has been logged on other devices" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alertview show];
                    }
                    
                    [[userModel sharedUserModel] bananaUserLogout];
                }
            }
        }
        
        
        
        //更新时间
        if ([BASE isNotNull:[sender.userInfo objectForKey:@"list"]]) {
            NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
            NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
            
            [_imageViewleft removeFromSuperview]; _imageViewleft = nil;
            [_imageViewRight removeFromSuperview]; _imageViewRight = nil;
            int time = [[sender.userInfo objectForKey:@"list"] doubleValue];
            time = time - localTimeZone.secondsFromGMT + timeZone.secondsFromGMT;
            
            if (sender!=nil) {
                NSInteger int1 = time/36000;
                time = time%36000;
                NSInteger int2 = time/3600;
                time = time%3600;
                NSInteger int3 = time/600;
                time = time%600;
                NSInteger int4 = time/60;
                
                if (!_labelTime) {
                    _labelTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH-100, 30)];
                    [_labelTime setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24]];
                    _labelTime.backgroundColor = [UIColor clearColor];
                    [_labelTime setTextAlignment:NSTextAlignmentCenter];
                    _labelTime.alpha = 0.8;
                    [_viewTime addSubview:_labelTime];
                }
                //_labelTime.text = nil;
                _labelTime.text = [NSString stringWithFormat:@"%d%d %d%d",int1,int2,int3,int4];
                
                
                if (!_labelName) {
                    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH-100, 20)];
                    _labelName.text = @"banana clock";
                    _labelName.backgroundColor = [UIColor clearColor];
                    [_labelName setFont:[UIFont fontWithName:@"HelveticaNeue" size:9]];
                    [_labelName setTextAlignment:NSTextAlignmentCenter];
                    _labelName.alpha = 0.8;
                    [_viewTime addSubview:_labelName];
                }
                
            }
            
        }else{
            [_labelTime removeFromSuperview]; _labelTime = nil;
            [_labelName removeFromSuperview]; _labelName =nil;
            if (_imageViewleft==nil) {
                _imageViewleft = [[UIImageView alloc]initWithFrame:CGRectMake(79, 10, 26, 26)];
                [_imageViewleft setImage:GetPngImage(@"t_off")];
                [_viewTime addSubview:_imageViewleft];
            }
            if (_imageViewRight==nil) {
                _imageViewRight = [[UIImageView alloc]initWithFrame:CGRectMake(114, 10, 26, 26)];
                [_imageViewRight setImage:GetPngImage(@"t_off")];
                [_viewTime addSubview:_imageViewRight];
            }
        }
        
        if (!_labelMiddle) {
            _labelMiddle = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 320, 26/1.5)];
            _labelMiddle.textAlignment = NSTextAlignmentCenter;
            _labelMiddle.backgroundColor = [UIColor clearColor];
            [_labelMiddle setFont:[UIFont boldSystemFontOfSize:20]];
            _labelMiddle.text = @":";
            [_viewTime addSubview:_labelMiddle];
        }

    }
}

- (double )dateToTimestamp:(NSInteger )hour minute:(NSInteger )minute{
    NSDate *date = [NSDate date];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    [components setHour:hour];
    [components setMinute:minute];
    
    NSDate *newData = [calendar dateFromComponents:components];
    double string = (long)[newData timeIntervalSince1970];
    return string;
}

- (void)systemBootAction:(UIButton *)button{
    [self setHelp];
    
    if ([_delegate respondsToSelector:@selector(systemBootAction)]) {
        [_delegate systemBootAction];
    }
}

- (void)setHelp{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:HELP_CENTER] boolValue]) {
        if (_labelTitle.text.length<1) {
            return;
        }

        if (_buttonTime.hidden) {//显示
            if (_buttonTime.frame.size.height<18) {
                _buttonTime.hidden = NO; _buttonTime.alpha = 1;
                _buttonTitle.hidden = NO; _buttonTitle.alpha = 1;
//                _buttonTime.frame = CGRectMake(154.474, 20.1, 2.1, 1.8);
                [UIView animateWithDuration:0.3
                                 animations:^{
                                     _buttonTime.alpha = 1;
                                     _buttonTitle.alpha = 1;
                                     _buttonTime.transform = CGAffineTransformScale(_buttonTime.transform, 10, 10);
                                     _buttonTitle.transform = CGAffineTransformScale(_buttonTitle.transform, 10, 10);
                                 } completion:^(BOOL finished) {
                                     
                                 }];
            }


        }else{//隐藏
            if (!_buttonTime.hidden) {
                if (_buttonTime.frame.size.height>17) {
                    [UIView animateWithDuration:0.3
                                     animations:^{
                                         _buttonTime.transform = CGAffineTransformScale(_buttonTime.transform, 0.1, 0.1);
                                         _buttonTitle.transform = CGAffineTransformScale(_buttonTitle.transform, 0.1, 0.1);
                                         _buttonTime.alpha = 0;
                                         _buttonTitle.alpha = 0;
                                     } completion:^(BOOL finished) {
                                         _buttonTime.hidden = YES;
                                         _buttonTitle.hidden = YES;
                                     }];
                }

            }else{

            }

        }
        

    }else{//隐藏
        if (_buttonTime.alpha == 0) {
            _buttonTime.hidden = ![[[NSUserDefaults standardUserDefaults] objectForKey:HELP_CENTER] boolValue];
            _buttonTitle.hidden = ![[[NSUserDefaults standardUserDefaults] objectForKey:HELP_CENTER] boolValue];
        }else{
            [UIView animateWithDuration:0.3
                             animations:^{
                                 _buttonTime.transform = CGAffineTransformScale(_buttonTime.transform, 0.1, 0.1);
                                 _buttonTitle.transform = CGAffineTransformScale(_buttonTitle.transform, 0.1, 0.1);
                                 _buttonTime.alpha = 0;
                                 _buttonTitle.alpha = 0;
                             } completion:^(BOOL finished) {
                                 _buttonTime.hidden = ![[[NSUserDefaults standardUserDefaults] objectForKey:HELP_CENTER] boolValue];
                                 _buttonTitle.hidden = ![[[NSUserDefaults standardUserDefaults] objectForKey:HELP_CENTER] boolValue];
                             }];
        }
    }
}

@end
