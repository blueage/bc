//
//  lowooPOPpropObtain.m
//  banana_clock
//
//  Created by MAC on 13-10-17.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPpropObtain.h"

@implementation lowooPOPpropObtain

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(59, 128, 195, 166)];
        imageViewPanel.image = GetPngImage(@"POPPanelSmall");
        [self.viewMove addSubview:imageViewPanel];
        
        if (LANGUAGE_CHINESE) {
            UIImageView *imageViewText = [[UIImageView alloc] initWithFrame:CGRectMake(83, 180, 149, 59)];
            [imageViewText setImage:GetPngImage(@"notObtain")];
            [self.viewMove addSubview:imageViewText];
        }else{
            UIImageView *imageViewText = [[UIImageView alloc] initWithFrame:CGRectMake(78, 170, 156, 92)];
            [imageViewText setImage:GetPngImage(@"notObtainE")];
            [self.viewMove addSubview:imageViewText];
        }
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose setFrame:CGRectMake(215, 119, 47, 47) image:@"POPClosea" image:@"POPCloseb"];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside:)];
    }
    return self;
}

- (void)buttonCloseTouchUpinside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonpropObtainCloseTouchUpInsideWithView:)]) {
        [_delegate buttonpropObtainCloseTouchUpInsideWithView:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
