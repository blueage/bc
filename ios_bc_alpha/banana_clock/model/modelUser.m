//
//  userListModel.m
//  banana_clock
//
//  Created by MAC on 14-1-21.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "modelUser.h"
#import "JSON.h"
#import "JSONKit.h" 

@implementation modelUser


- (NSString *)name{
    if ([self checkJSONdictionary:@"name"]) {
        return [self.JSONdictionary objectForKey:@"name"];
    }
    return @"";
}

- (NSString *)fid{
    if ([self checkJSONdictionary:@"f_id"]) {
        return [self.JSONdictionary objectForKey:@"f_id"];
    }
    return @"";
}

- (NSString *)uid{
    if ([self checkJSONdictionary:@"id"]) {
        return [self.JSONdictionary objectForKey:@"id"];
    }
    return @"";
}

- (NSString *)propID{//libo  后台
    if ([self checkJSONdictionary:@"propID"]) {
        return [self.JSONdictionary objectForKey:@"propID"];
    }
    return @"0";
}

- (NSString *)avatarUrl{
    if ([BASE isNotNull:[self.dictionaryParams objectForKey:@"face"]]) {
        return [self.dictionaryParams objectForKey:@"face"];
    }
    return @"";
}

- (NSString *)timeStart{
    if ([self checkJSONdictionary:@"time_start"]) {
        return [self.JSONdictionary objectForKey:@"time_start"];
    }
    return @"";
}

- (NSString *)timeStop{
    if ([self checkJSONdictionary:@"time_stop"]) {
        return [self.JSONdictionary objectForKey:@"time_stop"];
    }
    return @"";
}

- (BOOL)boolTodayCanBeCall{
    if ([self checkJSONdictionary:@"day"]) {
        if ([[self.JSONdictionary objectForKey:@"day"] intValue]==1) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)boolFoucs{
    if ([self checkJSONdictionary:@"foucs"]) {
        if ([[self.JSONdictionary objectForKey:@"foucs"] intValue]==1) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)boolRefuse{
    if ([self checkJSONdictionary:@"refuse"]) {
        if ([[self.JSONdictionary objectForKey:@"refuse"] intValue]>=3) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)boolSpider{
    if ([self checkJSONdictionary:@"spider"]) {
        return [[self.JSONdictionary objectForKey:@"spider"] intValue] >= 2? YES:NO ;
    }
    return NO;
}

- (NSDictionary *)dictionaryParams{
    if ([self checkJSONdictionary:@"params"]) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSString *params = [self.JSONdictionary objectForKey:@"params"];
        id param = [parser objectWithString:params];
        if ([param isKindOfClass:[NSDictionary class]]) {
            return param;
        }
    }
    return [NSDictionary dictionaryWithObjectsAndKeys: nil];
}

- (NSInteger)relation{
    if ([self checkJSONdictionary:@"relation"]) {
        return [[self.JSONdictionary objectForKey:@"relation"] intValue];
    }
    return 1;
}

- (NSInteger)state{
    if ([self checkJSONdictionary:@"state"]) {
        return [[self.JSONdictionary objectForKey:@"state"] intValue];
    }
    return 1;
}


@end
