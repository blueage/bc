//
//  lowooPOPFlollowSuccess.h
//  banana_clock
//
//  Created by MAC on 14-1-15.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "popView.h"

@protocol lowooPOPFollowSuccessDelegate <NSObject>
- (void)buttonFollowCloseTouchUpInsideWithView:(UIView *)entity;
@end

@interface lowooPOPFlollowSuccess : popView

@property (nonatomic, weak) id<lowooPOPFollowSuccessDelegate>delegate;
@property (nonatomic, strong) UIImageView *imageViewDuigou;

@end
