//
//  lowooSina.h
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//
#import "lowooBaseView.h"
#import <UIKit/UIKit.h>
#import "sinaCell.h"
#import "lowooSinaWeibo.h"
#import "lowooShareWeibo.h"
#import "UITableView_pullUpToRefresh.h"
@class lowooSina;

@protocol lowooSinaDelegate <NSObject>
- (void)viewDismiss:(lowooSina *)viewController;
@end

@protocol lowooSinaDataSource <NSObject>
- (void)viewLoaded:(lowooSina *)viewController;
@end


@interface lowooSina : lowooBaseView<sinaCellDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,lowooSinaWeiboDelegate>

@property (nonatomic, assign) id <lowooSinaDelegate> delegate;
@property (nonatomic, assign) id <lowooSinaDataSource> dataSource;
//新浪微博
@property (nonatomic, retain) NSDictionary *dictionarySinaUserInfo;
@property (nonatomic, retain) NSDictionary *dictionarySinaUserFriendsList;
@property (nonatomic, retain) NSMutableArray *mutableArrayUserFriendsList;
@property (nonatomic, retain) NSMutableArray *mutableArrayUser;
@property (nonatomic, retain) NSMutableArray *mutableArrayUserID;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL boolDataSourceIsLoading;
@property (nonatomic, assign) BOOL boolAllLoaded;
@property (nonatomic, assign) int cursor;
@property (nonatomic, assign) int count;
@property (nonatomic, strong) UITableView_pullUpToRefresh *tableViewPull;
@property (nonatomic, strong) NSMutableDictionary *mutableDict;
@property (nonatomic, strong) UIView *aview;
@property (nonatomic, assign) NSInteger friendsCount;//记录被抹去的banana好友数量
//@property (nonatomic, strong) lowooPOPRequestHasBeenSent *addRequest;
@property (nonatomic, strong) lowooSinaWeibo *sina;

//- (void)doMicrobloggingCertification;
//- (void)userInfo;
//
//- (void)getSinaFriendsList:(int )cursor;

- (void)isSinaMicrobloggingcertification;

@end
