//
//  lowooGetUpFailure.m
//  banana_clock
//
//  Created by MAC on 13-3-22.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooGetUpFailure.h"

@implementation lowooGetUpFailure

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonEnterTouchUpinside) name:@"timeOut" object:nil];
        
        self.backgroundColor = [UIColor clearColor];
        _imageViewBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, SCREEN_HEIGHT)];
        if (iPhone5||iPhone5_0) {
            _imageViewBack.image = GetPngImage(@"launch_bc5b");
        }else{
            _imageViewBack.image = GetPngImage(@"launch_bc4b");
        }
        _imageViewBack.alpha = 1;
        [self addSubview:_imageViewBack];
        
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self addSubview:_viewBack];
        
        if (iPhone5 || iPhone5_0) {
            _viewMove = [[UIView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            _viewMove = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        _viewMove.backgroundColor = [UIColor clearColor];
        [_viewBack addSubview:_viewMove];
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(43, 86, 234, 313)];
        imageViewPanel.image = GetPngImage(@"POPPanelLarge");
        [_viewMove addSubview:imageViewPanel];
        
        
        _buttonEnter = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonEnter setFrame:CGRectMake(81, 322, 157, 53) image:[BASE International:@"POPDeterminea"] image:[BASE International:@"POPDetermineb"]];
        [_buttonEnter addTarget:self action:@selector(buttonEnterTouchUpinside)];
        [_viewMove addSubview:_buttonEnter];
        
        _imageViewPeople = [[UIImageView alloc]initWithFrame:CGRectMake(76, 102, 168, 153)];
        _imageViewPeople.image = GetPngImage(@"bycall_pic02");
        [_viewMove addSubview:_imageViewPeople];
        
        _imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(70, 62, 179, 74)];
        NSString *namepng = [BASE International:@"gameOverText"];
        _imageViewText.image = GetPngImage(namepng);
        [_viewMove addSubview:_imageViewText];
        
        _buttonRepeat = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonRepeat setFrame:CGRectMake(82, 261, 157, 53) image:[BASE International:@"gameOverRepeata"] image:[BASE International:@"gameOverRepeatb"]];
        [_buttonRepeat addTarget:self action:@selector(buttonRepeatTouchUpinside)];
        [_viewMove addSubview:_buttonRepeat];
    }
    return self;
}

- (void)buttonEnterTouchUpinside{
    [_delegate buttonGetUpFailureTouchUpinsideWithEntity:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonGetUpFailureTouchUpinside" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lazy" object:nil];
}


- (void)buttonRepeatTouchUpinside{
    [_delegate buttonGetUpFailureTouchUpinsideWithEntity:self];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonGameRepeatTouchUpinside" object:nil userInfo:nil];
}





@end
