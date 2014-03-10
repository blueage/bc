//
//  lowooAddFriendsListVC.h
//  banana clock
//
//  Created by MAC on 12-11-5.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooBaseVC.h"
#import "AddFriendsListCell.h"
#import "AddFriendListCell1.h"


@interface lowooAddFriendsListVC : lowooBaseVC<AddFriendListCell1Delegate>

@property (strong, nonatomic) AddFriendListCell1 *AddCell;
@property (nonatomic, strong) modelUser *user;

@end
