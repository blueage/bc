//
//  lowooFriendsList.h
//  banana_clock
//
//  Created by MAC on 12-12-25.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooBaseView.h"
#import "lowooFriendsListCell.h"
#import "UITableView_pullUpToRefresh.h"

@interface lowooFriendsList : lowooBaseView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (strong, nonatomic) UITableViewCell_custom *cellFirst;
@property (nonatomic, strong) NSArray *arrayUp;
@property (nonatomic, strong) NSArray *arrayLazy;
@property (nonatomic, strong) NSArray *arrayCall;
@property (nonatomic, strong) NSNotification *notificationSender;
@property (nonatomic, strong) UITableView_pullUpToRefresh *tableViewPull;
@property (nonatomic, strong) THLabel *label1;
@property (nonatomic, strong) THLabel *label2;
@property (nonatomic, strong) THLabel *label3;

@property (nonatomic, assign) NSInteger cellCount;


- (void)setVC;


@end
