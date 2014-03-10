//
//  lowooPOPAchievement.h
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPAwardedAchievementDelegate <NSObject>
- (void)buttonAchievementTouchUpinsideWithentity:(UIView *)entity;
@end


@interface lowooPOPAwardedAchievement : popView



@property (nonatomic, weak) id<lowooPOPAwardedAchievementDelegate>delegate;
@property (nonatomic, strong) UIImageView_custom *imageViewHead;



- (void)confirmAchieve:(modelAchievement *)achievement;


@end
