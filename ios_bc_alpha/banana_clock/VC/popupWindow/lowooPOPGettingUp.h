//
//  lowooPOPGettingUp.h
//  banana_clock
//
//  Created by MAC on 13-3-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol lowooPOPGettingUpDelegate <NSObject>
- (void)buttonGettingUpTouchUpInsideWithView:(UIView *)entity;
@end

@interface lowooPOPGettingUp : UIView


@property (nonatomic, weak) id<lowooPOPGettingUpDelegate>delegate;

@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) UIImageView *imageViewBack;


@property (nonatomic, strong) viewHead *viewHead;
@property (nonatomic, strong) UIImageView *imageViewProp;


@property (nonatomic, strong) UIImageView *imageViewText;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, strong) UIImageView *imageViewPeopleLeft;
@property (nonatomic, strong) UIImageView *imageViewPeopleRight;


- (void)animation;
- (void)animation1;
- (void)confirmDataWithModelUser:(modelUser *)user TID:(NSInteger)tid;



@end
