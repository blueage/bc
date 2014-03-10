//
//  lowooPOPUseOfShied.h
//  banana_clock
//
//  Created by MAC on 13-3-27.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol lowooPOPUseOfShiedDelegate <NSObject>
- (void)buttonUseOfShieldTouchupInsideWithView:(UIView *)entity;
@end

@interface lowooPOPUseOfShied : UIView


@property (nonatomic, weak) id<lowooPOPUseOfShiedDelegate>delegate;

@property (nonatomic, strong) UIView *viewBack;

@property (nonatomic, strong) UIImageView *imageViewBack;
@property (nonatomic, strong) UIImageView *imageViewUp;
@property (nonatomic, strong) UIImageView *imageViewCenter;
@property (nonatomic, strong) UIImageView *imageViewDown;

- (void)animation;

@end
