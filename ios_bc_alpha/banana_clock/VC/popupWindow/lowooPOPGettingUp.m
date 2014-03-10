//
//  lowooPOPGettingUp.m
//  banana_clock
//
//  Created by MAC on 13-3-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPGettingUp.h"

@implementation lowooPOPGettingUp

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _imageViewBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, -4, 320, 504)];
        if (iPhone5||iPhone5_0) {
            _imageViewBack.image = GetPngImage(@"launch_bc5b");
        }else{
            _imageViewBack.image = GetPngImage(@"launch_bc4b");
        }
        _imageViewBack.alpha = 1;
        [self addSubview:_imageViewBack];
        
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _viewBack.backgroundColor = [UIColor clearColor];
        _viewBack.clipsToBounds = YES;
        [self addSubview: _viewBack];

        _viewHead = [[viewHead alloc] init];
        _viewHead.view = [[UIView alloc] initWithFrame:CGRectZero];
        _imageViewProp = [[UIImageView alloc]initWithFrame:CGRectZero];
        if (iPhone5||iPhone5_0) {
            [_imageViewProp setFrame:CGRectMake(183, 60, 34, 35)];
            CGRect frame = _viewHead.view.frame;
            frame.origin.y = 70;
            [_viewHead.view setFrame:frame];
            
            _imageViewPeopleLeft = [[UIImageView alloc]initWithFrame:CGRectMake(-56-130, 220, 180, 190)];
            _imageViewPeopleRight = [[UIImageView alloc]initWithFrame:CGRectMake(183+130, 220, 180, 190)];
            if (LANGUAGE_CHINESE) {
                _imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(79, 230, 155, 85)];
                _imageViewText.image = GetPngImage(@"Callpage_text_cn1");
            }else{
                _imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(79, 250, 165, 35)];
                _imageViewText.image = GetPngImage(@"Callpage_text_en1");
            }
        }else{
            [_imageViewProp setFrame:CGRectMake(183, 25, 34, 35)];
            CGRect frame = _viewHead.view.frame;
            frame.origin.y = 40;
            [_viewHead.view setFrame:frame];
            
            _imageViewPeopleLeft = [[UIImageView alloc]initWithFrame:CGRectMake(-56-130, 180, 180, 190)];
            _imageViewPeopleRight = [[UIImageView alloc]initWithFrame:CGRectMake(183+130, 180, 180, 190)];
            if (LANGUAGE_CHINESE) {
                _imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(79, 200, 155, 85)];
                _imageViewText.image = GetPngImage(@"Callpage_text_cn1");
            }else{
                _imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(79, 240, 165, 35)];
                _imageViewText.image = GetPngImage(@"Callpage_text_en1");
            }
        }
        

        _imageViewPeopleLeft.image = GetPngImage(@"Callpage_pic01");
        [_viewBack addSubview:_imageViewPeopleLeft];
        
        _imageViewPeopleRight.image = GetPngImage(@"Callpage_pic02");
        [_viewBack addSubview:_imageViewPeopleRight];
        
        [_viewBack addSubview:_imageViewText];
        
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_viewBack addGestureRecognizer:_tap];
        
    }
    return self;
}

- (void)tapAction{
    if ([_delegate respondsToSelector:@selector(buttonGettingUpTouchUpInsideWithView:)]) {
        [_delegate buttonGettingUpTouchUpInsideWithView:self];
    }
}

- (void)confirmDataWithModelUser:(modelUser *)user TID:(NSInteger)tid{
    if (user.avatarUrl != nil) {
        [_viewHead setImageWithUrl:user.avatarUrl name:user.name];
    }else{
        [_viewHead setImageWithUrl:@"" name:user.name];
    }   
    NSString *smallName = [NSString stringWithFormat:@"%02d.png.small",tid];
    [_imageViewProp setImage:GetPngImage(smallName)];
}


- (void)animation{
    _imageViewText.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_TO_RADIANS(0.5));
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    [_timer fire];
    
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _imageViewPeopleLeft.transform = CGAffineTransformScale(CGAffineTransformRotate(CGAffineTransformTranslate(CGAffineTransformIdentity, 130, -25), DEGREES_TO_RADIANS(-0.5)), 0.98, 1);
                         _imageViewPeopleRight.transform = CGAffineTransformScale(CGAffineTransformRotate(CGAffineTransformTranslate(CGAffineTransformIdentity, -130, -25), DEGREES_TO_RADIANS(-0.5)), 0.98, 1);
                     } completion:^(BOOL finished) {

                     }];
}

- (void)animation1{
    [UIView animateWithDuration:0.05
                     animations:^{
                         _imageViewText.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_TO_RADIANS(0.5));

                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.05
                                          animations:^{
                                              _imageViewText.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_TO_RADIANS(-0.5));
                                          }];
                     }];
}



@end
