//
//  lowooPOPSlob.h
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPSlobDelegate <NSObject>
- (void)buttonSlobTouchUpinsideWithentity:(UIView *)entity;
@end


@interface lowooPOPSlob : popView



@property (nonatomic, weak) id<lowooPOPSlobDelegate>delegate;
@property (nonatomic, retain) viewHead *viewHead;


- (void)confirmDataWithDictionary:(NSDictionary *)sender;



@end
