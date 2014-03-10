//
//  lowooPOPLazy.m
//  banana_clock
//
//  Created by MAC on 13-3-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPLazy.h"

@implementation lowooPOPLazy

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
        
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _viewBack.backgroundColor = [UIColor clearColor];
        [self addSubview:_viewBack];
        
        
        _imageViewUp = [[UIImageView alloc]initWithFrame:CGRectMake(58, 31, 121, 41)];//160  65
        _imageViewCenter = [[UIImageView alloc]initWithFrame:CGRectMake(0, 103, 320, 240)];//160  223
        _imageViewDown = [[UIImageView alloc]initWithFrame:CGRectMake(103, 347, 114, 59)];//160   376
        
        _imageViewUp.image = GetPngImage(@"banana_logo");
        
        [_viewBack addSubview:_imageViewUp];
        
        
        _imageViewCenter.image = GetPngImage(@"bycall_pic02");
        
        [_viewBack addSubview:_imageViewCenter];
        
        
        //_imageViewDown.image = GetPngImage(@"coin-1");
        
        [_viewBack addSubview:_imageViewDown];
        
        if (iPhone5||iPhone5_0) {
            [_imageViewUp setCenter:CGPointMake(160, 90)];
            [_imageViewCenter setCenter:CGPointMake(160, 270)];
            [_imageViewDown setCenter:CGPointMake(160, 450)];
        }else{
            [_imageViewUp setCenter:CGPointMake(160, 80)];
            [_imageViewCenter setCenter:CGPointMake(160, 245)];
            [_imageViewDown setCenter:CGPointMake(160, 400)];
        }
        
        
        UIButton_custom *button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [_viewBack addSubview:button];
        
        
    }
    return self;
}


- (void)animation{
    _imageViewUp.transform = CGAffineTransformTranslate(_imageViewUp.transform, 0, -80);
    _imageViewCenter.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3);
    _imageViewDown.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3);
    
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _imageViewBack.alpha = 1.0f;
                         _imageViewUp.transform = CGAffineTransformTranslate(_imageViewUp.transform, 0, 100);
                         _imageViewCenter.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                         _imageViewDown.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              _imageViewUp.transform = CGAffineTransformTranslate(_imageViewUp.transform, 0, -5);
                                              _imageViewCenter.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                                              _imageViewDown.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
}

- (void)buttonAction{
    if ([_delegate respondsToSelector:@selector(buttonLazyTouchupInsideWithView:)]) {
        [_delegate buttonLazyTouchupInsideWithView:self];
        
    }
}

@end
