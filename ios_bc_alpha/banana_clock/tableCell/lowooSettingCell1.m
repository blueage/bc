//
//  lowooSettingCell1.m
//  banana clock
//
//  Created by MAC on 12-10-9.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooSettingCell1.h"

@implementation lowooSettingCell1



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setFrame:CGRectMake(0, 0, 320, 55)];
        [self.viewOne setFrame:CGRectMake(0, 0, 320, 55)];
        self.clipsToBounds = YES;
        self.viewOne.clipsToBounds = YES;
        
        _button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_button setFrame:CGRectMake(22, 0, 276, 55)];
        [_button setImageNormal:GetPngImage(@"List_item_bg01")];
        [_button setImageHighlited:GetPngImage(@"List_item_bg02")];
//        [_button addTarget:self action:@selector(buttonTouchUpInside:)];
        _button.userInteractionEnabled = NO;
        [self.viewOne addSubview:_button];
        
        _imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(37, 15, 18, 18)];
        [self.viewOne addSubview:_imageViewIcon];
        
        self.labelDayFrame = CGRectMake(150, 15, 125, 21);
        self.labelDayFrameBig = CGRectMake(220, 15, 55, 21);
    }
    return self;
}

//- (UIImageView *)imageViewjiantou{
//    if (!_imageViewjiantou) {
//        _imageViewjiantou = [[UIImageView alloc] initWithFrame:CGRectMake(275, 19, 7, 11)];
//        _imageViewjiantou.image = GetPngImage(@"jiantou");
//        [self.viewOne addSubview:_imageViewjiantou];
//    }
//    return _imageViewjiantou;
//}

//- (void)setImageViewjiantouNil{
//    if (_imageViewjiantou) {
//        [_imageViewjiantou removeFromSuperview];
//    }
//}


- (UILabel *)labelChinese{
    if (_labelEG) {
        [_labelEG removeFromSuperview];
    }
    
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
    if (_labelChinese) {
        [_labelChinese removeFromSuperview];
        [_labelEnglish removeFromSuperview];
    }
    
    
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
        _labelDay = [[UILabel alloc] initWithFrame:CGRectMake(120, 15, 140, 21)];
        [_labelDay setBackgroundColor:[UIColor clearColor]];
        [_labelDay setTextAlignment:NSTextAlignmentRight];
        [_labelDay setFont:[UIFont systemFontOfSize:13.0]];
        [_labelDay setTextColor:[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:0.9]];
        [self.viewOne addSubview:_labelDay];
    }
    return _labelDay;
}

- (void)buttonTouchUpInside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(settingCell1ButtonTouchUpInsideWithTag:)]) {
        [_delegate settingCell1ButtonTouchUpInsideWithTag:sender.tag];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}




@end
