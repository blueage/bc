//
//  textFieldLogin.m
//  banana_clock
//
//  Created by MAC on 14-1-25.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "textFieldLogin.h"

@implementation textFieldLogin

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect{
    UIColor *color = [UIColor colorWithWhite:0.3 alpha:0.7];
    [color setFill];
    self.alpha = 0.5;
    if (IOS_7) {
        rect.origin.y += 7;
    }
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:14]];
}


- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    if (IOS_7) {
        return CGRectMake(bounds.size.width-20+5, (bounds.size.height-20)/2+3, 16, 16);
    }else{
        return CGRectMake(bounds.size.width-20, (bounds.size.height-20)/2 - 4, 16, 16);
    }
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
