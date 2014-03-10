//
//  modelUserDetail.h
//  banana_clock
//
//  Created by MAC on 14-1-21.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "model.h"

@interface modelUserDetail : model

@property (nonatomic) NSInteger callTimes;
@property (nonatomic) NSInteger getupTimes;
@property (nonatomic) NSInteger lazyTimes;
@property (nonatomic) NSInteger state;
@property (nonatomic) NSInteger allMedals;
@property (nonatomic) NSInteger getMedals;
@property (nonatomic) NSInteger allAchievements;
@property (nonatomic) NSInteger getAchievements;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *timeStart;
@property (nonatomic, strong) NSString *timeStop;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSDictionary *dictionaryParams;
@property (nonatomic, strong) NSArray *arrayRepeat;
@property (nonatomic, strong) NSArray *arrayMedal;
@property (nonatomic, strong) NSArray *arrayAchievement;

@property (nonatomic) BOOL boolFoucs;
@property (nonatomic) BOOL boolMoon;
@property (nonatomic) BOOL boolSpider;





@end
