//
//  lowooWeakupVC.h
//  banana clock
//
//  Created by MAC on 12-9-20.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "lowooBaseVC.h"
#import "lowooPersonalDetails.h"
#import "lowooWeakUpDetails.h"
#import "lowooAppDelegate.h"
#import "lowooStateCell.h"
#import "lowooGettingUpViewController.h"
#import <AddressBook/AddressBook.h>
#import "lowooPOPhadbeencalled.h"
#import "systemBoot.h"


@interface lowooWeakupVC : lowooBaseVC<lowooStateCellDelegate,lowooPersonalDetailsDataSource,lowooPersonalDetailsDelegate>

@property (nonatomic, strong) lowooPersonalDetails *personalDetails;
@property (strong, nonatomic) UIView *viewNoRecentContact;
@property (nonatomic, strong) UIImageView *imageViewText;
@property (strong, nonatomic) UIImageView *imageViewFinger;
@property (nonatomic, assign) NSIndexPath *indexPathCell;//记录请求数据的cell indexpath
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *timerFinger;
@property (nonatomic, assign) NSInteger viewDidLoadCount;

@property (nonatomic, strong) systemBoot *boot;
@property (nonatomic, strong) lowooTimeSet *timeSet;


@end
