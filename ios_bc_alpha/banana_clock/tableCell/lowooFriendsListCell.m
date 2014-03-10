//
//  lowooFriendsListCell.m
//  banana_clock
//
//  Created by MAC on 12-12-25.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooFriendsListCell.h"
#import "JSONKit.h"
#import "JSON.h"

@implementation lowooFriendsListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        [self setFrame:CGRectMake(0, 0, 320, 78)];
        
        _imageViewBackgound = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 78)];
        _imageViewBackgound.image = [UIImage imageNamed:@"listCellBack.png"];
        [self addSubview:_imageViewBackgound];
        
        UIImageView *imageViewHeadBack = [[UIImageView alloc]initWithFrame:CGRectMake(81, 2, 54, 54)];
        imageViewHeadBack.image = [UIImage imageNamed:@"listHeadBack.png"];
        [self addSubview:imageViewHeadBack];

        UIImageView *imageViewHeadBack1 = [[UIImageView alloc]initWithFrame:CGRectMake(160, 2, 54, 54)];
        imageViewHeadBack1.image = [UIImage imageNamed:@"listHeadBack.png"];
        [self addSubview:imageViewHeadBack1];

        UIImageView *imageViewHeadBack2 = [[UIImageView alloc]initWithFrame:CGRectMake(238, 2, 54, 54)];
        imageViewHeadBack2.image = [UIImage imageNamed:@"listHeadBack.png"];
        [self addSubview:imageViewHeadBack2];

        UIImageView *imageViewDefault1 = [[UIImageView alloc] initWithFrame:CGRectMake(86, 7, 44, 44)];
        imageViewDefault1.image = [UIImage imageNamed:@"default_head_small.png"];
        [self addSubview:imageViewDefault1];
        
        UIImageView *imageViewDefault2 = [[UIImageView alloc] initWithFrame:CGRectMake(165, 7, 44, 44)];
        imageViewDefault2.image = [UIImage imageNamed:@"default_head_small.png"];
        [self addSubview:imageViewDefault2];
        
        UIImageView *imageViewDefault3 = [[UIImageView alloc] initWithFrame:CGRectMake(243, 7, 44, 44)];
        imageViewDefault3.image = [UIImage imageNamed:@"default_head_small.png"];
        [self addSubview:imageViewDefault3];
        
        _imageViewHeadGetup = [[UIImageView_custom alloc]initWithFrame:CGRectMake(86, 7, 44, 44)];
        [self addSubview:_imageViewHeadGetup];
        _imageViewHeadLazy = [[UIImageView_custom alloc]initWithFrame:CGRectMake(165, 7, 44, 44)];
        [self addSubview:_imageViewHeadLazy];
        _imageViewHeadCall = [[UIImageView_custom alloc]initWithFrame:CGRectMake(243, 7, 44, 44)];
        [self addSubview:_imageViewHeadCall];
        
        _labelGetup = [[UILabel alloc] initWithFrame:CGRectMake(76, 55, 64, 20)];
        _labelGetup.backgroundColor = [UIColor clearColor];
        _labelGetup.textAlignment = NSTextAlignmentCenter;
        _labelGetup.textColor = COLOR_CHINESE;
        _labelGetup.font = [UIFont systemFontOfSize:12.0];
        [self  addSubview:_labelGetup];
        
        _labelLazy = [[UILabel alloc] initWithFrame:CGRectMake(155, 55, 64, 20)];
        _labelLazy.backgroundColor = [UIColor clearColor];
        _labelLazy.textAlignment = NSTextAlignmentCenter;
        _labelLazy.textColor = COLOR_CHINESE;
        _labelLazy.font = [UIFont systemFontOfSize:12.0];
        [self  addSubview:_labelLazy];
        
        _labelCall = [[UILabel alloc] initWithFrame:CGRectMake(233, 55, 64, 20)];
        _labelCall.backgroundColor = [UIColor clearColor];
        _labelCall.textAlignment = NSTextAlignmentCenter;
        _labelCall.textColor = COLOR_CHINESE;
        _labelCall.font = [UIFont systemFontOfSize:12.0];
        [self  addSubview:_labelCall];
        
        _viewListNumber = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 58)];
        [self addSubview:_viewListNumber];
        
    }
    return self;
}

- (void)confirmUserGetup:(modelUser *)userGetup UserLazy:(modelUser *)userLazy UserCall:(modelUser *)userCall{
    [_imageViewHeadGetup setImageURL:userGetup.avatarUrl];
    _labelGetup.text = userGetup.name;
    
    [_imageViewHeadLazy setImageURL:userLazy.avatarUrl];
    _labelLazy.text = userLazy.name;
    
    [_imageViewHeadCall setImageURL:userCall.name];
    _labelCall.text = userCall.name;
 
}

- (void)setListNumber:(NSInteger )number{
    if (number%2==1) {
        _imageViewBackgound.hidden = YES;
    }else{
        _imageViewBackgound.hidden = NO;
    }
    [_viewNumber removeFromSuperview];
    
    _viewNumber = [[UIView alloc] initWithFrame:CGRectZero];
    [_viewListNumber addSubview:_viewNumber];
    NSMutableArray *numbers = [NSMutableArray array];
    int left = 0;
    UIImageView *imageView;
    while (number) {
        int c = number%10;
        [numbers addObject:[NSNumber numberWithInt:c]];
        number = number/10;
    }
    
    for (int i=[numbers count] - 1; i>=0; i--) {
        NSString *name = [NSString stringWithFormat:@"list%@",[numbers objectAtIndex:i]];
        UIImage *image = GetPngImage(name);
        imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setFrame:(CGRect){left,0,{image.size.width/2,image.size.height/2}}];
        [_viewNumber addSubview:imageView];
        left += image.size.width/2;
    }
    [_viewNumber setFrame:(CGRect){0,0,left,imageView.frame.size.height}];
    [_viewNumber setCenter:_viewListNumber.center];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
