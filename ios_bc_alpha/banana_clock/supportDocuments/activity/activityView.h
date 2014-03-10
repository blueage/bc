//
//  activityView.h
//  banana_clock
//
//  Created by MAC on 13-8-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface activityView : NSObject


@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSTimer *timerText;
@property (nonatomic, strong) NSTimer *timerEnd;
@property (nonatomic, strong) UILabel *label;


+ (id)sharedActivityView;

- (void)showHUD:(NSInteger)time;
- (void)removeHUD;

@end
