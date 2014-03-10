//
//  UIImageViewRepeat.h
//  circleNew
//
//  Created by Lowoo on 2/14/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIImageViewRepeat;

@protocol UIImageViewRepeatDelegate <NSObject>

- (void)imageViewRepeatTaped:(UIImageViewRepeat *)imageView;

@end

@interface UIImageViewRepeat : UIImageView

@property (nonatomic, assign) id <UIImageViewRepeatDelegate> delegate;

@property (nonatomic, strong) UIImage *imageDown;
@property (nonatomic, strong) UIImage *imageUp;
@property (nonatomic, assign) BOOL boolTouchDown;
@property (nonatomic, strong) NSString *name;

@end
