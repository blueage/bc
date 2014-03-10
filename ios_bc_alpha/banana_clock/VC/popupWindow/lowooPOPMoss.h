//
//  lowooPOPMoss.h
//  banana_clock
//
//  Created by MAC on 13-9-24.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPMossDelegate <NSObject>
- (void)buttonlowooPOPMossCloseTouchUpInside:(UIView *)entity;
@end

@interface lowooPOPMoss : popView

@property (nonatomic ,weak) id<lowooPOPMossDelegate>delegate;


@property (nonatomic, strong) UIImageView *imageViewDescription;

@end
