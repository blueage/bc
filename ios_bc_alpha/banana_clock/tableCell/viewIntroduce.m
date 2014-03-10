//
//  viewIntroduce.m
//  banana_clock
//
//  Created by MAC on 13-7-17.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "viewIntroduce.h"


@implementation viewIntroduce

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (UILabel *)labelChinese{
    if (_labelEnglish) {
        [_labelEnglish removeFromSuperview];
        _labelEnglish = nil;
    }
    
    if (!_labelChinese) {
        _labelChinese = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 21)];
        _labelChinese.backgroundColor = [UIColor clearColor];
        _labelChinese.textAlignment = NSTextAlignmentLeft;
        _labelChinese.textColor = COLOR_CHINESE;
        _labelChinese.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:_labelChinese];
    }
    
    return _labelChinese;
}

- (UILabel *)labelChineseEnglish{
    if (!_labelChineseEnglish) {
        _labelChineseEnglish = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 250, 21)];
        _labelChineseEnglish.backgroundColor = [UIColor clearColor];
        _labelChineseEnglish.textAlignment = NSTextAlignmentLeft;
        _labelChineseEnglish.textColor = COLOR_ENGLISH;
        _labelChineseEnglish.font = [UIFont systemFontOfSize:9.0f];
        [self addSubview:_labelChineseEnglish];
    }
    
    return _labelChineseEnglish;
}

- (UILabel *)labelEnglish{
    if (_labelChinese) {
        [_labelChinese removeFromSuperview];
        [_labelChineseEnglish removeFromSuperview];
        _labelChinese = nil;
        _labelChineseEnglish = nil;
    }
    
    if (!_labelEnglish) {
        _labelEnglish = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 200, 21)];
        _labelEnglish.backgroundColor = [UIColor clearColor];
        _labelEnglish.textAlignment = NSTextAlignmentLeft;
        _labelEnglish.textColor = [UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:0.8];
        _labelEnglish.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_labelEnglish];
    }
    
    return _labelEnglish;
}



@end
