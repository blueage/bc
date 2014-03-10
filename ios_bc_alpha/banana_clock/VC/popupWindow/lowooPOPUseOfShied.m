//
//  lowooPOPUseOfShied.m
//  banana_clock
//
//  Created by MAC on 13-3-27.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPUseOfShied.h"

@implementation lowooPOPUseOfShied

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        _imageViewBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
        if (iPhone5||iPhone5_0) {
            _imageViewBack.image = GetPngImage(@"launch_bc5b");
        }else{
            _imageViewBack.image = GetPngImage(@"launch_bc4b");
        }
        _imageViewBack.alpha = 1;
        [self addSubview:_imageViewBack];
        
        _imageViewUp = [[UIImageView alloc]initWithFrame:CGRectMake(58, 31, 121, 41)];//160  65
        _imageViewCenter = [[UIImageView alloc]initWithFrame:CGRectMake(0, 103, 320, 240)];//160  223
        _imageViewDown = [[UIImageView alloc]initWithFrame:CGRectMake(103, 347, 114, 59)];//160   376
        
        if (iPhone5 || iPhone5_0) {
            _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [_imageViewUp setCenter:CGPointMake(160, 80)];
            [_imageViewCenter setCenter:CGPointMake(160, 280)];
            [_imageViewDown setCenter:CGPointMake(160, 450)];
        }else{
            _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [_imageViewUp setCenter:CGPointMake(160, 80)];
            [_imageViewCenter setCenter:CGPointMake(160, 245)];
            [_imageViewDown setCenter:CGPointMake(160, 400)];
        }
        _viewBack.backgroundColor = [UIColor clearColor];
        [self addSubview:_viewBack];
        
        
        
        
        _imageViewUp.image = GetPngImage(@"banana_logo");
        [_viewBack addSubview:_imageViewUp];
        
        
        _imageViewCenter.image = GetPngImage(@"bycall_pic01");
        [_viewBack addSubview:_imageViewCenter];
        
        
        _imageViewDown.image = GetPngImage(@"coin-3");
        [_viewBack addSubview:_imageViewDown];
        

        
        UIButton_custom *button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [_viewBack addSubview:button];
        

    }
    return self;
}



- (void)animation{
    _imageViewUp.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3);
    _imageViewCenter.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3);
    _imageViewDown.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3);
    
    

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _imageViewBack.alpha = 1.0f;
                         _imageViewUp.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              _imageViewUp.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                         
                     }];
    [UIView animateWithDuration:0.3
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _imageViewCenter.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              _imageViewCenter.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
    [UIView animateWithDuration:0.3
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _imageViewDown.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              _imageViewDown.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
}

- (void)buttonAction{
    if ([_delegate respondsToSelector:@selector(buttonUseOfShieldTouchupInsideWithView:)]) {
        [_delegate buttonUseOfShieldTouchupInsideWithView:self];
    }
}

@end
