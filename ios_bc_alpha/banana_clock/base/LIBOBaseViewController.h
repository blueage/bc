//
//  LIBOBaseViewController.h
//  banana_clock
//
//  Created by Lowoo on 2/8/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBONavigationController.h"

@interface LIBOBaseViewController : UIViewController

@property (nonatomic, assign) NavigationBarLeftType naviLeftType;
@property (nonatomic, assign) NavigationBarRightType naviRightType;

- (void)leftClick;
- (void)rightClick;

@end
