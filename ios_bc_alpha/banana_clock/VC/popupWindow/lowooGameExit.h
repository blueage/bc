//
//  lowooGameExit.h
//  banana_clock
//
//  Created by MAC on 13-3-7.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"


@protocol lowooPOPgameExitDelegate <NSObject>
- (void)buttonGameExitTouchUpinsideWithentity:(UIView *)entity;
@end


@interface lowooGameExit : popView

@property (nonatomic, weak) id<lowooPOPgameExitDelegate>delegate;
@property (nonatomic, strong) UIButton_custom *buttonCancel;



@end
