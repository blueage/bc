//
//  lowooPOPAchievement.m
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPAwardedAchievement.h"

@implementation lowooPOPAwardedAchievement

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        

        
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        self.viewMove.backgroundColor = [UIColor clearColor];
        [self.viewBack addSubview:self.viewMove];
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(42, 76, 466/2, 712/2)];
        imageViewPanel.image = GetPngImage(@"achievementPanel");
        [self.viewMove addSubview:imageViewPanel];
        

        
        UIImageView *imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(45, 60, 232, 54)];
        NSString *str = [BASE International:@"POPAnAchievementText"];
        imageViewText.image = GetPngImage(str);
        [self.viewMove addSubview:imageViewText];

        UIImageView *imageViewMask = [[UIImageView alloc] initWithFrame:CGRectMake(83, 111, 155, 155)];
        imageViewMask.image = GetPngImage(@"chengjiubc");
        [self.viewMove addSubview:imageViewMask];
        
        _imageViewHead = [[UIImageView_custom alloc]initWithFrame:CGRectMake(91, 116, 138, 140)];
        _imageViewHead.layer.masksToBounds = YES;
        _imageViewHead.layer.cornerRadius = 5.0;
        _imageViewHead.layer.borderWidth = 0.5;
        _imageViewHead.layer.borderColor = [[UIColor whiteColor] CGColor];
        _imageViewHead.image = GetPngImage(@"achieve270x270");
        [self.viewMove addSubview:_imageViewHead];

        UIButton_custom *buttonDetermine = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [buttonDetermine addTarget:self action:@selector(buttonCloseTouchUpinside)];
        [buttonDetermine setFrame:CGRectMake(82, 360, 157, 53) image:[BASE International:@"POPDeterminea"] image:[BASE International:@"POPDetermineb"]];
        [self.viewMove addSubview:buttonDetermine];
    }
    return self;
}

- (void)confirmAchieve:(modelAchievement *)achievement{
    UIImageView *imageViewGold = [[UIImageView alloc] initWithFrame:CGRectMake(102.5, 315, 217/2, 81/2)];
    [self.viewMove addSubview:imageViewGold];
    NSString *goldName = [NSString stringWithFormat:@"gold%02d",achievement.coin];
    imageViewGold.image = GetPngImage(goldName);
    
    if (achievement.imageUrl && achievement.imageUrl.length>9) {
        NSString *string90 = achievement.imageUrl;
        NSInteger length = [string90 length];
        NSRange range = NSMakeRange(length-9, 2);
        NSString *string90_30 = [string90 stringByReplacingCharactersInRange:range withString:@"270"];
        [_imageViewHead setImageURL:string90_30];
    }

    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(65, 262, 186, 21)];
    labelName.backgroundColor = [UIColor clearColor];
    [labelName setTextAlignment:NSTextAlignmentCenter];
    [self.viewMove addSubview:labelName];
    
    UILabel *labelDescription = [[UILabel alloc]initWithFrame:CGRectMake(65, 274, 186, 40)];
    labelDescription.backgroundColor = [UIColor clearColor];
    [labelDescription setTextAlignment:NSTextAlignmentCenter];
    labelDescription.font = [UIFont systemFontOfSize:12];
    labelDescription.lineBreakMode = NSLineBreakByCharWrapping;
    labelDescription.numberOfLines = 0;
    [self.viewMove addSubview:labelDescription];

    UILabel *labelTime = [[UILabel alloc] initWithFrame:CGRectMake(65, 300, 186, 20)];
    labelTime.backgroundColor = [UIColor clearColor];
    [labelTime setTextAlignment:NSTextAlignmentCenter];
    [labelTime setFont:[UIFont systemFontOfSize:13]];
    [labelTime setTextColor:COLOR_DAY];
    [self.viewMove addSubview:labelTime];
    
    if (LANGUAGE_CHINESE) {
        labelName.text = achievement.nameChinese;
        labelDescription.text = achievement.describChinese;
    }else{
        labelName.text = achievement.nameEnglish;
        labelDescription.text = achievement.describEnglish;
    }
    labelTime.text = achievement.timeGet;
}


- (void)buttonCloseTouchUpinside{
    if ([_delegate respondsToSelector:@selector(buttonAchievementTouchUpinsideWithentity:)]) {
        [_delegate buttonAchievementTouchUpinsideWithentity:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonAchievementTouchUpinside" object:nil userInfo:nil];
}



@end
