//
//  clockVC.m
//  banana_clock
//
//  Created by Lowoo on 2/16/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import "clockVC.h"

static const NSInteger distanceEnd = 4;
static const NSInteger distanceTouch = 3;

static const NSInteger startDistance = 3;//红色按钮矫正数值
static const NSInteger endDistance = 3;

@interface clockVC ()

@end

@implementation clockVC


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.viewLeftButton.hidden = YES;
    [self initNavigationBar];
    self.stringTitle = @"TIME SETTING";
    [self changeTitle];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.viewLeftButton.hidden = YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnceSystemBootEnd) name:@"systemBootEnd" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setcalledtime:) name:@"setcalledtime" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //程序公用部分，若改变位置可能会出现父view等还未初始化问题
    _tiemrRetime = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [_tiemrRetime fire];
    
    
    if (iPhone5||iPhone5_0) {
        _imageViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, -60, SCREEN_WIDTH, 568)];
        [_imageViewBack setImage:GetPngImage(@"moonBack5")];
    }else{
        _imageViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, -60, SCREEN_WIDTH, 480)];
        [_imageViewBack setImage:GetPngImage(@"moonBack4")];
    }
    self.imageViewBack.alpha = 0;
    [self.view addSubview:_imageViewBack];
    [self setTimeClock];
    [self updataNetworkData];
#pragma mark ---------------- 注册运行引导动画 -----------
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SYSTEM_BOOT_0] boolValue]) {//新手引导，只出现一次
        //注册成功音乐
        [[lowooMusic sharedLowooMusic] playShortMusic:@"start" Type:@"mp3"];
        [[time_title shareInstance] setHelp];
        _boot = [[systemBoot alloc] init];
        [_boot addOnceView:0];
        self.imageViewBubble = [[UIImageView alloc] initWithFrame:CGRectZero];
        if (iPhone5||iPhone5_0) {
            self.imageViewBubble.frame = CGRectMake(30, 110, 295/2, 259/2);
        }else{
            self.imageViewBubble.frame = CGRectMake(30, 70, 295/2, 259/2);
        }
        self.viewMask = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self.viewMask];
        
        self.imageViewBubble.image = GetPngImage(@"bubble");
        [self.view addSubview:self.imageViewBubble];
        [self.view bringSubviewToFront:self.imageViewBubble];
    }
}

- (void)updataNetworkData{
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: self.memoryAddress, MEMORY_ADDRESS, @"yes", @"self", nil] requestType:achievelist];
}

- (void)setcalledtime:(NSNotification *)notification{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gameEnd" object:nil];
}

- (void)memoryNotificationAction:(NSNotification *)notification{
    modelUserDetail *user = notification.object;
    
    //时区转换
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    NSInteger start = [user.timeStart intValue] - timeZone.secondsFromGMT + localTimeZone.secondsFromGMT;
    NSInteger stop = [user.timeStop intValue] - timeZone.secondsFromGMT + localTimeZone.secondsFromGMT;
    if (start<0) {
        start = start + 86400;
    }
    if (stop<0) {
        stop = stop + 86400;
    }

    start = start%100000;
    stop = stop%100000;
    
    NSInteger beginHour = start/3600;
    NSInteger beginMinute = start%3600/60;
    NSInteger endHour = stop/3600;
    NSInteger endMinute = stop%3600/60;
    
    NSInteger startCount = beginHour*12 +beginMinute/5;
    NSInteger endCount = endHour*12 +endMinute/5;
   
    [self initCircleViewStartTime:endCount endTime:startCount];
    [self setRepeatWeek:user.arrayRepeat repeatSwitch:user.boolMoon];
    
  
    //初始动画
    if (user.boolMoon) {
        if (IOS_7) {
            [UIView animateWithDuration:0.8
                                  delay:0
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:0.9
                                options:UIViewAnimationCurveEaseOut
                             animations:^{
                                 _imageViewBack.alpha = 0.0f;
                                 self.viewCircle.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
                             } completion:^(BOOL finished) {
                                 
                             }];
        }else{
            [UIView animateWithDuration:0.8
                             animations:^{
                                 _imageViewBack.alpha = 0.0f;
                                 self.viewCircle.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
                             } completion:^(BOOL finished) {
                                 
                             }];
        }
    }else{
        if (IOS_7) {
            [UIView animateWithDuration:0.8
                                  delay:0
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:0.9
                                options:UIViewAnimationCurveEaseOut
                             animations:^{
                                 _imageViewBack.alpha = 1.0f;
                                 self.viewCircle.transform = CGAffineTransformMakeTranslation(0, 0);
                             } completion:^(BOOL finished) {
                                 
                             }];
        }else{
            [UIView animateWithDuration:0.8
                             animations:^{
                                 _imageViewBack.alpha = 1.0f;
                                 self.viewCircle.transform = CGAffineTransformMakeTranslation(0, 0);
                             } completion:^(BOOL finished) {
                                 
                             }];
        }
    }

}

- (void)offline{
    [_tiemrRetime invalidate]; _tiemrRetime = nil;
}

- (void)OnceSystemBootEnd{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SYSTEM_BOOT_0] boolValue]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SYSTEM_BOOT_0];
        _boot = [[systemBoot alloc] init];
        [_boot addBaseView:0];
        [[time_title shareInstance] setHelp];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"systemBootEnd" object:nil];
    self.buttonSun.userInteractionEnabled = YES;
    self.viewRepeat.userInteractionEnabled = YES;
}

//实时更新
- (void)updateTime{
    if (USERID && ![USERID isEqualToString:@""]) {
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: [[NSUserDefaults standardUserDefaults] objectForKey:DeviceTokenRegisteredKEY],@"token", nil] requestType:retime];
    }
}

- (void)setTimeClock{
    self.circle = [[circleView alloc] initWithFrame:CGRectMake(0, 0, 491/2, 491/2)];
    self.circle.delegate = self;
    self.circle.dataSource = self;
    //半径
    self.circle.radius = 90;
    self.circle.imageViewStart = [[circleImageView alloc] initWithFrame:CGRectMake(0, 0, 65/2, 125/2)];
    self.circle.imageViewEnd = [[circleImageView alloc] initWithFrame:CGRectMake(0, 0, 75/2, 125/2)];
    //按钮图片
    self.circle.imageViewProgress = [[circleImageView alloc] initWithFrame:CGRectMake(0, 0, 290/2, 143/2)];
    self.circle.imageViewProgress.radius = 84;
    NSMutableArray *arrayImages = [[NSMutableArray alloc] init];
    for (int t=0; t<24; t++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"huadong%02d.png",t]];
        [arrayImages insertObject:image atIndex:t];
    }
    self.circle.imageViewProgress.animationImages = arrayImages;
    
    self.viewCircle =[[UIView alloc] initWithFrame:CGRectZero];
    if (iPhone5 || iPhone5_0) {
        [self.viewCircle setFrame:CGRectMake((320-491/2)/2, 50-SCREEN_HEIGHT, 320, 320)];
    }else{
        [self.viewCircle setFrame:CGRectMake((320-491/2)/2, 30-SCREEN_HEIGHT, 320, 320)];
    }
    [self.viewCircle addSubview:self.circle];
    [self.view addSubview:self.viewCircle];
    
    //显示大时间
    self.viewStart = [[UIView alloc] initWithFrame:CGRectZero];
    if (iPhone5_0||iPhone5) {
        self.viewStart.frame = CGRectMake(69, 122, 38/2*4+20/2, 51/2);
    }else{
        self.viewStart.frame = CGRectMake(69, 122, 38/2*4+20/2, 51/2);
    }
    [self.viewCircle addSubview:self.viewStart];
    
    //显示小时间
    self.viewEnd = [[UIView alloc] initWithFrame:CGRectZero];
    if (iPhone5||iPhone5_0) {
        self.viewEnd.frame = CGRectMake(69, 92, 38/2*4+20/2, 51/2);
    }else{
        self.viewEnd.frame = CGRectMake(69, 92, 38/2*4+20/2, 51/2);
    }
    [self.viewCircle addSubview:self.viewEnd];
    
    self.imageView01 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38/2, 51/2)];
    [self.viewStart addSubview:self.imageView01];
    self.imageView02 = [[UIImageView alloc] initWithFrame:CGRectMake(38/2, 0, 38/2, 51/2)];
    [self.viewStart addSubview:self.imageView02];
    self.imageView03 = [[UIImageView alloc] initWithFrame:CGRectMake(38/2*2, 5, 20/2, 39/2)];
    self.imageView03.image = [UIImage imageNamed:@"maohao.png"];
    [self.viewStart addSubview:self.imageView03];
    self.imageView04 = [[UIImageView alloc] initWithFrame:CGRectMake(38/2*2+20/2, 0, 38/2, 51/2)];
    [self.viewStart addSubview:self.imageView04];
    self.imageView05 = [[UIImageView alloc] initWithFrame:CGRectMake(38/2*3+20/2, 0, 38/2, 51/2)];
    [self.viewStart addSubview:self.imageView05];
    
    self.imageView11 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38/2, 51/2)];
    [self.viewEnd addSubview:self.imageView11];
    self.imageView12 = [[UIImageView alloc] initWithFrame:CGRectMake(38/2, 0, 38/2, 51/2)];
    [self.viewEnd addSubview:self.imageView12];
    self.imageView13 = [[UIImageView alloc] initWithFrame:CGRectMake(38/2*2, 5, 20/2, 39/2)];
    self.imageView13.image = [UIImage imageNamed:@"maohao.png"];
    [self.viewEnd addSubview:self.imageView13];
    self.imageView14 = [[UIImageView alloc] initWithFrame:CGRectMake(38/2*2+20/2, 0, 38/2, 51/2)];
    [self.viewEnd addSubview:self.imageView14];
    self.imageView15 = [[UIImageView alloc] initWithFrame:CGRectMake(38/2*3+20/2, 0, 38/2, 51/2)];
    [self.viewEnd addSubview:self.imageView15];
}

- (void)initCircleViewStartTime:(NSInteger)timeStart endTime:(NSInteger)timeEnd{
    self.startOldNum = timeStart;
    self.endOldNum = timeEnd;
    if (timeStart>timeEnd) {
        self.circle.endDistance = timeStart - (timeEnd-distanceEnd);
    }else{
        self.circle.endDistance = 288 - (timeEnd-distanceEnd) +timeStart;
    }
    
    //设置进度条初始长度
    NSInteger distance = timeStart-timeEnd;
    if (distance<0) {
        distance += 288;
    }

    NSInteger index = distance-1;
    if (index>=0 && index<=23) {
        self.circle.imageViewProgress.image = [self.circle.imageViewProgress.animationImages objectAtIndex:index];
        //设置触摸区域
        [self.circle loadViewWithStartTime:timeStart+startDistance EndTime:timeStart-endDistance-distance];
    }
    self.distanceTure = distance+startDistance+endDistance;

    self.startOld_radian = M_PI;
    
    self.startScrollNum = 500;
    if (timeStart>12*12) {
        timeStart -= 144;
        self.startScrollNum ++;
    }
    if (timeStart<72) {
        self.startOld_radian = ((72.0-(float)timeStart)/72.0)*M_PI;
    }else{
        self.startOld_radian = M_PI + ((144.0 - (float)timeStart)/72.0)*M_PI;
    }
    self.endScrollNum = 500;
    if (timeEnd>12*12) {
        timeEnd -= 144;
        self.endScrollNum ++;
    }
    if (timeEnd<72) {
        self.endOld_radian = ((72.0-(float)timeEnd)/72.0)*M_PI;
    }else{
        self.endOld_radian = M_PI + ((144.0 - (float)timeEnd)/72.0)*M_PI;
    }
    
    self.startOldNum = timeStart;
    self.endOldNum = timeEnd;
    if (timeStart == 0) {
        self.boolStart00 = YES;
    }
    if (timeEnd == 0) {
        self.boolEnd00 = YES;
    }
    if ((timeEnd-endDistance)<0) {
        self.endScrollNum --;
    }
    [self setUpTime:timeEnd-endDistance];
    [self setDownTime:timeStart+startDistance];
}

#define buttonSize CGSizeMake(80/2, 100/2)
- (void)setRepeatWeek:(NSArray *)week repeatSwitch:(BOOL)moon{
    self.arrayHTTP = [NSMutableArray arrayWithArray:week];
    self.viewRepeat = [[UIView alloc] initWithFrame:CGRectZero];
    if (iPhone5_0||iPhone5) {
        self.viewRepeat.frame = CGRectMake(10, 300, 611/2, 232/2);
    }else{
        self.viewRepeat.frame = CGRectMake(10, 240, 611/2, 232/2);
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){CGPointZero,611/2,232/2}];
    imageView.image = GetPngImage(@"repeatBack");
    [self.viewRepeat addSubview:imageView];
    [self.view addSubview:self.viewRepeat];
    
    self.arrayImageViews = [[NSMutableArray alloc] init];
    for (int i=0; i<7; i++) {
        UIImageViewRepeat *imageView = [[UIImageViewRepeat alloc] initWithFrame:CGRectMake(buttonSize.width*i+(i/5)*3 + 10, 55, buttonSize.width, buttonSize.height)];
        imageView.tag = i;
        imageView.delegate = self;
        imageView.imageUp = [UIImage imageNamed:[NSString stringWithFormat:@"repeatBtn%da.png",i]];
        imageView.imageDown = [UIImage imageNamed:[NSString stringWithFormat:@"repeatBtn%db.png",i]];
        [self.viewRepeat addSubview:imageView];
        [self.arrayImageViews insertObject:imageView atIndex:i];
        
        if ([[week objectAtIndex:i] intValue]==1) {
            imageView.image = imageView.imageDown;
            imageView.boolTouchDown = YES;
        }else{
            imageView.image = imageView.imageUp;
            imageView.boolTouchDown = NO;
        }
    }
    
    self.buttonSun = [[UIButtonRepeat alloc] initWithFrame:CGRectZero];
    if (iPhone5||iPhone5_0) {
        self.buttonSun.frame = CGRectMake(30, 305, 96/2, 96/2);
    }else{
        self.buttonSun.frame = CGRectMake(30, 245, 96/2, 96/2);
    }
    self.buttonSun.dictionaryImages = @{@"upa":@"repeatSuna",
                                        @"upb":@"repeatSunb",
                                        @"downa":@"repeatMoona",
                                        @"downb":@"repeatMoonb"};
    self.buttonSun.highlighted = YES;
    [self.buttonSun addTarget:self action:@selector(buttonSunTouchupInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonSun];

    if (iPhone5||iPhone5_0) {
        self.imageViewPeople = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 275)];
    }else{
        self.imageViewPeople = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 320, 275)];
    }
    self.imageViewPeople.image = GetPngImage(@"moonPeople");
    [self.view addSubview:self.imageViewPeople];
    self.imageViewPeople.hidden = YES;
    
    if (moon) {
        self.buttonSun.boolDown = YES;
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.imageViewPeople.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
                         } completion:^(BOOL finished) {
                             self.imageViewPeople.hidden = NO;
                         }];
    }else{
        self.buttonSun.boolDown = NO;
        self.viewRepeat.userInteractionEnabled = NO;
        self.viewRepeat.alpha = 0.5;
        self.imageViewPeople.hidden = NO;
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SYSTEM_BOOT_0] boolValue]) {
        self.buttonSun.userInteractionEnabled = NO;
        self.viewRepeat.userInteractionEnabled = NO;
    }
}

- (void)timeNetwork:(NSInteger)start end:(NSInteger)end{
    //时间转换为时间戳
    double beginStamp = [self dateToTimestamp:start/12 minute:start%12*5];
    double endStamp = [self dateToTimestamp:end/12 minute:end%12*5];
    NSString *getupEndTimeStamp = [NSString stringWithFormat:@"%f",endStamp];
    NSString *getupBeginTimeStamp = [NSString stringWithFormat:@"%f",beginStamp];
    
    NSString *storeBeginTimeStamp = [[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:USER_BEGINTIME];
    NSString *storeEndTimeStamp = [[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:USER_ENDTIME];
    liboTOOLS *tool = [[liboTOOLS alloc] init];
    if ([[tool timestamp_TO_time:[storeBeginTimeStamp intValue]] isEqualToString:[tool timestamp_TO_time:[getupBeginTimeStamp intValue]]] && [[tool timestamp_TO_time:[storeEndTimeStamp intValue]] isEqualToString:[tool timestamp_TO_time:[getupEndTimeStamp intValue]]]) {
        return;
    }
    
    //用户存储
    NSMutableDictionary *dictionary =  [[NSMutableDictionary alloc] initWithDictionary:[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION]];
    [dictionary setObject:getupEndTimeStamp forKey:USER_ENDTIME];
    [dictionary setObject:getupBeginTimeStamp forKey:USER_BEGINTIME];
    
    [[userModel sharedUserModel] setUserInformation:[NSDictionary dictionaryWithDictionary:dictionary] forKey:LOCAL_NOTIFICATION];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[LocalNotification sharedLocalNotification] setLocalNotification];
    });
    
    //上传网络
    if ([[lowooHTTPManager getInstance] isExistenceNetwork]) {
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:
         [NSDictionary dictionaryWithObjectsAndKeys:[[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:@"moon"],@"moon", nil]requestType:moon_sun];
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:
         [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt:beginStamp], @"timestart",
          [NSNumber numberWithInt:endStamp], @"timestop", nil] requestType:setcalledtime];
        [[userModel sharedUserModel] setUserInformation:@"" forKey:@"moon_network"];
        [[userModel sharedUserModel] setUserInformation:@"" forKey:@"timestop"];
    }else{
        [[userModel sharedUserModel] setUserInformation:@"" forKey:@"moon_network"];
        [[userModel sharedUserModel] setUserInformation:getupEndTimeStamp forKey:@"timestop"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changedays" object:nil];
    }
    
    NSDictionary *returnDict = [[userModel sharedUserModel] getCache:@"achievelist"];
    beginStamp = abs([[tool time_TO_timestamp:0 minute:0] intValue] - beginStamp);
    endStamp = abs([[tool time_TO_timestamp:0 minute:0] intValue] - endStamp);
    NSString *startString = [NSString stringWithFormat:@"%d",(int)beginStamp];
    NSString *endString = [NSString stringWithFormat:@"%d",(int)endStamp];
    NSMutableDictionary *mutable = [NSMutableDictionary dictionaryWithDictionary:returnDict];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:startString, @"start", endString, @"stop", nil];
    [mutable setObject:dict forKey:@"getup"];
    [[userModel sharedUserModel] writeCache:[NSDictionary dictionaryWithDictionary:mutable] title:@"achievelist"];
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

- (void)buttonSunTouchupInside:(UIButtonRepeat *)button{
    if (button.boolDown) {
        if (IOS_7) {
            [UIView animateWithDuration:0.8
                                  delay:0
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:0.9
                                options:UIViewAnimationCurveEaseInOut animations:^{
                                    self.imageViewPeople.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
                                } completion:^(BOOL finished) {
                                    
                                }];
            [UIView animateWithDuration:0.8
                                  delay:0.4
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:0.9
                                options:UIViewAnimationCurveEaseOut
                             animations:^{
                                 self.viewCircle.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
                             } completion:^(BOOL finished) {
                                 
                                 
                             }];
            
        }else{
            [UIView animateWithDuration:0.8
                             animations:^{
                                 self.imageViewPeople.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
                             } completion:^(BOOL finished) {
                                 
                             }];
            [UIView animateWithDuration:0.8
                                  delay:0.4
                                options:UIViewAnimationCurveEaseInOut
                             animations:^{
                                 self.viewCircle.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
                             } completion:^(BOOL finished) {
                                 
                             }];
            
        }
        [UIView animateWithDuration:0.6 animations:^{
            _imageViewBack.alpha = 0.0f;
        }];
        
        self.viewRepeat.userInteractionEnabled = YES;
        self.viewRepeat.alpha = 1;
        
        NSDictionary *dict = (NSDictionary *)[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION];
        if (!dict) {
            [[LocalNotification sharedLocalNotification] setDefaultLocalNotification];
            dict = (NSDictionary *)[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION];
        }
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        [mutableDict setObject:@"1" forKey:@"moon"];
        [[userModel sharedUserModel] setUserInformation:[NSDictionary dictionaryWithDictionary:mutableDict] forKey:LOCAL_NOTIFICATION];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[LocalNotification sharedLocalNotification] setLocalNotification];
        });
        NSDictionary *returnDict = [[userModel sharedUserModel] getCache:@"achievelist"];
        NSMutableDictionary *mutable = [NSMutableDictionary dictionaryWithDictionary:returnDict];
        [mutable setObject:@"1" forKey:@"moon"];
        [[userModel sharedUserModel] writeCache:[NSDictionary dictionaryWithDictionary:mutable] title:@"achievelist"];
    }else{
        if (IOS_7) {
            [UIView animateWithDuration:0.8
                                  delay:0
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:0.9
                                options:UIViewAnimationCurveEaseOut
                             animations:^{
                                 self.viewCircle.transform = CGAffineTransformMakeTranslation(0, 0);
                             } completion:^(BOOL finished) {
                             }];
            [UIView animateWithDuration:0.8
                                  delay:0.4
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:0.9
                                options:UIViewAnimationCurveEaseOut
                             animations:^{
                                 self.imageViewPeople.transform = CGAffineTransformMakeTranslation(0, 0);
                             } completion:^(BOOL finished) {
                                 
                             }];
        }else{
            [UIView animateWithDuration:0.8
                             animations:^{
                                 self.viewCircle.transform = CGAffineTransformMakeTranslation(0, 0);
                             } completion:^(BOOL finished) {
                             }];
            [UIView animateWithDuration:0.8
                                  delay:0.4
                                options:UIViewAnimationCurveEaseInOut
                             animations:^{
                                 self.imageViewPeople.transform = CGAffineTransformMakeTranslation(0, 0);
                             } completion:^(BOOL finished) {
                                 
                             }];

        }
       
        [UIView animateWithDuration:0.6 animations:^{
            _imageViewBack.alpha = 1.0f;
        }];
        self.viewRepeat.userInteractionEnabled = NO;
        self.viewRepeat.alpha = 0.5;
        
        NSDictionary *dict = [[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION];
        NSMutableDictionary *muDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        [muDict setObject:@"0" forKey:@"moon"];
        [[userModel sharedUserModel] setUserInformation:[NSDictionary dictionaryWithDictionary:muDict] forKey:LOCAL_NOTIFICATION];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[LocalNotification sharedLocalNotification] setLocalNotification];
        });
        NSDictionary *returnDict = [[userModel sharedUserModel] getCache:@"achievelist"];
        NSMutableDictionary *mutable = [NSMutableDictionary dictionaryWithDictionary:returnDict];
        [mutable setObject:@"0" forKey:@"moon"];
        [[userModel sharedUserModel] writeCache:[NSDictionary dictionaryWithDictionary:mutable] title:@"achievelist"];
    }
   
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:
     [NSDictionary dictionaryWithObjectsAndKeys:[[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:@"moon"],@"moon", nil]requestType:moon_sun];
}

- (void)imageViewRepeatTaped:(UIImageViewRepeat *)imageView{
    if (imageView.boolTouchDown) {
        [self.arrayHTTP replaceObjectAtIndex:imageView.tag withObject:@"1"];
    }else{
        [self.arrayHTTP replaceObjectAtIndex:imageView.tag withObject:@"0"];
    }

    [self repeatNetwork];
}

- (void)repeatNetwork{
    if ([self.manager isExistenceNetwork]) {
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:self.arrayHTTP,@"value", nil] requestType:changedays];
    }else{
        NSMutableDictionary *mutableDict =  [[NSMutableDictionary alloc] initWithDictionary:[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION]];
        [mutableDict setObject:self.arrayHTTP forKey:@"array"];
        [[userModel sharedUserModel] setUserInformation:mutableDict forKey:LOCAL_NOTIFICATION];
        [[LocalNotification sharedLocalNotification] setRepeatWeek:self.arrayHTTP];//用于显示
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[LocalNotification sharedLocalNotification] setLocalNotification];
        });
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changedays" object:nil];
    }
}
- (NSInteger)CircleViewMaxDistance{
    return 12*2+(startDistance+endDistance+1);
}

- (NSInteger)CircleViewMinDistance{
    return (startDistance+endDistance);
}

- (void)circleView:(circleView *)circleView didSelectStart:(int)start End:(int)end{
//    NSLog(@"%d,%d,%d",circleView.imageViewStart.count,circleView.imageViewEnd.count,circleView.imageViewStart.count-circleView.imageViewEnd.count);

    /**
    结束时间
     */
    //倒转一圈
    if (circleView.imageViewStart.current_radian-self.startOld_radian<M_PI && self.startOld_radian<M_PI && circleView.imageViewStart.current_radian>M_PI) {
        self.boolStart00 = NO;
        self.startScrollNum --;
    }
    //正转一圈
    if (self.startOld_radian-circleView.imageViewStart.current_radian<M_PI && self.startOld_radian>M_PI && circleView.imageViewStart.current_radian<M_PI) {
        if (self.boolStart00) {
            if (self.startOld_radian>M_PI) {
                self.boolStart00 = NO;
            }
        }else{
            self.startScrollNum ++;
        }
    }
    self.startOld_radian = circleView.imageViewStart.current_radian;

    
    /**
     开始时间
     */
    //倒转一圈
    if (circleView.imageViewEnd.current_radian-self.endOld_radian<M_PI && self.endOld_radian<M_PI && circleView.imageViewEnd.current_radian>M_PI) {
        self.endScrollNum --;
        self.boolEnd00 = NO;
    }
    //正转一圈
    if (self.endOld_radian-circleView.imageViewEnd.current_radian<M_PI && self.endOld_radian>M_PI && circleView.imageViewEnd.current_radian<M_PI) {
        self.endScrollNum ++;
    }
    self.endOld_radian = circleView.imageViewEnd.current_radian;
    
    self.startOldNum = start;
    self.endOldNum = start-self.distanceTure;
    
    [self setUpTime:self.endOldNum];
    [self setDownTime:self.startOldNum];
    
    [self music];

}

- (void)circleView:(circleView *)circleView selectEnd:(int)end endDistance:(int)distance{
    if (distance>144) {
        distance -= 144;
    }
    NSInteger index = distance-startDistance-endDistance-1;
    if (index<0 || index>23) {
        return;
    }
    circleView.imageViewProgress.image = [circleView.imageViewProgress.animationImages objectAtIndex:index];

    self.distanceTure = distance;

    /**
     开始时间
     */
    //倒转一圈
    if (circleView.imageViewEnd.current_radian-self.endOld_radian<M_PI && self.endOld_radian<M_PI && circleView.imageViewEnd.current_radian>M_PI) {
        self.endScrollNum --;
        self.boolEnd00 = NO;
    }
    //正转一圈
    if (self.endOld_radian-circleView.imageViewEnd.current_radian<M_PI && self.endOld_radian>M_PI && circleView.imageViewEnd.current_radian<M_PI) {
        self.endScrollNum ++;
    }
    self.endOld_radian = circleView.imageViewEnd.current_radian;
    
    //更改时间
    self.endOldNum = end;
    
    [self setUpTime:self.endOldNum];

    [self music];
}

- (void)music{
    [[lowooMusic sharedLowooMusic] SystemSoundID:@"timelow" type:@"mp3"];
}

- (void)setDownTime:(NSInteger)count{
//    NSLog(@"%d",self.startScrollNum);
//    NSLog(@"%D",count);
    if (count == 0) {
        count += 144;
    }

    if (self.startScrollNum%2 != 0 && count<=144) {
        count += 144;
    }

    {//将圆心代替触摸区域中心点
        count -= startDistance;
        if (count<0) {
            count += 288;
        }
    }

    NSInteger hour = count/12;
    NSInteger hour1 = hour/10;
    NSInteger hour2 = hour%10;
    
    NSInteger minite = count%12;
    NSInteger minite1 = minite/2;
    NSInteger minite2 = minite%2*5;
    
    self.imageView01.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",hour1]];
    self.imageView02.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",hour2]];
    self.imageView04.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",minite1]];
    self.imageView05.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",minite2]];
}

- (void)setUpTime:(NSInteger)countEnd{
    if (countEnd<0) {
        countEnd += 144;
    }
    if (countEnd == 0) {
        countEnd += 144;
    }

    if (self.endScrollNum%2 != 0) {
        countEnd += 144;
    }
    

    countEnd += endDistance;
    if (countEnd>288) {
        countEnd = countEnd-288;
    }
    if (countEnd==288) {
        countEnd = 0;
    }

    NSInteger hour = countEnd/12;
    NSInteger hour1 = hour/10;
    NSInteger hour2 = hour%10;
    
    NSInteger minite = countEnd%12;
    NSInteger minite1 = minite/2;
    NSInteger minite2 = minite%2*5;
    
    self.imageView11.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",hour1]];
    self.imageView12.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",hour2]];
    self.imageView14.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",minite1]];
    self.imageView15.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",minite2]];
}

- (void)circleViewFinishedSelect:(circleView *)circleView{
    self.startCount = 0;
    self.endCount = 0;
    NSInteger up = self.endOldNum;
    if (up<0) {
        up += 144;
    }
    if (self.endScrollNum%2 != 0) {
        if (up<=144) {
            up += 144;
        }
    }
    up += endDistance;
    if (up>288) {
        up -= 288;
    }

    NSInteger down = self.startOldNum;
    if (down<0) {
        down += 144;
    }
    if (self.startScrollNum%2 != 0) {
        if (down<=144) {
            down += 144;
        }
    }
    down -= startDistance;
    if (down<0) {
        down += 144;
    }
    if (down-up>12*2) {
        [liboTOOLS alertViewMSG:@"好像出问题了哎，无法保存设置时间"];
        return;
    }
  
    [self timeNetwork:up end:down];
    
    if (self.imageViewBubble.hidden) {
        [self.imageViewBubble removeFromSuperview]; self.imageViewBubble = nil;
        [self.viewMask removeFromSuperview]; self.viewMask = nil;
        _boot = [[systemBoot alloc] init];
        [_boot addOnceView:2];
    }
}

- (void)circleViewStartMove:(circleView *)circleView{
    if (self.imageViewBubble) {
        self.imageViewBubble.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
