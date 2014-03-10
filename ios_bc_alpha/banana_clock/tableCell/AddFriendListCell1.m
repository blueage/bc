//
//  AddFriendListCell1.m
//  banana_clock
//
//  Created by MAC on 13-8-11.
//  Copyright (c) 2013年 MAC. All rights reserved.
//u

#import "AddFriendListCell1.h"

@implementation AddFriendListCell1

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        [self setFrame:CGRectMake(0, 0, 320, 70)];
        
        UIImageView *imageViewHeadDefault = [[UIImageView alloc] initWithFrame:CGRectMake(19, 6, 52, 52)];
        imageViewHeadDefault.image = GetPngImage(@"default_head_small");
        [self addSubview:imageViewHeadDefault];
        
        _imageViewHead = [[UIImageView_custom alloc]initWithFrame:CGRectMake(19.5, 6.5, 52, 52)];
        [self addSubview:_imageViewHead];
        
        UIImageView *imageViewHeadMask = [[UIImageView alloc]initWithFrame:CGRectMake(15, 3, 61, 61)];
        imageViewHeadMask.image = GetPngImage(@"headBack");
        imageViewHeadMask.backgroundColor = [UIColor clearColor];
        [self addSubview:imageViewHeadMask];
        
        _imageViewState = [[UIImageView alloc] initWithFrame:CGRectMake(83, 5, 219, 56)];
        _imageViewState.image = GetPngImage(@"statelist");
        [self addSubview:_imageViewState];
        
        _buttonAddfriend = [UIButton_custom buttonWithType:UIButtonTypeCustom];//无按下状态
        [_buttonAddfriend setFrame:CGRectMake(250, 0, 47, 70)];
        _buttonAddfriend.backgroundColor = [UIColor clearColor];
        _buttonAddfriend.highlighted = NO;
        [_buttonAddfriend addTarget:self action:@selector(AddTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buttonAddfriend];
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(94, 20, 140, 21)];
        _labelName.backgroundColor = [UIColor clearColor];
        [_labelName setTextColor:[UIColor colorWithRed:48/255.0 green:48/255.0 blue:48/255.0 alpha:1]];
        [_labelName setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:_labelName];
        
        _imageViewExclamation = [[UIImageView alloc] initWithFrame:CGRectMake(251, -2, 47, 47)];
        _imageViewExclamation.image = GetPngImage(@"add");
        [self addSubview:_imageViewExclamation];
        
        _labelExclamation = [[THLabel alloc] initWithFrame:CGRectMake(259, 39, 34, 21)];
        [_labelExclamation setTextAlignment:NSTextAlignmentCenter];
        [_labelExclamation setFont:[UIFont systemFontOfSize:8]];
        [_labelExclamation setBackgroundColor:[UIColor clearColor]];
        [_labelExclamation setTextColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];

        [_labelExclamation setStrokeColor:[UIColor whiteColor]];
        [_labelExclamation setStrokeSize:1.5f];
        
        [_labelExclamation setShadowColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];
        [_labelExclamation setShadowOffset:CGSizeMake(0, 0)];
        [_labelExclamation setShadowBlur:2];

        [self addSubview:_labelExclamation];
        [self addSubview:_labelExclamation];
    }
    return self;
}

- (void)confirmUser:(modelUser *)user{
    if (user.avatarUrl != nil) {
        [_imageViewHead setImageURL:user.avatarUrl];
    }
    _labelName.text = user.name;
    
    if (LANGUAGE_CHINESE) {
        _labelExclamation.text = @"添加";
    }else{
        _labelExclamation.text = @"Add";
    }

    if (user.relation == 7 || user.relation == 1) {
        [self cancelTouch];
    }
}

- (void)cancelTouch{
    [_imageViewExclamation setFrame:CGRectMake(264, 18, 25, 25)];
    _imageViewExclamation.image = GetPngImage(@"friendcheckmark");
    _labelExclamation.hidden = YES;
    _buttonAddfriend.userInteractionEnabled = NO;
    _imageViewState.alpha = 0.5;
}

- (void)AddTouchUpInside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(buttonAddTouchUpInside:)]) {
        [_delegate buttonAddTouchUpInside:sender];
    }
}


@end
