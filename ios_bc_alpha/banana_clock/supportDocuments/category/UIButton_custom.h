//
//  UIButton_custom.h
//  banana_clock
//
//  Created by MAC on 13-9-16.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton_custom : UIButton

@property (nonatomic, copy) NSString *music;

@property (nonatomic, strong) UIImage *imageNormal;
@property (nonatomic, strong) UIImage *imageHighlited;

@property (nonatomic, assign) id  buttonTarget;
@property (nonatomic, assign) SEL buttonAction;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, assign) BOOL boolMask;

- (void)setFrame:(CGRect)frame image:(NSString *)normal image:(NSString *)highlited;

- (void)addTarget:(id)target action:(SEL)action;
- (void)removeTarget;


@end
