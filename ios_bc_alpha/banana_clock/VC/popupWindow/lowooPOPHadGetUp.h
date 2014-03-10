//
//  lowooPOPHadGetUp.h
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPHadGetUpDelegate <NSObject>
- (void)buttonHadGetUpTouchUpinsideWithentity:(UIView *)entity;
@end


@interface lowooPOPHadGetUp : popView



@property (nonatomic, weak) id<lowooPOPHadGetUpDelegate>delegate;
@property (nonatomic, strong) viewHead *viewHead; 


- (void)confirmDataWithDictionary:(NSDictionary *)sender;

@end
