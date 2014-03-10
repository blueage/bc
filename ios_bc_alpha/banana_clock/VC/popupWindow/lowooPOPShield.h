//
//  lowooPOPShield.h
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPShieldDelegate <NSObject>
- (void)buttonShieldTouchUpinsideWithentity:(UIView *)entity;
@end



@interface lowooPOPShield : popView


@property (nonatomic, weak) id<lowooPOPShieldDelegate>delegate;
@property (nonatomic, retain) viewHead *viewHead;



- (void)confirmDataWithDictionary:(NSDictionary *)sender;


@end
