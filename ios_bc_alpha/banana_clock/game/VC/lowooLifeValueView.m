//
//  lowooLifeValueView.m
//  test
//
//  Created by MAC on 13-2-22.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooLifeValueView.h"

@implementation lowooLifeValueView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageViewHead = [[UIImageView alloc]initWithFrame:CGRectMake(-7, 0, 57, 43)];
        _imageViewHead.image = GetPngImage(@"morpheus_2");
        [self addSubview:_imageViewHead];
        
        UIImageView *imageViewColor = [[UIImageView alloc]initWithFrame:CGRectMake(47, 11, 121, 23)];
        imageViewColor.image = GetPngImage(@"gameLifeColor");
        [self addSubview:imageViewColor];
        
        _viewMask = [[UIView alloc]initWithFrame:CGRectMake(49, 10, 91, 23)];
        _viewMask.userInteractionEnabled = NO;
        _viewMask.backgroundColor = [UIColor clearColor];
        _viewMask.clipsToBounds = YES;
        [self addSubview:_viewMask];
        
        _bloodView = [[UIView alloc]initWithFrame:CGRectMake(89, 2, 91, 22)];
        _bloodView.userInteractionEnabled = NO;
        _bloodView.backgroundColor = [UIColor whiteColor];
        [_viewMask addSubview:_bloodView];
        
        UIImageView *imageViewFrame = [[UIImageView alloc]initWithFrame:CGRectMake(46, 11, 121, 23)];
        imageViewFrame.image = GetPngImage(@"gameLifeFrame");
        [self addSubview:imageViewFrame];
    }
    return self;
}

- (void)bloodViewMoveWithScore:(NSInteger )score{
    if (score>SCORE) {
        
    }else{
        UIImage *image = GetPngImage(@"morpheusChange");
        _imageViewHead.image = image;
        [self performSelector:@selector(setChangeImage:) withObject:[NSNumber numberWithInteger:score] afterDelay:0.3];
        CGPoint point = _bloodView.center;
        point.x = point.x - _bloodView.frame.size.width/SCORE;
        _bloodView.center = point;
    }
}

- (void)setChangeImage:(NSNumber *)score{
    if ([score intValue]<22) {
        _imageViewHead.image = GetPngImage(@"morpheus_2");
    }else if ([score intValue]<30){
        _imageViewHead.image = GetPngImage(@"morpheus3");
    }else if ([score intValue] == 30){
        _imageViewHead.image = GetPngImage(@"morpheus_dead");
    }
    
}

- (void)knockdownTheBossWithScore:(NSInteger )score{
    if (score==SCORE) {
        [self bloodViewMoveWithScore:score];
        //得到足够分数

    }else{
        [self bloodViewMoveWithScore:score];
    }
}

@end
