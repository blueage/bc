//
//  activityView.m
//  banana_clock
//
//  Created by MAC on 13-8-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "activityView.h"
#define durationTime 0.15

@implementation activityView

+ (id)sharedActivityView{
    
    static activityView *activity;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        activity = [[self alloc] init];
    });
    return activity;
}

- (id)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}

- (void)showHUD:(NSInteger)time{
    [self removeHUD];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSArray *windows = [UIApplication sharedApplication].windows;
    if (windows.count>0) {
        keyWindow = [windows objectAtIndex:0];
    }
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [keyWindow addSubview:_view];
    
    UIImage *imageBack = GetPngImage(@"loadingBack");
    UIImageView *imageViewBack = [[UIImageView alloc] initWithImage:imageBack];
    [imageViewBack setFrame:(CGRect){CGPointZero,imageBack.size.width*3/5,imageBack.size.height*3/5}];
    [imageViewBack setCenter:_view.center];
    [_view addSubview:imageViewBack];
    
    UIImage *imageLoading = GetPngImage(@"loadingBanana");
    UIImageView *imageViewLoading = [[UIImageView alloc] initWithImage:imageLoading];
    [imageViewLoading setFrame:(CGRect){CGPointZero,imageLoading.size.width/2,imageLoading.size.height/2}];
    [imageViewLoading setCenter:CGPointMake(_view.center.x, _view.center.y - 10)];
    [_view addSubview:imageViewLoading];
    //旋转动画
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:2*M_PI];
    animation.duration = 0.7;
    animation.autoreverses = NO;
    animation.cumulative = YES;
    animation.repeatCount = HUGE_VALF;
    [imageViewLoading.layer addAnimation:animation forKey:nil];

    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageBack.size.width*3/5, 25)];
    _label.text = @"Loading";
    _label.font = [UIFont boldSystemFontOfSize:16.0f];
    _label.textColor = [UIColor colorWithRed:255/255.0 green:212/255.0 blue:55/255.0 alpha:1];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor clearColor];
    [_label setCenter:(CGPoint){_view.center.x, _view.center.y+20}];
    [_view addSubview:_label];


    _timerText = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animationText) userInfo:nil repeats:YES];
    if (time>0) {
        _timerEnd = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(removeHUD) userInfo:nil repeats:NO];
    }
}

- (void)animationText{
        if ([_label.text isEqualToString:@"Loading"]) {
            _label.text = @"Loading.";
        }
        else if ([_label.text isEqualToString:@"Loading."]) {
            _label.text = @"Loading..";
        }
        else if ([_label.text isEqualToString:@"Loading.."]) {
            _label.text = @"Loading...";
        }
        else if ([_label.text isEqualToString:@"Loading..."]) {
            _label.text = @"Loading";
        }
}

- (void)removeHUD{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

     if (_view) {
         [_view removeFromSuperview];_view = nil;
         [_timerEnd invalidate];_timerEnd = nil;
         [_timerText invalidate];_timerText = nil;
     }

}


@end
