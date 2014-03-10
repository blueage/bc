//
//  lowooPOPPropKind.m
//  banana_clock
//
//  Created by MAC on 13-8-9.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPPropKind.h"

@implementation lowooPOPPropKind

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(59, 128, 195, 166)];
        imageViewPanel.image = GetPngImage(@"POPPanelMedium02");
        [self.viewMove addSubview:imageViewPanel];
        
        _imageViewKind = [[UIImageView alloc] initWithFrame:CGRectMake(47, 71, 120, 134)];
        [self.viewMove addSubview:_imageViewKind];
        
        _imageViewDescription = [[UIImageView alloc] initWithFrame:CGRectMake(80, 210, 180, 65)];
        [self.viewMove addSubview:_imageViewDescription];
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose setFrame:CGRectMake(215, 119, 47, 47) image:@"POPClosea" image:@"POPCloseb"];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside:)];
    }
    return self;
}


- (void)confirmDataWithTag:(NSInteger)sender{
    switch (sender) {
        case 1:
            _imageViewKind.image = GetPngImage(@"General_Clock");
            if (LANGUAGE_CHINESE) {
                _imageViewDescription.image = GetPngImage(@"General_ClockWords");
            }else{
                _imageViewDescription.image = GetPngImage(@"General_ClockWordsEnglish");
            }
            break;
        case 2:
            _imageViewKind.image = GetPngImage(@"No_Shield");
            if (LANGUAGE_CHINESE) {
                _imageViewDescription.image = GetPngImage(@"No_ShieldWords");
            }else{
                _imageViewDescription.image = GetPngImage(@"No_ShieldWordsEnglish");
            }
            break;
        case 3:
            _imageViewKind.image = GetPngImage(@"More_Mony_Clock");
            if (LANGUAGE_CHINESE) {
                _imageViewDescription.image = GetPngImage(@"More_Mony_ClockWords");
            }else{
                _imageViewDescription.image = GetPngImage(@"More_Mony_ClockWordsEnglish");
            }
            break;
        case 4:
            _imageViewKind.image = GetPngImage(@"Robber_Clock");
            if (LANGUAGE_CHINESE) {
                _imageViewDescription.image = GetPngImage(@"Robber_ClockWords");
            }else{
                _imageViewDescription.image = GetPngImage(@"Robber_ClockWordsEnglish");
            }
            break;
            
        default:
            break;
    }
}




- (void)buttonCloseTouchUpinside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonPOPPropCloseTouchUpInside:)]) {
        [_delegate buttonPOPPropCloseTouchUpInside:self];
    }
}


@end
