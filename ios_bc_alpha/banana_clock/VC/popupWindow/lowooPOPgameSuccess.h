//
//  lowooPOPgameSuccess.h
//  banana_clock
//
//  Created by MAC on 13-3-7.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPgameSuccessDelegate <NSObject>
- (void)buttonGameSuccessCloseTouchUpinsideWithentity:(UIView *)entity;
@end


@interface lowooPOPgameSuccess : popView

@property (nonatomic, weak) id<lowooPOPgameSuccessDelegate>delegate;

@property (nonatomic, strong) UIView *viewBack1;
@property (nonatomic, strong) UIImageView *imageViewPeople;
@property (nonatomic, strong) UIImageView *imageViewGold;



- (void)animation;

@end
