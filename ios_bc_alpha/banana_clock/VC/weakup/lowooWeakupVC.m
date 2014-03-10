//
//  lowooWeakupVC.m
//  banana clock
//
//  Created by MAC on 12-9-20.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooWeakupVC.h"
#import "JSON.h"
#import "JSONKit.h"

@interface lowooWeakupVC ()
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) lowooStateCell *cellDisplayingMenuOptions;
@end

@implementation lowooWeakupVC

static int loadTimes;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.viewLeftButton.hidden = YES;
    [self initNavigationBar];
    self.stringTitle = @"RECENT WAKE FRIENDS";
    [self changeTitle];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.viewLeftButton.hidden = YES;
    if (_timerFinger) {
        [_timerFinger invalidate];
        _timerFinger = nil;
        [self CheckForRecentContactFriends];
    }
    
    if (_viewDidLoadCount == 0) {
        
        _viewDidLoadCount = NO;
    }

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    loadTimes ++;
    if (loadTimes==1) {
        //每个界面在显示前会调用 viewWillDisappear  过滤掉此次
    }else{
        [_timerFinger invalidate];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpDataNetwork:) name:@"getRecentFriendsList" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(medalHidden:) name:MEDAL_HIDDEN object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(medalHidden:) name:TIME_HIDDEN object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnceSystemBootEnd) name:@"systemBootEnd" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //程序公用部分，若改变位置可能会出现父view等还未初始化问题
    _timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [_timer fire];
    
    [self updataNetworkData];
#pragma mark ---------------- 注册运行引导动画 -----------
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SYSTEM_BOOT_0] boolValue]) {//新手引导，只出现一次
        //注册成功音乐
        [[lowooMusic sharedLowooMusic] playShortMusic:@"start" Type:@"mp3"];
        [[time_title shareInstance] setHelp];
        _boot = [[systemBoot alloc] init];
        [_boot addOnceView:0];
    }
}

- (void)OnceSystemBootEnd{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SYSTEM_BOOT_0] boolValue]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SYSTEM_BOOT_0];
        _boot = [[systemBoot alloc] init];
        [_boot addBaseView:0];
        [[time_title shareInstance] setHelp];
    }
    [[lowooMusic sharedLowooMusic] playShortMusic:@"help" Type:@"mp3"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"systemBootEnd" object:nil];
}

//实时更新
- (void)updateTime{
    if (USERID && ![USERID isEqualToString:@""]) {
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: [[NSUserDefaults standardUserDefaults] objectForKey:DeviceTokenRegisteredKEY],@"token", nil] requestType:retime];
    }
}

- (void)medalHidden:(NSNotification *)sender{
    [self.tableView reloadData];
}

//初始化  手动刷新
- (void)updataNetworkData{
    [super updataNetworkData];
    if (self.slimeView.broken == NO) {
        self.slimeView.broken = YES;
        self.slimeView.loading = YES;
        [self.tableView setContentOffset:CGPointMake(0, -60)];
        [self.slimeView scrollViewDidEndDraging];
    }
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:RecentFriendsList];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rightSwipeAction" object:nil];
}

- (void)didUpDataNetwork:(NSNotification *)sender{
    [self.slimeView endRefresh];//停止下拉刷新
    self.arrayReturn = sender.object;
    [self CheckForRecentContactFriends];
}

#pragma mark----------- 查看是否有最近联系的好友------
- (void)CheckForRecentContactFriends{
    if (self.arrayReturn.count == 0) {//没有最近联系人
        if (_timerFinger) {
            if (LANGUAGE_CHINESE) {
                [_imageViewFinger setFrame:CGRectMake(90, SCREEN_HEIGHT-150, 65, 83)];
                _imageViewFinger.image = GetPngImage(@"finger");
                [_imageViewText setFrame:CGRectMake(36, 180, 247, 75.5)];
                _imageViewText.image = GetPngImage(@"warning");
            }else{
                [_imageViewFinger setFrame:CGRectMake(90, SCREEN_HEIGHT-150, 74, 83)];
                _imageViewFinger.image = GetPngImage(@"fingerEnglish");
                [_imageViewText setFrame:CGRectMake(36, 180, 247, 75.5)];
                _imageViewText.image = GetPngImage(@"warningEnglish");
            }
            return;
        }
        _timerFinger = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(fingerAnimation) userInfo:nil repeats:YES];
        self.tableView.hidden = YES;
        if (!_viewNoRecentContact) {
            _viewNoRecentContact = [[UIView alloc]init];
            _viewNoRecentContact.backgroundColor = [UIColor clearColor];
            [_viewNoRecentContact setFrame:CGRectMake(0, -44, 320, 411)];
            [self.view addSubview:_viewNoRecentContact];
            if (LANGUAGE_CHINESE) {
                _imageViewFinger = [[UIImageView alloc]initWithFrame:CGRectMake(90, SCREEN_HEIGHT-150, 65, 83)];
                _imageViewFinger.image = GetPngImage(@"finger");
                _imageViewText = [[UIImageView alloc] initWithFrame:CGRectMake(36, 180, 247, 75.5)];
                _imageViewText.image = GetPngImage(@"warning");
            }else{
                _imageViewFinger = [[UIImageView alloc]initWithFrame:CGRectMake(90, SCREEN_HEIGHT-150, 74, 83)];
                _imageViewFinger.image = GetPngImage(@"fingerEnglish");
                _imageViewText = [[UIImageView alloc] initWithFrame:CGRectMake(36, 180, 247, 75.5)];
                _imageViewText.image = GetPngImage(@"warningEnglish");
            }
            [_viewNoRecentContact addSubview:_imageViewText];
            [_viewNoRecentContact addSubview:_imageViewFinger];
        }

        //手指动画
        [_timerFinger fire];
    }else{//有最近联系人
        if (_timerFinger) {
            [_timerFinger invalidate];_timerFinger = nil;
            [_viewNoRecentContact removeFromSuperview];_viewNoRecentContact = nil;
        }

        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
}

- (void)fingerAnimation{
    CGPoint fingerPoint;
    CGPoint fingerPointNew;
    if (iPhone5_0||iPhone5) {
        fingerPoint = CGPointMake(127, 459);
        fingerPointNew = CGPointMake(127, 459-30);
    }else{
        fingerPoint = CGPointMake(127, 371);
        fingerPointNew = CGPointMake(127, 371-30);
    }
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _imageViewFinger.center = fingerPointNew;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.6
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              _imageViewFinger.center = fingerPoint;
                                          } completion:^(BOOL finished) {
                                          }];
                     }];
}


#pragma mark----------- UITableViewDataSource ------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayReturn.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *stateCellIdentify = @"stateCellIdentifier";
    lowooStateCell *stateCell = [tableView dequeueReusableCellWithIdentifier:stateCellIdentify];
    if (!stateCell) {
        stateCell = [[lowooStateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stateCellIdentify];
    }
    //保证初始位置正确，防止cell 重用造成位置混乱
    CGPoint point = stateCell.viewCellBase.center;
    point.x = 160;
    stateCell.viewCellBase.center = point;
    stateCell.delegate = self;
    stateCell.indexPath = indexPath;
    stateCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [stateCell stateCellConfirmDataWithDictionary:[self.arrayReturn objectAtIndex:indexPath.row]];
    return stateCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark----------- UITableViewDelegate -------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}



- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rightSwipeAction" object:nil];
}


#pragma mark----------- 删除最近联系人 --------------
- (void)cellDidSelectDelete:(lowooStateCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self.arrayReturn];
    modelUser *user = [mutableArray objectAtIndex:indexPath.row];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: user.fid, @"fid", nil] requestType:deleteRecentFriends];
    [mutableArray removeObjectAtIndex:indexPath.row];
    self.arrayReturn = [NSArray arrayWithArray:mutableArray];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark----------- lowooStateCellDelegate --------
- (void)buttonStateAction:(UIButton_custom *)button Name:(NSString *)name indexPath:(NSIndexPath *)indexPath{
    if (self.boolPush) {
        return;
    }
    [self setBoolPushYES];
    [[activityView sharedActivityView] showHUD:20];
    _indexPathCell = indexPath;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rightSwipeAction" object:nil];//取消滑动删除
    
    //请求好友最新信息
    modelUser *user = [self.arrayReturn objectAtIndex:button.tag];
    [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:self.memoryAddress, MEMORY_ADDRESS, user.fid, @"fid", nil] requestType:showstate];
}

/*
 state = 1 被叫者 可以叫
 
 state = 2 被叫者 起床中
 f_id = 1111  叫者id
 propID = 1  道具id
 
 state = 3 已起床
 state = 4 休息中
 **/

- (void)memoryNotificationAction:(NSNotification *)notification{
    [[activityView sharedActivityView] removeHUD];
    modelUser *user = notification.object;
    switch (user.state) {
        case 1://可叫醒
        {
            lowooWeakUpDetails *weakUpDetail = [[lowooWeakUpDetails alloc]init];
            weakUpDetail.user = [self.arrayReturn objectAtIndex:_indexPathCell.row];
            weakUpDetail.stringFather = @"weakup";
            [weakUpDetail initView];
            [weakUpDetail.flowView setFirstView];
            [self.navigationController pushViewController:weakUpDetail animated:YES];
        }
            break;
        case 2://起床中
        {
            if ([user.fid isEqualToString:USERID]) {//自己叫醒
                lowooGettingUpViewController *gettingup = [[lowooGettingUpViewController alloc]init];
                [self.navigationController pushViewController:gettingup animated:YES];
                [gettingup confirmDataWithUser:[self.arrayReturn objectAtIndex:_indexPathCell.row] propID:user.propID];
            }else{
                lowooPOPhadbeencalled *called = [[lowooPOPhadbeencalled alloc] init];
                [self.navigationController pushViewController:called animated:YES];
                [called confirmDataWithUser:[self.arrayReturn objectAtIndex:_indexPathCell.row]];
            }
        }
            break;
        case 3://已起床
        {
            [self leftButtonDidTouchedUpInside];
        }
            break;
        case 4://休息中
        {
            [self leftButtonDidTouchedUpInside];
        }
            break;
        default:
            break;
    }
}

//
//- (void)getFriendState:(NSNotification *)sender{
//    [[activityView sharedActivityView] removeHUD];
//    modelUser *user = sender.object;
//    switch ([[sender.userInfo objectForKey:@"state"] intValue]) {
//        case 1://可叫醒
//            {
//                lowooWeakUpDetails *weakUpDetail = [[lowooWeakUpDetails alloc]init];
//                weakUpDetail.user = [self.arrayReturn objectAtIndex:_indexPathCell.row];
//                weakUpDetail.stringFather = @"weakup";
//                [weakUpDetail initView];
//                [weakUpDetail.flowView setFirstView];
//                [self.navigationController pushViewController:weakUpDetail animated:YES];
//            }
//            break;
//        case 2://起床中
//            {
//                if ([[[sender.userInfo objectForKey:@"list"] objectForKey:@"fid"] isEqualToString:USERID]) {//自己叫醒
//                    lowooGettingUpViewController *gettingup = [[lowooGettingUpViewController alloc]init];
//                    [self.navigationController pushViewController:gettingup animated:YES];
//                    [gettingup confirmDataWithUser:[self.arrayReturn objectAtIndex:_indexPathCell.row] propID:[[sender.userInfo objectForKey:@"list"] objectForKey:@"t_id"]];
//                }else{
//                    lowooPOPhadbeencalled *called = [[lowooPOPhadbeencalled alloc]init];
//                    [self.navigationController pushViewController:called animated:YES];
//                    [called confirmDataWithUser:[self.arrayReturn objectAtIndex:_indexPathCell.row]];
//                }
//            }
//            break;
//        case 3://已起床
//            {}
//            break;
//        case 4://休息中
//            {}
//            break;
//        default:
//            break;
//    }
//
//}

#pragma mark----------- 点击用户头像 ------------
- (void)buttonHeadDidTouchUpInside:(NSIndexPath *)indexPath{
    if (self.boolPush) {
        return;
    }
    [self setBoolPushYES];
    [[activityView sharedActivityView] showHUD:20];
    _personalDetails = [[lowooPersonalDetails alloc] init];
    _personalDetails.selfSetting = NO;
    _personalDetails.fid = [(modelUser *)[self.arrayReturn objectAtIndex:indexPath.row] fid];
    _personalDetails.dataSoure = self;
    _personalDetails.delegate = self;
    [_personalDetails updataNetworkData];
}

- (void)viewLoaded:(lowooPersonalDetails *)viewController{
    _personalDetails.dataSoure = nil;
    [self.navigationController pushViewController:_personalDetails animated:YES];
}

- (void)viewDismiss:(lowooPersonalDetails *)viewController{
    _personalDetails.delegate = nil;
    [_personalDetails removeFromParentViewController]; _personalDetails = nil;
}

- (void)offline{
    [super offline];
    [_timer invalidate]; _timer = nil;
    [_timerFinger invalidate]; _timerFinger = nil;
}

- (void)dealloc{
    [_timer invalidate]; _timer = nil;
    [_timerFinger invalidate]; _timerFinger = nil;
}


@end
