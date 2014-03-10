//
//  lowooTarget.h
//  test
//
//  Created by MAC on 13-2-25.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lowooTarget : UIView

@property (nonatomic, assign) NSInteger randomCount;
@property (nonatomic, assign) BOOL left;


@property (strong, nonatomic) UIView *viewBed;


@property (strong, nonatomic) UIImageView *imageViewMorpheus;



- (void)sleepBedMoveWithRepeatCount:(NSInteger )repeatCount score:(NSInteger )score hitMorpheus:(BOOL )hitMorpheus;






@end
