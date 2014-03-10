//
//  lowooPOPFriendsAddRequest.m
//  banana_clock
//
//  Created by MAC on 13-3-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPFriendsAddRequest.h"
#import "JSON.h"
#import "JSONKit.h"

@implementation lowooPOPFriendsAddRequest

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc]initWithFrame:CGRectMake(43, 81, 234, 313)];
        imageViewPanel.image = GetPngImage(@"POPPanelLarge");
        [self.viewMove addSubview:imageViewPanel];
        
        self.imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(67, 67, 187, 52)];
        NSString *str = [BASE International:@"POPFriendsAddRequestText"];
        self.imageViewText.image = GetPngImage(str);
        [self.viewMove addSubview:self.imageViewText];
        
        self.buttonEnter = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.buttonEnter setFrame:CGRectMake(82, 246, 157, 53) image:[BASE International:@"POPAgreeButtona"] image:[BASE International:@"POPAgreeButtonb"]];
        self.buttonEnter.tag = 0;
        [self.buttonEnter addTarget:self action:@selector(buttonDetermineTouchUpInside)];
        [self.viewMove addSubview:self.buttonEnter];

        
        
        
        _buttonRefuse = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonRefuse setFrame:CGRectMake(82, 310, 157, 53) image:[BASE International:@"POPRefuseButtona"] image:[BASE International:@"POPRefuseButtonb"]];
        _buttonRefuse.tag = 1;
        [_buttonRefuse addTarget:self action:@selector(buttonRefuseTouchUpInside)];
        [self.viewMove addSubview:_buttonRefuse];
        

        _buttonBlack = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonBlack setFrame:CGRectMake(82, 310, 157, 53) image:[BASE International:@"POPBlacklistButtona"] image:[BASE International:@"POPBlacklistButtonb"]];
        _buttonBlack.tag = 2;
        [_buttonBlack addTarget:self action:@selector(buttonRefuseTouchUpInside)];
        [self.viewMove addSubview:_buttonBlack];
        _buttonBlack.hidden = YES;
        

        UIImageView *imageViewHeadDefault = [[UIImageView alloc] initWithFrame:CGRectMake(125, 137, 70, 68)];
        imageViewHeadDefault.image = GetPngImage(@"default_head_small");
        [self.viewMove addSubview:imageViewHeadDefault];
        _imageViewAvatar = [[UIImageView_custom alloc]initWithFrame:CGRectMake(125, 137, 70, 68)];
        [self.viewMove addSubview:_imageViewAvatar];
        _imageViewAvatarBackground = [[UIImageView alloc]initWithFrame:CGRectMake(115, 127, 90, 90)];
        _imageViewAvatarBackground.image = GetPngImage(@"POPAvatarSmall");
        [self.viewMove addSubview:_imageViewAvatarBackground];
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(100, 217, 120, 21)];
        _labelName.backgroundColor = [UIColor clearColor];
        [_labelName setTextAlignment:NSTextAlignmentCenter];
        [self.viewMove addSubview:_labelName];
        
    }
    return self;
}

- (void)confirmDataWithUser:(modelUser *)user{
    if (user.avatarUrl != nil) {
        [_imageViewAvatar setImageURL:user.avatarUrl];
    }
    if (user.boolRefuse) {
        _buttonBlack.hidden = NO;
        _buttonRefuse.hidden = YES;
    }else{
        _buttonBlack.hidden = YES;
        _buttonRefuse.hidden = NO;
    }
    _labelName.text = user.name;
    _stringfid = user.fid;
}

- (void)buttonCloseTouchUpinside{
    if ([_delegate respondsToSelector:@selector(buttonFriendsAddRequestTouchUpinsideWithentity:)]) {
        [_delegate buttonFriendsAddRequestTouchUpinsideWithentity:self];
    }
}

- (void)buttonDetermineTouchUpInside{
    [[lowooHTTPManager getInstance]doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: _stringfid,@"fid", nil] requestType:applayFriendRequest];
    [self buttonCloseTouchUpinside];
}

- (void)buttonRefuseTouchUpInside{
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: _stringfid ,@"fid" , nil] requestType:ignoreFriendRequest];
    [self buttonCloseTouchUpinside];
}



@end
