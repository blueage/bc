//
//  lowooGameOver.m
//  banana_clock
//
//  Created by MAC on 13-3-7.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooGameOver.h"

@implementation lowooGameOver

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        

        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(43, 86, 234, 313)];
        imageViewPanel.image = GetPngImage(@"POPPanelLarge");
        [self.viewMove addSubview:imageViewPanel];
        
        self.buttonEnter = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.buttonEnter setFrame:CGRectMake(81, 322, 157, 53) image:[BASE International:@"POPDeterminea"] image:[BASE International:@"POPDetermineb"]];
        [self.buttonEnter addTarget:self action:@selector(buttonCloseTouchUpinside)];
        [self.viewMove addSubview:self.buttonEnter];

        _imageViewPeople = [[UIImageView alloc]initWithFrame:CGRectMake(65, 102, 640/2*0.6, 480/2*0.6)];//168, 153
        _imageViewPeople.image = GetPngImage(@"bycall_pic02");
        [self.viewMove addSubview:_imageViewPeople];
        
        self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(56, 62, 207, 74)];
        NSString *namepng = [BASE International:@"PanleGameText03"];
        self.imageViewText.image = GetPngImage(namepng);
        [self.viewMove addSubview:self.imageViewText];
        
        _buttonRepeat = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonRepeat setFrame:CGRectMake(82, 261, 157, 53) image:[BASE International:@"gameOverRepeata"] image:[BASE International:@"gameOverRepeatb"]];
        [_buttonRepeat addTarget:self action:@selector(buttonRepeatTouchUpinside)];
        [self.viewMove addSubview:_buttonRepeat];
        
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }

    }
    return self;
}

- (void)buttonCloseTouchUpinside{
    if ([_delegate respondsToSelector:@selector(buttonGameOverColoseTouchUpinsideWithEntity:)]) {
        [_delegate buttonGameOverColoseTouchUpinsideWithEntity:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonGameOverCloseTouchUpinside" object:nil userInfo:nil];
}


- (void)buttonRepeatTouchUpinside{
    if ([_delegate respondsToSelector:@selector(buttonGameOverColoseTouchUpinsideWithEntity:)]) {
        [_delegate buttonGameOverColoseTouchUpinsideWithEntity:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonGameRepeatTouchUpinside" object:nil userInfo:nil];
}


@end
