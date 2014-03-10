//
//  achievementView.h
//  banana_clock
//
//  Created by Lowoo on 2/12/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView_custom.h"

@interface achievementView : UIView

@property (nonatomic, strong) UIImageView_custom *imageViewIcon;
@property (nonatomic, strong) UILabel *labelChinese;
@property (nonatomic, strong) UILabel *labelEnglish;

- (void)setAchievementData:(modelAchievement *)achieve;

- (void)setanimation;

@end
