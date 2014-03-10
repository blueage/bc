//
//  clockVC.h
//  banana_clock
//
//  Created by Lowoo on 2/16/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import "lowooBaseView.h"
#import "circleView.h"
#import "UIImageViewRepeat.h"
#import "UIButtonRepeat.h"
#import "systemBoot.h"
#import "LocalNotification.h"

@interface clockVC : lowooBaseView <circleViewDataSource,
                                    circleViewDelegate,
                                    UIImageViewRepeatDelegate>

@property (nonatomic, strong) circleView *circle;
@property (nonatomic, strong) UIView *viewCircle;
@property (nonatomic, assign) NSInteger startOldNum;
@property (nonatomic, assign) NSInteger startCount;
@property (nonatomic, assign) NSInteger endOldNum;
@property (nonatomic, assign) NSInteger endCount;
@property (nonatomic, assign) float startOld_radian;
@property (nonatomic, assign) float endOld_radian;
@property (nonatomic, assign) NSInteger startScrollNum;
@property (nonatomic, assign) NSInteger endScrollNum;
@property (nonatomic, assign) NSInteger distanceTure;
@property (nonatomic, assign) BOOL startMove;

@property (nonatomic, strong) UIView *viewRepeat;
@property (nonatomic, strong) NSMutableArray *arrayImageViews;
@property (nonatomic, strong) UIButtonRepeat *buttonSun;
@property (nonatomic, strong) UIImageView *imageViewPeople;

@property (nonatomic, strong) UIView *viewStart;
@property (nonatomic, strong) UIImageView *imageView01;
@property (nonatomic, strong) UIImageView *imageView02;
@property (nonatomic, strong) UIImageView *imageView03;
@property (nonatomic, strong) UIImageView *imageView04;
@property (nonatomic, strong) UIImageView *imageView05;
@property (nonatomic, strong) UIView *viewEnd;
@property (nonatomic, strong) UIImageView *imageView11;
@property (nonatomic, strong) UIImageView *imageView12;
@property (nonatomic, strong) UIImageView *imageView13;
@property (nonatomic, strong) UIImageView *imageView14;
@property (nonatomic, strong) UIImageView *imageView15;


@property (nonatomic, strong) NSTimer *tiemrRetime;
@property (nonatomic, strong) systemBoot *boot;
@property (nonatomic, strong) NSMutableArray *arrayHTTP;

@property (nonatomic, assign) BOOL boolStart00;
@property (nonatomic, assign) BOOL boolEnd00;
@property (nonatomic, strong) UIImageView *imageViewBack;
@property (nonatomic, strong) UIImageView *imageViewBubble;
@property (nonatomic, strong) UIView *viewMask;

@end
