//
//  UINavigationBar_custom.m
//  banana_clock
//
//  Created by MAC on 13-10-9.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#define BackTage  999001
#define ButtonLeftTage   100002
#define ButtonRightTage  100003

#import "UINavigationBar_custom.h"

@implementation UINavigationBar_custom

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    UIImageView *back = (UIImageView *)[self viewWithTag:BackTage];
    if (!back) {
        back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        [back setTag:BackTage];
        back.image = GetPngImage(@"top");
        [self addSubview:back];
    }
    [self sendSubviewToBack:back];
}

- (void)setNeedsLayout{
    [super setNeedsLayout];
    
    self.barStyle = (_stateBarStyle)? [_stateBarStyle integerValue]:DefaultStateBarStyle;
    UIView *viewStatusBar = [self viewWithTag:99900];
    if (!viewStatusBar) {
        viewStatusBar = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.bounds.size.width, 20)];
        [viewStatusBar setTag:99900];
        viewStatusBar.backgroundColor = (_stateBarColor)? _stateBarColor:DefaultStateBarColor;
        [self addSubview:viewStatusBar];
    }
    
    /**< 起到在IOS 7中navbar 和state bar 不 悬浮的作用*/
    self.translucent = NO;
    //self.tintColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setStateBarColor:(UIColor *)stateBarColor{
    _stateBarColor = stateBarColor;
    UIView *viewStatusBar = [self viewWithTag:99900];
    if (!viewStatusBar) {
        [self setNeedsLayout];
    }
}

- (void)setCusBarStyele:(UIBarStyle)cusBarStyele{
    _stateBarStyle = [NSNumber numberWithInteger:cusBarStyele];
    [self setNeedsLayout];
}

- (void)setDefault{
    self.stateBarColor = DefaultStateBarColor;
    self.cusBarStyele = DefaultStateBarStyle;
}



@end
