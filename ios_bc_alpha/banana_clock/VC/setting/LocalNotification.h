//
//  LocalNotification.h
//  banana_clock
//
//  Created by MAC on 13-9-26.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotification : NSObject


+ (id)sharedLocalNotification;

- (void)setLocalNotification;
- (void)setDefaultLocalNotification;
- (void)setRepeatWeek:(NSArray *)sender;
- (void)cancelLocalNotificationOfToday;
- (void)checkCancelLocalNotification;
- (void)cancelLocalNotificationWithIndex:(NSString *)index;

@end
