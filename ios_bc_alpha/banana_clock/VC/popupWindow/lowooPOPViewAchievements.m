//
//  lowooPOPViewAchievements.m
//  banana_clock
//
//  Created by MAC on 13-3-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPViewAchievements.h"

@implementation lowooPOPViewAchievements

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(43, 80, 234, 313)];
        imageViewPanel.image = GetPngImage(@"gameSuccessPanel");
        [self.viewMove addSubview:imageViewPanel];
        
        UIImageView *imageViewMask = [[UIImageView alloc] initWithFrame:CGRectMake(82.5, 117, 155, 155)];
        imageViewMask.image = GetPngImage(@"chengjiubc");
        [self.viewMove addSubview:imageViewMask];
        
        _imageViewAchievements = [[UIImageView_custom alloc]initWithFrame:CGRectMake(92.5, 124, 135, 135)];
        _imageViewAchievements.image = GetPngImage(@"achieve270x270");
        [self.viewMove addSubview:_imageViewAchievements];
        

        UIButton_custom *buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [buttonClose setFrame:CGRectMake(224, 74, 47, 47) image:@"POPClosea" image:@"POPCloseb"];
        [buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside:)];
        [self.viewMove addSubview:buttonClose];

    }
    return self;
}

- (void)confirmData:(modelAchievement *)achieve{
    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(65, 270, 186, 21)];
    labelName.backgroundColor = [UIColor clearColor];
    labelName.text = @"";
    [labelName setTextAlignment:NSTextAlignmentCenter];
    [self.viewMove addSubview:labelName];
    
    if (LANGUAGE_CHINESE) {
        labelName.text = achieve.nameChinese;
        
        UILabel *labelDescription = [[UILabel alloc]initWithFrame:CGRectMake(65, 285, 186, 40)];
        labelDescription.backgroundColor = [UIColor clearColor];
        labelDescription.textColor = COLOR_CHINESE;
        [labelDescription setTextAlignment:NSTextAlignmentCenter];
        labelDescription.font = [UIFont systemFontOfSize:12];
        labelDescription.lineBreakMode = NSLineBreakByCharWrapping;
        labelDescription.numberOfLines = 0;
        [self.viewMove addSubview:labelDescription];
        labelDescription.text = achieve.describChinese;
        
        UILabel *labelEnglishDescrib = [[UILabel alloc]initWithFrame:CGRectMake(65, 305, 179, 40)];
        labelEnglishDescrib.backgroundColor = [UIColor clearColor];
        labelEnglishDescrib.textColor = COLOR_CHINESE;
        [labelEnglishDescrib setTextAlignment:NSTextAlignmentCenter];
        labelEnglishDescrib.font = [UIFont systemFontOfSize:12];
        labelEnglishDescrib.textAlignment = NSTextAlignmentCenter;
        labelEnglishDescrib.lineBreakMode = NSLineBreakByCharWrapping;
        labelEnglishDescrib.numberOfLines = 0;
        [self.viewMove addSubview:labelEnglishDescrib];
        labelEnglishDescrib.text = achieve.describEnglish;
        labelEnglishDescrib.hidden = NO;
    }else{
        labelName.text = achieve.nameEnglish;
        
        UILabel *labelEnglishDescrib = [[UILabel alloc]initWithFrame:CGRectMake(65, 297, 186, 40)];
        labelEnglishDescrib.backgroundColor = [UIColor clearColor];
        labelEnglishDescrib.textColor = COLOR_CHINESE;
        [labelEnglishDescrib setTextAlignment:NSTextAlignmentCenter];
        labelEnglishDescrib.font = [UIFont systemFontOfSize:12];
        labelEnglishDescrib.lineBreakMode = NSLineBreakByCharWrapping;
        labelEnglishDescrib.numberOfLines = 0;
        [self.viewMove addSubview:labelEnglishDescrib];
        labelEnglishDescrib.text = achieve.describEnglish;
    }

    if ([achieve.timeGet intValue] != 0) {
        UILabel *labelDay = [[UILabel alloc]initWithFrame:CGRectMake(65, 350, 179, 21)];
        labelDay.backgroundColor = [UIColor clearColor];
        labelDay.textColor = COLOR_DAY;
        labelDay.font = [UIFont systemFontOfSize:12];
        [labelDay setTextAlignment:NSTextAlignmentCenter];
        [self.viewMove addSubview:labelDay];
        labelDay.text = achieve.timeGet;
    }
    
   // 90_01
    if (achieve.imageUrl) {
        NSString *string90 = [NSString stringWithFormat:@"%@",achieve.imageUrl];
        NSInteger length = [string90 length];
        NSRange range = NSMakeRange(length-9, 2);
        NSString *string270 = [string90 stringByReplacingCharactersInRange:range withString:@"270"];
        [_imageViewAchievements storeImageUrl:string270];
    }
}

- (void)buttonCloseTouchUpinside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonViewAchievementsTouchUpinsideWithentity:)]) {
        [_delegate buttonViewAchievementsTouchUpinsideWithentity:self];
    }
}



@end
