//
//  lowooTimeSet.m
//  banana_clock
//
//  Created by MAC on 13-1-6.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooTimeSet.h"
#import "LocalNotification.h"
#import "liboTOOLS.h"

#define colorDown [UIColor colorWithRed:198/255.0 green:136/255.0 blue:43/255.0 alpha:0.9]
#define colorUp   [UIColor colorWithRed:164/255.0 green:163/255.0 blue:163/255.0 alpha:0.9]
#define colorTime [UIColor colorWithRed:229/255.0 green:166/255.0 blue:73/255.0 alpha:0.9]

@implementation lowooTimeSet

//每次显示此页面都会加载，在此处load 数据
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"TIME SETTING";
    [self changeTitle];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    _pickerView1.boolMusic = [[[NSUserDefaults standardUserDefaults] objectForKey:MUSIC_ALLOW] boolValue];
//    _pickerView2.boolMusic = [[[NSUserDefaults standardUserDefaults] objectForKey:MUSIC_ALLOW] boolValue];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpFailed) name:@"httpFailed" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([_stringFather isEqualToString:@"register"]) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -4, SCREEN_WIDTH, SCREEN_HEIGHT+4)];
        imageview.image = GetPngImage(@"iphone5bc");
        [self.view addSubview:imageview];
    }

    if (iPhone5||iPhone5_0) {
        _imageViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, -60, SCREEN_WIDTH, 568)];
        [_imageViewBack setImage:GetPngImage(@"moonBack5")];
    }else{
        _imageViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, -60, SCREEN_WIDTH, 480)];
        [_imageViewBack setImage:GetPngImage(@"moonBack4")];
    }
    [self.view addSubview:_imageViewBack];
}

- (void)initView{
    if (iPhone5||iPhone5_0) {
        _viewBaseLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 160, 250)];
        _viewBaseRight = [[UIView alloc] initWithFrame:CGRectMake(160, 60, 160, 250)];
    }else{
        _viewBaseLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 160, 250)];
        _viewBaseRight = [[UIView alloc] initWithFrame:CGRectMake(160, 20, 160, 250)];
    }
    
    //左
    UIImageView *imageViewLeftBackground = [[UIImageView alloc] initWithFrame:CGRectMake(17, 17, 126, 220)];
    imageViewLeftBackground.image = GetJpgImage(@"BackgroundLeft");
    [_viewBaseLeft addSubview:imageViewLeftBackground];
    
    _imageViewUp = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 139, 122)];
    _imageViewUp.image = GetPngImage(@"ModuleUp");
    [_viewBaseLeft addSubview:_imageViewUp];
    _imageViewUp.hidden = YES;

    

    
    _labelUpTime = [[UILabel alloc] initWithFrame:CGRectMake(49, 73, 63, 29)];
    _labelUpTime.backgroundColor = [UIColor clearColor];
    _labelUpTime.textColor = colorTime;
    _labelUpTime.textAlignment = NSTextAlignmentCenter;
    [_labelUpTime setFont:[UIFont fontWithName:@"Futura" size:18.0]];
    [_viewBaseLeft addSubview:_labelUpTime];
    
    _buttonUp = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [_buttonUp setFrame:CGRectMake(11, 11, 139, 122)];
    [_buttonUp setTag:0];
    [_buttonUp addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBaseLeft addSubview:_buttonUp];
    //下
    _imageViewDown = [[UIImageView alloc] initWithFrame:CGRectMake(11, 122, 139, 122)];
    _imageViewDown.image = GetPngImage(@"ModuleDown");
    [_viewBaseLeft addSubview:_imageViewDown];


    
    _labelDownTime = [[UILabel alloc] initWithFrame:CGRectMake(49, 180, 63, 29)];
    _labelDownTime.backgroundColor = [UIColor clearColor];
    _labelDownTime.textColor = colorDown;
    _labelDownTime.textAlignment = NSTextAlignmentCenter;
    [_labelDownTime setFont:[UIFont fontWithName:@"Futura" size:18.0]];
    [_viewBaseLeft addSubview:_labelDownTime];
    
    _buttonDown = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [_buttonDown setFrame:CGRectMake(11, 122, 139, 122)];
    [_buttonDown setTag:1];
    [_buttonDown addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBaseLeft addSubview:_buttonDown];
    
    UIImageView *imageViewLeftMask = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 140, 236)];
    imageViewLeftMask.image = GetPngImage(@"BoxLeft");
    [_viewBaseLeft addSubview:imageViewLeftMask];
    
    
    //右
    UIImageView *imageViewRightBackground = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 137, 220)];
    imageViewRightBackground.image = GetJpgImage(@"BackgroundRight");
    [_viewBaseRight addSubview:imageViewRightBackground];
    
    UIImageView *imageViewRithtLeft = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 64, 225)];
    imageViewRithtLeft.image = GetPngImage(@"TimeLeftRollingAxis");
    [_viewBaseRight addSubview:imageViewRithtLeft];
    
    UIImageView *imageViewRightRight = [[UIImageView alloc] initWithFrame:CGRectMake(78, 13, 64, 225)];
    imageViewRightRight.image = GetPngImage(@"TimeRightRollingAxis");
    [_viewBaseRight addSubview:imageViewRightRight];
    
    if (!_picker1) {
        _picker1 = [[tableViewPicker alloc] initWithFrame:CGRectMake(14, 14, 64, 225)];
        _picker1.cellSize = CGSizeMake(64, 225/5);
        _picker1.cellNumber = 24;
        _picker1.pickerDataSource = self;
        [_viewBaseRight addSubview:_picker1];
        
        _picker2 = [[tableViewPicker alloc] initWithFrame:CGRectMake(78, 14, 64, 225)];
        _picker2.cellSize = CGSizeMake(64, 225/5);
        _picker2.cellNumber = 60;
        _picker2.pickerDataSource = self;
        [_viewBaseRight addSubview:_picker2];
    }
    
    UIImageView *imageViewRightUp = [[UIImageView alloc] initWithFrame:CGRectMake(9, 15, 138, 15)];
    imageViewRightUp.image = GetPngImage(@"ShadowUp");
    [_viewBaseRight addSubview:imageViewRightUp];
    
    UIImageView *imageViewRightDown = [[UIImageView alloc] initWithFrame:CGRectMake(9, 222, 138, 15)];
    imageViewRightDown.image = GetPngImage(@"ShadowDown");
    [_viewBaseRight addSubview:imageViewRightDown];
    
    UIImageView *imageViewRightCenter = [[UIImageView alloc] initWithFrame:CGRectMake(13, 103, 130, 42)];
    imageViewRightCenter.image = GetPngImage(@"Time-selection-bar");
    [_viewBaseRight addSubview:imageViewRightCenter];
    
    UIImageView *imageViewRightMask = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 146, 232)];
    imageViewRightMask.image = GetPngImage(@"BoxRight");
    [_viewBaseRight addSubview:imageViewRightMask];
    
    if (LANGUAGE_CHINESE) {
        //中文
        _labelUpChinese = [[UILabel alloc] initWithFrame:CGRectMake(46, 35, 68, 21)];
        _labelUpChinese.backgroundColor = [UIColor clearColor];
        _labelUpChinese.textColor = colorDown;
        _labelUpChinese.font = [UIFont systemFontOfSize:16];
        [_viewBaseLeft addSubview:_labelUpChinese];
        
        _labelUpChineseEnglish = [[UILabel alloc] initWithFrame:CGRectMake(67, 50, 42, 21)];
        _labelUpChineseEnglish.backgroundColor = [UIColor clearColor];
        _labelUpChineseEnglish.textColor = colorDown;
        _labelUpChineseEnglish.font = [UIFont systemFontOfSize:9];
        [_viewBaseLeft addSubview:_labelUpChineseEnglish];
        
        _labelUpChinese.text = @"开始时间";
        _labelUpChineseEnglish.text = @"From";
        
        //中文
        _labelDownChinese = [[UILabel alloc] initWithFrame:CGRectMake(46, 145, 68, 21)];
        _labelDownChinese.backgroundColor = [UIColor clearColor];
        _labelDownChinese.textColor = colorUp;
        _labelDownChinese.font = [UIFont systemFontOfSize:16];
        [_viewBaseLeft addSubview:_labelDownChinese];
        
        _labelDownChineseEnglish = [[UILabel alloc] initWithFrame:CGRectMake(72, 160, 42, 21)];
        _labelDownChineseEnglish.backgroundColor = [UIColor clearColor];
        _labelDownChineseEnglish.textColor = colorUp;
        _labelDownChineseEnglish.font = [UIFont systemFontOfSize:9];
        [_viewBaseLeft addSubview:_labelDownChineseEnglish];
        
        _labelDownChinese.text = @"结束时间";
        _labelDownChineseEnglish.text = @"To";
    }else{
        //英文
        _labelUpEnglish = [[UILabel alloc] initWithFrame:CGRectMake(46, 35, 68, 40)];
        _labelUpEnglish.backgroundColor = [UIColor clearColor];
        _labelUpEnglish.textColor = colorUp;
        _labelUpEnglish.font = [UIFont systemFontOfSize:18];
        _labelUpEnglish.textAlignment = NSTextAlignmentCenter;
        [_viewBaseLeft addSubview:_labelUpEnglish];
        _labelUpEnglish.text = @"From";
        
        //英文
        _labelDownEnglish = [[UILabel alloc] initWithFrame:CGRectMake(46, 145, 68, 40)];
        _labelDownEnglish.backgroundColor = [UIColor clearColor];
        _labelDownEnglish.textColor = colorUp;
        _labelDownEnglish.font = [UIFont systemFontOfSize:18];
        _labelDownEnglish.textAlignment = NSTextAlignmentCenter;
        [_viewBaseLeft addSubview:_labelDownEnglish];
        _labelDownEnglish.text = @"To";
    }
    
    if ([[[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:@"moon"] isEqualToString:@"1"]) {
        _viewMove = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _viewMove1 = [[UIView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];

    }else{
        _viewMove = [[UIView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _viewMove1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    [_viewMove addSubview:_viewBaseLeft];
    [_viewMove addSubview:_viewBaseRight];
    [self.view addSubview:_viewMove];
    
    UIImageView *imageViewPeople;
    if (iPhone5||iPhone5_0) {
        imageViewPeople = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 275)];
    }else{
        imageViewPeople = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 320, 275)];
    }
    imageViewPeople.image = GetPngImage(@"moonPeople");
    [_viewMove1 addSubview:imageViewPeople];
    [self.view addSubview:_viewMove1];
    
    UIButton_custom *buttonMoon;
    if (iPhone5_0||iPhone5) {
        buttonMoon = [[UIButton_custom alloc] initWithFrame:CGRectMake(112, SCREEN_HEIGHT-230, 95, 90)];
    }else{
        buttonMoon = [[UIButton_custom alloc] initWithFrame:CGRectMake(112, SCREEN_HEIGHT-215, 95, 90)];
    }
    if ([[[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:@"moon"] isEqualToString:@"0"]) {
        [buttonMoon setImage:GetPngImage(@"suna") forState:UIControlStateNormal];
        [buttonMoon setImage:GetPngImage(@"sunb") forState:UIControlEventTouchDown];
        _imageViewBack.alpha = 1.0f;
    }else{
        [buttonMoon setImage:GetPngImage(@"moona") forState:UIControlStateNormal];
        [buttonMoon setImage:GetPngImage(@"moonb") forState:UIControlEventTouchDown];
        _imageViewBack.alpha = 0.0f;
    }
    [buttonMoon addTarget:self action:@selector(moonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonMoon];
}

- (void)moonAction:(UIButton_custom *)button{
    button.userInteractionEnabled = NO;
    if ([[[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:@"moon"] isEqualToString:@"1"]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             [_viewMove setCenter:CGPointMake(SCREEN_WIDTH/2, -SCREEN_HEIGHT/2)];
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.3
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  [_viewMove1 setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
                                                  button.userInteractionEnabled = YES;
                                                  [button setImage:GetPngImage(@"suna") forState:UIControlStateNormal];
                                                  [button setImage:GetPngImage(@"sunb") forState:UIControlEventTouchDown];
                                              } completion:^(BOOL finished) {
                                                  
                                              }];
                         }];
        [UIView animateWithDuration:0.6 animations:^{
            _imageViewBack.alpha = 1.0f;
        }];
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
    }else{
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [_viewMove1 setCenter:CGPointMake(SCREEN_WIDTH/2, -SCREEN_HEIGHT/2)];
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.3
                                              animations:^{
                                                  [_viewMove setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
                                                  button.userInteractionEnabled = YES;
                                                  [button setImage:GetPngImage(@"moona") forState:UIControlStateNormal];
                                                  [button setImage:GetPngImage(@"moonb") forState:UIControlEventTouchDown];
                                              }];

                         }];
        [UIView animateWithDuration:0.6 animations:^{
            _imageViewBack.alpha = 0.0f;
        }];
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
    }
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:
     [NSDictionary dictionaryWithObjectsAndKeys:[[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:@"moon"],@"moon", nil]requestType:moon_sun];
    
}

- (void)buttonAction:(UIButton_custom *)sender{
    if (sender.tag==0) {
        if (_imageViewUp.hidden==NO) {
            _imageViewUp.hidden = YES;
            _imageViewDown.hidden = NO;
            
            _labelUpChinese.textColor = colorDown;
            _labelUpChineseEnglish.textColor = colorDown;
            _labelDownChinese.textColor = colorUp;
            _labelDownChineseEnglish.textColor = colorUp;
            _labelUpTime.textColor = colorTime;
            _labelDownTime.textColor = colorUp;
            
            [self confirmDateWithTime];
        }
    }else{
        if (_imageViewDown.hidden==NO) {
            _imageViewDown.hidden = YES;
            _imageViewUp.hidden = NO;
            
            _labelUpChinese.textColor = colorUp;
            _labelUpChineseEnglish.textColor = colorUp;
            _labelDownChinese.textColor = colorDown;
            _labelDownChineseEnglish.textColor = colorDown;
            
            _labelDownTime.textColor = colorTime;
            _labelUpTime.textColor = colorUp;
            
            [self confirmDateWithTime];
        }
    }
}

- (void)confirmDateWithTime{
    if (_imageViewUp.hidden==YES) {
        [_picker1 setSelectRow:[_beginHour intValue]];
        [_picker2 setSelectRow:[_beginMinute intValue]];
    }else{
        [_picker1 setSelectRow:[_endHour intValue]];
        [_picker2 setSelectRow:[_endMinute intValue]];
    }
}

- (void)pickerSelectAtRow:(NSInteger)row tableViewPixker:(tableViewPicker *)picker{
    if (row>=0) {
        NSString *time = [NSString stringWithFormat:@"%02d",row];
        if (_imageViewUp.hidden) {
            if (picker == _picker1) {
                _beginHour = time;
            }else{
                _beginMinute = time;
            }
            _labelUpTime.text = [NSString stringWithFormat:@"%@:%@",_beginHour,_beginMinute];
        }else{
            if (picker == _picker1) {
                _endHour = time;
            }else{
                _endMinute = time;
            }
            _labelDownTime.text = [NSString stringWithFormat:@"%@:%@",_endHour,_endMinute];
        }
    }
}

- (void)confirmDateWithStart:(NSInteger )start Stop:(NSInteger )stop{
    [self initView];
    start = start%100000;
    stop = stop%100000;

    _beginHour = [NSString stringWithFormat:@"%02d",start/3600];
    _beginMinute = [NSString stringWithFormat:@"%02d",start%3600/60];
    _endHour = [NSString stringWithFormat:@"%02d",stop/3600];
    _endMinute = [NSString stringWithFormat:@"%02d",stop%3600/60];
    
    _labelUpTime.text = [NSString stringWithFormat:@"%@:%@",_beginHour,_beginMinute];
    _labelDownTime.text = [NSString stringWithFormat:@"%@:%@",_endHour,_endMinute];

    [_picker1 setSelectRow:[_beginHour intValue]];
    [_picker2 setSelectRow:[_beginMinute intValue]];
}

- (NSString *)timestampToHour:(double)timestamp{
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    NSString *hour = [NSString stringWithFormat:@"%02d",[components hour]];
    
    return hour;
}

- (NSString *)timestampToMinute:(double)timestamp{
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    NSString *minute = [NSString stringWithFormat:@"%02d",[components minute]];
    
    return minute;
}


#pragma mark - AFPickerViewDataSource

- (UIView *)contentView{
    UILabel *label = [[UILabel alloc]init];
    return label;
}

- (CGFloat )floatOfWidth{
    return 44;
}

#pragma mark-------leftBtnPressed-------------
//覆盖父方法
-(void)leftButtonDidTouchedUpInside{
    [self setTime];
    
    //显示提示信息
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"attentionShow"] boolValue]) {
        lowooPOPattention *attention = [[lowooPOPattention alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [[lowooAlertViewDemo sharedAlertViewManager] show:attention];
    }

    self.viewLeftButton.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCell" object:nil userInfo:nil];
}

- (void)setTime{
    //时间转换为时间戳
    double beginStamp = [self dateToTimestamp:[_beginHour intValue] minute:[_beginMinute intValue]];
    double endStamp = [self dateToTimestamp:[_endHour intValue] minute:[_endMinute intValue]];
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

    
    
//    //时区 上传零点时区  转换为本地时区
//    {
//        NSLog(@"%f",string);
//        NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
//        NSLog(@"%f",string - localTimeZone.secondsFromGMT);
//        //string = string - localTimeZone.secondsFromGMT;
//    }
    
    return string;
}



@end
