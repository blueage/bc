//
//  lowooPOPAddedSuccessfully.m
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPAddedSuccessfully.h"

@implementation lowooPOPAddedSuccessfully

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(61, 131, 198, 136)];
        imageViewPanel.image = GetPngImage(@"POPPanelSmall");
        [self.viewMove addSubview:imageViewPanel];
        
        self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(72, 172, 176, 56)];
        NSString *namepng = [BASE International:@"POPFriendsAddedSuccessfullyText"];
        self.imageViewText.image = GetPngImage(namepng);
        [self.viewMove addSubview:self.imageViewText];
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose setFrame:CGRectMake(219, 116, 47, 47) image:@"POPClosea" image:@"POPCloseb"];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside:)];
    }
    return self;
}


- (void)buttonCloseTouchUpinside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonAddedSuccessfullyTouchUpinsideWithentity:)]) {
        [_delegate buttonAddedSuccessfullyTouchUpinsideWithentity:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonAddedSuccessfullyTouchUpinside" object:nil userInfo:nil];
}


@end
