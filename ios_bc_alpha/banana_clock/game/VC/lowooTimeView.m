//
//  lowooTimeView.m
//  test
//
//  Created by MAC on 13-2-22.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooTimeView.h"

@implementation lowooTimeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _delegateOnce = YES;
        
        _imageViewClock = [[UIImageView alloc]initWithFrame:CGRectMake(0, -6, 42, 42)];
        _imageViewClock.image = GetPngImage(@"clock");
        [self addSubview:_imageViewClock];
        
        UIImageView *imageViewColor = [[UIImageView alloc]initWithFrame:CGRectMake(46, 7, 93, 23)];
        imageViewColor.image = GetPngImage(@"timeColor");
        [self addSubview:imageViewColor];
        
        _viewMask = [[UIView alloc]initWithFrame:CGRectMake(47, 8, 90, 20)];
        _viewMask.userInteractionEnabled = NO;
        _viewMask.clipsToBounds = YES;
        _viewMask.backgroundColor = [UIColor clearColor];
        [self addSubview:_viewMask];
        
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(90, 0, 90, 20)];
        _maskView.userInteractionEnabled = NO;
        _maskView.backgroundColor = [UIColor whiteColor];
        [_viewMask addSubview:_maskView];
        
        UIImageView *imageViewFrame = [[UIImageView alloc]initWithFrame:CGRectMake(46, 7, 93, 23)];
        imageViewFrame.image = GetPngImage(@"gameTimeFrame");
        [self addSubview:imageViewFrame];
    }
    return self;
}



- (void)TimeViewMaskViewMoveWithRepeatCount:(NSInteger)repeatCount startPoint:(CGPoint)point score:(NSInteger)score{
CGPoint maskPoint = _maskView.center;
    //时间到 结束
    if (maskPoint.x <= (point.x - _maskView.frame.size.width)) {
        if (_delegateOnce) {
            [_delegate timeOut];
            _delegateOnce = NO;
        }
    }else{
        if (repeatCount%20==0) {
            [UIView animateWithDuration:0.03*10
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 _imageViewClock.transform = CGAffineTransformMakeRotation(M_PI/180*10);
                             } completion:^(BOOL finished) {
                                 
                             }];
        }else if(repeatCount%20==10){
            [UIView animateWithDuration:0.03*10
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 _imageViewClock.transform = CGAffineTransformMakeRotation(-M_PI/180*10);
                             } completion:^(BOOL finished) {
                                 
                             }];
        }
        
        
        maskPoint.x = maskPoint.x - _maskView.frame.size.width/(TIME)*0.03;
        _maskView.center = CGPointMake(maskPoint.x, maskPoint.y);
    }
}

@end
