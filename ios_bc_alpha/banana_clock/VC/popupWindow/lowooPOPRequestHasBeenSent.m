//
//  lowooPOPRequestHasBeenSent.m
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPRequestHasBeenSent.h"

@implementation lowooPOPRequestHasBeenSent

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(59, 128, 195, 166)];
        imageViewPanel.image = GetPngImage(@"POPPanelMedium02");
        [self.viewMove addSubview:imageViewPanel];
        
        self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(68, 150, 185, 60)];
        NSString *namepng = [BASE International:@"POPRequestHasBeenSentText"];
        self.imageViewText.image = GetPngImage(namepng);
        [self.viewMove addSubview:self.imageViewText];
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside)];
        [self.buttonClose setFrame:CGRectMake(80, 220, 157, 53) image:[BASE International:@"POPDeterminea"] image:[BASE International:@"POPDetermineb"]];
        
    }
    return self;
}

- (void)confirmDataWithNSDictionary:(NSDictionary *)sender{


}


- (void)buttonCloseTouchUpinside{
    if ([_delegate respondsToSelector:@selector(buttonRequestHasBeenSentTouchUpinsideWithentity:)]) {
        [_delegate buttonRequestHasBeenSentTouchUpinsideWithentity:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonRequestHasBeenSentTouchUpinside" object:nil userInfo:nil];
}




@end
