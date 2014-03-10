//
//  lowooCarToon.h
//  banana_clock
//
//  Created by MAC on 13-3-5.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol lowooCarToonDelegate <NSObject>
@optional
- (void)carToonEnd;
- (void)carToonRemove:(UIView *)view;
@end



@interface lowooCarToon : UIView<UIScrollViewDelegate>

@property (nonatomic, weak) id<lowooCarToonDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *arrayPage;
@property (nonatomic, strong) UIImageView *imageViewLogo;
@property (nonatomic, assign) NSInteger currentPage;


@property (nonatomic, strong) UIImageView *imageView11;
@property (nonatomic, strong) UIImageView *imageView12;
@property (nonatomic, strong) UIImageView *imageView13;
@property (nonatomic, strong) UIImageView *imageView21;
@property (nonatomic, strong) UIImageView *imageView22;
@property (nonatomic, strong) UIImageView *imageView23;
@property (nonatomic, strong) UIImageView *imageView31;
@property (nonatomic, strong) UIImageView *imageView32;
@property (nonatomic, strong) UIImageView *imageView41;
@property (nonatomic, strong) UIImageView *imageView42;
@property (nonatomic, strong) UIImageView *imageView51;
@property (nonatomic, strong) UIImageView *imageView52;
@property (nonatomic, strong) UIImageView *imageView53;
@property (nonatomic, strong) UIImageView *imageView61;
@property (nonatomic, strong) UIImageView *imageView62;
@property (nonatomic, strong) UIImageView *imageView63;
@property (nonatomic, strong) UIImageView *imageView71;
@property (nonatomic, strong) UIImageView *imageView72;
@property (nonatomic, strong) UIImageView *imageView73;
@property (nonatomic, strong) UIImageView *imageView81;
@property (nonatomic, strong) UIImageView *imageView82;


@end
