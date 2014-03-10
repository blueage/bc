//
//  liboTOOLS.m
//  banana_clock
//
//  Created by MAC on 13-11-20.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "liboTOOLS.h"
#import <CommonCrypto/CommonCrypto.h>

typedef void(^animation) (id data);

@implementation liboTOOLS



-(NSString *)dayOfWeek{
    NSDateFormatter *fmtter =[[NSDateFormatter alloc] init];
    [fmtter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [fmtter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [fmtter setDateFormat:@"EEE"];
    return [fmtter stringFromDate:[NSDate new]];
}

-(DayType )dayOfWeekType{
    NSString* dayString = [self dayOfWeek];
    if (nil == dayString) {
        return Unknown;
    }
    
    if ([dayString hasPrefix:@"Mon"]) {
        return Mon;
    }
    if ([dayString hasPrefix:@"Tue"]) {
        return Tue;
    }
    if ([dayString hasPrefix:@"Wed"]) {
        return Wed;
    }
    if ([dayString hasPrefix:@"Thu"]) {
        return Thu;
    }
    if ([dayString hasPrefix:@"Fri"]) {
        return Fri;
    }
    if ([dayString hasPrefix:@"Sat"]) {
        return Sat;
    }
    if ([dayString hasPrefix:@"Sun"]) {
        return Sun;
    }
    
    return Unknown;
}




#pragma mark ---------- MD5 -------------
- (NSString *)MD5:(NSString *)str{
    NSString *string1 = @"87765004";
    NSString *string2 = @"40056778";
    
    NSString *md5 = [self MD5_32_bit:str];
    NSString *md5Copy = @"";
    for (int i=0; i<string1.length; i++) {
        NSRange range = {i,1};
        int t = [[string1 substringWithRange:range] intValue];
        md5Copy = [md5Copy stringByAppendingString:[md5 substringWithRange:NSMakeRange(t, 1)]];
    }
    
    md5 = [self MD5_32_bit:md5Copy];
    md5Copy = @"";
    for (int i=0; i<string2.length; i++) {
        NSRange range = {i,1};
        int t = [[string2 substringWithRange:range] intValue];
        md5Copy = [md5Copy stringByAppendingString:[md5 substringWithRange:NSMakeRange(t, 1)]];
    }
    return md5Copy;
}

//32位小写
- (NSString *)MD5_32_bit:(NSString *)str{
    return [self getMd5_32Bit_String:str];
}

//32位大写
- (NSString *)MD5_32_BIT:(NSString *)str{
    return [[self getMd5_32Bit_String:str] uppercaseString];
}

//16位小写
- (NSString *)MD5_16_bit:(NSString *)str{
    return [self getMd5_16Bit_String:str];
}

//16位大写
- (NSString *)MD5_16_BIT:(NSString *)str{
    return [[self getMd5_16Bit_String:str] uppercaseString];
}

//16位MD5加密方式
- (NSString *)getMd5_16Bit_String:(NSString *)srcString{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self getMd5_32Bit_String:srcString];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}

//32位MD5加密方式
- (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

- (NSString *)timeNow{
    NSDate *date = [NSDate date];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.timeZone = [NSTimeZone systemTimeZone];
    [formater setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *timestr = [formater stringFromDate: date];
    return timestr;
}

- (NSString *)timestamp_TO_time:(NSInteger)stamp{
       {
        if (stamp<100000) {
            NSInteger int1 = stamp/36000;
            stamp = stamp%36000;
            NSInteger int2 = stamp/3600;
            stamp = stamp%3600;
            NSInteger int3 = stamp/600;
            stamp = stamp%600;
            NSInteger int4 = stamp/60;
            int4 = (int4/5)*5;
            NSString *str = [NSString stringWithFormat:@"%d%d:%d%d",int1,int2,int3,int4];
            return str;
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];


        //时间戳转时间的方法
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:stamp];
        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        return confromTimespStr;
    }
    
    
    NSString *str1 = [NSString stringWithFormat:@"%d",stamp];
    int timeStamp = [[NSDate new] timeIntervalSince1970];
    NSString *str2 = [NSString stringWithFormat:@"%d",timeStamp];
    NSString *string = [str2 stringByReplacingCharactersInRange:NSMakeRange(str2.length - str1.length, str1.length) withString:str1];
    stamp = [string intValue];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //[formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSinceNow:stamp + timeZone.secondsFromGMT];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:stamp + timeZone.secondsFromGMT];
//    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    return confromTimespStr;
}



- (NSString *)time_TO_timestamp:(NSInteger)hour minute:(NSInteger)minute{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];

    
    
    NSDate *date = [NSDate new] ;
    NSInteger unitFlags =   NSYearCalendarUnit |
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
    //string = string + timeZone.secondsFromGMT;
    NSString *stringTime = [NSString stringWithFormat:@"%f",string];
    return stringTime;
}

- (NSDate *)timeString_date:(NSString *)timeString{
    if (timeString.length>19) {
        timeString = [timeString substringWithRange:NSMakeRange(0, 19)];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:timeString];
    return date;
}

- (NSInteger )timeDate_timeStamp:(NSString *)timeStamp{
    NSDate *date = [self timeString_date:timeStamp];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return [timeSp intValue];
}

- (NSInteger)date_timeStamp:(NSDate *)date{
    return (long)[date timeIntervalSince1970];
}


+ (void)alertViewMSG:(NSString *)string{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:string message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

+ (void)showHUD:(NSString *)title{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStylePlain];
    [MMProgressHUD showWithTitle:nil status:title];
}

+ (void)dismissHUD{
    [MMProgressHUD dismiss];
}

@end
