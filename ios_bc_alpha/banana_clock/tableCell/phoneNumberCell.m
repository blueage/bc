//
//  phoneNumberCell.m
//  banana_clock
//
//  Created by MAC on 13-7-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//
#import "lowooHTTPManager.h"
#import "phoneNumberCell.h"


@implementation phoneNumberCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        [self setFrame:CGRectMake(0, 0, 320, 70)];
        
        
        UIImageView *imageViewBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 289, 56)];
        imageViewBackGround.image = GetPngImage(@"statelist");
        [self addSubview:imageViewBackGround];
        
        _labelName = [[UILabel alloc] initWithFrame:CGRectMake(35, 20, 100, 21)];
        _labelName.backgroundColor = [UIColor clearColor];
        _labelName.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_labelName];
        
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

        
        _buttonAdd = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonAdd setImageHighlited:[UIImage imageNamed:@"add.png"]];
        [_buttonAdd setImageNormal:[UIImage imageNamed:@"add.png"]];
        [_buttonAdd setFrame:CGRectMake(251, -2, 47, 47)];
        [_buttonAdd addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buttonAdd];
    }
    return self;
}

- (void)confirmData:(NSDictionary *)sender{
    _labelName.text = [sender objectForKey:@"personName"];
    _stringFid = [sender objectForKey:@"fid"];
    if (LANGUAGE_CHINESE) {
        _labelAdd.text = @"添加";
    }else{
        _labelAdd.text = @"add";
    }
}

- (void)buttonAction:(UIButton_custom *)sender{
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: _stringFid, @"fid", nil] requestType:addFriend];
}






@end
