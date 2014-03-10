//
//  lowooLifeValueView.h
//  test
//
//  Created by MAC on 13-2-22.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lowooLifeValueView : UIView




@property (strong, nonatomic) UIImageView *imageViewHead;

@property (nonatomic, strong) UIView *viewMask;

@property (strong, nonatomic) UIView *bloodView;



- (void)bloodViewMoveWithScore:(NSInteger )score;

- (void)knockdownTheBossWithScore:(NSInteger )score;


@end
