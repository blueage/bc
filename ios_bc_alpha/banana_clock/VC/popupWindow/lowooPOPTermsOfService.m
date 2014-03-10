//
//  lowooPOPTermsOfService.m
//  banana_clock
//
//  Created by MAC on 14-1-14.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "lowooPOPTermsOfService.h"

@implementation lowooPOPTermsOfService

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        
        UIImageView *imageViewPanel = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-571/2)/2, (SCREEN_HEIGHT-756/2)/2, 571/2, 756/2)];
        imageViewPanel.image = GetPngImage(@"help_back");
        [self.viewMove addSubview:imageViewPanel];
        
        self.viewMove.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self.viewBack addGestureRecognizer:tap];
        self.viewBack.userInteractionEnabled = YES;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"termsOfService" ofType:@"html"];
        NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-571/2)/2 + 10, (SCREEN_HEIGHT-756/2)/2 + 10, 571/2 - 20, 756/2 - 20)];
        web.backgroundColor = [UIColor clearColor];
        web.delegate = self;
        web.opaque = NO;
        [self.viewMove addSubview:web];
        [web loadHTMLString:text baseURL:nil];
        
    }
    return self;
}

- (void)tapAction{
    if ([_delegate respondsToSelector:@selector(lowooPOPTermsOfServiceDismiss:)]) {
        [_delegate lowooPOPTermsOfServiceDismiss:self];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [[activityView sharedActivityView] showHUD:-1];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[activityView sharedActivityView] removeHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[activityView sharedActivityView] removeHUD];
}

- (void)drawRect:(CGRect)rect
{
    
}


@end
