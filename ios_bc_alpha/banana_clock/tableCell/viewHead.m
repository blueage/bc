//
//  viewHead.m
//  banana_clock
//
//  Created by MAC on 13-8-27.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "viewHead.h"

@implementation viewHead

- (void)setImageWithUrl:(NSString *)url name:(NSString *)name{
    for (UIView *aview in self.view.subviews) {
        [aview removeFromSuperview];
    }
    
    UIImage *imageBack = GetPngImage(@"default_head_small");
    UIImage *imageMask = GetPngImage(@"HeadMask");
    UIImageView *imageviewBack = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, imageMask.size.width/2-10, imageMask.size.height/2-10)];
    imageviewBack.image = imageBack;
    [self.view addSubview:imageviewBack];
    
    if (url.length>0) {
        UIImageView_custom *imageViewHead = [[UIImageView_custom alloc] initWithFrame:CGRectMake(4, 4, imageMask.size.width/2-10, imageMask.size.height/2-10)];
        [imageViewHead setImageURL:[NSString stringWithFormat:@"%@",url]];
        [self.view addSubview:imageViewHead];
    }
    
    
    UIImageView *imageViewMask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageMask.size.width/2, imageMask.size.height/2)];
    imageViewMask.image = imageMask;
    [self.view addSubview:imageViewMask];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(-20, imageMask.size.height/2, imageMask.size.width/2+40, 20)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
    _label.text = name;
    [self.view addSubview:_label];
    [self.view setFrame:(CGRect){SCREEN_WIDTH/2-imageMask.size.width/2/2, self.view.frame.origin.y-5,{imageMask.size.width/2,imageMask.size.height/2}}];
}

- (void)setSmallImageWithUrl:(NSString *)url name:(NSString *)name{
    for (UIView *aview in self.view.subviews) {
        [aview removeFromSuperview];
    }
    
    UIImage *imageBack = GetPngImage(@"default_head_small");
    UIImage *imageMask = GetPngImage(@"POPAvatarSmall");
    UIImageView *imageviewBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, imageMask.size.width/2-18, imageMask.size.height/2-19)];
    imageviewBack.image = imageBack;
    [self.view addSubview:imageviewBack];
    
    if ([BASE isNotNull:url] && url.length>0) {
        UIImageView_custom *imageViewHead = [[UIImageView_custom alloc] initWithFrame:CGRectMake(10, 10, imageMask.size.width/2-18, imageMask.size.height/2-19)];
        [imageViewHead setImageURL:[NSString stringWithFormat:@"%@",url]];
        [self.view addSubview:imageViewHead];
    }
    
    
    UIImageView *imageViewMask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageMask.size.width/2, imageMask.size.height/2)];
    imageViewMask.image = imageMask;
    [self.view addSubview:imageViewMask];
    
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(-20, imageMask.size.height/2-5, imageMask.size.width/2+40, 30)];
    labelName.backgroundColor = [UIColor clearColor];
    labelName.textAlignment = NSTextAlignmentCenter;
    labelName.text = name;
    [self.view addSubview:labelName];
    [self.view setFrame:(CGRect){SCREEN_WIDTH/2-imageMask.size.width/2/2, self.view.frame.origin.y,{imageMask.size.width/2,imageMask.size.height/2}}];
}

- (void)setCallBackImageWithUrl:(NSString *)url name:(NSString *)name{

}


@end
