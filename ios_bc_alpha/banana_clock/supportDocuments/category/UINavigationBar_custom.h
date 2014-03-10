//
//  UINavigationBar_custom.h
//  banana_clock
//
//  Created by MAC on 13-10-9.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#define navbarHeight 44
#define DefaultStateBarColor [UIColor blackColor]
#define DefaultStateBarStyle UIBarStyleBlackOpaque

#import <UIKit/UIKit.h>



@interface UINavigationBar_custom : UINavigationBar


/**< 适用于ios7*/
@property (nonatomic,strong)UIColor *stateBarColor;/**< 默认black*/
@property (nonatomic,assign)UIBarStyle cusBarStyele;/**< 默认UIBarStyleBlackOpaque*/
@property (nonatomic,strong)NSNumber *stateBarStyle;


- (void)setDefault;


@end
