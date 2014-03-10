//
//  lowooGetUpGame.m
//  banana_clock
//
//  Created by MAC on 13-8-9.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooGetUpGame.h"
#import "liboTOOLS.h"

@interface lowooGetUpGame (){
    BOOL scrolling;
}

@end

@implementation lowooGetUpGame

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _boolOnce = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(offline) name:@"offline" object:nil];
        _scrollViewBack = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollViewBack.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2);
        _scrollViewBack.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
        _scrollViewBack.delegate = self;
        _scrollViewBack.userInteractionEnabled = NO;
        
        _imageViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _imageViewAlpha = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _viewAlpha = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];

        _viewBack = [[UIView alloc] initWithFrame:CGRectZero];
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        _label.font = [UIFont systemFontOfSize:12.0f];
        _label.textAlignment = NSTextAlignmentCenter;
        UIImageView *imageViewNameBack = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageViewNameBack.image = GetPngImage(@"nameback");
        
        _viewTime = [[UIView alloc] initWithFrame:CGRectZero];
        _imageViewButton = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageViewButton.hidden = YES;
         _imageViewButton.image = GetPngImage(@"callbutton01");
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        for (int i=1; i<=24; i++) {
            NSString *name = [NSString stringWithFormat:@"she_mo00%02d.png",i];
            UIImage *image = [UIImage imageNamed:name];
            [mutableArray addObject:image];
        }
        [_imageViewButton setAnimationImages:mutableArray];
        [_imageViewButton setAnimationRepeatCount:1];
        [_imageViewButton setAnimationDuration:1];
        _timerImageAnimation = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(imageViewButtonAnimation) userInfo:nil repeats:YES];

        _buttonShield = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonShield.hidden = YES;
        [_buttonShield setHighlighted:NO];
        [_buttonShield addTarget:self action:@selector(buttonShieldAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        _imageViewArrow = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageViewArrow.image = GetPngImage([BASE International:@"callpicCN"]);
        _viewHead = [[viewHead alloc] init];
        _viewHead.view = [[UIView alloc] initWithFrame:CGRectZero];
        _imageViewProp  = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        if (iPhone5||iPhone5_0) {
            _imageViewBack.image = GetPngImage(@"launch_bc5b");
            _imageViewAlpha.image = GetPngImage(@"callbc5");
            _scrollUP = 1130;
            
            [_viewTime setFrame:CGRectMake(0, 30+SCREEN_HEIGHT, 320, 89)];
            [_viewBack setFrame:CGRectMake(0, SCREEN_HEIGHT+170, 160, 164)];
            [_label setFrame:CGRectMake(40, 120, 83, 15)];
            [imageViewNameBack setFrame:CGRectMake(40, 120, 83, 15)];
            [_imageViewProp setFrame:CGRectMake(101, 15, 34, 35)];
            [_imageViewButton setFrame:CGRectMake(135, 400, 50, 62)];
            [_buttonShield setFrame:CGRectMake(135, 400, 50, 62)];
            [_imageViewArrow setFrame:CGRectMake(15, -55, 140, 250)];
        }else{
            _imageViewBack.image = GetPngImage(@"launch_bc5b");
            _imageViewAlpha.image = GetPngImage(@"callbc4");
            _scrollUP = 959;
            
            [_viewTime setFrame:CGRectMake(0, 15+SCREEN_HEIGHT, 320, 89)];
            [_viewBack setFrame:CGRectMake(5, SCREEN_HEIGHT+143, 160, 164)];
            [_label setFrame:CGRectMake(40, 120, 83, 15)];
            [imageViewNameBack setFrame:CGRectMake(40, 120, 83, 15)];
            [_imageViewProp setFrame:CGRectMake(101, 15, 34, 35)];
            [_imageViewButton setFrame:CGRectMake(135, 351, 50, 62)];
            [_buttonShield setFrame:CGRectMake(135, 351, 50, 62)];
            [_imageViewArrow setFrame:CGRectMake(10, -55, 140, 250)];
        }



        [_scrollViewBack addSubview:_imageViewBack];
        [_scrollViewBack addSubview:_viewAlpha];
        [_viewAlpha addSubview:_imageViewAlpha];
        [self addSubview:_scrollViewBack];
        [_viewAlpha addSubview:_imageViewButton];
        [_scrollViewBack addSubview:_viewTime];
        [_viewBack addSubview:_imageViewArrow];
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(75, 0, 160, SCREEN_HEIGHT)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(160, SCREEN_HEIGHT*3);
        _scrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
        [self addSubview:_scrollView];

        [_scrollView addSubview:_viewBack];
        [_viewBack addSubview:_viewHead.view];
        [_viewBack addSubview:imageViewNameBack];
        [_viewBack addSubview:_label];
        [_viewBack addSubview:_imageViewProp];
        
        _labelTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        _labelTime.backgroundColor = [UIColor clearColor];
        _labelTime.textColor = [UIColor whiteColor];
        _labelTime.textAlignment = NSTextAlignmentCenter;
        [_labelTime setFont:[UIFont fontWithName:@"Futura Lt BT" size:50]];
        _labelTime.font = [UIFont systemFontOfSize:50];
        [_viewTime addSubview:_labelTime];
        
        _labelMiddle = [[UILabel alloc] initWithFrame:CGRectMake(0, -4, 320, 70)];
        _labelMiddle.backgroundColor = [UIColor clearColor];
        _labelMiddle.textColor = [UIColor whiteColor];
        _labelMiddle.text = @":";
        _labelMiddle.textAlignment = NSTextAlignmentCenter;
        _labelMiddle.font = [UIFont systemFontOfSize:50];
        [_viewTime addSubview:_labelMiddle];
        
        _labelTimeText = [[UILabel alloc] initWithFrame:CGRectMake(0, 54, 320, 20)];
        _labelTimeText.backgroundColor = [UIColor clearColor];
        _labelTimeText.textAlignment = NSTextAlignmentCenter;
        _labelTimeText.textColor = [UIColor whiteColor];
        _labelTimeText.text = @"Banana Clock";
        [_viewTime addSubview:_labelTimeText];
        
        [_viewHead setImageWithUrl:@"" name:@""];
        if (iPhone5|iPhone5_0) {
            [_viewHead.view setCenter:CGPointMake(_viewBack.center.x+3, 70)];
        }else{
            [_viewHead.view setCenter:CGPointMake(_viewBack.center.x-5, 70)];
        }

        //覆盖触控手势
        UIView *viewUpMask = [[UIView alloc] initWithFrame:CGRectMake(47, 0, 226, 170)];
        UIView *viewDownMask = [[UIView alloc] initWithFrame:CGRectMake(47, 348, 226, 220)];
        [self addSubview:viewUpMask];
        [self addSubview:viewDownMask];


        
        [self addSubview:_buttonShield];
        [self animation];
        
        _timerDelay = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timerAction) userInfo:nil repeats:NO];
    }
    return self;
}

- (void)imageViewButtonAnimation{
    [_imageViewButton startAnimating];
}

//时间到自动设为赖床
- (void)timerAction{
    [[lowooMusic sharedLowooMusic] stopPlayer];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonGameOverCloseTouchUpinside" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lazy" object:Nil];
    _boolOnce = NO;
}

- (void)confirmDataWith:(NSDictionary *)sender{
    if ([BASE isNotNull:[sender objectForKey:@"index"]] && [[sender objectForKey:@"index"] length]!=0) {
        self.stringIndex = [sender objectForKey:@"index"];
    }else{
        self.stringIndex = @"";
    }
    _dictionaryConfirm = sender;
    _tid = [sender objectForKey:@"tid"];
    _fid = [sender objectForKey:@"fid"];
    [[lowooMusic sharedLowooMusic] playMusic:_tid type:@"caf" numberOfLoops:3 volume:1];
    if ([BASE isNotNull:[sender objectForKey:@"face"]] && [[sender objectForKey:@"face"] length]>0) {
        [_viewHead setImageWithUrl:[sender objectForKey:@"face"] name:@""];
    }else{
        [_viewHead setImageWithUrl:@"" name:@""];
    }
    if (iPhone5|iPhone5_0) {
        [_viewHead.view setCenter:CGPointMake(_viewBack.center.x+3, 70)];
    }else{
        [_viewHead.view setCenter:CGPointMake(_viewBack.center.x-5, 70)];
    }
    
    _label.text = [sender objectForKey:@"name"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    NSInteger time = [[sender objectForKey:@"time"] doubleValue] + localTimeZone.secondsFromGMT - timeZone.secondsFromGMT;
    liboTOOLS *tools = [[liboTOOLS alloc] init];
    {//显示当前时间
        time = [tools timeDate_timeStamp:[tools timeNow]];
    }
    if (time<0) {
        time = time + 86400;
    }
    _labelTime.text = [tools timestamp_TO_time:time];

    _labelTime.text = [_labelTime.text stringByReplacingCharactersInRange:NSMakeRange(2, 1) withString:@" "];
    _timerMiddal = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timeMiddle) userInfo:nil repeats:YES];
    [_timerMiddal fire];

    
    NSString *smallName = [NSString stringWithFormat:@"%02d.png.small",[_tid intValue]];
    [_imageViewProp setImage:GetPngImage(smallName)];

    
    //少于一个或3个金币不允许下滑
    if ([[[userModel sharedUserModel] getUserInformationWithKey:USER_COIN] intValue]<1 || [[sender objectForKey:@"term"] intValue] == 4) {
        _boolNoDown = YES;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(160, SCREEN_HEIGHT*2);
        _scrollView.contentOffset = CGPointMake(0, 0);
        if (iPhone5||iPhone5_0) {
            _scrollUP = SCREEN_HEIGHT-10;
            [_viewBack setFrame:CGRectMake(0, 170, 160, 164)];
        }else{
            _scrollUP = SCREEN_HEIGHT-10;
            [_viewBack setFrame:CGRectMake(5, 143, 160, 164)];
        }
        _scrollCenter = 0;
    }else{
        _scrollCenter = SCREEN_HEIGHT;
    }

    
    // 少于3个金币不显示盾
    if ([[[userModel sharedUserModel] getUserInformationWithKey:USER_COIN] intValue]<3) {
        _imageViewButton.hidden = YES;
        [_imageViewButton stopAnimating];
        _buttonShield.userInteractionEnabled = NO;
        _buttonShield.hidden = YES;
    }else{
        if ([sender objectForKey:@"term"]) {
            if ([[sender objectForKey:@"term"] intValue] == 2) {
                _buttonShield.hidden = YES;
                _imageViewButton.hidden = YES;
            }else{
                _buttonShield.hidden = NO;
                _imageViewButton.hidden = NO;
                [_imageViewButton startAnimating];
            }
        }
    }
    [[activityView sharedActivityView] removeHUD];
}

- (void)timeMiddle{
    if (_labelMiddle.alpha == 1) {
        _labelMiddle.alpha =0;
    }else{
        _labelMiddle.alpha = 1;
    }
}

- (void)buttonShieldAction{
    [_timerAnimation invalidate];
    _timerAnimation = nil;
    [_timerMiddal invalidate];
    _timerMiddal = nil;
    [_timerDelay invalidate];
    _timerDelay = nil;
    [_imageViewButton stopAnimating];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gameOver" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userShield" object:nil userInfo:nil];
    [[lowooMusic sharedLowooMusic] stopPlayer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    scrolling = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate){
        scrolling = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    scrolling = NO;
    _buttonShield.hidden = NO;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _buttonShield.hidden = YES;
    if (_boolOnce) {
        if (scrollView==_scrollView) {
            if (scrollView.contentOffset.y>_scrollCenter) {//上滑
                if (_boolNoDown) {
                    CGPoint point = CGPointMake(0, _scrollView.contentOffset.y+SCREEN_HEIGHT);
                    _scrollViewBack.contentOffset = point;
                    _imageViewArrow.alpha = (200-(scrollView.contentOffset.y))/200;
                }else{
                    CGPoint point = CGPointMake(0, _scrollView.contentOffset.y);
                    _scrollViewBack.contentOffset = point;
                    _imageViewArrow.alpha = (200-(scrollView.contentOffset.y-SCREEN_HEIGHT))/200;
                }
                
            }else{//下滑
                if (_boolNoDown) {
                    _scrollViewBack.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
                }else{
                    if (iPhone5||iPhone5_0) {
                        _viewAlpha.alpha = (_scrollView.contentOffset.y - 430)/150;
                    }else{
                        _viewAlpha.alpha = (_scrollView.contentOffset.y - 330)/150;
                    }
                    
                    _scrollViewBack.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
                    _imageViewArrow.alpha = (200-(SCREEN_HEIGHT-scrollView.contentOffset.y))/200;
                }
            }

            //上滑到顶
            if (_scrollView.contentOffset.y>_scrollUP) {
                [_timerAnimation invalidate];
                _timerAnimation = nil;
                [_timerMiddal invalidate];
                _timerMiddal = nil;
                [_timerDelay invalidate];
                _timerDelay = nil;
                
                [[lowooMusic sharedLowooMusic] stopPlayer];
                [self removeFromSuperview];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"startToGetup" object:Nil];
                _boolOnce = NO;
            }
            //下滑到底
            if (!_boolNoDown) {
                if (_scrollView.contentOffset.y<10) {
                    [_timerAnimation invalidate];
                    _timerAnimation = nil;
                    [_timerMiddal invalidate];
                    _timerMiddal = nil;
                    [_timerDelay invalidate];
                    _timerDelay = nil;
                    
                    [[lowooMusic sharedLowooMusic] stopPlayer];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"gameLazy" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"lazy" object:Nil];
                    _boolOnce = NO;
                }
            }
        }
    }

}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{

}

- (void)animation{
    _timerAnimation = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(animationAction) userInfo:Nil repeats:YES];
    [_timerAnimation fire];
}

- (void)animationAction{
    if (scrolling){
        return;
    }
    UIImageView *imageViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 29, 86)];
    UIImageView *imageViewRight = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 29, 86)];
    if (iPhone5||iPhone5_0) {
        [imageViewLeft setCenter:CGPointMake(60, 70)];
        [imageViewRight setCenter:CGPointMake(102, 70)];
    }else{
        [imageViewLeft setCenter:CGPointMake(60, 65)];
        [imageViewRight setCenter:CGPointMake(102, 65)];
    }
    imageViewLeft.image = GetPngImage(@"bycall_mosh");
    imageViewLeft.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3);
    [_viewBack addSubview:imageViewLeft];
    [_viewBack sendSubviewToBack:imageViewLeft];
    
    imageViewRight.image = GetPngImage(@"bycall_mosh2");
    imageViewRight.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3);
    [_viewBack addSubview:imageViewRight];
    [_viewBack sendSubviewToBack:imageViewRight];
    
    [UIView animateWithDuration:1.8
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         imageViewLeft.alpha = 0;
                         imageViewRight.alpha = 0;
                         imageViewLeft.transform = CGAffineTransformTranslate(CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3), -70, 0);
                         imageViewRight.transform = CGAffineTransformTranslate(CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3), 70, 0);
                         
                     } completion:^(BOOL finished) {
                         [imageViewLeft removeFromSuperview];
                         [imageViewRight removeFromSuperview];
                     }];

    
}


- (void)offline{
    [_timerAnimation invalidate]; _timerAnimation = nil;
    [_timerDelay invalidate]; _timerDelay = nil;
    [_timerMiddal invalidate]; _timerMiddal = nil;
    [_timerImageAnimation invalidate]; _timerImageAnimation = nil;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_timerAnimation invalidate]; _timerAnimation = nil;
    [_timerDelay invalidate]; _timerDelay = nil;
    [_timerMiddal invalidate]; _timerMiddal = nil;
    [_timerImageAnimation invalidate]; _timerImageAnimation = nil;
}

@end
