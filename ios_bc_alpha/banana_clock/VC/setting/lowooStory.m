//
//  lowooStory.m
//  banana_clock
//
//  Created by MAC on 13-3-14.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooStory.h"
#import "lowooAppDelegate.h"


@implementation lowooStory

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.tabBarController hidesBottomBarViewWhenPushed:YES];
    [self.tabBarController hidesTimeTitleWhenPushed:YES];
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
    lowooCarToon *carToon = [[lowooCarToon alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    carToon.delegate = self;
    [self.view addSubview:carToon];

}


- (void)carToonEnd{
    self.view.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
