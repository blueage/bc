//
//  UIImageViewRepeat.m
//  circleNew
//
//  Created by Lowoo on 2/14/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import "UIImageViewRepeat.h"

@implementation UIImageViewRepeat

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.highlighted = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setBoolTouchDown:(BOOL)boolTouchDown{
    _boolTouchDown = boolTouchDown;
    if (self.boolTouchDown) {
        self.image = self.imageDown;
    }else{
        self.image = self.imageUp;
    }
}

- (void)touchAction{
    self.boolTouchDown = !self.boolTouchDown;
    [[lowooMusic sharedLowooMusic] SystemSoundID:@"click" type:@"mp3"];
    if ([_delegate respondsToSelector:@selector(imageViewRepeatTaped:)]) {
        [_delegate imageViewRepeatTaped:self];
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
