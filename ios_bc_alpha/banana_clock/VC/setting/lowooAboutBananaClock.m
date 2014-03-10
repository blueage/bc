//
//  lowooAboutBananaClock.m
//  banana_clock
//
//  Created by MAC on 13-1-5.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooAboutBananaClock.h"


@implementation lowooAboutBananaClock


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"ABOUT BANANACLOCK";
    [self changeTitle];
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
    
    UIImageView *imageViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, -60, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (iPhone5||iPhone5_0) {
        imageViewBack.image = GetPngImage(@"about_bananclock5");
    }else{
        imageViewBack.image = GetPngImage(@"about_bananclock4");
    }
    [self.view addSubview:imageViewBack];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
