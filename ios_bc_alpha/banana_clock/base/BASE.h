//
//  BASE.h
//  banana_clock
//
//  Created by MAC on 13-9-13.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BASE : NSObject


+ (NSString *)International:(NSString *)title;

+ (NSInteger )statusBarHeight;
+ (NSInteger )statusBarHeightIOS_6;

+ (NSInteger )navigationBarButton;

+ (BOOL)isNotNull:(id)parameter;

+ (NSInteger )height10;
+ (NSInteger )height10_ISO6;
+ (NSInteger )height15_ISO6;
+ (NSInteger )height15_ISO7;
+ (NSInteger )height5_ISO6;
+ (NSInteger )height2_IOS6;


@end
