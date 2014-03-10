//
//  lowooPOPAwardedMedals.h
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPAwardedMedalsDelegate <NSObject>
- (void)buttonAwardedMedalsTouchUpinsideWithentity:(UIView *)entity;
@end

@interface lowooPOPAwardedMedals : popView


@property (nonatomic, weak) id<lowooPOPAwardedMedalsDelegate>delegate;
@property (nonatomic, strong) UIImageView_custom *imageViewHead;



- (void)confirmMedal:(modelMedal *)medal;






@end
