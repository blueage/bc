//
//  lowoo_m
//  banana clock
//
//  Created by MAC on 12-10-9.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooheadCell.h"
#import "JSON.h"
#import "JSONKit.h"
#import <QuartzCore/QuartzCore.h>
#import "lowooAlertViewDemo.h"

@implementation lowooHeadCell

#define headheight 20


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        //大按钮
        _buttonBig = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonBig setFrame:CGRectMake(22, headheight, 276, 69)];
        [_buttonBig setImageNormal:GetPngImage(@"List_item_bg01")];
        [_buttonBig setImageHighlited:GetPngImage(@"List_item_bg02")];
        [_buttonBig addTarget:self action:@selector(buttonTouchUpInside:)];
        _buttonBig.userInteractionEnabled = NO;
        [self addSubview:_buttonBig];
        
        //头像
        UIView *viewHeadBack = [[UIView alloc]initWithFrame:CGRectMake(22, headheight, 68, 68)];
        viewHeadBack.backgroundColor = [UIColor clearColor];
        [viewHeadBack setTag:100];
        [self addSubview:viewHeadBack];
        
        UIImageView *imageviewdefault = [[UIImageView alloc]initWithFrame:CGRectMake(0.5, 1.5, 67, 65)];
        imageviewdefault.image = GetPngImage(@"default_head_small");//默认头像
        [viewHeadBack addSubview:imageviewdefault];
        
        _imageviewUserHead = [[UIImageView_custom alloc]initWithFrame:CGRectMake(0.5, 1.5, 67, 65)];
        _imageviewUserHead.backgroundColor = [UIColor clearColor];
        [viewHeadBack addSubview:_imageviewUserHead];
        _imageviewUserHead.contentMode = UIViewContentModeScaleAspectFit;//自动适应,保持图片宽高比
        
        //点击头像
        UIButton_custom *buttonHead = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [buttonHead setFrame:CGRectMake(0, 1, 68, 67)];
        [buttonHead addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
        [viewHeadBack addSubview:buttonHead];

        _labelUserName = [[UILabel alloc]initWithFrame:CGRectMake(100, headheight, 150, 29)];
        [_labelUserName setBackgroundColor:[UIColor clearColor]];
        [_labelUserName setTextAlignment:NSTextAlignmentLeft];
        [_labelUserName setFont:[UIFont systemFontOfSize:12.0]];
        [_labelUserName setTextColor:[UIColor colorWithRed:1.0/255.0 green:1.0/255.0 blue:1.0/255.0 alpha:0.3]];
        [self addSubview:_labelUserName];
        
        _labelUserLocation = [[UILabel alloc]initWithFrame:CGRectMake(100, 27+headheight, 119, 15)];
        [_labelUserLocation setBackgroundColor:[UIColor clearColor]];
        [_labelUserLocation setTextAlignment:NSTextAlignmentLeft];
        [_labelUserLocation setFont:[UIFont systemFontOfSize:12.0]];
        [_labelUserLocation setText:@"地区："];
        [_labelUserLocation setTextColor:[UIColor colorWithRed:1.0/255.0 green:1.0/255.0 blue:1.0/255.0 alpha:0.3]];
        [self addSubview:_labelUserLocation];
        
        _labelUserID = [[UILabel alloc]initWithFrame:CGRectMake(100, 48+headheight, 84, 15)];
        [_labelUserID setBackgroundColor:[UIColor clearColor]];
        [_labelUserID setTextAlignment:NSTextAlignmentLeft];
        [_labelUserID setFont:[UIFont systemFontOfSize:12.0]];
        [_labelUserID setText:@"ID:"];
        [_labelUserID setTextColor:[UIColor colorWithRed:1.0/255.0 green:1.0/255.0 blue:1.0/255.0 alpha:0.3]];
        [self addSubview:_labelUserID];
        
        _imageviewUserMale = [[UIImageView alloc]initWithFrame:CGRectMake(72, 45+headheight, 17, 21)];
        [self addSubview:_imageviewUserMale];
        
        _imageviewEditor = [[UIImageView alloc]initWithFrame:CGRectMake(276, 27+headheight, 7.5, 12.5)];
        [_imageviewEditor setImage:GetPngImage(@"jiantou")];
        [self addSubview:_imageviewEditor];
        
        _buttonFoucs = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonFoucs setFrame:CGRectMake(240, 13+headheight, 83/2, 81/2)]; //image:@"foucs_a" image:@"foucs_b"];
        [_buttonFoucs addTarget:self action:@selector(foucsFriend:)];
        [self addSubview:_buttonFoucs];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFoucs:) name:@"foucs" object:nil];
    }
    return self;
}

- (void)foucsFriend:(UIButton_custom *)button{
    //无网络
    if (![[lowooHTTPManager getInstance] isExistenceNetwork]) {
        return;
    }

    
    if (button.tag==0) {//不关注
        //显示提示信息
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"followShow"] boolValue]) {
            lowooPOPFlollowSuccess *followSuccess = [[lowooPOPFlollowSuccess alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [[lowooAlertViewDemo sharedAlertViewManager] show:followSuccess];
        }
        button.tag = 1;
        [button setImageNormal:[UIImage imageNamed:@"foucs_b"]];
        [button setImageHighlited:[UIImage imageNamed:@"foucs_b01"]];
    }else{
        button.tag = 0;
        [button setImageNormal:[UIImage imageNamed:@"foucs_a"]];
        [button setImageHighlited:[UIImage imageNamed:@"foucs_a01"]];
    }
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: _fid, @"fid", nil] requestType:foucs];
}

- (void)didFoucs:(NSNotification *)notification{//不允许同时存在多个此界面 
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:RecentFriendsList];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:refreshFriendList];
}

- (void)confirmDataWithUser:(modelUserDetail *)user{
    _fid = user.uid;
    //蜘蛛网
    if (user.boolSpider) {
        _imageViewMoss.hidden = NO;
        _buttonMoss.hidden = NO;
        
        if (!_imageViewMoss) {
            UIView *view = [self viewWithTag:100];
            _imageViewMoss = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 68)];
            _imageViewMoss.image = GetPngImage(@"moss_big");
            [view addSubview:_imageViewMoss];
            
            _buttonMoss = [UIButton buttonWithType:UIButtonTypeCustom];
            [_buttonMoss setFrame:CGRectMake(0, -5, 18, 31)];
            [_buttonMoss setImage:GetPngImage(@"exclamation") forState:UIControlStateNormal];
            [_buttonMoss setImage:GetPngImage(@"exclamation") forState:UIControlEventTouchUpInside];
            [_buttonMoss addTarget:self action:@selector(mossAction) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:_buttonMoss];
        }
    }else{
        _imageViewMoss.hidden = YES;
        _buttonMoss.hidden = YES;
    }
    if (!user.boolFoucs) {//不关注
        [_buttonFoucs setImageNormal:[UIImage imageNamed:@"foucs_a"]];
        [_buttonFoucs setImageHighlited:[UIImage imageNamed:@"foucs_a01"]];
        _buttonFoucs.tag = 0;
    }else{
        [_buttonFoucs setImageNormal:[UIImage imageNamed:@"foucs_b"]];
        [_buttonFoucs setImageHighlited:[UIImage imageNamed:@"foucs_b01"]];
        _buttonFoucs.tag = 1;
    }
    
    
    if (LANGUAGE_CHINESE) {
        _labelUserName.text = [NSString stringWithFormat:@"昵称:%@",user.name];
    }else{
        _labelUserName.text = [NSString stringWithFormat:@"name:%@",user.name];
    }

    _labelUserID.text = [NSString stringWithFormat:@"ID:%@",user.uid];

    if (LANGUAGE_CHINESE) {
        _labelUserLocation.text = [NSString stringWithFormat:@"地区:%@",user.location];
    }else{
        _labelUserLocation.text = [NSString stringWithFormat:@"location:%@",user.location];
    }

    if (user.avatarUrl) {
        [_imageviewUserHead setImageURL:[NSString stringWithFormat:@"%@",user.avatarUrl]];
    }

    if ([user.sex isEqualToString:@"m"]) {
        _imageviewUserMale.image = GetPngImage(@"regist_male");
    }else{
        _imageviewUserMale.image = GetPngImage(@"regist_female");
    }
}

- (void)tapAction{
    if ([_delegate respondsToSelector:@selector(imageHeadTaped:)]) {
        [_delegate imageHeadTaped:_imageviewUserHead.image];
    }
}

- (void)mossAction{
    lowooPOPMoss *moss = [[lowooPOPMoss alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[lowooAlertViewDemo sharedAlertViewManager] show:moss];
}

- (void) buttonTouchUpInside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonEditDidTouchedUpInside)]) {
        [_delegate buttonEditDidTouchedUpInside];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
