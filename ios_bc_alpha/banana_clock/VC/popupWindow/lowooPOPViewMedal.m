//
//  lowooPOPViewMedal.m
//  banana_clock
//
//  Created by MAC on 13-3-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPViewMedal.h"

@implementation lowooPOPViewMedal

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(43, 80, 234, 313)];
        imageViewPanel.image = GetPngImage(@"gameSuccessPanel");
        [self.viewMove addSubview:imageViewPanel];
        
        UIImageView *imageViewMask = [[UIImageView alloc] initWithFrame:CGRectMake(83, 112, 155, 155)];
        imageViewMask.image = GetPngImage(@"chengjiubc");
        [self.viewMove addSubview:imageViewMask];
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonClose setFrame:CGRectMake(222, 70, 47, 47) image:@"POPClosea" image:@"POPCloseb"];
        
        _labelChinese = [[UILabel alloc]initWithFrame:CGRectMake(65, 275, 186, 21)];
        _labelChinese.backgroundColor = [UIColor clearColor];
        [_labelChinese setTextAlignment:NSTextAlignmentCenter];
        [self.viewMove addSubview:_labelChinese];
        
        _labelChineseDescrib = [[UILabel alloc]initWithFrame:CGRectMake(65, 303, 186, 40)];
        _labelChineseDescrib.backgroundColor = [UIColor clearColor];
        [_labelChineseDescrib setTextAlignment:NSTextAlignmentCenter];
        _labelChineseDescrib.font = [UIFont systemFontOfSize:12];
        _labelChineseDescrib.lineBreakMode = NSLineBreakByCharWrapping;
        _labelChineseDescrib.numberOfLines = 0;
        [self.viewMove addSubview:_labelChineseDescrib];
        

        
        _labelEnglishDescrib = [[UILabel alloc] initWithFrame:CGRectMake(65, 312, 186, 40)];
        _labelEnglishDescrib.backgroundColor = [UIColor clearColor];
        _labelEnglishDescrib.font = [UIFont systemFontOfSize:12];
        _labelEnglishDescrib.textAlignment = NSTextAlignmentCenter;
        _labelEnglishDescrib.lineBreakMode = NSLineBreakByCharWrapping;
        _labelEnglishDescrib.numberOfLines = 0;
        [self.viewMove addSubview:_labelEnglishDescrib];
        

        _labelDay = [[UILabel alloc]initWithFrame:CGRectMake(65, 350, 179, 21)];
        _labelDay.backgroundColor = [UIColor clearColor];
        _labelDay.textColor = COLOR_DAY;
        _labelDay.font = [UIFont systemFontOfSize:12];
        [_labelDay setTextAlignment:NSTextAlignmentCenter];
        [self.viewMove addSubview:_labelDay];
        
        _imageViewAchievements = [[UIImageView_custom alloc]initWithFrame:CGRectMake(92.5, 119.5, 135, 135)];
        _imageViewAchievements.image = GetPngImage(@"achieve270x270");
        [self.viewMove addSubview:_imageViewAchievements];
    }
    return self;
}

- (void)confirmMedal:(modelMedal *)medal{
    if (LANGUAGE_CHINESE) {
        _labelChinese.text = medal.nameChinese;
        [_labelChineseDescrib setFrame:CGRectMake(65, 290, 186, 40)];
        _labelChineseDescrib.text = medal.describChinese;
        _labelEnglishDescrib.text = medal.describEnglish;
        _labelEnglishDescrib.hidden = NO;
    }else{
        _labelChinese.text = medal.nameEnglish;
        [_labelChineseDescrib setFrame:CGRectMake(65, 303, 186, 40)];
        _labelChineseDescrib.text = medal.describEnglish;
        _labelEnglishDescrib.hidden = YES;
    }


    if (medal.boolGet) {
        _labelDay.text = medal.timeGet;
    }
    
    if (medal.imageUrl != nil) {
        [_imageViewAchievements storeImageUrl:medal.imageUrl];
//        [_imageViewAchievements setImageURL:medal.imageUrl];
//        NSString *string90 = [NSString stringWithFormat:@"%@",medal.imageUrl];
//        NSInteger length = [string90 length];
//        NSRange range = NSMakeRange(length-9, 2);
//        NSString *string270 = [string90 stringByReplacingCharactersInRange:range withString:@"270"];
//        [_imageViewAchievements setImageURL:string270];
    }
}


- (void)buttonCloseTouchUpinside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonViewMedalTouchUpinsideWithentity:)]) {
        [_delegate buttonViewMedalTouchUpinsideWithentity:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonViewMedalTouchUpinside" object:nil userInfo:nil];
}






@end
