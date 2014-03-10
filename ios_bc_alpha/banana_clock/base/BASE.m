//
//  BASE.m
//  banana_clock
//
//  Created by MAC on 13-9-13.
//  Copyright (c) 2013年 MAC. All rights reserved.
//


#import "BASE.h"

@interface BASE ()

@end

@implementation BASE




+ (NSInteger )statusBarHeight{
    if (IOS_7) {
        return 20;
    }
    return 0;
}

+ (NSInteger )statusBarHeightIOS_6{
    if (IOS_7) {
        return 0;
    }
    return 20;
}

+ (NSInteger )navigationBarButton{
    if (IOS_7) {
        return 12;
    }
    return 0;
}

+ (NSInteger )height10{
    if (IOS_7) {
        return -10;
    }
    return 0;
}

+ (NSInteger )height10_ISO6{
    if (!IOS_7) {
        return 10;
    }
    return 0;
}

+ (NSInteger )height15_ISO6{
    if (!IOS_7) {
        return 15;
    }
    return 0;
}

+ (NSInteger )height15_ISO7{
    if (IOS_7) {
        return 20;
    }
    return 0;
}

+ (NSInteger )height5_ISO6{
    if (!IOS_7) {
        return 5;
    }
    return 0;
}

+ (NSInteger )height2_IOS6{
    if (!IOS_7) {
        return 2;
    }
    return 0;
}

+ (BOOL)isNotNull:(id)parameter{
    if (parameter) {
        if (parameter == [NSNull null] || parameter == nil) {
            return NO;
        }
        return YES;
    }
    return NO;
}



+ (NSString *)International:(NSString *)title{
    NSDictionary *dictionaryInternational;
    
    if (LANGUAGE_CHINESE) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"chinese" ofType:@"plist"];
        dictionaryInternational = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }else{
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"english" ofType:@"plist"];
        dictionaryInternational = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        
    }
    return [dictionaryInternational objectForKey:title];
}



@end
