//
//  LocalNotification.m
//  banana_clock
//
//  Created by MAC on 13-9-26.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "LocalNotification.h"
#import "Week.h"

@implementation LocalNotification

+ (id)sharedLocalNotification{
    static LocalNotification *notification;                                         
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notification = [[self alloc] init];
    });
    return notification;
}

- (id)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}

//设置默认闹铃时间
- (void)setDefaultLocalNotification{
    NSMutableDictionary *dictionary =  [[NSMutableDictionary alloc] init];
    NSArray *array = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    NSString *endTime =  [NSString stringWithFormat:@"%f",[self dateToTimestamp:8 minute:0]];
    [dictionary setObject:endTime forKey:USER_ENDTIME];
    [dictionary setObject:array forKey:@"array"];
    [dictionary setObject:@"1" forKey:@"moon"];
    [[userModel sharedUserModel] setUserInformation:dictionary forKey:LOCAL_NOTIFICATION];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[LocalNotification sharedLocalNotification] setLocalNotification];
    });
}

- (void)setLocalNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    if (![BASE isNotNull:[[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:USER_ENDTIME]] || ![BASE isNotNull:[[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:@"array"]]) {
        return;
    }
    if ([[[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:@"moon"] isEqualToString:@"0"]) {
        return;
    }
    
    liboTOOLS *tool = [[liboTOOLS alloc] init];
    int today = [tool dayOfWeekType];
    
    NSMutableArray *arraySound = [[NSMutableArray alloc] init];
    NSString *endTime = [[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:USER_ENDTIME];
    NSArray *array = [[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:@"array"];

    for (int i=0; i<array.count; i++) {
        for (int t=0; t<6; t++) {
            if ([[array objectAtIndex:i]isEqualToString:@"1"]) {
                UILocalNotification *notification = [[UILocalNotification alloc] init];
                NSDate *now = [NSDate new];
                NSDate *dateEnd = [NSDate dateWithTimeIntervalSince1970:[endTime intValue] + t*300 + 86400*(i-today+1)];
                NSInteger interval =  [dateEnd timeIntervalSinceDate:now];
                
                notification.fireDate = [now dateByAddingTimeInterval:interval];
                notification.timeZone = [NSTimeZone defaultTimeZone];
                notification.alertBody = @"闹铃";
                notification.repeatInterval = kCFCalendarUnitWeek;//NSDayCalendarUnit;//UILocalNotification被重复激发之间的时间差
                notification.repeatCalendar = [NSCalendar currentCalendar];
                notification.applicationIconBadgeNumber = 1;
//                int allSound = [[[[userModel sharedUserModel] getCache:@"userpropsinfo"] objectForKey:@"list"] count];
//                NSInteger sound = arc4random()%allSound;
//                if (sound == 0) {
//                    sound = 1;
//                }
//                if (sound>32) {
//                    sound = 1;
//                }
                NSInteger sound = 1;
                [arraySound addObject:[NSString stringWithFormat:@"%d",sound]];
                notification.soundName = [NSString stringWithFormat:@"%d.caf",sound];
                
                NSString *str = [dateEnd description];//区分停止某个闹铃
                NSRange range = {0,10};
                NSString *string = [str substringWithRange:range];
                notification.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                         string, @"fireDate",
                                         [NSString stringWithFormat:@"%d",sound] , @"sound",
                                         @"localCall", @"localCall",
                                         [NSString stringWithFormat:@"%d",i],@"index",
                                         notification.fireDate, @"date",
                                         //[NSString stringWithFormat:@"%@",notification.timeZone], @"timeZone",
                                         //notification.alertBody, @"alertBody",
                                         //notification.repeatInterval, @"repeatInterval",
                                         //notification.repeatCalendar, @"repeatCalendar",
                                         //notification.soundName, @"soundName",
                                         nil];
                [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//                NSLog(@"%@",notification);
            }
        }
    }
    NSDictionary *dict = [[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION];
    NSMutableDictionary *muDict = [[NSMutableDictionary alloc] initWithDictionary:dict];

    //将铃声数组按星期保存，方便存取
    NSMutableArray *arraySoundCopy = [[NSMutableArray alloc] init];
    int t=0;
    for (int i=0; i<array.count; i++) {
        if ([[array objectAtIndex:i] intValue]==1) {
            [arraySoundCopy addObject:[arraySound objectAtIndex:t]];
            t++;
        }else{
            [arraySoundCopy addObject:@"0"];
        }
    }
    tool = nil;
    [muDict setObject:arraySoundCopy forKey:@"arraySound"];
    [[userModel sharedUserModel] setUserInformation:[NSDictionary dictionaryWithDictionary:muDict] forKey:LOCAL_NOTIFICATION];
}

- (void)cancelLocalNotificationOfToday{
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSString *str = [[NSDate new] description];
    NSRange range = {0,10};
    NSString *string = [str substringWithRange:range];
    for (UILocalNotification *notification in array) {
        if ([string isEqualToString:[notification.userInfo objectForKey:@"fireDate"]]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
}

- (void)cancelLocalNotificationWithIndex:(NSString *)index{
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in array) {
        if ([[notification.userInfo objectForKey:@"index"] isEqualToString:index]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
}

- (void)checkCancelLocalNotification{//无时区
    NSDate *now = [NSDate new];
    NSString *endTime = [[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:@"endTime"];
    NSDate *dateEnd =  [NSDate dateWithTimeIntervalSince1970:[endTime intValue]];
    if ([now compare:dateEnd]>0) {
        [self cancelLocalNotificationOfToday];
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

//上级调用 用于显示文字
- (void)setRepeatWeek:(NSArray *)sender{
    [[userModel sharedUserModel] setUserInformation:sender forKey:@"repeatWeek"];

     //设置如何显示
    NSMutableArray *array = [[userModel sharedUserModel] getUserInformationWithKey:@"repeatWeek"]; 
     int t=0;
     for (NSString *day in array) {
         if ([day intValue]==1) {
             t++;
         }
     }
     NSString *monday = [NSString stringWithFormat:@"一"];
     NSString *tuesday = [NSString stringWithFormat:@"二"];
     NSString *wednesday = [NSString stringWithFormat:@"三"];
     NSString *thursday = [NSString stringWithFormat:@"四"];
     NSString *friday = [NSString stringWithFormat:@"五"];
     NSString *saturday = [NSString stringWithFormat:@"六"];
     NSString *sunday = [NSString stringWithFormat:@"日"];
     if (!LANGUAGE_CHINESE) {
         monday = [NSString stringWithFormat:@"M"];
         tuesday = [NSString stringWithFormat:@"T"];
         wednesday = [NSString stringWithFormat:@"W"];
         thursday = [NSString stringWithFormat:@"Th"];
         friday = [NSString stringWithFormat:@"F"];
         saturday = [NSString stringWithFormat:@"Sa"];
         sunday = [NSString stringWithFormat:@"Su"];
     }
     NSMutableArray *arrayString = [[NSMutableArray alloc] initWithObjects:monday,tuesday,wednesday,thursday,friday,saturday,sunday, nil];
    
    
     if (t==2) {
         if ([[array objectAtIndex:5] intValue]==1 &&[ [array objectAtIndex:6] intValue]==1) {//周末
             if (LANGUAGE_CHINESE) {
                 [[userModel sharedUserModel] setUserInformation:@"周末" forKey:@"week"];
             }else{
                 [[userModel sharedUserModel] setUserInformation:@"weekday" forKey:@"week"];
             }
         }else{//无序组合
             NSMutableArray *arrayWeek = [[NSMutableArray alloc] init];
             for (int i=0; i<array.count; i++) {
                 if ([[array objectAtIndex:i] intValue]==1) {
                     [arrayWeek addObject:[arrayString objectAtIndex:i]];
                 }
             }
             NSString *week = [arrayWeek componentsJoinedByString:@","];
             [[userModel sharedUserModel] setUserInformation:week forKey:@"week"];
         }
     }
     else if (t==7){//每天
         if (LANGUAGE_CHINESE) {
             [[userModel sharedUserModel] setUserInformation:@"每天" forKey:@"week"];
         }else{
             [[userModel sharedUserModel] setUserInformation:@"every day" forKey:@"week"];
         }
     }
     else if (t==5) {//工作日
         if ([[array objectAtIndex:5] intValue]!=1 &&[ [array objectAtIndex:6] intValue]!=1) {
             if (LANGUAGE_CHINESE) {
                 [[userModel sharedUserModel] setUserInformation:@"工作日" forKey:@"week"];
             }else{
                 [[userModel sharedUserModel] setUserInformation:@"work day" forKey:@"week"];
             }
         }else{//无序组合
             NSMutableArray *arrayWeek = [[NSMutableArray alloc] init];
             for (int i=0; i<array.count; i++) {
                 if ([[array objectAtIndex:i] intValue]==1) {
                     [arrayWeek addObject:[arrayString objectAtIndex:i]];
                 }
             }
             NSString *week = [arrayWeek componentsJoinedByString:@","];
             [[userModel sharedUserModel] setUserInformation:week forKey:@"week"];
         }
     }
     else if (t==1) {//单独一天
         for (int i=0; i<array.count; i++) {
             if ([[array objectAtIndex:i] intValue]==1) {
                 if (LANGUAGE_CHINESE) {
                     NSString *str = @"每周";
                     [[userModel sharedUserModel] setUserInformation:[str stringByAppendingString:[arrayString objectAtIndex:i]] forKey:@"week"];
                 }else{
                     NSString *str = @"Every ";
                     [arrayString removeAllObjects]; arrayString = nil;
                     arrayString = [[NSMutableArray alloc] initWithObjects:@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday", nil];
                     [[userModel sharedUserModel] setUserInformation:[str stringByAppendingString:[arrayString objectAtIndex:i]] forKey:@"week"];
                 }
             }
         }
     }
     else if (t==0){//永不
         if (LANGUAGE_CHINESE) {
             [[userModel sharedUserModel] setUserInformation:@"永不" forKey:@"week"];
         }else{
             [[userModel sharedUserModel] setUserInformation:@"never" forKey:@"week"];
         }
     }
     else{//无序组合
         NSMutableArray *arrayWeek = [[NSMutableArray alloc] init];
         for (int i=0; i<array.count; i++) {
             if ([[array objectAtIndex:i] intValue]==1) {
                 [arrayWeek addObject:[arrayString objectAtIndex:i]];
             }
         }
         NSString *week = [arrayWeek componentsJoinedByString:@","];
         [[userModel sharedUserModel] setUserInformation:week forKey:@"week"];
     }
}



@end
