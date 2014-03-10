//
//  UIButtonRepeat.m
//  circleNew
//
//  Created by Lowoo on 2/16/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import "UIButtonRepeat.h"

@implementation UIButtonRepeat

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.highlighted = YES;
    }
    return self;
}

- (void)buttonAction:(UIButton *)button{
    self.boolDown = !self.boolDown;
}

- (void)setBoolDown:(BOOL)boolDown{
    _boolDown = boolDown;
    if (self.boolDown) {
        [self setImage:[UIImage imageNamed:[self.dictionaryImages objectForKey:@"downa"]] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:[self.dictionaryImages objectForKey:@"downb"]] forState:UIControlStateHighlighted];
    }else{
        [self setImage:[UIImage imageNamed:[self.dictionaryImages objectForKey:@"upa"]] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:[self.dictionaryImages objectForKey:@"upb"]] forState:UIControlStateHighlighted];
    }
}

@end
