//
//  lowooPOPViewAchievements.h
//  banana_clock
//
//  Created by MAC on 13-3-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPViewAchievementsDelegate <NSObject>
- (void)buttonViewAchievementsTouchUpinsideWithentity:(UIView *)entity;
@end



@interface lowooPOPViewAchievements : popView


@property (nonatomic, weak) id<lowooPOPViewAchievementsDelegate>delegate;
@property (nonatomic, strong) UIImageView_custom *imageViewAchievements;



- (void)confirmData:(modelAchievement *)achieve;



@end
