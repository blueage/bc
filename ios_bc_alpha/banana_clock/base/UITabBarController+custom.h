//
//  UITabBarController+custom.h
//  banana_clock
//
//  Created by MAC on 13-10-11.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (custom)


- (void)hidesBottomBarViewWhenPushed:(BOOL)hidden;
- (void)hidesTimeTitleWhenPushed:(BOOL)hidden;
- (void)setImageViewMessageNotificationREDHidden:(BOOL)hidden;

- (id)UITabBarController_custom_view;

@end
