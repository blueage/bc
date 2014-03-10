//
//  lowooPOPMoss.m
//  banana_clock
//
//  Created by MAC on 13-9-24.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPMoss.h"

@implementation lowooPOPMoss

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
        
        _imageViewDescription = [[UIImageView alloc] initWithFrame:CGRectMake(58, 117, 214, 190)];
        NSString *namepng = [NSString stringWithFormat:@"%@",[BASE International:@"moss_english"]];
        _imageViewDescription.image = GetPngImage(namepng);
        [self.viewMove addSubview:_imageViewDescription];
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose setFrame:CGRectMake(215, 119, 47, 47) image:@"POPClosea" image:@"POPCloseb"];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside:)];
    }
    return self;
}

- (void)buttonCloseTouchUpinside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonPOPPropCloseTouchUpInside:)]) {
        [_delegate buttonlowooPOPMossCloseTouchUpInside:self];
    }
}


@end
