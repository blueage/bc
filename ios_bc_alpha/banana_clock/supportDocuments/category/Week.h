//
//  Week.h
//  test
//
//  Created by MAC on 13-10-24.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DayOfWeekUnknown = 0,
    DayOfWeekMon,
    DayOfWeekTue,
    DayOfWeekWed,
    DayOfWeekThu,
    DayOfWeekFri,
    DayOfWeekSat,
    DayOfWeekSun
}DayOfWeekType;



@interface Week : NSObject

-(NSString*)dayOfWeek;


-(DayOfWeekType )dayOfWeekType;

@end
