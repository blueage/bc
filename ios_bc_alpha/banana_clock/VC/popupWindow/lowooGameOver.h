//
//  lowooGameOver.h
//  banana_clock
//
//  Created by MAC on 13-3-7.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooGameOverDelegate <NSObject>
- (void)buttonGameOverColoseTouchUpinsideWithEntity:(UIView *)entity;
@end



@interface lowooGameOver : popView

@property (nonatomic, weak) id<lowooGameOverDelegate>delegate;
@property (nonatomic, strong) UIImageView *imageViewPeople;
@property (nonatomic, strong) UIButton_custom *buttonRepeat;

@end
