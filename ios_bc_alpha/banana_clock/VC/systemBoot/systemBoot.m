//
//  systemBoot.m
//  banana_clock
//
//  Created by MAC on 13-12-3.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "systemBoot.h"
@class time_title;

@implementation systemBoot

- (void)addBaseView:(NSInteger )index{
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:HELP_CENTER] boolValue]) {
        return;
    }
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    _viewAlpha = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _viewAlpha.backgroundColor = [UIColor blackColor];
    _viewAlpha.alpha = 0.5;
    [keyWindow addSubview:_viewAlpha];
    
    _viewBase = [[UIView alloc] initWithFrame:CGRectMake(0, ((SCREEN_HEIGHT-80)-285)/2, SCREEN_WIDTH, 378)];
    _viewBase.backgroundColor = [UIColor clearColor];
    [keyWindow addSubview:_viewBase];

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_viewBase.frame), CGRectGetHeight(_viewBase.frame))];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    
    for (int i=0; i<13; i++) {
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_viewBase.frame)*i + 17.5, 0, 285.5, 378)];
        view.image = [UIImage imageNamed:@"help_back.png"];
        [_scrollView addSubview:view];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_viewBase.frame)*i + 19, 0, 285.5, 378)];
        [_scrollView addSubview:imageView];
        NSString *imageName = [NSString stringWithFormat:@"help_page%d",i];
        imageView.image = GetPngImage(imageName);
    }
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_viewBase.frame)*13, CGRectGetHeight(_viewBase.frame)/4);
    if (index) {
        [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_viewBase.frame)*index, 0) animated:NO];
    }
    [_viewBase addSubview:_scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((320-377/2)/2, 350, 377/2, 10)];
    imageView.image = GetPngImage(@"help_pageControl_back");
    [_viewBase addSubview:imageView];

    _imageViewPoint = [[UIImageView alloc] initWithFrame:CGRectMake(65.5+14.5*index, 350, 14.5, 10)];
    NSString *stringName = [NSString stringWithFormat:@"help_pageControl%d",(index+1)];
    _imageViewPoint.image = GetPngImage(stringName);
    [_viewBase addSubview:_imageViewPoint];

    
    UIButton_custom *button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(270, -13, 47, 47) image:@"POPClosea" image:@"POPCloseb"];
    [button addTarget:self action:@selector(removeBaseView)];
    [_viewBase addSubview:button];
    
    //先缩小再放大
    _viewBase.transform = CGAffineTransformMakeScale(0.3, 0.3);
    if (IOS_7) {
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _viewBase.transform = CGAffineTransformMakeScale(1, 1);
                         } completion:^(BOOL finished) {
                             
                         }];
        
    }else{
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _viewBase.transform = CGAffineTransformMakeScale(1, 1);
                         } completion:^(BOOL finished) {
                             
                         }];
    }
    [self performSelector:@selector(music) withObject:nil afterDelay:.1];
}

- (void)music{
    [[lowooMusic sharedLowooMusic] playShortMusic:@"help" Type:@"mp3"];
}

- (void)addOnceView:(NSInteger)index{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

    _viewAlpha = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _viewAlpha.backgroundColor = [UIColor blackColor];
    _viewAlpha.alpha = 0.5;
    [keyWindow addSubview:_viewAlpha];
    
    _viewBase = [[UIView alloc] initWithFrame:CGRectMake(0, ((SCREEN_HEIGHT-80)-285)/2, SCREEN_WIDTH, 378)];
    _viewBase.backgroundColor = [UIColor clearColor];
    [keyWindow addSubview:_viewBase];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_viewBase.frame), CGRectGetHeight(_viewBase.frame))];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.scrollEnabled = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;

    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(17.5, 0, 285.5, 378)];
    view.image = [UIImage imageNamed:@"help_back.png"];
    [_scrollView addSubview:view];
    
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 0, 285.5, 378)];
        imageView.image = GetPngImage(@"help1-1");
        [_scrollView addSubview:imageView];
        
        UIButton_custom *button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        button.tag = 0;
        [button setFrame:CGRectMake(83, 300, 155, 52) image:@"help_nextstepa" image:@"help_nextstepb"];
        [button addTarget:self action:@selector(buttonAction:)];
        [_scrollView addSubview:button];
    }
    {
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(17+320, 0, 285.5, 378)];
        imageView1.image = GetPngImage(@"help1-2");
        [_scrollView addSubview:imageView1];
        
        UIButton_custom *button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        button.tag = 1;
        [button setFrame:CGRectMake(83+320, 300, 155, 52) image:@"help_nextstepa" image:@"help_nextstepb"];
        [button addTarget:self action:@selector(buttonAction:)];
        [_scrollView addSubview:button];
    }
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(17+320*2, 0, 285.5, 378)];
        imageView.image = GetPngImage(@"help1-3");
        [_scrollView addSubview:imageView];
        
        UIButton_custom *button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        button.tag = 2;
        [button setFrame:CGRectMake(83+320*2, 300, 155, 52) image:@"help_donea" image:@"help_doneb"];
        [button addTarget:self action:@selector(buttonAction:)];
        [_scrollView addSubview:button];
    }
    _scrollView.contentSize = CGSizeMake(320*3, 0);
    _scrollView.contentOffset = CGPointMake(320*index, 0);
    [_viewBase addSubview:_scrollView];
    
    //先缩小再放大
    _viewBase.transform = CGAffineTransformMakeScale(0.3, 0.3);
    if (IOS_7) {
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _viewBase.transform = CGAffineTransformMakeScale(1, 1);
                         } completion:^(BOOL finished) {
                             
                         }];
    }else{
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _viewBase.transform = CGAffineTransformMakeScale(1, 1);
                         } completion:^(BOOL finished) {
                             
                         }];
    }
}

- (void)buttonAction:(UIButton_custom *)button{

    if (button.tag == 0) {
        [_scrollView setContentOffset:CGPointMake(320, 0) animated:YES];
    }else if (button.tag == 1){
        [self removeBaseView];
    }else if (button.tag == 2){
        [self removeBaseView];
        [self performSelector:@selector(removeViewEnd) withObject:nil afterDelay:0.4];
    }
}

- (void)removeBaseView{
    [[time_title shareInstance] setHelp];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _viewBase.transform = CGAffineTransformMakeScale(0.3, 0.3);
                         _viewBase.alpha = 0;
                     } completion:^(BOOL finished) {

                     }];

    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(removeView) withObject:nil afterDelay:0.3];
}

- (void)removeViewEnd{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SYSTEM_BOOT_0] boolValue]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"systemBootEnd" object:nil];
    }
}

- (void)removeView{
    [_viewAlpha removeFromSuperview];
    [_viewBase removeFromSuperview];
}

#pragma mark ---------- pageControlAction ---------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/SCREEN_WIDTH;
    [_imageViewPoint setFrame:CGRectMake(65.5+CGRectGetWidth(_imageViewPoint.frame)*page, 350, 14.5, 10)];
    NSString *stringName = [NSString stringWithFormat:@"help_pageControl%d",(page+1)];
    _imageViewPoint.image = GetPngImage(stringName);
    //_currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float contentoffset = scrollView.contentOffset.x;
    int i = contentoffset/320;

    //music
    if (_currentPage != i) {
        [[lowooMusic sharedLowooMusic] SystemSoundID:@"manhua_fanye" type:@"mp3"];
        _currentPage = i;
    }
    
}


@end
