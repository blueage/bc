//
//  sinaCell.m
//  banana_clock
//
//  Created by MAC on 13-7-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "sinaCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation sinaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        [self setFrame:CGRectMake(0, 0, 320, 70)];
        
        UIImageView *imageViewState = [[UIImageView alloc]initWithFrame:CGRectMake(83, 5, 219, 56)];
        [imageViewState setImage:[UIImage imageNamed:@"statelist.png"]];
        [self addSubview:imageViewState];
        
        _button = [UIButton_custom buttonWithType:UIButtonTypeRoundedRect];
        [_button setFrame:CGRectZero];
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _button.backgroundColor = [UIColor clearColor];
        [self addSubview:_button];

        _labelAdd = [[THLabel alloc] initWithFrame:CGRectMake(260, 39, 34, 21)];
        [_labelAdd setTextAlignment:NSTextAlignmentCenter];
        [_labelAdd setFont:[UIFont systemFontOfSize:8]];
        [_labelAdd setBackgroundColor:[UIColor clearColor]];
        [_labelAdd setTextColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];

        [_labelAdd setStrokeColor:[UIColor whiteColor]];
        [_labelAdd setStrokeSize:1.5f];
        [_labelAdd setShadowColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];
        [_labelAdd setShadowOffset:CGSizeMake(0, 0)];
        [_labelAdd setShadowBlur:2];
        
        
        [self addSubview:_labelAdd];
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(94, 22, 104, 21)];
        _labelName.backgroundColor = [UIColor clearColor];
        [_labelName setTextColor:[UIColor colorWithRed:48/255.0 green:48/255.0 blue:48/255.0 alpha:1]];
        [_labelName setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:_labelName];
        
        _imageViewHead = [[UIImageView_custom alloc]initWithFrame:CGRectMake(20, 7, 51, 51)];
        _imageViewHead.layer.masksToBounds = YES;
        _imageViewHead.layer.cornerRadius = 5.0;
        _imageViewHead.layer.borderWidth = 0.5;
        _imageViewHead.layer.borderColor = [[UIColor whiteColor] CGColor];
        [self addSubview:_imageViewHead];
        

    }
    return self;
}

- (void)buttonAction:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(sinaCellButtonTouchupInside:toSinaID:)]) {
        [_delegate sinaCellButtonTouchupInside:_stringfid toSinaID:_stringSinaid];
    }
}

- (void)ConfirmDataWithDictionary:(NSDictionary *)dictionary{
    _stringSinaid = [dictionary objectForKey:@"id"];
    _labelName.text = [dictionary objectForKey:@"screen_name"];
    [_imageViewHead downLoadImage:[dictionary objectForKey:@"profile_image_url"]];


    if (LANGUAGE_CHINESE) {
        if ([dictionary objectForKey:@"fid"]) {
            _stringfid = [dictionary objectForKey:@"fid"];
            _labelAdd.text = @"添加";
            _labelAdd.hidden = NO;
            [_button setFrame:CGRectMake(251, -2, 47, 47)];
            [_button setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            [_button setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateHighlighted];
        }else{
            _stringfid = @"";
            _labelAdd.hidden = YES;
            [_button setFrame:CGRectMake(242, 20, 64*0.7, 36*0.7)];
            [_button setBackgroundImage:[UIImage imageNamed:@"Invite"] forState:UIControlStateNormal];
            [_button setBackgroundImage:[UIImage imageNamed:@"Invite"] forState:UIControlStateHighlighted];
        }
    }else{
        if ([dictionary objectForKey:@"fid"]) {
            _stringfid = [dictionary objectForKey:@"fid"];
            _labelAdd.text = @"Add";
            _labelAdd.hidden = NO;
            [_button setFrame:CGRectMake(251, -2, 47, 47)];
            [_button setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            [_button setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateHighlighted];
        }else{
            _stringfid = @"";
            _labelAdd.hidden = YES;
            [_button setFrame:CGRectMake(230, 18, 64, 36)];
            [_button setBackgroundImage:[UIImage imageNamed:@"InviteEnglish"] forState:UIControlStateNormal];
            [_button setBackgroundImage:[UIImage imageNamed:@"InviteEnglish"] forState:UIControlStateHighlighted];
        }
    }
}


@end
