//
//  lowooPOPGetUpSuccessfully.m
//  banana_clock
//
//  Created by MAC on 13-3-22.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPGetUpSuccessfully.h"
#import <QuartzCore/QuartzCore.h>

@implementation lowooPOPGetUpSuccessfully

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _imageViewBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, SCREEN_HEIGHT)];
        if (iPhone5||iPhone5_0) {
            _imageViewBack.image = GetPngImage(@"launch_bc5b");
        }else{
            _imageViewBack.image = GetPngImage(@"launch_bc4b");
        }
        _imageViewBack.alpha = 1;
        [self addSubview:_imageViewBack];
        
        if (iPhone5 || iPhone5_0) {
            _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        _viewBack.backgroundColor = [UIColor clearColor];
        [self addSubview:_viewBack];
        
        _viewBack1 = [[UIView alloc]initWithFrame:CGRectMake(43, 86, 234, 313)];
        _viewBack1.backgroundColor = [UIColor clearColor];
        [_viewBack addSubview:_viewBack1];
        _viewBack1.hidden = YES;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 234, 313)];
        imageView.image = GetPngImage(@"POPPanelLarge");
        [_viewBack1 addSubview:imageView];
        
        _buttonEnter = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonEnter addTarget:self action:@selector(buttonEnterTouchUpinside)];
        [_buttonEnter setFrame:CGRectMake(39, 235, 157, 53) image:[BASE International:@"POPDeterminea"] image:[BASE International:@"POPDetermineb"]];
        [_viewBack1 addSubview:_buttonEnter];
        _buttonEnter.userInteractionEnabled = NO;
        
        
        
        _imageViewPeople = [[UIImageView alloc]initWithFrame:CGRectMake(69, 30, 182, 290)];
        _imageViewPeople.image = GetPngImage(@"gameSuccessPeople");
        [_viewBack addSubview:_imageViewPeople];
        _imageViewPeople.hidden = YES;
        
        if (LANGUAGE_CHINESE) {
            _imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(60, 176, 212, 74)];
            _imageViewText.image = GetPngImage(@"gameSuccessTextnew");
        }else{
            _imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(55, 176, 216, 54)];
            _imageViewText.image = GetPngImage(@"gameSuccessTextnewEnglish");
        }
        [_viewBack addSubview:_imageViewText];
        _imageViewText.hidden = YES;
        
        _imageViewGold = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-217/2)/2, 251, 217/2,81/2)];
        _imageViewGold.image = GetPngImage(@"Gold05");
        [_viewBack addSubview:_imageViewGold];
        //_imageViewGold.hidden = YES;
    }
    return self;
}

- (void)animation{
    _viewBack1.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3);
    _viewBack1.hidden = NO;
    [UIView animateWithDuration:0.2
                     animations:^{
                         _viewBack1.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                          animations:^{
                                              _viewBack1.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                                          } completion:^(BOOL finished) {
                                              _buttonEnter.userInteractionEnabled = YES;
                                          }];
                     }];
    
    CGPoint point = _imageViewPeople.center;
    point.y = point.y - 480;
    _imageViewPeople.center = point;
    _imageViewPeople.hidden = NO;
    [UIView animateWithDuration:0.2
                     animations:^{
                         CGPoint point = CGPointMake(160, 185);
                         _imageViewPeople.center = point;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                          animations:^{
                                              CGPoint point = CGPointMake(160, 175);
                                              _imageViewPeople.center = point;
                                          }];
                     }];
    
    _imageViewText.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
    [UIView animateWithDuration:0.2
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _imageViewText.hidden = NO;
                         _imageViewText.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                          animations:^{
                                              _imageViewText.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                                          }];
                     }];
    
    _imageViewGold.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
    [UIView animateWithDuration:0.2
                          delay:0.4
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //_imageViewGold.hidden = NO;
                         _imageViewGold.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                          animations:^{
                                              _imageViewGold.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
}


- (void)buttonEnterTouchUpinside{
    if ([_delegate respondsToSelector:@selector(buttonGetUpSuccessfullyTouchUpinsideWithentity:)]) {
        [_delegate buttonGetUpSuccessfullyTouchUpinsideWithentity:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonGetUpSuccessfullyTouchUpinside" object:nil userInfo:nil];
}



@end
