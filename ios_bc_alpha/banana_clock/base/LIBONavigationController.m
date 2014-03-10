//
//  LIBONavigationController.m
//  banana_clock
//
//  Created by Lowoo on 2/8/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import "LIBONavigationController.h"
#import "LIBOBaseViewController.h"

@interface LIBONavigationController ()

@end

@implementation LIBONavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.naviBar = [[LIBONavigationBar alloc] initWithFrame:(CGRect){CGPointZero,SCREEN_WIDTH,NAVIGATIONBAR_HEIGHT}];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)setNaviLeftType:(NavigationBarLeftType *)naviLeftType{
    switch ((NSInteger)naviLeftType) {
        case NavigationBarLeftTypeNone:
            
            break;
        case NavigationBarLeftTypeBack:
            
            break;
        case NavigationBarLeftTypeRanking:
            
            break;
        default:
            break;
    }
}

- (void)setNaviRightType:(NavigationBarRightType *)naviRightType{
    switch ((NSInteger)naviRightType) {
        case NavigationBarRightTypeNone:
            
            break;
        case NavigationBarRightTypeAdd:
            
            break;
        case NavigationBarRightTypeBuy:
            
            break;
        case NavigationBarRightTypeSave:
            
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
