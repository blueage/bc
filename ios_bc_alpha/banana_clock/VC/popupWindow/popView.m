//
//  popView.m
//  banana_clock
//
//  Created by MAC on 13-10-14.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "popView.h"

@implementation popView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *imageViewBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
        imageViewBack.backgroundColor = [UIColor blackColor];
        imageViewBack.alpha = 0.5;
        [self addSubview:imageViewBack];
        
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _viewBack.backgroundColor = [UIColor clearColor];
        [self addSubview:_viewBack];
        
        _viewMove = [[UIView alloc] initWithFrame:CGRectZero];
        _viewMove.backgroundColor = [UIColor clearColor];
        [_viewBack addSubview:_viewMove];
        


    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
