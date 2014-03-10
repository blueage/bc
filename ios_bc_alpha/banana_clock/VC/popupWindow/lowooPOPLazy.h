//
//  lowooPOPLazy.h
//  banana_clock
//
//  Created by MAC on 13-3-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol lowooPOPLazyDelegate <NSObject>
- (void)buttonLazyTouchupInsideWithView:(UIView *)entity;
@end


@interface lowooPOPLazy : UIView

@property (nonatomic, weak) id<lowooPOPLazyDelegate>delegate;

@property (nonatomic, strong) UIView *viewBack;


@property (nonatomic, strong) UIImageView *imageViewBack;
@property (nonatomic, strong) UIImageView *imageViewUp;
@property (nonatomic, strong) UIImageView *imageViewCenter;
@property (nonatomic, strong) UIImageView *imageViewDown;

- (void)animation;

@end
