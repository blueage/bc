//
//  lowooPOPTheInvitationHasBeenSent.m
//  banana_clock
//
//  Created by MAC on 13-3-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPTheInvitationHasBeenSent.h"

@implementation lowooPOPTheInvitationHasBeenSent

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(59, 128, 203, 190)];
        imageViewPanel.image = GetPngImage(@"POPPanelMedium02");
        [self.viewMove addSubview:imageViewPanel];
        
        self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(68, 159, 185, 60)];
        NSString *namepng = [BASE International:@"theInvitationHasBeenSentText"];
        self.imageViewText.image = GetPngImage(namepng);
        [self.viewMove addSubview:self.imageViewText];
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside)];
        [self.buttonClose setFrame:CGRectMake(82, 239, 157, 53) image:[BASE International:@"POPDeterminea"] image:[BASE International:@"POPDetermineb"]];
    }
    return self;
}


- (void)buttonCloseTouchUpinside{
    if ([_delegate respondsToSelector:@selector(buttonTheInvitationHasBeenSentTouchUpinsideWithentity:)]) {
        [_delegate buttonTheInvitationHasBeenSentTouchUpinsideWithentity:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonTheInvitationHasBeenSentTouchUpinside" object:nil userInfo:nil];
}




@end
