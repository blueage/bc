//
//  lowooCloud.m
//  test
//
//  Created by MAC on 13-2-27.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooCloud.h"


@implementation lowooCloud

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageViewCloudSmall = [[UIImageView alloc]initWithFrame:CGRectMake(-247, 50, 567, 122)];
        [_imageViewCloudSmall setImage:GetPngImage(@"cloud2")];
        [self addSubview:_imageViewCloudSmall];
        
        _imageVeiwCloudSmallCopy = [[UIImageView alloc]initWithFrame:CGRectMake(320, 50, 567, 122)];
        [_imageVeiwCloudSmallCopy setImage:GetPngImage(@"cloud2")];
        [self addSubview:_imageVeiwCloudSmallCopy];
        
        _imageViewCloudBig = [[UIImageView alloc]initWithFrame:CGRectMake(-247, 20, 567, 122)];
        [_imageViewCloudBig setImage:GetPngImage(@"cloud1")];
        [self addSubview:_imageViewCloudBig];
        
        _imageVeiwCloudBigCopy = [[UIImageView alloc]initWithFrame:CGRectMake(320, 20, 567, 122)];
        [_imageVeiwCloudBigCopy setImage:GetPngImage(@"cloud1")];
        [self addSubview:_imageVeiwCloudBigCopy];


        
        _pointStart = CGPointMake(603, 81);
        _pointMiddle = CGPointMake(0, 81);
        _pointEnd = CGPointMake(-530, 81);
        
        _pointStartSmall = CGPointMake(603, 111);
        _pointEndSmall = CGPointMake(-530, 111);

    }
    return self;
}

- (void)scrollImageWithRepeatCount:(NSInteger )repeatCount{
    if (repeatCount%2==1) {
        if (_imageViewCloudBig.center.x<=_pointEnd.x) {
            _imageViewCloudBig.center = _pointStart;
        }
        [self scrollToNewPointWithImageView:_imageViewCloudBig];
        
        if (_imageVeiwCloudBigCopy.center.x<=_pointEnd.x) {
            _imageVeiwCloudBigCopy.center = _pointStart;
        }
        [self scrollToNewPointWithImageView:_imageVeiwCloudBigCopy];
    }

    

    if (repeatCount%6==1) {
        if (_imageViewCloudSmall.center.x<=_pointEndSmall.x) {
            _imageViewCloudSmall.center = _pointStartSmall;
        }
        [self scrollToNewPointWithImageView:_imageViewCloudSmall];
        
        if (_imageVeiwCloudSmallCopy.center.x<=_pointEndSmall.x) {
            _imageVeiwCloudSmallCopy.center = _pointStartSmall;
        }
        [self scrollToNewPointWithImageView:_imageVeiwCloudSmallCopy];
    }
}

- (void)scrollToNewPointWithImageView:(UIImageView *)imageView{
    CGPoint point = imageView.center;
    point.x = point.x - 0.4;
    imageView.center = point;
}



@end
