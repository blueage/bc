//
//  LIBONavigationController.h
//  banana_clock
//
//  Created by Lowoo on 2/8/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBONavigationBar.h"

typedef NS_ENUM(NSInteger, NavigationBarLeftType) {
    NavigationBarLeftTypeNone = 0,//default
    NavigationBarLeftTypeBack,
    NavigationBarLeftTypeRanking,
};

typedef NS_ENUM(NSInteger, NavigationBarRightType) {
    NavigationBarRightTypeNone = 0,
    NavigationBarRightTypeAdd,
    NavigationBarRightTypeBuy,
    NavigationBarRightTypeSave,
};

@interface LIBONavigationController : UINavigationController

@property (nonatomic, strong) LIBONavigationBar *naviBar;

@property (nonatomic, assign) NavigationBarLeftType *naviLeftType;
@property (nonatomic, assign) NavigationBarRightType *naviRightType;


@end
