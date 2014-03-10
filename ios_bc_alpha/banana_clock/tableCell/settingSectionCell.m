//
//  settingSectionCell.m
//  banana_clock
//
//  Created by MAC on 13-7-19.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "settingSectionCell.h"

@implementation settingSectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 320, 45)];
        [self.viewOne setFrame:CGRectMake(0, -5, 320, 45)];
        self.clipsToBounds = YES;
        self.viewOne.clipsToBounds = YES;
        
        
        _button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_button setFrame:CGRectMake(22, 0, 276, 45)];
        [_button setImageNormal:[UIImage imageNamed:@"List_item_bg01.png"]];
        [_button setImageHighlited:[UIImage imageNamed:@"List_item_bg02.png"]];
        [_button addTarget:self action:@selector(buttonTouchUpInside:)];
        [self.viewOne addSubview:_button];
        
        _imageViewjiantou = [[UIImageView alloc] initWithFrame:CGRectMake(275, 19, 7, 11)];
        _imageViewjiantou.image = [UIImage imageNamed:@"jiantou.png"];
        [self.viewOne addSubview:_imageViewjiantou];
        _imageViewjiantou.hidden = YES;
        
        _imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(37, 15, 18, 18)];
        [self.viewOne addSubview:_imageViewIcon];
        }
    return self;
}

- (UILabel *)labelChinese{
    [_labelEG removeFromSuperview];
    _labelEG = nil;
    
    if (!_labelChinese) {
        _labelChinese = [[UILabel alloc]initWithFrame:CGRectMake(66, 10, 128, 21)];
        [_labelChinese setBackgroundColor:[UIColor clearColor]];
        [_labelChinese setTextAlignment:NSTextAlignmentLeft];
        [_labelChinese setFont:[UIFont systemFontOfSize:13.0]];
        [_labelChinese setTextColor:[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:0.9]];
        [self.viewOne addSubview:_labelChinese];
    }
    return _labelChinese;
}

- (UILabel *)labelEnglish{
    
    
    if (!_labelEnglish) {
        _labelEnglish = [[UILabel alloc]initWithFrame:CGRectMake(66, 26, 174, 15)];
        [_labelEnglish setBackgroundColor:[UIColor clearColor]];
        [_labelEnglish setTextAlignment:NSTextAlignmentLeft];
        [_labelEnglish setFont:[UIFont systemFontOfSize:8.0]];
        [_labelEnglish setTextColor:[UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:0.7]];
        [self.viewOne addSubview:_labelEnglish];
    }
    return _labelEnglish;
}

- (UILabel *)labelEG{
    [_labelChinese removeFromSuperview];
    _labelChinese = nil;
    [_labelEnglish removeFromSuperview];
    _labelEnglish = nil;
    
    if (!_labelEG) {
        _labelEG = [[UILabel alloc]initWithFrame:CGRectMake(66, 5, 174, 40)];
        [_labelEG setBackgroundColor:[UIColor clearColor]];
        [_labelEG setTextAlignment:NSTextAlignmentLeft];
        [_labelEG setFont:[UIFont systemFontOfSize:14]];
        [_labelEG setTextColor:[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:0.8]];
        _labelEG.lineBreakMode = NSLineBreakByCharWrapping;
        _labelEG.numberOfLines = 0;
        [self.viewOne addSubview:_labelEG];
    }
    return _labelEG;
}

- (UILabel *)labelDay{
    if (!_labelDay) {
        _labelDay = [[UILabel alloc]initWithFrame:CGRectMake(139, 15, 136, 21)];
        [_labelDay setBackgroundColor:[UIColor clearColor]];
        [_labelDay setTextAlignment:NSTextAlignmentRight];
        [_labelDay setFont:[UIFont systemFontOfSize:13.0]];
        [_labelDay setTextColor:[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:0.9]];
        [self.viewOne addSubview:_labelDay];
    }
    return _labelDay;
}

- (void)confirmData{
    
}


@end
