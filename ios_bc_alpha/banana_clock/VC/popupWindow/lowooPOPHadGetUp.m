//
//  lowooPOPHadGetUp.m
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPHadGetUp.h"

@implementation lowooPOPHadGetUp

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
        
        if (LANGUAGE_CHINESE) {
            self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(80, 80, 164, 90)];
        }else{
            self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(80, 95, 164, 90)];
        }
        NSString *str = [BASE International:@"POPHeHasToGetUpText"];
        self.imageViewText.image = GetPngImage(str);
        [self.viewMove addSubview:self.imageViewText];
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose setFrame:CGRectMake(222, 116, 47, 47) image:@"POPClosea" image:@"POPCloseb"];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside:)];

        _viewHead = [[viewHead alloc] init];
        _viewHead.view = [[UIView alloc] initWithFrame:CGRectMake(0, 165, 0, 0)];
        [self.viewMove addSubview:_viewHead.view];

        
    }
    return self;
}

- (void)confirmDataWithDictionary:(NSDictionary *)sender{
    [_viewHead setSmallImageWithUrl:[sender  objectForKey:@"face"] name:[sender objectForKey:@"name"]];
}


- (void)buttonCloseTouchUpinside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonHadGetUpTouchUpinsideWithentity:)]) {
        [_delegate buttonHadGetUpTouchUpinsideWithentity:self];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonHadGetUpTouchUpinside" object:nil userInfo:nil];
    
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:RecentFriendsList];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:refreshFriendList];
}





@end
