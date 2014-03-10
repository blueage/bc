//
//  lowooAddFriendsListVC.m
//  banana clock
//
//  Created by MAC on 12-11-5.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooAddFriendsListVC.h"
#import "JSONKit.h"
#import "JSON.h"
#import "SBJsonBase.h"

@implementation lowooAddFriendsListVC


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle  = @"ADD FRIEND";
    [self changeTitle];
    [self updataNetworkData];
}

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

    self.slimeView.hidden = YES;
    [self.slimeView removeFromSuperview];
}

- (void)initView{
    [self.tableView reloadData];//页面显示时才会真正 执行
}

- (void)setUser:(modelUser *)user{
    _user = user;
    [self.tableView reloadData];
}

#pragma mark ----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//每个状态返回一个dic，根据dic确定row的数量
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"lowooFriendsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        _AddCell = [[AddFriendListCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        _AddCell.delegate = self;
        cell = _AddCell;
    }
    [_AddCell confirmUser:_user];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark --------UITableViewDelegate-----------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}

#pragma mark --------AddFriendsListCellDelegate---------
- (void)buttonAddTouchUpInside:(UIButton_custom *)sender{
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:_user.fid, @"fid", nil] requestType:addFriend];
}

- (void)didAddFriend:(NSNotification *)sender{
    if (![BASE isNotNull:sender.userInfo]) {
        return;
    }
    //已经是好友
    if ([[sender.userInfo objectForKey:@"msg"] isEqualToString:@"have is your friend!"]) {
        if (LANGUAGE_CHINESE) {
            [liboTOOLS alertViewMSG:[NSString stringWithFormat:@"ID为%@的用户已经是您的好友",[[self.arrayReturn objectAtIndex:0] objectForKey:@"name"]]];
        }else{
            [liboTOOLS alertViewMSG:[NSString stringWithFormat:@"User ID %@ is already your friends",[[self.arrayReturn objectAtIndex:0] objectForKey:@"name"]]];
        }
        
    }else{
        lowooPOPRequestHasBeenSent *addRequest = [[lowooPOPRequestHasBeenSent alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
        [[lowooAlertViewDemo sharedAlertViewManager] show:addRequest];
    }
}




@end
