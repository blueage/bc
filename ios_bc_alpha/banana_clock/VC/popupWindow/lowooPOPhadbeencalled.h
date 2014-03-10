//
//  lowooPOPhadbeencalled.h
//  banana_clock
//
//  Created by MAC on 13-5-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "lowooViewController.h"

@interface lowooPOPhadbeencalled : lowooViewController

@property (nonatomic, strong) UIImageView *imageViewBack;
@property (nonatomic, strong) viewHead *viewHead;


@property (nonatomic, strong) UIImageView *imageViewPeople;
@property (nonatomic, strong) UIImageView *imageViewText;



- (void)animation;
- (void)confirmDataWithUser:(modelUser *)user;

@end
