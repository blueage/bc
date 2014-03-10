//
//  lowooNavigationView.h
//  banana_clock
//
//  Created by MAC on 13-4-27.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lowooCoinView;

@interface lowooNavigationView : UIView


@property (nonatomic, strong) lowooCoinView *viewGold;

- (void)resetNumber;
- (void)resetNumberWithNotification:(NSNotification *)sender;

@end
