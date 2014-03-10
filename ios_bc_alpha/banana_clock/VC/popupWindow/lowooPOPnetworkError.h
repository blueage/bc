//
//  lowooPOPnetworkError.h
//  banana_clock
//
//  Created by MAC on 13-10-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPnetworkErrorDelegate <NSObject>
- (void)networkError:(UIView *)entity;
@end

@interface lowooPOPnetworkError : popView

@property (nonatomic ,weak) id<lowooPOPnetworkErrorDelegate>delegate;
@property (nonatomic, strong) UIImageView *imageViewPeople;


@end
