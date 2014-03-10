//
//  lowooCarToon.m
//  banana_clock
//
//  Created by MAC on 13-3-5.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooCarToon.h"
#define maxImage  8

@implementation lowooCarToon

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
#pragma mark------------iphone5---------
        //黄色背景
        UIView *viewIphone5 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        viewIphone5.backgroundColor = [UIColor colorWithRed:249/255.0 green:181/255.0 blue:56/255.0 alpha:1];
        [self addSubview:viewIphone5];
        

        UIScrollView *scrollView;
        CGRect scrollViewFrame;
        if (iPhone5_0||iPhone5) {
            scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 480)];
        }else{
            if (IOS_7) {
                scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, frame.size.width, 480)];
            }else{
                scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 480)];
            }
        }
        scrollView.clipsToBounds = NO;
        scrollViewFrame = scrollView.frame;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.bounces = NO;
        [scrollView setContentSize:CGSizeMake((8)*320, scrollViewFrame.size.height)];
        [self addSubview:scrollView];
        
        _currentPage = 0;
        _arrayPage = [[NSMutableArray alloc]init];
        
        //初始化个图片并确定初始位置
        _imageView11 = [[UIImageView alloc]initWithFrame:CGRectMake(13, 80, 299, 160)];
        _imageView11.image = GetPngImage(@"1-1");
        _imageView12 = [[UIImageView alloc]initWithFrame:CGRectMake(13, 239, 210, 60)];
        _imageView12.image = GetPngImage(@"1-2");
        _imageView13 = [[UIImageView alloc]initWithFrame:CGRectMake(74, 319, 176, 50)];
        _imageView13.image = GetPngImage(@"1-3");
        
        _imageView21 = [[UIImageView alloc]initWithFrame:CGRectMake(14, -237, 298, 157)];
        _imageView21.image = GetPngImage(@"2-1");
        _imageView22 = [[UIImageView alloc]initWithFrame:CGRectMake(14, 641, 195, 100)];
        _imageView22.image = GetPngImage(@"2-2");
        _imageView23 = [[UIImageView alloc]initWithFrame:CGRectMake(209, 894, 103, 107)];
        _imageView23.image = GetPngImage(@"2-3");
        
        _imageView31 = [[UIImageView alloc]initWithFrame:CGRectMake(1288, 101, 312, 124)];
        _imageView31.image = GetPngImage(@"3-1");
        _imageView32 = [[UIImageView alloc]initWithFrame:CGRectMake(1980, 233, 176, 143)];
        _imageView32.image = GetPngImage(@"3-2");
        
        _imageView41 = [[UIImageView alloc]initWithFrame:CGRectMake(680, -249, 240, 169)];
        _imageView41.image = GetPngImage(@"4-1");
        _imageView42 = [[UIImageView alloc]initWithFrame:CGRectMake(989, 200, 231, 213)];
        _imageView42.image = GetPngImage(@"4-2");
        
        _imageView51 = [[UIImageView alloc]initWithFrame:CGRectMake(990, 685, 276, 187)];
        _imageView51.image =GetPngImage(@"5-1");
        _imageView52 = [[UIImageView alloc]initWithFrame:CGRectMake(982, 1032, 277, 103)];
        _imageView52.image = GetPngImage(@"5-2");
        _imageView53 = [[UIImageView alloc]initWithFrame:CGRectMake(1032, 1282, 194, 136)];
        _imageView53.image = GetPngImage(@"5-3");
        
        _imageView61 = [[UIImageView alloc]initWithFrame:CGRectMake(1952, 42, 155, 149)];
        _imageView61.image = GetPngImage(@"6-1");
        _imageView62 = [[UIImageView alloc]initWithFrame:CGRectMake(2970, 61, 248, 198)];
        _imageView62.image = GetPngImage(@"6-2");
        _imageView63 = [[UIImageView alloc]initWithFrame:CGRectMake(2043, 181, 225, 246)];
        _imageView63.image = GetPngImage(@"6-3");
        
        _imageView71 = [[UIImageView alloc]initWithFrame:CGRectMake(1616, -278, 304, 179)];
        _imageView71.image = GetPngImage(@"7-1");
        _imageView72 = [[UIImageView alloc]initWithFrame:CGRectMake(1941, 128, 130, 122)];
        _imageView72.image = GetPngImage(@"7-2");
        _imageView73 = [[UIImageView alloc]initWithFrame:CGRectMake(1608, 525, 312, 228)];
        _imageView73.image = GetPngImage(@"7-3");
        
        _imageView81 = [[UIImageView alloc]initWithFrame:CGRectMake(2276, 43, 248, 364)];
        _imageView81.image = GetPngImage(@"8-1");
        _imageView82 = [[UIImageView alloc]initWithFrame:CGRectMake(1995, 680, 171, 58)];
        _imageView82.image = GetPngImage(@"8-2");
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonAction)];
        [_imageView82 addGestureRecognizer:tap];
        _imageView82.userInteractionEnabled = YES;
        
        [scrollView addSubview:_imageView11];
        [scrollView addSubview:_imageView12];
        [scrollView addSubview:_imageView13];
        [scrollView addSubview:_imageView21];
        [scrollView addSubview:_imageView22];
        [scrollView addSubview:_imageView23];
        [scrollView addSubview:_imageView31];
        [scrollView addSubview:_imageView32];
        [scrollView addSubview:_imageView42];
        [scrollView addSubview:_imageView41];
        [scrollView addSubview:_imageView51];
        [scrollView addSubview:_imageView52];
        [scrollView addSubview:_imageView53];
        [scrollView addSubview:_imageView61];
        [scrollView addSubview:_imageView62];
        [scrollView addSubview:_imageView63];
        [scrollView addSubview:_imageView71];
        [scrollView addSubview:_imageView72];
        [scrollView addSubview:_imageView73];
        [scrollView addSubview:_imageView81];
        [scrollView addSubview:_imageView82];
        

#pragma mark--------pageControl----------
        int t;
        UIView *viewPageControl;
        if (IOS_7) {
            viewPageControl = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, 320, 45)];
        }else{
            viewPageControl = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, 320, 45)];
        }
        
        viewPageControl.backgroundColor = [UIColor clearColor];
        for (t=1; t<=maxImage; t++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
            NSString *namepng = [NSString stringWithFormat:@"carpage%02d",t];
            imageView.image = GetPngImage(namepng);
            [_arrayPage addObject:imageView];
            [viewPageControl addSubview:imageView];
            imageView.hidden = YES;
        }
        [self addSubview:viewPageControl];
        UIImageView *pageimage = (UIImageView *)[_arrayPage objectAtIndex:0];
        pageimage.hidden = NO;
#pragma mark----------logo------------
        _imageViewLogo = [[UIImageView alloc]initWithFrame:CGRectMake(330, [BASE statusBarHeight], 120, 41)];
        _imageViewLogo.image = GetPngImage(@"banana_logo");
        [self addSubview:_imageViewLogo];
    }
    
    return self;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView;  {

    CGRect rect = _imageViewLogo.frame;
    if (scrollView.contentOffset.x<320) {
        rect.origin.x = 330-scrollView.contentOffset.x;
        _imageViewLogo.frame = rect;
    }else if (scrollView.contentOffset.x>=320){
        [_imageViewLogo setFrame:CGRectMake(10, [BASE statusBarHeight], 120, 41)];
    }

    if (scrollView.contentOffset.x<320) {
        _imageView11.transform = CGAffineTransformMakeTranslation(-scrollView.contentOffset.x*2.5, 0);
        _imageView12.transform = CGAffineTransformMakeTranslation(-scrollView.contentOffset.x*1.1, 0);
        _imageView13.transform = CGAffineTransformMakeTranslation(-scrollView.contentOffset.x*4, 0);
        
        _imageView21.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x, (scrollView.contentOffset.x)*1.0);
        _imageView22.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x, -(scrollView.contentOffset.x)*1.2);
        _imageView23.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x, -(scrollView.contentOffset.x)*2);
    }
    else if(scrollView.contentOffset.x>=320&&scrollView.contentOffset.x<640){
        CGRect frame21 = _imageView21.frame;
        frame21.origin.x = 333.5;
        frame21.origin.y = 82.5;
        CGRect frame22 = _imageView22.frame;
        frame22.origin.x = 333.5;
        frame22.origin.y = 257.5;
        CGRect frame23 = _imageView23.frame;
        frame23.origin.x = 528.5;
        frame23.origin.y = 255;
        [UIView animateWithDuration:0.2
                         animations:^{
                             _imageView21.frame = frame21;
                             _imageView22.frame = frame22;
                             _imageView23.frame = frame23;
                         }];
        
        
        _imageView31.transform = CGAffineTransformMakeTranslation(-scrollView.contentOffset.x*1, 0);
        _imageView32.transform = CGAffineTransformMakeTranslation(-scrollView.contentOffset.x*2, 0);
        
    }
    else if(scrollView.contentOffset.x>=640&&scrollView.contentOffset.x<960){
        _imageView31.transform = CGAffineTransformMakeTranslation(-scrollView.contentOffset.x*1, 0);
        _imageView32.transform = CGAffineTransformMakeTranslation(-scrollView.contentOffset.x*2, 0);
        
        _imageView41.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x-640, scrollView.contentOffset.x-640);

    }
    else if(scrollView.contentOffset.x>=960&&scrollView.contentOffset.x<1280){
        CGRect frame41 = _imageView41.frame;
        frame41.origin.x = 999.5;
        frame41.origin.y = 70.5;
        [UIView animateWithDuration:0.2
                         animations:^{
                             _imageView41.frame = frame41;
                         }];
        
        _imageView51.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x-960, -(scrollView.contentOffset.x-960)*2);
        _imageView52.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x-960, -(scrollView.contentOffset.x-960)*2.6);
        _imageView53.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x-960, -(scrollView.contentOffset.x-960)*3.1);
    }
    else if(scrollView.contentOffset.x>1280&&scrollView.contentOffset.x<1600){
        _imageView51.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x-960, -644 +(scrollView.contentOffset.x-1280)*2);
        _imageView52.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x-960, -(scrollView.contentOffset.x-960)*2.6);
        _imageView53.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x-960, -(scrollView.contentOffset.x-960)*3.1);
        
        _imageView61.transform = CGAffineTransformMakeTranslation(-(scrollView.contentOffset.x-1280)*1.1, 0);
        _imageView62.transform = CGAffineTransformMakeTranslation(-(scrollView.contentOffset.x-1280)*4, 0);
        _imageView63.transform = CGAffineTransformMakeTranslation(-(scrollView.contentOffset.x-1280)*1.3, 0);
    }
    else if(scrollView.contentOffset.x>1600&&scrollView.contentOffset.x<1920){
        _imageView61.transform = CGAffineTransformMakeTranslation(-(scrollView.contentOffset.x-1280)*1.1, 0);
        _imageView62.transform = CGAffineTransformMakeTranslation(-(scrollView.contentOffset.x-1280)*4, 0);
        _imageView63.transform = CGAffineTransformMakeTranslation(-(scrollView.contentOffset.x-1280)*1.3, 0);
        
        _imageView71.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x-1600, scrollView.contentOffset.x-1600);
        _imageView73.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x-1600, -(scrollView.contentOffset.x-1600));
        
    }
    else if(scrollView.contentOffset.x>=1920&&scrollView.contentOffset.x<2240){
        CGRect frame71 = _imageView71.frame;
        frame71.origin.x = 1935.5;
        frame71.origin.y = 41.5;
        CGRect frame73 = _imageView73.frame;
        frame73.origin.x = 1927.5;
        frame73.origin.y = 205.5;
        [UIView animateWithDuration:0.2
                         animations:^{
                             _imageView71.frame = frame71;
                             _imageView73.frame = frame73;
                         }];
        
        _imageView82.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x-1920, -(scrollView.contentOffset.x-1920));
    }
    else if(scrollView.contentOffset.x>=2240&&scrollView.contentOffset.x<2560){
        CGRect frame82 = _imageView82.frame;
        frame82.origin.x = 2314.5;
        frame82.origin.y = 360.5;
        [UIView animateWithDuration:0.2
                         animations:^{
                             _imageView82.frame = frame82;
                         }];
        
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    for (UIImageView *imageview in _arrayPage) {
        imageview.hidden = YES;
    }
    float contentoffset = scrollView.contentOffset.x;
    int i = contentoffset/320;
    UIImageView *imageview = (UIImageView *)[_arrayPage objectAtIndex:i];
    imageview.hidden = NO;
    
    //music
    if (_currentPage != i) {
        [[lowooMusic sharedLowooMusic] SystemSoundID:@"manhua_fanye" type:@"mp3"];
        _currentPage = i;
    }

}

- (void)buttonAction{
    if ([_delegate respondsToSelector:@selector(carToonEnd)]) {
        [_delegate carToonEnd];
    }
    if ([_delegate respondsToSelector:@selector(carToonRemove:)]) {
        [_delegate carToonRemove:self];
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}


@end
