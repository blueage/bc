//
//  lowooPOPFlollowSuccess.m
//  banana_clock
//
//  Created by MAC on 14-1-15.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "lowooPOPFlollowSuccess.h"

@implementation lowooPOPFlollowSuccess

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-441/2)/2, (SCREEN_HEIGHT-441/2)/2-60, 441/2, 441/2)];
        imageViewPanel.image = GetPngImage(@"followBG");
        [self.viewMove addSubview:imageViewPanel];
        
        UIImageView *imageViewText = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-310/2)/2, (SCREEN_HEIGHT-364/2)/2-90, 310/2, 364/2)];
        NSString *namepng = [BASE International:@"followChinese"];
        [imageViewText setImage:GetPngImage(namepng)];
        [self.viewMove addSubview:imageViewText];
        
        if (iPhone5||iPhone5_0) {
            
        }else{
            [imageViewPanel setFrame:CGRectMake((SCREEN_WIDTH-441/2)/2, (SCREEN_HEIGHT-441/2)/2-17, 441/2, 441/2)];
            [imageViewText setFrame:CGRectMake((SCREEN_WIDTH-310/2)/2, (SCREEN_HEIGHT-364/2)/2-47, 310/2, 364/2)];
        }
        
        UIButton_custom *button = [[UIButton_custom alloc] initWithFrame:CGRectMake(125, 320-54, 22, 17)];
        [button setHighlighted:NO];
        [button setImage:GetPngImage(@"attentionShow") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.viewMove addSubview:button];
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose setFrame:CGRectMake(234, 108, 47, 47) image:@"POPClosea" image:@"POPCloseb"];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside:)];
    }
    return self;
}

- (void)buttonAction:(UIButton_custom *)button{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"followShow"] boolValue]) {
        [button setImage:GetPngImage(@"attentionShow") forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"followShow"];
    }else{
        [button setImage:GetPngImage(@"attentionNotShow") forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"followShow"];
    }
}

- (void)buttonCloseTouchUpinside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonFollowCloseTouchUpInsideWithView:)]) {
        [_delegate buttonFollowCloseTouchUpInsideWithView:self];
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
