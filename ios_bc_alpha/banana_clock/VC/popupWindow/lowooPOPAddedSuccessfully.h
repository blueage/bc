//
//  lowooPOPAddedSuccessfully.h
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPAddedSuccessfullyDelegate <NSObject>
- (void)buttonAddedSuccessfullyTouchUpinsideWithentity:(UIView *)entity;
@end





@interface lowooPOPAddedSuccessfully : popView


@property (nonatomic, weak) id<lowooPOPAddedSuccessfullyDelegate>delegate;






@end
