//
//  lowooDidNotGetTheAchievement.m
//  banana_clock
//
//  Created by MAC on 13-3-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooDidNotGetTheAchievement.h"

@implementation lowooDidNotGetTheAchievement

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(61, 131, 198, 136)];
        imageViewPanel.image = GetPngImage(@"POPPanelSmall");
        [self.viewMove addSubview:imageViewPanel];
        
        self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(72, 172, 176, 56)];
        NSString *namepng = [BASE International:@"POPDidNotGetTheAchievement"];
        self.imageViewText.image = GetPngImage(namepng);
        [self.viewMove addSubview:self.imageViewText];
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose setFrame:CGRectMake(219, 116, 47, 47) image:@"POPClosea" image:@"POPCloseb"];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside)];
    }
    return self;
}



- (void)buttonCloseTouchUpinside{
    if ([_delegate respondsToSelector:@selector(buttonDidNotGetTheAchievementTouchUpinsideWithentity:)]) {
        [_delegate buttonDidNotGetTheAchievementTouchUpinsideWithentity:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonDidNotGetTheAchievementTouchUpinside" object:nil userInfo:nil];
}


@end
