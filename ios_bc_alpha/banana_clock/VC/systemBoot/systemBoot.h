//
//  systemBoot.h
//  banana_clock
//
//  Created by MAC on 13-12-3.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "lowooTimeSet.h"
@class systemBoot;


@interface systemBoot : NSObject<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *viewAlpha;
@property (nonatomic, strong) UIView *viewBase;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageViewPoint;
@property (nonatomic, assign) NSInteger currentPage;

- (void)addBaseView:(NSInteger)index;
- (void)addOnceView:(NSInteger)index;

@end



