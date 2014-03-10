//
//  lowooPOPpropObtain.h
//  banana_clock
//
//  Created by MAC on 13-10-17.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPropObtainCloseTouchUpInside <NSObject>
- (void)buttonpropObtainCloseTouchUpInsideWithView:(UIView *)entity;
@end

@interface lowooPOPpropObtain : popView

@property (nonatomic, weak) id<lowooPropObtainCloseTouchUpInside>delegate;




@end
