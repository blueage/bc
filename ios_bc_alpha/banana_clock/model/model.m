//
//  model.m
//  banana_clock
//
//  Created by MAC on 14-1-21.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "model.h"

@implementation model

- (BOOL)checkJSONdictionary:(NSString *)key{
    if ([BASE isNotNull:self.JSONdictionary]) {
        if ([self.JSONdictionary isKindOfClass:[NSDictionary class]]) {
            if ([BASE isNotNull:[self.JSONdictionary objectForKey:key]]) {
                return YES;
            }
        }
    }
    return NO;
}

//超级取值   [model checkNSStringJSONdictionary:key] 等价于 model.key + -(NSString *)key{return [self.json objectforkey:key] }
- (NSString *)checkNSStringJSONdictionary:(NSString *)key{
    if ([BASE isNotNull:self.JSONdictionary]) {
        if ([self.JSONdictionary isKindOfClass:[NSDictionary class]]) {
            if ([BASE isNotNull:[self.JSONdictionary objectForKey:key]]) {
                return [self.JSONdictionary objectForKey:key];
            }
        }
    }
    return @"";
}

@end
