//
//  lowooPOPRequestHasBeenSent.h
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"


@protocol lowooPOPRequestHasBeenSentDelegate <NSObject>
- (void)buttonRequestHasBeenSentTouchUpinsideWithentity:(UIView *)entity;
@end


@interface lowooPOPRequestHasBeenSent : popView


@property (nonatomic, weak) id<lowooPOPRequestHasBeenSentDelegate>delegate;




- (void)confirmDataWithNSDictionary:(NSDictionary *)sender;


@end
