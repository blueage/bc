//
//  circleImageView.m
//  circleNew
//
//  Created by MAC on 14-2-11.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "circleImageView.h"

@implementation circleImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (float)angle{
    return self.current_radian/(2*M_PI)*360;
}

- (NSInteger)count{
    NSInteger num = (int)(self.angle/2.5);
    num = 72 - num;
    if (num<0) {
        num += 144;
    }
    return num;
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
