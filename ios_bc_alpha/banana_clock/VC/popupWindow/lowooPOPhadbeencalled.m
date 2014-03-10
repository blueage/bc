//
//  lowooPOPhadbeencalled.m
//  banana_clock
//
//  Created by MAC on 13-5-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPhadbeencalled.h"

@interface lowooPOPhadbeencalled ()

@end

@implementation lowooPOPhadbeencalled

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"CALL";
    [self changeTitle];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.clipsToBounds = NO;
    [self initView];
}

- (void)initView{
    _imageViewBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, -4, 320, SCREEN_HEIGHT)];
    [self.view addSubview:_imageViewBack];
    _viewHead  = [[viewHead alloc] init];
    _viewHead.view = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (iPhone5||iPhone5_0) {
        _imageViewBack.image = GetPngImage(@"launch_bc5b");
        CGRect frame = _viewHead.view.frame;
        frame.origin.y = 70;
        [_viewHead.view setFrame:frame];
        
        if (LANGUAGE_CHINESE) {
            _imageViewText = [[UIImageView alloc] initWithFrame:CGRectMake(132, 300, 175, 65)];
            _imageViewText.image = GetPngImage(@"Callpage_text_cn2");
        }else{
            _imageViewText = [[UIImageView alloc] initWithFrame:CGRectMake(132, 300, 155, 55)];
            _imageViewText.image = GetPngImage(@"Callpage_text_en2");
        }
    }else{
        _imageViewBack.image = GetPngImage(@"launch_bc4b");
        CGRect frame = _viewHead.view.frame;
        frame.origin.y = 40;
        [_viewHead.view setFrame:frame];
        
        if (LANGUAGE_CHINESE) {
            _imageViewText = [[UIImageView alloc] initWithFrame:CGRectMake(132, 240, 175, 65)];
            _imageViewText.image = GetPngImage(@"Callpage_text_cn2");
        }else{
            _imageViewText = [[UIImageView alloc] initWithFrame:CGRectMake(132, 240, 155, 55)];
            _imageViewText.image = GetPngImage(@"Callpage_text_en2");
        }
    }
    
    

    [self.view addSubview:_imageViewText];
    [self.view addSubview:_viewHead.view];
}

- (void)confirmDataWithUser:(modelUser *)user{
    [self.view bringSubviewToFront:_viewHead.view];
    if (user.avatarUrl != nil) {
        [_viewHead setImageWithUrl:user.avatarUrl name:user.name];
    }else{
        [_viewHead setImageWithUrl:@"" name:user.name];
    }
    _viewHead.label.textColor = [UIColor whiteColor];
    _viewHead.label.font = [UIFont systemFontOfSize:16.0];
    [self animation];
}

- (void)animation{
    if (iPhone5_0||iPhone5) {
        _imageViewPeople = [[UIImageView alloc] initWithFrame:CGRectMake(-100, 230, 140, 185)];
    }else{
        _imageViewPeople = [[UIImageView alloc] initWithFrame:CGRectMake(-100, 170, 140, 185)];
    }
    _imageViewPeople.image = GetPngImage(@"Callpage_pic03");
    [self.view addSubview:_imageViewPeople];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         _imageViewPeople.transform = CGAffineTransformMakeTranslation(110, 0);
                     } completion:^(BOOL finished) {
                     }];
}

- (void)leftButtonDidTouchedUpInside{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
