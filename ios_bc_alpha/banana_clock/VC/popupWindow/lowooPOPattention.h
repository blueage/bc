//
//  lowooPOPattention.h
//  banana_clock
//
//  Created by MAC on 13-10-17.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPattentionDelegate <NSObject>
- (void)buttonAttentionCloseTouchUpInsideWithView:(UIView *)entity;
@end

@interface lowooPOPattention : popView

@property (nonatomic, weak) id<lowooPOPattentionDelegate>delegate;
@property (nonatomic, strong) UIImageView *imageViewDuigou;

@end
