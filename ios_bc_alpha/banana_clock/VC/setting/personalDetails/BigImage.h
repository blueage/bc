//
//  BigImage.h
//  banana_clock
//
//  Created by MAC on 13-12-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView_custom.h"

CGRect ScreenBounds();

@protocol BigImageDelegate <NSObject>
- (void)removeBigImage:(UIView *)view;
@end

@interface BigImage : UIView

@property (nonatomic, assign) id <BigImageDelegate>delegate;
@property (nonatomic, strong) UIImageView_custom *imageView;

- (void)showImageWithUrlstring:(NSString *)string;
- (void)showDefaultImage;
- (void)dismiss;

@end
