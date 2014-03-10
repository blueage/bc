//
//  lowooTimeView.h
//  test
//
//  Created by MAC on 13-2-22.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol lowooTimeViewDelegate <NSObject>
- (void)timeOut;
@end


@interface lowooTimeView : UIView


@property (nonatomic, assign) BOOL delegateOnce;

@property (nonatomic, weak) id <lowooTimeViewDelegate>delegate;

@property (strong, nonatomic) UIImageView *imageViewClock;

@property (nonatomic, strong) UIView *viewMask;

@property (strong, nonatomic) UIView *maskView;




- (void)TimeViewMaskViewMoveWithRepeatCount:(NSInteger )repeatCount startPoint:(CGPoint )point score:(NSInteger )score;



@end
