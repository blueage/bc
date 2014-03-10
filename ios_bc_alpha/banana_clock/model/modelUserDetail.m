//
//  modelUserDetail.m
//  banana_clock
//
//  Created by MAC on 14-1-21.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "modelUserDetail.h"
#import "JSON.h"
#import "JSONKit.h"

@implementation modelUserDetail


- (NSInteger)getupTimes{
    return [[self.JSONdictionary objectForKey:@"continue_getuptimes"] intValue];
}

- (NSInteger)lazyTimes{
    return [[self.JSONdictionary objectForKey:@"continue_inbedtimes"] intValue];
}

- (NSInteger)callTimes{
    return [[self.JSONdictionary objectForKey:@"continue_call"] intValue];
}

- (NSInteger)state{
    return [[self.JSONdictionary objectForKey:@"state"] intValue];
}

- (NSInteger)allMedals{
    return [[[self.JSONdictionary objectForKey:@"num"] objectForKey:@"allmedal"] intValue];
}

- (NSInteger)getMedals{
    return [[[self.JSONdictionary objectForKey:@"num"] objectForKey:@"getmedal"] intValue];
}

- (NSInteger)allAchievements{
    return [[[self.JSONdictionary objectForKey:@"num"] objectForKey:@"allachieve"] intValue];
}

- (NSInteger)getAchievements{
    return [[[self.JSONdictionary objectForKey:@"num"] objectForKey:@"getachieve"] intValue];
}

- (NSString *)name{
    if ([BASE isNotNull:[self.JSONdictionary objectForKey:@"name"]]) {
        return [self.JSONdictionary objectForKey:@"name"];
    }
    return @"";
}

- (NSString *)email{
    return [self.JSONdictionary objectForKey:@"email"];
}

- (NSString *)timeStart{
    return [[self.JSONdictionary objectForKey:@"getup"] objectForKey:@"start"];
}

- (NSString *)timeStop{
    return [[self.JSONdictionary objectForKey:@"getup"] objectForKey:@"stop"];
}

- (NSString *)avatarUrl{
    return [self.dictionaryParams objectForKey:@"face"];
}

- (NSString *)location{
    if ([BASE isNotNull:[self.dictionaryParams objectForKey:@"location"]]) {
        return [self.dictionaryParams objectForKey:@"location"];
    }
    return @"";
}

- (NSString *)sex{
    return [self.dictionaryParams objectForKey:@"sex"];
}

- (NSString *)uid{
    if ([BASE isNotNull:[self.JSONdictionary objectForKey:@"username"]]) {
        return [self.JSONdictionary objectForKey:@"username"];
    }
    return @"";
}

- (BOOL)boolFoucs{
    if ([[self.JSONdictionary objectForKey:@"foucs"] intValue]==1) {
        return YES;
    }
    return NO;
}

- (BOOL)boolMoon{
    if ([[self.JSONdictionary objectForKey:@"moon"] intValue]==1) {
        return YES;
    }
    return NO;
}

- (BOOL)boolSpider{
    if ([[self.JSONdictionary objectForKey:@"spider"] intValue]>=2) {
        return YES;
    }
    return NO;
}

- (NSDictionary *)dictionaryParams{
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSString *params = [self.JSONdictionary objectForKey:@"param"];
    id param = [parser objectWithString:params];
    if ([param isKindOfClass:[NSDictionary class]]) {
        return param;
    }
    return nil;
}

- (NSArray *)arrayMedal{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i=0; i<[[self.JSONdictionary objectForKey:@"medal"] count]; i++) {
        modelMedal *medal = [[modelMedal alloc] init];
        medal.JSONdictionary = [[self.JSONdictionary objectForKey:@"medal"] objectAtIndex:i];
        [array addObject:medal];
    }
    return [NSArray arrayWithArray:array];
}

- (NSArray *)arrayAchievement{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i=0; i<[[self.JSONdictionary objectForKey:@"achieve"] count]; i++) {
        modelAchievement *achieve = [[modelAchievement alloc] init];
        achieve.JSONdictionary = [[self.JSONdictionary objectForKey:@"achieve"] objectAtIndex:i];
        [array addObject:achieve];
    }
    return array;
}

- (NSArray *)arrayRepeat{
    return [self.JSONdictionary objectForKey:@"randomday"];
}


@end
