//
//  circleView.h
//  circleNew
//
//  Created by MAC on 14-2-11.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "circleImageView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
@class circleView;

@protocol circleViewDelegate <NSObject>
@optional
- (void)circleView:(circleView *)circleView startAngle:(float)angle;
- (void)circleView:(circleView *)circleView didSelectStart:(int)start End:(int)end;
- (void)circleView:(circleView *)circleView selectEnd:(int)end endDistance:(int)distance;
- (void)circleViewFinishedSelect:(circleView *)circleView;
- (void)circleViewStartMove:(circleView *)circleView;
@end

@protocol circleViewDataSource <NSObject>
@required
- (NSInteger)CircleViewMaxDistance;
- (NSInteger)CircleViewMinDistance;
@end

@interface circleView : UIView<UIGestureRecognizerDelegate>

@property (nonatomic) CGFloat radius;
@property (nonatomic) CGPoint center;
@property (nonatomic) CGFloat average_radina;
@property (nonatomic) CGPoint pointDrag;
@property (nonatomic) NSInteger step;

@property (nonatomic) BOOL isInConfirmButton;
@property (nonatomic) BOOL isOutOfScope;

@property (nonatomic, assign) id <circleViewDelegate> delegate;
@property (nonatomic, assign) id <circleViewDataSource> dataSource;
@property (nonatomic, strong) circleImageView *imageViewStart;
@property (nonatomic, strong) circleImageView *imageViewEnd;
@property (nonatomic, strong) circleImageView *imageViewProgress;
@property (nonatomic, assign) float initailStartAngle;
@property (nonatomic, assign) float initailProgress;
@property (nonatomic, assign) float initailEndAngle;
@property (nonatomic, assign) BOOL boolStart;
@property (nonatomic, assign) float startMove;//开始点移动距离 共114
@property (nonatomic, assign) int endMove;


@property (nonatomic) NSInteger startCurrentPage;
@property (nonatomic) NSInteger endCurrentPage;

- (void)loadViewWithStartTime:(NSInteger)start EndTime:(NSInteger)end;


@property (nonatomic) NSInteger endDistance;

@end
