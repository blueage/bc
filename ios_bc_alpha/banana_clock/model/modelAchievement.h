//
//  modelAchieve.h
//  banana_clock
//
//  Created by MAC on 14-1-21.
//  Copyright (c) 2014年 MAC. All rights reserved.
//
#import "model.h"
#import <Foundation/Foundation.h>

@interface modelAchievement : model

@property (nonatomic, strong) NSString *nameChinese;
@property (nonatomic, strong) NSString *nameEnglish;
@property (nonatomic, strong) NSString *describChinese;
@property (nonatomic, strong) NSString *describEnglish;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *timeGet;
@property (nonatomic, strong) NSString *percentage;
@property (nonatomic) int coin;
@property (nonatomic) BOOL boolGet;



@end
