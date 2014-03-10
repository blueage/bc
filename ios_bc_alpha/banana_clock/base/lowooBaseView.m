//
//  lowooBaseView.m
//  banana clock
//
//  Created by MAC on 12-10-26.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooBaseView.h"



@implementation lowooBaseView


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
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
