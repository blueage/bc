//
//  UIButton_custom.m
//  banana_clock
//
//  Created by MAC on 13-9-16.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "UIButton_custom.h"

#define music_default @"click"

@implementation UIButton_custom

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(actionWithImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [self addTarget:self action:@selector(buttonTouchUpInsideMusic) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)removeTarget{
    [self removeTarget:self action:@selector(actionWithImage) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonTouchUpInsideMusic{
    NSString *soundName = (_music)?_music:music_default;
    [[lowooMusic sharedLowooMusic] SystemSoundID:soundName type:@"mp3"];
}


- (void)setMusic:(NSString *)music{
    _music = music;
}


- (void)setFrame:(CGRect)frame image:(NSString *)normal image:(NSString *)highlited{
    _imageNormal = GetPngImage(normal);
    _imageHighlited = GetPngImage(highlited);
    
    [self setFrame:frame];
    [self setImage:_imageNormal forState:UIControlStateNormal];
    [self setImage:_imageHighlited forState:UIControlEventTouchDown];
}

- (void)addTarget:(id)target action:(SEL)action{
    _buttonTarget = target;
    _buttonAction = action;
    
}

- (void)setImageNormal:(UIImage *)imageNormal{
    _imageNormal = imageNormal;
    [self setImage:imageNormal forState:UIControlStateNormal];
}

- (void)setImageHighlited:(UIImage *)imageHighlited{
    _imageHighlited = imageHighlited;
    [self setImage:_imageHighlited forState:UIControlEventTouchDown];
}



- (void)actionWithImage{
    if (_imageHighlited) {
        [self setImage:_imageHighlited forState:UIControlStateNormal];
    }
    
    if (_boolMask) {
        
    }else{//默认添加遮罩
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor clearColor];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_maskView];
    }
    
    
    [self performSelector:@selector(setDelayAction) withObject:nil afterDelay:0.15];
    [self performSelector:@selector(setDelayAction1) withObject:nil afterDelay:0.2];
}

- (void)setDelayAction{
    if (_imageNormal) {
        [self setImage:_imageNormal forState:UIControlStateNormal];
    }
}

- (void)setDelayAction1{
    @try {
        if (self&&_buttonAction&&_buttonTarget) {
            SuppressPerformSelectorLeakWarning(
                [_buttonTarget performSelector:_buttonAction withObject:self];
            );
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
//        if (_maskView) {
//            [_maskView removeFromSuperview];
//            _maskView = nil;
//        }
        [self performSelector:@selector(test) withObject:nil afterDelay:.2];
    }
    
}

- (void)test{
    if (_maskView) {
        [_maskView removeFromSuperview];
        _maskView = nil;
    }
}

- (void)dealloc{
    if (_maskView) {
        [_maskView removeFromSuperview];
        _maskView = nil;
    }
    _imageNormal = nil;
    _imageHighlited = nil;
    _buttonTarget = nil;
    _buttonAction = nil;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}


@end
