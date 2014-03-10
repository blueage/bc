//
//  lowooCloud.h
//  test
//
//  Created by MAC on 13-2-27.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lowooCloud : UIView



@property (nonatomic, assign) CGPoint pointStart;
@property (nonatomic, assign) CGPoint pointMiddle;
@property (nonatomic, assign) CGPoint pointEnd;

@property (nonatomic, assign) CGPoint pointStartSmall;
@property (nonatomic, assign) CGPoint pointEndSmall;


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *imageViewCloudBig;
@property (nonatomic, strong) UIImageView *imageVeiwCloudBigCopy;

@property (nonatomic, strong) UIImageView *imageViewCloudSmall;
@property (nonatomic, strong) UIImageView *imageVeiwCloudSmallCopy;



- (void)scrollImageWithRepeatCount:(NSInteger )repeatCount;

@end
