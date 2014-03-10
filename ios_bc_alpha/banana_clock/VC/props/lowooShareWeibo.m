//
//  lowooShareWeibo.m
//  banana_clock
//
//  Created by MAC on 13-8-20.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooShareWeibo.h"


@interface lowooShareWeibo ()

@end

@implementation lowooShareWeibo

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    if ([_titleName isEqualToString:@"renren"]) {
        self.stringTitle = @"SHARE RENREN";
    }else{
        self.stringTitle = @"SHARE SINA";
    }
    
    [self changeTitle];
    [self.buttonRight setFrame:CGRectMake(-12, 3, 61, 36)];
    [self.buttonRight setImage:GetPngImage([BASE International:@"buttonShareCNa"]) forState:UIControlStateNormal];
    [self.buttonRight setImage:GetPngImage([BASE International:@"buttonShareCNb"]) forState:UIControlEventTouchDown];
    
    self.viewRightButton.hidden = NO;
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
    
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSArray *windows = [UIApplication sharedApplication].windows;
    if (windows.count>0) {
        keyWindow = [windows objectAtIndex:0];
    }
    _viewBase = [[UIView alloc] initWithFrame:CGRectMake(0, 65, 320, 300)];
    [keyWindow addSubview:_viewBase];
    
    if (iPhone5||iPhone5_0) {
        _rectTextBackChinese = CGRectMake(0, 0, 320, 240);
        _rectTextBackEnglish = CGRectMake(0, 0, 320, 280);
        _rectTextChinese = CGRectMake(20, 15, 277, 90);
        _rectTextEnglish = CGRectMake(20, 15, 277, 130);
        _pointImageCenterChinese = CGPointMake(160, 155);
        _pointImageCenterEnglish = CGPointMake(160, 195);
    }else{
        _rectTextBackChinese = CGRectMake(0, 0, 320, 160);
        _rectTextBackEnglish = CGRectMake(0, 0, 320, 200);
        _rectTextChinese = CGRectMake(20, 15, 277, 38);
        _rectTextEnglish = CGRectMake(20, 15, 277, 78);
        _pointImageCenterChinese = CGPointMake(160, 90);
        _pointImageCenterEnglish = CGPointMake(160, 130);
    }
    
    _imageViewTextBack = [[UIImageView alloc] initWithFrame:_rectTextBackEnglish];
    if (iPhone5_0||iPhone5_0) {
        _imageViewTextBack.image = GetPngImage(@"shareBack5");
    }else{
        _imageViewTextBack.image = GetPngImage(@"shareBack4");
    }
    [_viewBase addSubview:_imageViewTextBack];
    
    _textView = [[UITextView alloc] initWithFrame:_rectTextEnglish];
    _textView.font = [UIFont systemFontOfSize:14.0f];
    _textView.delegate = self;
    [_textView becomeFirstResponder];
    [_viewBase addSubview:_textView];
    
    _viewImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 129)];
    _viewImageView.center = _pointImageCenterEnglish;
    UIImageView_custom *imageviewwibo = [[UIImageView_custom alloc] initWithFrame:CGRectZero];
    if (iPhone5||iPhone5_0) {
        [imageviewwibo setFrame:CGRectMake(0, 53, 320, 90)];
        [imageviewwibo setImageURL:@"/download/bananaclock_weibo_t_5.png"];
    }else{
        [imageviewwibo setFrame:CGRectMake(0, 45, 320, 82)];
        [imageviewwibo setImageURL:@"/download/bananaclock_weibo_t_4.png"];
    }
    [_viewImageView addSubview:imageviewwibo];
    [_viewBase addSubview:_viewImageView];

    _label = [[UILabel alloc] initWithFrame:CGRectMake(270, 22, 40, 30)];
    _label.backgroundColor = [UIColor clearColor];
    _label.text = [NSString stringWithFormat:@"%d",140-70];
    [_viewImageView addSubview:_label];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrame:) name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

- (void)keyboardFrame:(NSNotification *)notification{
    CGRect keyboardFrame;
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    float keyboardHeight = CGRectGetHeight(keyboardFrame);
    if (keyboardHeight > 216) {
        [self aniamtionToChinese];
    }else{
        [self animationToEnglish];
    }
    
}

- (void)animationToEnglish{
    [UIView animateWithDuration:0.2 animations:^{
        [_imageViewTextBack setFrame:_rectTextBackEnglish];
        [_textView setFrame:_rectTextEnglish];
        [_viewImageView setCenter:_pointImageCenterEnglish];
    }];
}

- (void)aniamtionToChinese{
    [UIView animateWithDuration:0.2 animations:^{
        [_imageViewTextBack setFrame:_rectTextBackChinese];
        [_textView setFrame:_rectTextChinese];
        [_viewImageView setCenter:_pointImageCenterChinese];
    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    _textCount = _textView.text.length;
    _label.text = [NSString stringWithFormat:@"%d",140 - 70 -_textCount];
    if (_textCount>70) {
        _label.textColor = [UIColor redColor];
    }else{
        _label.textColor = [UIColor blackColor];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_textView setNeedsDisplay];
}

- (void)leftButtonDidTouchedUpInside{
    [_textView resignFirstResponder];
    [_viewBase removeFromSuperview];
    _viewBase = nil;
    [super leftButtonDidTouchedUpInside];
}

- (void)rightButtonTouchUpInside{
    NSString *string1 = @"还不起床？要睡到什么时候嘛！美好的一天开始喽，我的小伙伴们快和我一起banana call吧~ 链接:http://bc.lowoo.cc/mobile/";
    _postText = [_textView.text stringByAppendingString:string1];
    if (_textCount<=70) {
        if ([_titleName isEqualToString:@"renren"]) {
            if ([_delegate respondsToSelector:@selector(shareRenren:)]) {
                [_delegate shareRenren:_postText];
                [[activityView sharedActivityView] showHUD:20];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(shareWeiboWithText:)]) {
                [_delegate shareWeiboWithText:_postText];
                [[activityView sharedActivityView] showHUD:20];
            }
        }
        [_textView resignFirstResponder];
        [_viewBase removeFromSuperview];
        _viewBase = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
