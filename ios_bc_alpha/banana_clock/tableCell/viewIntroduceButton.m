//
//  viewIntroduceButton.m
//  banana_clock
//
//  Created by MAC on 13-7-18.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "viewIntroduceButton.h"

@implementation viewIntroduceButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self button];
    }
    return self;
}

- (UIButton_custom *)button{
    if (_button) {
        return _button;
    }
    _button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 276, 55) image:@"List_item_bg01" image:@"List_item_bg02"];
    [self addSubview:_button];
    return _button;
}

- (viewIntroduce *)viewIntroduce{
    if (_viewIntroduce) {
        return _viewIntroduce;
    }
    _viewIntroduce = [[viewIntroduce alloc] initWithFrame:CGRectMake(14, 12, 80, 27)];
    [self addSubview:_viewIntroduce];
    return _viewIntroduce;
}

- (UIImageView *)imageView{
    if (_imageView) {
        return _imageView;
    }
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(253, 21, 7, 12)];
    [self addSubview:_imageView];
    return _imageView;
}

@end
