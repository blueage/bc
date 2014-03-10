//
//  lowooDidNotGetTheAchievement.h
//  banana_clock
//
//  Created by MAC on 13-3-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooDidNotGetTheAchievementDelegate <NSObject>
- (void)buttonDidNotGetTheAchievementTouchUpinsideWithentity:(UIView *)entity;
@end

@interface lowooDidNotGetTheAchievement : popView

@property (nonatomic, weak) id<lowooDidNotGetTheAchievementDelegate>delegate;





@end
