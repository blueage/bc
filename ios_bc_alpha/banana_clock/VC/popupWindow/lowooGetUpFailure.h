//
//  lowooGetUpFailure.h
//  banana_clock
//
//  Created by MAC on 13-3-22.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol lowooGetUpFailureDelegate <NSObject>
- (void)buttonGetUpFailureTouchUpinsideWithEntity:(UIView *)entity;
@end

@interface lowooGetUpFailure : UIView
@property (nonatomic, weak) id<lowooGetUpFailureDelegate>delegate;
@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) UIImageView *imageViewBack;
@property (nonatomic, strong) UIView *viewMove;
@property (nonatomic, strong) UIButton_custom *buttonEnter;


@property (nonatomic, strong) UIImageView *imageViewPeople;
@property (nonatomic, strong) UIImageView *imageViewText;
@property (nonatomic, strong) UIButton_custom *buttonRepeat;
@end
