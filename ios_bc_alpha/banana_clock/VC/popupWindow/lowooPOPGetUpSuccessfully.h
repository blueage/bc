//
//  lowooPOPGetUpSuccessfully.h
//  banana_clock
//
//  Created by MAC on 13-3-22.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol lowooPOPGetUpSuccessfullyDelegate <NSObject>
- (void)buttonGetUpSuccessfullyTouchUpinsideWithentity:(UIView *)entity;
@end




@interface lowooPOPGetUpSuccessfully : UIView


@property (nonatomic, weak) id<lowooPOPGetUpSuccessfullyDelegate>delegate;
@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) UIView *viewBack1;
@property (nonatomic, strong) UIImageView *imageViewBack;
@property (nonatomic, strong) UIImageView *imageViewPeople;
@property (nonatomic, strong) UIImageView *imageViewText;
@property (nonatomic, strong) UIImageView *imageViewGold;
@property (nonatomic, strong) UIButton_custom *buttonEnter;





- (void)animation;





@end
