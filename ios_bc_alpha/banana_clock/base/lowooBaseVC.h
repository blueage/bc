//
//  lowooBaseVC.h
//  banana clock
//
//  Created by MAC on 12-10-20.
//  Copyright (c) 2012年 MAC. All rights reserved.
//  [_nameField setFont:[UIFont fontWithName:@"TRENDS" size:16]];
//   Futura Medium 17.0


#import <UIKit/UIKit.h>
#import "lowooViewController.h"
#import "SRRefreshView.h"
//#import "tooles.h"



@interface lowooBaseVC : lowooViewController<UITableViewDataSource,UITableViewDelegate,SRRefreshDelegate,UIScrollViewDelegate>


@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) SRRefreshView  *slimeView;//下拉刷新


@end
