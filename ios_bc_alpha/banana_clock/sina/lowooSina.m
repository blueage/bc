//
//  lowooSina.m
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooSina.h"
#import "lowooShareWeibo.h"
#import "lowooAppDelegate.h"

#define REFRESH_HEADER_HEIGHT  52.0f

@implementation lowooSina

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"SINA";
    [self changeTitle];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpFailed) name:@"httpFailed" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transferMicrobloggingFriendsID:) name:@"transferMicrobloggingFriendsID" object:nil];
    }
    return self;
}

- (void)initView{
    [_tableViewPull reloadData];
}

- (void)changeTitle{
    if (self == [self.navigationController.viewControllers lastObject]) {
        [self changeTitleWith:self.stringTitle];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _count = 0;
    _number = 0;

    if (iPhone5||iPhone5_0) {
        _tableViewPull = [[UITableView_pullUpToRefresh alloc] initWithFrame:CGRectMake(0, -4, SCREEN_WIDTH, SCREEN_HEIGHT-110)];
    }else{
        _tableViewPull = [[UITableView_pullUpToRefresh alloc] initWithFrame:CGRectMake(0, -4, SCREEN_WIDTH, SCREEN_HEIGHT-105)];
    }
    _tableViewPull.backgroundColor = [UIColor clearColor];
    _tableViewPull.delegate = self;
    _tableViewPull.dataSource = self;
    [self.view addSubview:_tableViewPull];
    
    [self isSinaMicrobloggingcertification];
}

- (void)isSinaMicrobloggingcertification{
    //本地存储的sinaID 退出用户时需注销
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_userIDKey]) {
        _sina = [[lowooSinaWeibo alloc] init];
        _sina.delegate = self;
        [_sina getSinaFriendsList:0];
    }else{//还未认证
        [liboTOOLS dismissHUD];
        _sina = [[lowooSinaWeibo alloc] init];
        _sina.delegate = self;
        [_sina doMicrobloggingCertification];
    }
}

- (void)SinaLogIn:(NSDictionary *)dictionary{
    [_sina getSinaFriendsList:0];
}

- (void)sinaLogInDidCancel:(lowooSinaWeibo *)sina{
    [[activityView sharedActivityView] removeHUD];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sinaWeiboLoginFaild:(lowooSinaWeibo *)sina{
    [[activityView sharedActivityView] removeHUD];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------------ 获得新浪好友 对好友进行分组上传 -------------
- (void)sinaGetUserFriendsList:(NSDictionary *)dictionary{
    _count = [[dictionary objectForKey:@"total_number"] intValue];
    _cursor = [[dictionary objectForKey:@"next_cursor"] intValue];
    NSArray *arrayUsers = [[NSArray alloc] initWithArray:[dictionary objectForKey:@"users"]];
    [self.mutableArrayUserFriendsList removeAllObjects]; self.mutableArrayUserFriendsList = nil;
    _mutableArrayUserFriendsList = [[NSMutableArray alloc] init];
    _number = 0;
    for (NSDictionary *dict in arrayUsers) {
        NSDictionary *dictionaryUser = [[NSDictionary alloc] initWithObjectsAndKeys:[dict objectForKey:@"idstr"],@"id",
                                        [dict objectForKey:@"screen_name"],@"screen_name",
                                        [dict objectForKey:@"profile_image_url"],@"profile_image_url", nil];
        [_mutableArrayUserFriendsList addObject:dictionaryUser];
    }
    
    float num = (float)_mutableArrayUserFriendsList.count;
    for (int i=0; i<ceil(num/10.0); i++) {
        NSMutableArray *arrayFriendsSinaID = [[NSMutableArray alloc] init];
        for (int t=0; t<10; t++) {
            if (i*10+t<num) {//在总数之内
                [arrayFriendsSinaID addObject:[[_mutableArrayUserFriendsList objectAtIndex:t+i*10] objectForKey:@"id"]];
            }
        }
        [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:arrayFriendsSinaID, @"sinaid", nil] requestType:transferMicrobloggingFriendsID];
    }
}

#pragma mark ----------- 对sina好友进行分组，是否为app用户 ---------------
- (void)transferMicrobloggingFriendsID:(NSNotification *)sender{
    _number += 10;//服务器每次对比10个
    if ([sender.object count]>0) {//存在好友
        for (int i=0; i<[sender.object count]; i++) {//返回已是banana用户的新浪好友
                NSDictionary *dictionaryHTTP = (NSDictionary *)[sender.object objectAtIndex:i];
                NSString *sinaid = [dictionaryHTTP objectForKey:@"sinaid"];//后台返回格式
                NSString *fid = [dictionaryHTTP objectForKey:@"uid"];
                
                for (NSDictionary *dict in _mutableArrayUserFriendsList) {//调整为自己的格式 将好友的位置置顶
                    if ([sinaid isEqualToString:[dict objectForKey:@"id"]]) {
                        if ([BASE isNotNull:[dictionaryHTTP objectForKey:@"relation"]] && [[dictionaryHTTP objectForKey:@"relation"] intValue] == 1) {
                            [_mutableArrayUserFriendsList removeObject:dict];
                            self.friendsCount ++;
                            break;
                        }else{
                            _mutableDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
                            [_mutableDict setObject:fid forKey:@"fid"];
                            [_mutableArrayUserFriendsList insertObject:_mutableDict atIndex:0];
                            [_mutableArrayUserFriendsList removeObject:dict];
                            break;
                        }
                    }
                }
          
        }
    }

    if (_number>=_mutableArrayUserFriendsList.count) {
        if (!_mutableArrayUser) {//多余50个时_mutableArrayUserFriendsList会直接为下50个
            _mutableArrayUser = [[NSMutableArray alloc] init];
        }
        
        for (int i=0; i<_mutableArrayUserFriendsList.count; i++) {
            [_mutableArrayUser addObject:[_mutableArrayUserFriendsList objectAtIndex:i]];
        }
        if (_mutableArrayUser.count+self.friendsCount >=_count) {
            _tableViewPull.boolHasMore = NO;
        }

        [_tableViewPull reloadData];
        [_tableViewPull stopLoading];
        [[activityView sharedActivityView] removeHUD];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mutableArrayUser.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"cellIdentifier";
    sinaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[sinaCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.delegate = self;
    [cell ConfirmDataWithDictionary:[_mutableArrayUser objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    _aview.backgroundColor = [UIColor clearColor];
    return _aview;
}

#pragma mark ----------- sinaCellDelegate --------------
- (void)sinaCellButtonTouchupInside:(NSString *)fid toSinaID:(NSString *)sinaid{
    if ([fid isEqualToString:@""]) {//为空，不是app用户
        //不是app用户 发送微博
        lowooShareWeibo *share = [[lowooShareWeibo alloc] init];
        [self.navigationController pushViewController:share animated:YES];
    }else{
        //直接添加好友
        [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: fid, @"fid", nil] requestType:addFriend];
    }
}

#pragma mark ----------- loadMoreTableFooterDelegate ----------

- (void)refresh{
    [_sina getSinaFriendsList:_cursor];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_tableViewPull.boolLoading) return;
    _tableViewPull.boolDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_tableViewPull.boolLoading && scrollView.contentOffset.y > 0) {
        // Update the content inset, good for section headers
        _tableViewPull.contentInset = UIEdgeInsetsMake(0, 0, REFRESH_HEADER_HEIGHT, 0);
    }else if(!_tableViewPull.boolHasMore){
        _tableViewPull.labelRefresh.text = _tableViewPull.stringNoMore;
        _tableViewPull.imageViewArrow.hidden = YES;
    }else if (_tableViewPull.boolDragging && scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= 0 ) {
        // Update the arrow direction and label
        [UIView beginAnimations:nil context:NULL];
        _tableViewPull.imageViewArrow.hidden = NO;
        if (scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= -REFRESH_HEADER_HEIGHT) {
            // User is scrolling above the header
            _tableViewPull.labelRefresh.text = _tableViewPull.stringRelease;
            [_tableViewPull.imageViewArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        } else { // User is scrolling somewhere within the header
            _tableViewPull.labelRefresh.text = _tableViewPull.stringPull;
            [_tableViewPull.imageViewArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
        }
        [UIView commitAnimations];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_tableViewPull.boolLoading || !_tableViewPull.boolHasMore) return;
    _tableViewPull.boolDragging = NO;
    //上拉刷新
    if(scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= -REFRESH_HEADER_HEIGHT && scrollView.contentOffset.y > 0){
        [self startLoading];
    }
}

- (void)startLoading {
    _tableViewPull.boolLoading = YES;
    
    // Show the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _tableViewPull.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
    _tableViewPull.labelRefresh.text = _tableViewPull.stringLoading;
    _tableViewPull.imageViewArrow.hidden = YES;
    [_tableViewPull.activityRefresh startAnimating];
    [UIView commitAnimations];
    
    [self refresh];
    
}


@end
