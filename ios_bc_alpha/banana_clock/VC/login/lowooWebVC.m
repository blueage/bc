//
//  lowooWebVC.m
//  banana clock
//
//  Created by MAC on 12-10-17.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooWebVC.h"

@interface lowooWebVC ()

@end

@implementation lowooWebVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar drawRect:CGRectZero];
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

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -4, 320, SCREEN_HEIGHT-60)];
    [self.view addSubview:_webView];
    _webView.delegate = self;
    self.webView.backgroundColor = [UIColor clearColor];
    UIImageView *imageview;
    if (iPhone5||iPhone5_0) {
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, -3, 320, SCREEN_HEIGHT)];
        imageview.image = GetPngImage(@"iphone5bc");
    }else{
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, -3, 320, SCREEN_HEIGHT)];
        imageview.image = GetPngImage(@"iphone4bc");
    }
    [self.view addSubview:imageview];
    
    
//    NSURL *url = [[NSURL alloc]initWithString:_urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"termsOfService" ofType:@"html"];
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:text baseURL:nil];
    
    [self.view bringSubviewToFront:self.webView];

    UILabel *lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    lableTitle.backgroundColor = [UIColor clearColor];
    lableTitle.textAlignment = NSTextAlignmentCenter;
    lableTitle.font = [UIFont boldSystemFontOfSize:20];
    lableTitle.textColor = [UIColor blackColor];
    lableTitle.text = _navTitle;
    [self.navigationController.navigationBar addSubview:lableTitle];
    
}
#pragma mark-------leftBtnPressed-------------
-(void)leftBtnPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
   // [tooles showHUD:@"正在加载...."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
   // [tooles removeHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
   // [tooles removeHUD];
   // [tooles MsgBox:@"网络连接错误"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
