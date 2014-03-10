//
//  lowooBlackCell.m
//  banana_clock
//
//  Created by MAC on 13-3-18.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBlackCell.h"
#import "JSONKit.h"
#import "JSON.h"

@implementation lowooBlackCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        [self setFrame:CGRectMake(0, 0, 320, 59)];
        
        UIImageView *imageViewHeadBack = [[UIImageView alloc]initWithFrame:CGRectMake(15, 3, 61, 61)];
        imageViewHeadBack.image = [UIImage imageNamed:@"headBack.png"];
        [self addSubview:imageViewHeadBack];
        
        UIImageView *imageViewHeadDefault = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 51, 51)];
        imageViewHeadDefault.image = [UIImage imageNamed:@"default_head_small.png"];
        [self addSubview:imageViewHeadDefault];
        
        _imageViewHead = [[UIImageView_custom alloc]initWithFrame:CGRectMake(20, 7, 51, 51)];
        _imageViewHead.layer.masksToBounds = YES;
        _imageViewHead.layer.cornerRadius = 5.0;
        _imageViewHead.layer.borderWidth = 0.5;
        _imageViewHead.layer.borderColor = [[UIColor whiteColor] CGColor];
        [self addSubview:_imageViewHead];
        
        _button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_button setFrame:CGRectMake(83, 5, 219, 56) image:@"statelist" image:@"statelist"];
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(94, 20, 104, 21)];
        _labelName.backgroundColor = [UIColor clearColor];
        [_labelName setTextColor:[UIColor colorWithRed:48/255.0 green:48/255.0 blue:48/255.0 alpha:1]];
        [_labelName setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:_labelName];
        

    }
    return self;
}


- (void)confirmUser:(modelUser *)user{
    [_imageViewHead setImageURL:user.avatarUrl];
    _labelName.text = user.name;
}

- (void)buttonAction:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(blackCellButtonTouchUpInside:)]) {
        [_delegate blackCellButtonTouchUpInside:sender];
    }
}

@end
