//
//  userListModel.h
//  banana_clock
//
//  Created by MAC on 14-1-21.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "model.h"
#import <Foundation/Foundation.h>

@interface modelUser : model

@property (nonatomic) BOOL boolTodayCanBeCall;
@property (nonatomic) BOOL boolFoucs;
@property (nonatomic) BOOL boolRefuse;
@property (nonatomic) BOOL boolSpider;
@property (nonatomic) NSInteger relation;
@property (nonatomic) NSInteger state;
@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *propID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *timeStart;
@property (nonatomic, strong) NSString *timeStop;
@property (nonatomic, strong) NSArray *arrayGetMedal;
@property (nonatomic, strong) NSDictionary *dictionaryParams;


@end
