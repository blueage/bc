//
//  LIBONavigationBar.h
//  banana_clock
//
//  Created by Lowoo on 2/8/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIBONavigationBar : UIView

@property (nonatomic, strong) UIView *viewLeft;
@property (nonatomic, strong) UIButton_custom *buttonLeft;//只负责效果和点击
@property (nonatomic, strong) UIImageView *imageViewLeft;//由于提供的图片原因，和Button一起完成Button点击效果

@property (nonatomic, strong) UIView *viewRight;
@property (nonatomic, strong) UIButton_custom *buttonRight;
@property (nonatomic, strong) UIImageView *imageViewRight;



@end
