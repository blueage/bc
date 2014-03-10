//
//  selfStateCell.m
//  banana_clock
//
//  Created by MAC on 13-12-9.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "selfStateCell.h"

@implementation selfStateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 1, 276, 37)];
        imageView.image = GetPngImage(@"personalstate");
        [self addSubview:imageView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UILabel *)labelChinese{
    if (_labelEnglish) {
        [_labelEnglish removeFromSuperview];
    }
    
    if (!_labelChinese) {
        _labelChinese = [[UILabel alloc]initWithFrame:CGRectMake(66, 4, 128, 21)];
        [_labelChinese setBackgroundColor:[UIColor clearColor]];
        [_labelChinese setTextAlignment:NSTextAlignmentLeft];
        [_labelChinese setFont:[UIFont systemFontOfSize:13.0]];
        [_labelChinese setTextColor:[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:0.9]];
        [self addSubview:_labelChinese];
    }
    return _labelChinese;
}

- (UILabel *)labelChineseEnglish{
    if (!_labelChineseEnglish) {
        _labelChineseEnglish = [[UILabel alloc]initWithFrame:CGRectMake(66, 20, 174, 15)];
        [_labelChineseEnglish setBackgroundColor:[UIColor clearColor]];
        [_labelChineseEnglish setTextAlignment:NSTextAlignmentLeft];
        [_labelChineseEnglish setFont:[UIFont systemFontOfSize:8.0]];
        [_labelChineseEnglish setTextColor:[UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:0.7]];
        [self addSubview:_labelChineseEnglish];
    }
    return _labelChineseEnglish;
}

- (UILabel *)labelEnglish{
    if (_labelChinese) {
        [_labelChinese removeFromSuperview];
        [_labelChineseEnglish removeFromSuperview];
    }
    
    
    if (!_labelEnglish) {
        _labelEnglish = [[UILabel alloc]initWithFrame:CGRectMake(66, 1, 174, 37)];
        [_labelEnglish setBackgroundColor:[UIColor clearColor]];
        [_labelEnglish setTextAlignment:NSTextAlignmentLeft];
        [_labelEnglish setFont:[UIFont systemFontOfSize:14]];
        [_labelEnglish setTextColor:[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:0.8]];
        _labelEnglish.lineBreakMode = NSLineBreakByCharWrapping;
        _labelEnglish.numberOfLines = 0;
        [self addSubview:_labelEnglish];
    }
    return _labelEnglish;
}

- (UILabel *)labelState{
    if (!_labelState) {
        _labelState = [[UILabel alloc]initWithFrame:CGRectMake(135, 8, 140, 21)];
        [_labelState setBackgroundColor:[UIColor clearColor]];
        [_labelState setTextAlignment:NSTextAlignmentRight];
        [_labelState setFont:[UIFont systemFontOfSize:14.0]];
        [_labelState setTextColor:[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:0.9]];
        [self addSubview:_labelState];
    }
    return _labelState;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
