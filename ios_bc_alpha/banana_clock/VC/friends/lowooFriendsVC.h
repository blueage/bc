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


@interface lowooFriendsVC :lowooBaseVC <UISearchBarDelegate,UISearchDisplayDelegate,lowooStateCellDelegate,lowooPersonalDetailsDataSource,lowooPersonalDetailsDelegate,AddFriendsListCellDelegate,UITextFieldDelegate>

@property (nonatomic, strong) lowooPersonalDetails *personalDetails;
@property (nonatomic, assign) BOOL boolReloadSingleCell;//是否单独刷新某行
@property (nonatomic, strong) NSIndexPath *indexPathCell;
@property (nonatomic, strong) NSIndexPath *indexPathDelete;
@property (nonatomic, strong) NSMutableArray *mutableArrayWeak;//存储叫醒界面，防止多次点击push多次
@property (nonatomic, strong) NSMutableArray *mutableArrayFriendRequest;
@property (nonatomic, strong) NSMutableArray *mutableArrayFriends;
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



@property (nonatomic, strong) NSMutableArray *mutableArraySections;
@property (nonatomic, strong) NSMutableArray *mutableArraySectionKeys;
@property (nonatomic, strong) NSMutableArray *mutableArrayA;
@property (nonatomic, strong) NSMutableArray *mutableArrayB;
@property (nonatomic, strong) NSMutableArray *mutableArrayC;
@property (nonatomic, strong) NSMutableArray *mutableArrayD;
@property (nonatomic, strong) NSMutableArray *mutableArrayE;
@property (nonatomic, strong) NSMutableArray *mutableArrayF;
@property (nonatomic, strong) NSMutableArray *mutableArrayG;
@property (nonatomic, strong) NSMutableArray *mutableArrayH;
@property (nonatomic, strong) NSMutableArray *mutableArrayI;
@property (nonatomic, strong) NSMutableArray *mutableArrayJ;
@property (nonatomic, strong) NSMutableArray *mutableArrayK;
@property (nonatomic, strong) NSMutableArray *mutableArrayL;
@property (nonatomic, strong) NSMutableArray *mutableArrayM;
@property (nonatomic, strong) NSMutableArray *mutableArrayN;
@property (nonatomic, strong) NSMutableArray *mutableArrayO;
@property (nonatomic, strong) NSMutableArray *mutableArrayP;
@property (nonatomic, strong) NSMutableArray *mutableArrayQ;
@property (nonatomic, strong) NSMutableArray *mutableArrayR;
@property (nonatomic, strong) NSMutableArray *mutableArrayS;
@property (nonatomic, strong) NSMutableArray *mutableArrayT;
@property (nonatomic, strong) NSMutableArray *mutableArrayU;
@property (nonatomic, strong) NSMutableArray *mutableArrayV;
@property (nonatomic, strong) NSMutableArray *mutableArrayW;
@property (nonatomic, strong) NSMutableArray *mutableArrayX;
@property (nonatomic, strong) NSMutableArray *mutableArrayY;
@property (nonatomic, strong) NSMutableArray *mutableArrayZ;





@end
