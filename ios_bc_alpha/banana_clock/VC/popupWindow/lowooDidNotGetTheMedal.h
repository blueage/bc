//
//  lowooDidNotGetTheMedal.h
//  banana_clock
//
//  Created by MAC on 13-3-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPDidNotGetTheMedalDelegate <NSObject>
- (void)buttonDidNotGetTheMedalTouchUpinsideWithentity:(UIView *)entity;
@end

@interface lowooDidNotGetTheMedal : popView

@property (nonatomic, weak) id<lowooPOPDidNotGetTheMedalDelegate>delegate;



@end
