//
//  lowooPOPDeleteFriend.m
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPDeleteFriend.h"

@implementation lowooPOPDeleteFriend

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(59, 128, 203, 190)];
        imageViewPanel.image = GetPngImage(@"POPPanelMedium02");
        [self.viewMove addSubview:imageViewPanel];
        
        self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(77, 77, 166, 94)];
        NSString *namepng = [BASE International:@"POPDoYouWantToDeleteFriendText"];
        self.imageViewText.image = GetPngImage(namepng);
        if (!LANGUAGE_CHINESE) {
            [self.imageViewText setFrame:CGRectMake(77, 88, 166, 94)];
        }
        [self.viewMove addSubview:self.imageViewText];
        

        self.buttonEnter = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.buttonEnter setFrame:CGRectMake(82, 179, 157, 53) image:[BASE International:@"POPDeterminea"] image:[BASE International:@"POPDetermineb"]];
        [self.buttonEnter addTarget:self action:@selector(buttonDeleteTouchUpinside)];
        self.buttonEnter.tag = 0;
        [self.viewMove addSubview:self.buttonEnter];
        

        _buttonCancel = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonCancel setFrame:CGRectMake(82, 241, 157, 53) image:[BASE International:@"POPCancela"] image:[BASE International:@"POPCancelb"]];
        [_buttonCancel addTarget:self action:@selector(buttonCloseTouchUpinside)];
        _buttonCancel.tag = 1;
        [self.viewMove addSubview:_buttonCancel];
        

        
    }
    return self;
}

- (void)buttonDeleteTouchUpinside{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteFriend" object:nil];
    if ([_delegate respondsToSelector:@selector(buttonDeleteFriendTouchUpinsideWithentity:)]) {
        [_delegate buttonDeleteFriendTouchUpinsideWithentity:self];
    }
}

- (void)buttonCloseTouchUpinside{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rightSwipeAction" object:nil];
    if ([_delegate respondsToSelector:@selector(buttonDeleteFriendTouchUpinsideWithentity:)]) {
        [_delegate buttonDeleteFriendTouchUpinsideWithentity:self];
    }
}


@end
