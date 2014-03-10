//
//  lowooPOPattention.m
//  banana_clock
//
//  Created by MAC on 13-10-17.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPattention.h"

@implementation lowooPOPattention

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(50, 122, 221, 263)];
        imageViewPanel.image = GetPngImage(@"attentionBack");
        [self.viewMove addSubview:imageViewPanel];
        
        if (LANGUAGE_CHINESE) {
            UIImageView *imageViewText = [[UIImageView alloc] initWithFrame:CGRectMake(98, 105, 145, 229)];
            [imageViewText setImage:GetPngImage(@"attention")];
            [self.viewMove addSubview:imageViewText];
        }else{
            UIImageView *imageViewText = [[UIImageView alloc] initWithFrame:CGRectMake(89, 111, 163, 228)];
            [imageViewText setImage:GetPngImage(@"attentionE")];
            [self.viewMove addSubview:imageViewText];
        }
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"attentionShow"];//首次设置为yes
        
        UIButton_custom *button = [[UIButton_custom alloc] initWithFrame:CGRectMake(128, 320, 22, 17)];
        [button setHighlighted:NO];
        [button setImage:GetPngImage(@"attentionShow") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.viewMove addSubview:button];
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose setFrame:CGRectMake(235, 108, 47, 47) image:@"POPClosea" image:@"POPCloseb"];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside:)];
    }
    return self;
}

- (void)buttonAction:(UIButton_custom *)button{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"attentionShow"] boolValue]) {
        [button setImage:GetPngImage(@"attentionShow") forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"attentionShow"];
    }else{
        [button setImage:GetPngImage(@"attentionNotShow") forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"attentionShow"];
    }
}

- (void)buttonCloseTouchUpinside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonAttentionCloseTouchUpInsideWithView:)]) {
        [_delegate buttonAttentionCloseTouchUpInsideWithView:self];
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
