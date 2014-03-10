//
//  lowooPOPShield.m
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPShield.h"

@implementation lowooPOPShield

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
        
        if (LANGUAGE_CHINESE) {
            self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(80, 90, 164, 90)];
        }else{
            self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(80, 105, 164, 90)];
        }
        NSString *str = [BASE International:@"POPHeUsedTheShieldText"];
        self.imageViewText.image = GetPngImage(str);
        [self.viewMove addSubview:self.imageViewText];
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose setFrame:CGRectMake(222, 116, 47, 47) image:@"POPClosea" image:@"POPCloseb"];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside:)];
        
        _viewHead = [[viewHead alloc] init];
        _viewHead.view = [[UIView alloc] initWithFrame:CGRectMake(0, 177, 0, 0)];
        [self.viewMove addSubview:_viewHead.view];
        
    }
    return self;
}

- (void)confirmDataWithDictionary:(NSDictionary *)sender{
    [_viewHead setSmallImageWithUrl:[sender  objectForKey:@"face"] name:[sender objectForKey:@"name"]];
}

- (void)buttonCloseTouchUpinside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonShieldTouchUpinsideWithentity:)]) {
        [_delegate buttonShieldTouchUpinsideWithentity:self];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"buttonShieldTouchUpinside" object:nil userInfo:nil];
    
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:RecentFriendsList];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:refreshFriendList];
}




@end
