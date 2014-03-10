//
//  lowooGettingUpViewController.m
//  banana_clock
//
//  Created by MAC on 13-5-6.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooGettingUpViewController.h"

@interface lowooGettingUpViewController ()

@end

@implementation lowooGettingUpViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"CALL";
    [self changeTitle];
    _boolAnimation = YES;
    if (_imageViewText) {
        [self animation1];
    }
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"navigationViewHiddenno" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _boolAnimation = NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:RecentFriendsList];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:refreshFriendList];

	[self initView];
}

- (void)initView{
    _boolAnimation = NO;
    for (UIView *aview in self.view.subviews) {
        [aview removeFromSuperview];
    }
    
    _imageViewBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, -4, 320, SCREEN_HEIGHT)];
    if (iPhone5||iPhone5_0) {
        _imageViewBack.image = GetPngImage(@"launch_bc5b");
    }else{
        _imageViewBack.image = GetPngImage(@"launch_bc4b");
    }
    _imageViewBack.alpha = 1;
    [self.view addSubview:_imageViewBack];
    
    _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _viewBack.backgroundColor = [UIColor clearColor];
    _viewBack.clipsToBounds = YES;
    [self.view addSubview: _viewBack];
    
    _viewHead  = [[viewHead alloc] init];
    _viewHead.view = [[UIView alloc] initWithFrame:CGRectZero];
    _labelName = [[UILabel alloc] init];
    _labelName.backgroundColor = [UIColor clearColor];
    _labelName.textColor = [UIColor whiteColor];
    _labelName.textAlignment = NSTextAlignmentCenter;
    _imageViewProp = [[UIImageView alloc] initWithFrame:CGRectZero];
    if (iPhone5||iPhone5_0) {
        CGRect frame = _viewHead.view.frame;
        frame.origin.y = 70;
        [_viewHead.view setFrame:frame];
        [_labelName setFrame:CGRectMake(0, 163, 320, 25)];
        [_imageViewProp setFrame:CGRectMake(180, 60, 34, 35)];
        
        _imageViewPeopleLeft = [[UIImageView alloc]initWithFrame:CGRectMake(-56-100, 220, 180, 190)];
        _imageViewPeopleRight = [[UIImageView alloc]initWithFrame:CGRectMake(183+100, 220, 180, 190)];
        if (LANGUAGE_CHINESE) {
            _imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(79, 220, 155, 85)];
            _imageViewText.image = GetPngImage(@"Callpage_text_cn1");
        }else{
            _imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(79, 270, 165, 35)];
            _imageViewText.image = GetPngImage(@"Callpage_text_en1");
        }
    }else{
        CGRect frame = _viewHead.view.frame;
        frame.origin.y = 40;
        [_viewHead.view setFrame:frame];
        [_labelName setFrame:CGRectMake(0, 133, 320, 25)];
        [_imageViewProp setFrame:CGRectMake(180, 30, 34, 35)];
        
        _imageViewPeopleLeft = [[UIImageView alloc]initWithFrame:CGRectMake(-56-100, 180, 180, 190)];
        _imageViewPeopleRight = [[UIImageView alloc]initWithFrame:CGRectMake(183+100, 180, 180, 190)];
        if (LANGUAGE_CHINESE) {
            _imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(79, 200, 155, 85)];
            _imageViewText.image = GetPngImage(@"Callpage_text_cn1");
        }else{
            _imageViewText = [[UIImageView alloc]initWithFrame:CGRectMake(79, 240, 165, 35)];
            _imageViewText.image = GetPngImage(@"Callpage_text_en1");
        }
    }
    [_viewBack addSubview:_viewHead.view];
    [_viewBack addSubview:_labelName];
    [_viewBack addSubview:_imageViewProp];
    
    _imageViewPeopleLeft.image = GetPngImage(@"Callpage_pic01");
    [_viewBack addSubview:_imageViewPeopleLeft];
    
    _imageViewPeopleRight.image = GetPngImage(@"Callpage_pic02");
    [_viewBack addSubview:_imageViewPeopleRight];
    [_viewBack addSubview:_imageViewText];
    
    [self animation];
}

- (void)confirmDataWithUser:(modelUser *)user propID:(NSString *)propID{
    [self.view bringSubviewToFront:_viewHead.view];
    if (user.avatarUrl!=nil) {
        [_viewHead setImageWithUrl:user.avatarUrl name:@""];
    }else{
        [_viewHead setImageWithUrl:@"" name:@""];
    }
    [_labelName setText:user.name];
    
    NSString *smallName = [NSString stringWithFormat:@"%02d.png.small",[propID intValue]];
    [_imageViewProp setImage:GetPngImage(smallName)];
}


- (void)animation{
    _imageViewText.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_TO_RADIANS(0.5));
    [self animation1];
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _imageViewPeopleLeft.transform = CGAffineTransformScale(CGAffineTransformRotate(CGAffineTransformTranslate(CGAffineTransformIdentity, 100, -25), DEGREES_TO_RADIANS(-0.5)), 0.98, 1);
                         _imageViewPeopleRight.transform = CGAffineTransformScale(CGAffineTransformRotate(CGAffineTransformTranslate(CGAffineTransformIdentity, -100, -25), DEGREES_TO_RADIANS(-0.5)), 0.98, 1);
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)animation1{
    [UIView animateWithDuration:0.05
                     animations:^{
                         _imageViewText.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_TO_RADIANS(0.5));
                         
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.05
                                          animations:^{
                                              _imageViewText.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_TO_RADIANS(-0.5));
                                          } completion:^(BOOL finished) {
                                              if (_boolAnimation) {
                                                  [self animation1];
                                              }
                                          }];
                     }];
}

- (void)leftButtonDidTouchedUpInside{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
