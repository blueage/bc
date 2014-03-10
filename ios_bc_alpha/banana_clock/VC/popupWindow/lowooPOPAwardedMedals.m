//
//  lowooPOPAwardedMedals.m
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPAwardedMedals.h"

@implementation lowooPOPAwardedMedals

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(43, 76, 468/2, 626/2)];
        imageViewPanel.image = GetPngImage(@"POPPanelLarge");
        [self.viewMove addSubview:imageViewPanel];
        
        UIImageView *imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(58, 58, 204, 54)];
        NSString *str = [BASE International:@"POPGetAMedalText"];
        imageViewText.image = GetPngImage(str);
        [self.viewMove addSubview:imageViewText];
        
        UIButton_custom *buttonDetermine = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [buttonDetermine setFrame:CGRectMake(82, 321, 157, 53) image:[BASE International:@"POPDeterminea"] image:[BASE International:@"POPDetermineb"]];
        [buttonDetermine addTarget:self action:@selector(buttonCloseTouchUpinside)];
        [self.viewMove addSubview:buttonDetermine];
        
        UIImageView *imageViewMask = [[UIImageView alloc] initWithFrame:CGRectMake(83, 112, 155, 155)];
        imageViewMask.image = GetPngImage(@"chengjiubc");
        [self.viewMove addSubview:imageViewMask];
        
        _imageViewHead = [[UIImageView_custom alloc]initWithFrame:CGRectMake(90.5, 117, 140, 140)];
        _imageViewHead.layer.masksToBounds = YES;
        _imageViewHead.layer.cornerRadius = 5.0;
        _imageViewHead.layer.borderWidth = 0.5;
        _imageViewHead.layer.borderColor = [[UIColor whiteColor] CGColor];
        _imageViewHead.image = GetPngImage(@"achieve270x270");
        [self.viewMove addSubview:_imageViewHead];
    }
    return self;
}

- (void)confirmMedal:(modelMedal *)medal{
    if (medal.imageUrl && medal.imageUrl.length>9) {
        NSString *string90 = medal.imageUrl;
        NSInteger length = [string90 length];
        NSRange range = NSMakeRange(length-9, 2);
        NSString *string90_30 = [string90 stringByReplacingCharactersInRange:range withString:@"90_30"];
        [_imageViewHead setImageURL:string90_30];
    }

    UILabel *labelChinese = [[UILabel alloc]initWithFrame:CGRectMake(65, 260, 186, 21)];
    labelChinese.backgroundColor = [UIColor clearColor];
    [labelChinese setTextAlignment:NSTextAlignmentCenter];
    [self.viewMove addSubview:labelChinese];
    
    UILabel *labelDescription = [[UILabel alloc]initWithFrame:CGRectMake(65, 272, 186, 40)];
    labelDescription.backgroundColor = [UIColor clearColor];
    //labelDescription.textColor = COLOR_DAY;
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
        labelChinese.text = medal.nameChinese;
        labelDescription.text = medal.describChinese;
    }else{
        labelChinese.text = medal.nameEnglish;
        labelDescription.text = medal.describEnglish;
    }
    labelTime.text = medal.timeGet;
}

- (void)buttonCloseTouchUpinside{
    if ([_delegate respondsToSelector:@selector(buttonAwardedMedalsTouchUpinsideWithentity:)]) {
        [_delegate buttonAwardedMedalsTouchUpinsideWithentity:self];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonAwardedMedalsTouchUpinside" object:nil userInfo:nil];
}



@end
