//
//  modelMedal.m
//  banana_clock
//
//  Created by MAC on 14-1-21.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "modelMedal.h"

@implementation modelMedal

- (NSString *)imageUrl{
    return [self checkNSStringJSONdictionary:@"pic"];
}

- (NSString *)nameChinese{
    return [self checkNSStringJSONdictionary:@"name"];
}

- (NSString *)nameEnglish{
    return [self checkNSStringJSONdictionary:@"English"];
}

- (NSString *)describChinese{
    return [self checkNSStringJSONdictionary:@"describ"];
}

- (NSString *)describEnglish{
    return [self checkNSStringJSONdictionary:@"e_describ"];
}

- (NSString *)percentage{
    return [NSString stringWithFormat:@"%@/%@",[self.JSONdictionary objectForKey:@"value"],[self.JSONdictionary objectForKey:@"max"]];
}

- (BOOL)boolGet{
    if ([[self.JSONdictionary objectForKey:@"ifget"] intValue]==1) {
        return YES;
    }
    return NO;
}

- (NSString *)timeGet{
    return [self checkNSStringJSONdictionary:@"gettime"];
}

- (NSArray *)arrayAchievement{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i=0; i<[[self.JSONdictionary objectForKey:@"achieve"] count]; i++) {
        modelAchievement *achievement = [[modelAchievement alloc] init];
        achievement.JSONdictionary = [[self.JSONdictionary objectForKey:@"achieve"] objectAtIndex:i];
        [array addObject:achievement];
    }
    return [NSArray arrayWithArray:array];
}


@end
