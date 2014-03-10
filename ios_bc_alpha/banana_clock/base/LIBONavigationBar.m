//
//  LIBONavigationBar.m
//  banana_clock
//
//  Created by Lowoo on 2/8/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import "LIBONavigationBar.h"

@implementation LIBONavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //左按钮
        self.viewLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 49, 90)];

        
        self.buttonLeft = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.buttonLeft setImage:[UIImage imageNamed:@"topBtnL01.png"] forState:UIControlStateNormal];
        [self.buttonLeft setImage:[UIImage imageNamed:@"topBtnL02.png"] forState:UIControlEventTouchDown];
        [self.buttonLeft setHighlighted:NO];
        [self.buttonLeft setFrame:CGRectMake(0,0,49,40)];
        [self.buttonLeft addTarget:self action:@selector(leftButtonDidTouchedUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self.viewLeft addSubview:self.buttonLeft];
        
        self.imageViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 19)];
        [self.viewLeft addSubview:self.imageViewLeft];
        
        //右按钮
        self.viewRight = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-49, 0, 449, 40)];
        
        self.buttonRight = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.buttonRight setImage:[UIImage imageNamed:@"topBtnR01.png"] forState:UIControlStateNormal];
        [self.buttonRight setImage:[UIImage imageNamed:@"topBtnR02.png"] forState:UIControlEventTouchDown];
        [self.buttonRight setHighlighted:NO];
        [self.buttonRight setFrame:CGRectMake(0,0,49,40)];
        [self.buttonRight addTarget:self action:@selector(rightButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self.viewRight addSubview:self.buttonRight];
        
        self.imageViewRight = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 19)];
        [self.viewRight addSubview:self.imageViewRight];
        
        [self addSubview:self.viewLeft];
        [self addSubview:self.viewRight];
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
