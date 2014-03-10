//
//  liboTOOLS.h
//  banana_clock
//
//  Created by MAC on 13-11-20.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface liboTOOLS : NSObject


#pragma mark -------- 获取今天是周几 ------------

typedef enum {
    Unknown = 0,
    Mon,
    Tue,
    Wed,
    Thu,
    Fri,
    Sat,
    Sun
}DayType;

-(DayType )dayOfWeekType;


- (NSString *)MD5:(NSString *)str;


- (NSString *)timestamp_TO_time:(NSInteger)stamp;
- (NSString *)time_TO_timestamp:(NSInteger)hour minute:(NSInteger)minute;
- (NSDate *)timeString_date:(NSString *)timeString;
- (NSInteger )timeDate_timeStamp:(NSString *)timeStamp;
- (NSInteger)date_timeStamp:(NSDate *)date;
- (NSString *)timeNow;

+ (void)alertViewMSG:(NSString *)string;
+ (void)showHUD:(NSString *)title;
+ (void)dismissHUD;

@end
