//
//  modelAchieve.m
//  banana_clock
//
//  Created by MAC on 14-1-21.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "modelAchievement.h"

@implementation modelAchievement

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

- (NSString *)imageUrl{
    return [self checkNSStringJSONdictionary:@"pic"];
}

- (NSString *)timeGet{
    return [self checkNSStringJSONdictionary:@"gettime"];
}

- (NSString *)percentage{
    return [NSString stringWithFormat:@"%@/%@",[self.JSONdictionary objectForKey:@"value"],[self.JSONdictionary objectForKey:@"need"]];
}

- (int)coin{
    return [[self.JSONdictionary objectForKey:@"coin"] intValue];
}

- (BOOL)boolGet{
    if ([[self.JSONdictionary objectForKey:@"ifget"] intValue]==1) {
        return YES;
    }
    return NO;
}


@end
