//
//  lowooPOPPropKind.h
//  banana_clock
//
//  Created by MAC on 13-8-9.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPPropKindDelegate <NSObject>
- (void)buttonPOPPropCloseTouchUpInside:(UIView *)entity;
@end

@interface lowooPOPPropKind : popView



@property (nonatomic ,weak) id<lowooPOPPropKindDelegate>delegate;

@property (nonatomic, strong) UIImageView *imageViewKind;
@property (nonatomic, strong) UIImageView *imageViewDescription;


- (void)confirmDataWithTag:(NSInteger )sender;


@end
