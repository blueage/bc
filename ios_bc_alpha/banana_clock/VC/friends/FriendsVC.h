//
//  lowooFriendsVC.h
//  banana clock
//
//  Created by MAC on 12-9-20.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lowooPersonalDetails.h"
#import "lowooAddFriends.h"
#import "lowooBaseVC.h"
#import "lowooStateCell.h"
#import "lowooWeakUpDetails.h"
#import "lowooFriendsList.h"
#import "AddFriendsListCell.h"
#import "lowooGettingUpViewController.h"
#import "JSONKit.h"
#import "JSON.h"
#import "lowooPOPhadbeencalled.h"
#import "RegexKitLite.h"
#import "POAPinyin.h"
#import "systemBoot.h"


@interface FriendsVC :lowooBaseVC <UISearchBarDelegate,UISearchDisplayDelegate,lowooStateCellDelegate,lowooPersonalDetailsDataSource,lowooPersonalDetailsDelegate,AddFriendsListCellDelegate,UITextFieldDelegate>

@property (nonatomic, strong) lowooPersonalDetails *personalDetails;
@property (nonatomic, assign) BOOL boolReloadSingleCell;//是否单独刷新某行
@property (nonatomic, strong) NSIndexPath *indexPathCell;
@property (nonatomic, strong) NSIndexPath *indexPathDelete;
@property (nonatomic, strong) NSMutableArray *mutableArrayFriendRequest;
@property (nonatomic, strong) NSMutableArray *mutableArrayFriends;
@property (nonatomic, strong) NSMutableArray *mutableArraySearch;
@property (nonatomic, strong) systemBoot *boot;

#pragma mark--------search---------
@property (nonatomic, strong) NSDictionary *localresource;
@property (nonatomic, strong) UIButton_custom *buttonKeyBoard;
@property (nonatomic, strong) NSString *stringSearch;
@property (nonatomic, strong) UIView *viewSearch;
@property (nonatomic, strong) UITextField *textFieldSearch;
- (void)SearchData:(NSString *)searchtext;

@property (nonatomic, assign) BOOL boolcellmove;
@property (nonatomic, assign) BOOL boolcelldelete;
@property (strong, nonatomic) UIView *viewNoFriend;

@property (nonatomic) NSInteger index;







@end
