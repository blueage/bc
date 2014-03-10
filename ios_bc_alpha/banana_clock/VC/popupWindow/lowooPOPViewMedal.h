//
//  lowooPOPViewMedal.h
//  banana_clock
//
//  Created by MAC on 13-3-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPViewMedalDelegate <NSObject>
- (void)buttonViewMedalTouchUpinsideWithentity:(UIView *)entity;
@end



@interface lowooPOPViewMedal : popView

@property (nonatomic, weak) id<lowooPOPViewMedalDelegate>delegate;
@property (nonatomic, strong) UIImageView_custom *imageViewAchievements;


@property (nonatomic, strong) UILabel *labelChinese;
@property (nonatomic, strong) UILabel *labelChineseDescrib;
@property (nonatomic, strong) UILabel *labelDay;
@property (nonatomic, strong) UILabel *labelEnglishDescrib;


- (void)confirmMedal:(modelMedal *)medal;



@end
