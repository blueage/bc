//
//  lowooGameExit.m
//  banana_clock
//
//  Created by MAC on 13-3-7.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooGameExit.h"

@implementation lowooGameExit

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        self.viewMove.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(59, 125, 203, 190)];
        imageViewPanel.image = GetPngImage(@"gameExitPanel");
        [self.viewMove addSubview:imageViewPanel];
        
        if (LANGUAGE_CHINESE) {
            self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(73, 79, 174, 89)];
        }else{
            self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(73, 105, 174, 89)];
        }
        NSString *str = [BASE International:@"gameExitText"];
        self.imageViewText.image = GetPngImage(str);
        [self.viewMove addSubview:self.imageViewText];
        
        self.buttonEnter = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        if (LANGUAGE_CHINESE) {
            [self.buttonEnter setFrame:CGRectMake(82, 175, 157, 53) image:[BASE International:@"POPDeterminea"] image:[BASE International:@"POPDetermineb"]];
        }else{
            [self.buttonEnter setFrame:CGRectMake(82, 175, 157, 53) image:[BASE International:@"POPYesaEnglish"] image:[BASE International:@"POPYesaEnglish"]];
        }
        [self.buttonEnter setFrame:CGRectMake(82, 175, 157, 53) image:[BASE International:@"POPDeterminea"] image:[BASE International:@"POPDetermineb"]];
        [self.buttonEnter addTarget:self action:@selector(buttonDetermineTouchUpinside)];
        [self.viewMove addSubview:self.buttonEnter];
        
        _buttonCancel = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonCancel setFrame:CGRectMake(82, 240, 157, 53) image:[BASE International:@"POPCancela"] image:[BASE International:@"POPCancelb"]];
        [_buttonCancel addTarget:self action:@selector(buttonCloseTouchUpinside)];
        [self.viewMove addSubview:_buttonCancel];
        
    }
    return self;
}

- (void)buttonDetermineTouchUpinside{
    if ([_delegate respondsToSelector:@selector(buttonGameExitTouchUpinsideWithentity:)]) {
        [_delegate buttonGameExitTouchUpinsideWithentity:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonGameExitDetermineTouchUpinside" object:nil userInfo:nil];
}


- (void)buttonCloseTouchUpinside{
    if ([_delegate respondsToSelector:@selector(buttonGameExitTouchUpinsideWithentity:)]) {
        [_delegate buttonGameExitTouchUpinsideWithentity:self];
    }

    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonGameExitCancelTouchUpinside" object:nil userInfo:nil];
}





@end
