//
//  time&title.h
//  banana_clock
//
//  Created by MAC on 13-6-25.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#define TEXT_WIDTH  210
#define TEXT_FONT   22.0f


#import <Foundation/Foundation.h>
#import "THLabel.h"

@protocol time_titleDelegate <NSObject>
- (void)systemBootAction;
@end

@interface time_title : NSObject


@property (nonatomic, assign) id<time_titleDelegate>delegate;
@property (nonatomic, assign) BOOL booltimeshow;//是否显示时间
@property (nonatomic, assign) BOOL boolanimation;//是否执行动画
@property (nonatomic, strong) UIView *viewBase;
@property (nonatomic, strong) UIView *viewTitle;
@property (nonatomic, strong) THLabel *labelTitle;

@property (nonatomic, strong) UIView *viewTime;

@property (nonatomic, strong) NSMutableArray *mutableArrayStart;
@property (nonatomic, strong) UIImageView *imageViewleft;
@property (nonatomic, strong) UIImageView *imageViewRight;
@property (nonatomic, strong) UILabel *labelMiddle;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UILabel *labelName;

@property (nonatomic, strong) NSTimer *timerMedal;
@property (nonatomic, strong) NSTimer *timerAnimation;

@property (nonatomic, strong) UIView *viewBananaNumber;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) UIButton *buttonTitle;
@property (nonatomic, strong) UIButton *buttonTime;
@property (nonatomic, strong) UIView *viewButtonTime;
@property (nonatomic, strong) UIView *viewButtonTitle;


+ (time_title *)shareInstance;
- (void)start;
- (void)initUpdateServerTime:(NSNotification *)sender;

- (void)transitionToTitle;

- (void)systemBootAction:(UIButton *)button;

- (void)setHelp;

@end
