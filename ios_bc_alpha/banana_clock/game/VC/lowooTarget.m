//
//  lowooTarget.m
//  test
//
//  Created by MAC on 13-2-25.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooTarget.h"

@implementation lowooTarget

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageViewMorpheus = [[UIImageView alloc]initWithFrame:CGRectMake(132, 138, 57, 82)];
        _imageViewMorpheus.image = GetPngImage(@"morpheus11");
        [self addSubview:_imageViewMorpheus];
        
        _viewBed = [[UIView alloc]initWithFrame:CGRectMake(21, 41, 283, 283)];
        UIImageView *imageviewBed = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 283, 283)];
        imageviewBed.image = GetPngImage(@"bigHand");
        [_viewBed addSubview:imageviewBed];
        [self addSubview:_viewBed];
    }
    return self;
}


- (void)setNeedsDisplay{
    _left = NO;
    _randomCount = 1;
}

- (void)sleepBedMoveWithRepeatCount:(NSInteger )repeatCount score:(NSInteger )score hitMorpheus:(BOOL)hitMorpheus{
    if (repeatCount%120==3) {
        
        [UIView animateWithDuration:0.03*60
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _viewBed.transform = CGAffineTransformMakeRotation(M_PI/180*10);
                         } completion:^(BOOL finished) {
                             
                         }];
    }else if(repeatCount%120==60){
        [UIView animateWithDuration:0.03*60
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _viewBed.transform = CGAffineTransformMakeRotation(-M_PI/180*10);
                         } completion:^(BOOL finished) {
                             
                         }];
        
    }
    
    //击中目标
    if (hitMorpheus) {
        [_imageViewMorpheus setImage:GetPngImage(@"morpheusInjury")];
    }else{
        if (score>15) {
            if (repeatCount%4==0) {
                [_imageViewMorpheus setImage:GetPngImage(@"morpheus21")];
            }else if(repeatCount%4==2){
                [_imageViewMorpheus setImage:GetPngImage(@"morpheus22")];
            }
        }else{
            if (repeatCount%4==0) {
                [_imageViewMorpheus setImage:GetPngImage(@"morpheus11")];
            }else if(repeatCount%4==2){
                [_imageViewMorpheus setImage:GetPngImage(@"morpheus12")];
            }
        }
    }
    
    
    
    NSInteger random = arc4random()%10;
    _randomCount ++;
    if (random == 3) {
        if (_randomCount > 30) {
            _left = !_left;
            _randomCount = 1;
        }
        
    }
    
    CGPoint point = self.center;
    if (point.x<32) {
        _randomCount = 1;
        _left = NO;
    }else if(point.x>288){
        _randomCount = 1;
        _left = YES;
    }
    if (!hitMorpheus) {
        if (_left) {
            point.x = point.x - 4 + sin(repeatCount);
        }else{
            point.x = point.x + 4 + sin(repeatCount);
        }
    }
    
    self.center = point;
}

@end
