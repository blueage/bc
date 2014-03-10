//
//  BigImage.m
//  banana_clock
//
//  Created by MAC on 13-12-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "BigImage.h"

@implementation BigImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect screenBounds = ScreenBounds();
        
        [self setFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height)];
        self.backgroundColor = [UIColor blackColor];
        self.opaque = YES;
        self.alpha = 0.5f;
        self.userInteractionEnabled = YES;
    }
    return self;
}




- (void)prepareLoadingToDisplay{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTap:)];
    [self addGestureRecognizer:tap];
}

- (void)viewTap:(id)sender{
    [self dismiss];
}

-(void)showWithAnimation{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSArray *windows = [UIApplication sharedApplication].windows;
    if (windows.count>0) {
        keyWindow = [windows objectAtIndex:0];
    }
    self.alpha = 0.0f;
    [keyWindow addSubview:self];
    _imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_imageView];
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.alpha = 1;
                         [_imageView.layer setFrame:CGRectMake(0, 80, 320, 320)];
                     } completion:^(BOOL finished){
                         
                     }];
}

- (void)showImageWithUrlstring:(NSString *)string{
    _imageView = [[UIImageView_custom alloc] initWithFrame:CGRectMake(20, 120, 90, 90)];
    _imageView.alpha = 1.0f;
    [_imageView storeImageUrl:string];
    [self prepareLoadingToDisplay];
    [self showWithAnimation];
}

- (void)showDefaultImage{
    _imageView = [[UIImageView_custom alloc] initWithFrame:CGRectMake(20, 120, 90, 90)];
    _imageView.alpha = 1.0f;
    _imageView.image = GetPngImage(@"defaultHead");
    [_imageView setFrame:CGRectMake(20, 120, 90, 90)];
    [self prepareLoadingToDisplay];
    [self showWithAnimation];
}

- (void)dismiss{
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.alpha = 0.0f;
                         [_imageView.layer setFrame:CGRectMake(20, 120, 90, 90)];
                     } completion:^(BOOL finished){
                         _imageView.alpha = 0.0f;
                         [_imageView removeFromSuperview];
                         [self removeFromSuperview];
                         if ([_delegate respondsToSelector:@selector(removeBigImage:)]) {
                             [_delegate removeBigImage:self];
                         }
                     }];
    
}




@end
