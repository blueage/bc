//
//  lowooWebVC.h
//  banana clock
//
//  Created by MAC on 12-10-17.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lowooViewController.h"

@interface lowooWebVC : lowooViewController<UIWebViewDelegate>



@property(nonatomic,strong)NSString *urlString;
@property(nonatomic,strong)NSString *navTitle;

@property (strong, nonatomic) UIWebView *webView;


@end
