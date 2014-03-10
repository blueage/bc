//
//  lowooPOPgameSuccess.m
//  banana_clock
//
//  Created by MAC on 13-3-7.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPgameSuccess.h"

@implementation lowooPOPgameSuccess

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (iPhone5 || iPhone5_0) {
            [self.viewBack setFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewBack setFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }

        
        _viewBack1 = [[UIView alloc]initWithFrame:CGRectMake(43, 86, 234, 313)];
        _viewBack1.backgroundColor = [UIColor clearColor];
        [self.viewBack addSubview:_viewBack1];
        _viewBack1.hidden = YES;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 234, 313)];
        imageView.image = GetPngImage(@"POPPanelLarge");
        [_viewBack1 addSubview:imageView];
        
        
        self.buttonEnter = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.buttonEnter setFrame:CGRectMake(39, 235, 157, 53) image:@"POPOKButtonaEnglish" image:@"POPOKButtonbEnglish" ];
        [self.buttonEnter addTarget:self action:@selector(buttonEnterTouchUpinside:)];
        [_viewBack1 addSubview:self.buttonEnter];
        self.buttonEnter.userInteractionEnabled = NO;

        _imageViewPeople = [[UIImageView alloc]initWithFrame:CGRectMake(69, 30, 428/2.35, 680/2.35)];
        _imageViewPeople.image = GetPngImage(@"gameSuccessPeople");
        [self.viewBack addSubview:_imageViewPeople];
        _imageViewPeople.hidden = YES;
        
        self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(61, 176, 210, 74)];
        NSString *str = [BASE International:@"PanleGameText05"];
        self.imageViewText.image = GetPngImage(str);
        [self.viewBack addSubview:self.imageViewText];
        self.imageViewText.hidden = YES;
        
        _imageViewGold = [[UIImageView alloc]initWithFrame:CGRectMake(95, 251, 137, 57)];
        _imageViewGold.image = GetPngImage(@"Gold01");
        [self.viewBack addSubview:_imageViewGold];
        _imageViewGold.hidden = YES;
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
                                              self.buttonEnter.userInteractionEnabled = YES;
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
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
    
    self.imageViewText.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
    [UIView animateWithDuration:0.2
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.imageViewText.hidden = NO;
                         self.imageViewText.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                          animations:^{
                                              self.imageViewText.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                                          } completion:^(BOOL finished) {
                                              
                                          }];
                     }];
    
    _imageViewGold.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
    [UIView animateWithDuration:0.2
                          delay:0.4
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _imageViewGold.hidden = NO;
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



- (void)buttonEnterTouchUpinside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonGameSuccessCloseTouchUpinsideWithentity:)]) {
        [_delegate buttonGameSuccessCloseTouchUpinsideWithentity:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonGameSuccessCloseTouchUpinside" object:nil userInfo:nil];
}


@end
