//
//  lowooDeleteFromeBlackListViewController.h
//  banana_clock
//
//  Created by MAC on 13-8-14.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBaseView.h"

@interface lowooDeleteFromeBlackListViewController : lowooBaseView

@property (nonatomic, strong) viewHead *viewHead;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) NSString *stringID;

- (void)confirmUser:(modelUser *)user;

@end
