//
//  popView.h
//  banana_clock
//
//  Created by MAC on 13-10-14.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface popView : UIView

@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) UIView *viewMove;
@property (nonatomic, strong) UIButton_custom *buttonClose;
@property (nonatomic, strong) UIButton_custom *buttonEnter;

@property (nonatomic, strong) UIImageView *imageViewText;

@end
