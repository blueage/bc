//
//  lowooFriendsVC.m
//  banana clock
//
//  Created by MAC on 12-9-20.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "FriendsVC.h"
#import "UITabBarController+custom.h"

@interface FriendsVC ()
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) lowooStateCell *cellDisplayingMenuOptions;
@end

@implementation FriendsVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    [self.imageViewLeft setFrame:CGRectMake(10, 12, 26, 17)];
    [self.imageViewLeft setImage:GetPngImage(@"topicon02")];
    
    [self.imageViewRight setFrame:CGRectMake(13, 8, 22, 22)];
    [self.imageViewRight setImage:GetPngImage(@"topicon03")];
    self.viewRightButton.hidden = NO;
    self.stringTitle = @"FRIENDS LIST";
    [self changeTitle];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpFailed) name:@"httpFailed" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpDataNetworkData:) name:@"newFriendList" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(medalHidden:) name:MEDAL_HIDDEN object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(medalHidden:) name:TIME_HIDDEN object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(friendReload) name:@"friendReload" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataNetworkData) name:@"refreshFriendList" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteFriend) name:@"deleteFriend" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _boolReloadSingleCell = NO;
    [self initButtonSearchbar];
    [self.tableView setScrollsToTop:YES];
    [self.tableView setFrame:CGRectMake(0, -15-35, 327, SCREEN_HEIGHT-65)];
    if (IOS_7) {
        [self.tableView setFrame:CGRectMake(0, -15-35, 320, SCREEN_HEIGHT-65)];
        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    self.tableView.sectionIndexTrackingBackgroundColor  = [UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor colorWithWhite:1.0f alpha:0.8];
    self.tableView.allowsSelectionDuringEditing = YES;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;

    [self updataNetworkData];


}

- (void)initViewNoFriend{
    [_viewNoFriend removeFromSuperview];
    _viewNoFriend = nil;
    _viewNoFriend = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_viewNoFriend];
    
    if (LANGUAGE_CHINESE) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(52, 80, 215.5, 58.5)];
        imageview.image = GetPngImage(@"NoFriendWarning");
        [_viewNoFriend addSubview:imageview];
        
        UIButton_custom *buttonSmall = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [buttonSmall setFrame:CGRectMake(157, 148, 35, 31)];
        [buttonSmall addTarget:self action:@selector(buttonNoFriendTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_viewNoFriend addSubview:buttonSmall];
        
        UIButton_custom *buttonBig = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [buttonBig setFrame:CGRectMake(109, 205, 103, 137)];
        [buttonBig setImageNormal:GetPngImage(@"NoFriendAddFriends")];
        [buttonBig setImageHighlited:GetPngImage(@"NoFriendAddFriendsb")];
        [buttonBig addTarget:self action:@selector(buttonNoFriendTouchUpInside:)];
        [_viewNoFriend addSubview:buttonBig];
        
        if (iPhone5||iPhone5) {
            
        }else{
            [imageview setFrame:CGRectMake(52, 80, 215.5, 58.5)];
            [buttonSmall setFrame:CGRectMake(157, 98, 35, 31)];
            [buttonBig setFrame:CGRectMake(109, 155, 103, 137)];
        }
    }else{
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(52, 80, 215.5, 58.5)];
        imageview.image = GetPngImage(@"NoFriendWarningEnglish");
        [_viewNoFriend addSubview:imageview];
        
        UIButton_custom *buttonSmall = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [buttonSmall setFrame:CGRectMake(180, 148, 35, 31)];
        [buttonSmall addTarget:self action:@selector(buttonNoFriendTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_viewNoFriend addSubview:buttonSmall];
        
        UIButton_custom *buttonBig = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [buttonBig setFrame:CGRectMake(109, 205, 103, 137)];
        [buttonBig setImageNormal:GetPngImage(@"NoFriendAddFriendsEnglish")];
        [buttonBig setImageHighlited:GetPngImage(@"NoFriendAddFriendsbEnglish")];
        [buttonBig addTarget:self action:@selector(buttonNoFriendTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_viewNoFriend addSubview:buttonBig];
        
        if (iPhone5||iPhone5) {
            
        }else{
            [imageview setFrame:CGRectMake(52, 80, 215.5, 58.5)];
            [buttonSmall setFrame:CGRectMake(157, 98, 35, 31)];
            [buttonBig setFrame:CGRectMake(109, 155, 103, 137)];
        }
    }
}

- (void)friendReload{
    _boolReloadSingleCell = YES;
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:newFriendList];
}

- (void)medalHidden:(NSNotification *)sender{
    [self.tableView reloadData];
}

- (void)rightButtonTouchUpInside{
     lowooAddFriends *AddFriends = [[lowooAddFriends alloc]init];
     [self.navigationController pushViewController:AddFriends animated:YES];
}

- (void)leftButtonDidTouchedUpInside{
    lowooFriendsList *friendsList = [[lowooFriendsList alloc]init];
    [friendsList setVC];
    [self.navigationController pushViewController:friendsList animated:YES];
}

#pragma mark-------------自动刷新或手动刷新--网络请求--------------
//初始化  手动刷新  好友请求  添加成功  删除好友   移植黑名单
- (void)updataNetworkData{
    if (self.slimeView.broken == NO) {
        self.slimeView.broken = YES;
        self.slimeView.loading = YES;
        [self.tableView setContentOffset:CGPointMake(0, -60)];
        [self.slimeView scrollViewDidEndDraging];
    }
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:newFriendList];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rightSwipeAction" object:nil];//将滑动删除好友归位
}


- (void)didUpDataNetworkData:(NSNotification *)sender{
    self.arrayReturn = sender.object;
    if (self.arrayReturn.count==0) {//没有好友
        [_mutableArrayFriendRequest removeAllObjects]; _mutableArrayFriendRequest = nil;
        self.tableView.hidden = YES;
        [self initViewNoFriend];
        _viewNoFriend.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_viewNoFriend];
        [self.view bringSubviewToFront:_viewNoFriend];
    }else{
        self.tableView.hidden = NO;
        if (_viewNoFriend) {
            [_viewNoFriend removeFromSuperview];
            _viewNoFriend = Nil;
        }
        
        [_mutableArrayFriends removeAllObjects]; _mutableArrayFriends = nil;
        _mutableArrayFriends = [[NSMutableArray alloc] init];
        [_mutableArrayFriendRequest removeAllObjects]; _mutableArrayFriendRequest = nil;
        _mutableArrayFriendRequest = [[NSMutableArray alloc] init];
        for (int i=0; i<self.arrayReturn.count; i++) {
            modelUser *user = [self.arrayReturn objectAtIndex:i];
            if (user.relation == 0) {//好友请求
                [_mutableArrayFriendRequest addObject:user];
            }else{
                [_mutableArrayFriends addObject:user];//好友
            }
        }
    }

    if (_mutableArrayFriendRequest.count>0) {
        [self.tabBarController setImageViewMessageNotificationREDHidden:NO];
    }else{
        [self.tabBarController setImageViewMessageNotificationREDHidden:YES];
    }
    
    [self.slimeView endRefresh];
    self.mutableArraySearch = [[NSMutableArray alloc] initWithArray:self.mutableArrayFriends];


    if (!_boolReloadSingleCell) {
        [self initButtonSearchbar];
        [self.tableView reloadData];
        _textFieldSearch.text = @"";
    }else{
        _boolReloadSingleCell = NO;
        //数据已经是最新的
        if (_textFieldSearch.text.length>0) {
            [self SearchData:_textFieldSearch.text];
        }
        if (_indexPathCell) {
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:_indexPathCell] withRowAnimation:nil];//////////////////
        }
    }
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark ----UITableViewDataSource-----------
//使用搜索的array 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mutableArraySearch.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.mutableArraySearch.count > 0){
            static NSString *stateCellIdentifier = @"stateCellIdentifier";
            lowooStateCell *stateCell = [tableView dequeueReusableCellWithIdentifier:stateCellIdentifier];
            if (!stateCell) {
                stateCell = [[lowooStateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stateCellIdentifier];
            }
            //保证初始位置正确，防止cell 重用造成位置混乱
            CGPoint point = stateCell.viewCellBase.center;
            point.x = 160;
            stateCell.viewCellBase.center = point;
        
            stateCell.delegate = self;
            stateCell.indexPath = indexPath;
            stateCell.buttonHead.tag = indexPath.row;
            stateCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [stateCell stateCellConfirmDataWithDictionary:[self.mutableArraySearch objectAtIndex:indexPath.row]];
            return stateCell;
        }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    return cell;
}



#pragma mark -----UITableViewDelegate----------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rightSwipeAction" object:nil];
}

#pragma mark------------ 删除好友 ----------------
- (void)cellDidSelectDelete:(lowooStateCell *)cell{
    _indexPathDelete = cell.indexPath;
    lowooPOPDeleteFriend *deleteFriend = [[lowooPOPDeleteFriend alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[lowooAlertViewDemo sharedAlertViewManager] show:deleteFriend];
    
}

- (void)deleteFriend{
    modelUser *user = [self.mutableArrayFriends objectAtIndex:_indexPathDelete.row];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:user.fid, @"fid", nil] requestType:deleteUsers];
    [self.mutableArrayFriends removeObjectAtIndex:_indexPathDelete.row];
    self.mutableArraySearch = self.mutableArrayFriends;

    [self.tableView deleteRowsAtIndexPaths:@[_indexPathDelete] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (self.mutableArraySearch.count == 0) {
        [self updataNetworkData];
    }
}


//把名字分解成字母字典
#pragma mark----------- 搜索控件初始化(好友请求) searchbar -----------
- (void)initButtonSearchbar{
    //有好友请求
    NSInteger height = 70*_mutableArrayFriendRequest.count;
    _viewSearch = [[UIView alloc] init];
    if (_mutableArrayFriendRequest.count!=0) {
        height = 70*_mutableArrayFriendRequest.count+20;
        [_viewSearch setFrame:CGRectMake(0, 0, 320, 80+height)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 320, 20)];
        label.text = [BASE International:@"Request"];
        [label setFont:[UIFont systemFontOfSize:16.0]];
        label.backgroundColor = [UIColor clearColor];
        [_viewSearch addSubview:label];
        UIImageView *imageViewDividingLine = [[UIImageView alloc] initWithFrame:CGRectMake(40, 37-8, 250, 35)];
        imageViewDividingLine.image = GetPngImage(@"light02");
        [_viewSearch addSubview:imageViewDividingLine];
        for (int i=0; i<_mutableArrayFriendRequest.count; i++) {
            AddFriendsListCell *addCell = [[AddFriendsListCell alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
            addCell.buttonAddfriend.tag = i;
            addCell.delegate = self;
            [addCell confirmDataWithUser:[_mutableArrayFriendRequest objectAtIndex:i]];
            addCell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i*65+60, 320, 65)];
            [view addSubview:addCell];
            [_viewSearch addSubview:view];
        }
    }else{//无好友请求
        [_viewSearch setFrame:CGRectMake(0, 0, 320, 80+height)];
    }
    
    UIImageView *imageViewSearchBG = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40+height, 280, 35)];
    imageViewSearchBG.image = GetPngImage(@"search01");
    [_viewSearch addSubview:imageViewSearchBG];
    UIImageView *imageViewSearchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(30, 50+height, 13, 14)];
    imageViewSearchIcon.image = GetPngImage(@"search02");
    [_viewSearch addSubview:imageViewSearchIcon];
    _textFieldSearch = [[UITextField alloc] initWithFrame:CGRectMake(50, 46+height, 240, 23)];
    _textFieldSearch.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textFieldSearch.delegate = self;
    _textFieldSearch.backgroundColor = [UIColor clearColor];
    _textFieldSearch.placeholder = @"search";
    [_textFieldSearch setClearButtonMode:UITextFieldViewModeAlways];
    [_textFieldSearch setReturnKeyType:UIReturnKeyDefault];
    [_viewSearch addSubview:_textFieldSearch];
    self.tableView.tableHeaderView = _viewSearch;
    
    //键盘返回
    _buttonKeyBoard = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    _buttonKeyBoard.frame = CGRectMake(0, 40, 320, 400);
    [_buttonKeyBoard addTarget:self action:@selector(resignSearchKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_buttonKeyBoard];
    _buttonKeyBoard.hidden = YES;
    _buttonKeyBoard.backgroundColor = [UIColor clearColor];
    
    //search数据
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys: nil];
    for (int i = 0 ; i<10; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        NSArray *array = [[NSArray alloc]initWithObjects:str,str, nil];
        [dict setObject:array forKey:str];
    }

}

//搜索好友
-(void)SearchData:(NSString *)searchtext{
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:searchtext];
    for (int t=0; t<searchtext.length; t++) {
        char a = [searchtext characterAtIndex:t];
        if (a == 6) {
            [mutableString deleteCharactersInRange:NSMakeRange(t, 1)];
        }else{
            
        }
        searchtext = mutableString;
    }

    searchtext = [searchtext stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self.mutableArraySearch removeAllObjects];
    for (int i=0; i<self.mutableArrayFriends.count; i++) {
        NSString *name = [[self.mutableArrayFriends objectAtIndex:i] name];
        NSRange foundObj = [name rangeOfString:searchtext options:NSCaseInsensitiveSearch];
        if (foundObj.length>0) {
            [self.mutableArraySearch addObject:[self.mutableArrayFriends objectAtIndex:i]];
        }else{

        }
    }
    [self.tableView reloadData];
}




#pragma mark----------- 点击search按钮 ---------------
//从UISearchBar输入框中提取内容调用SearchData方法进行查找
-(void)resignSearchKeyboard{
    _buttonKeyBoard.hidden = YES;
    [_textFieldSearch resignFirstResponder];
}

//自动搜索 删除搜索内容后
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *stringText;
    if (range.length==0) {
        stringText = [textField.text stringByAppendingString:string];
    }else if (range.length==1){
        if (textField.text.length>1) {
            stringText = [textField.text substringWithRange:NSMakeRange(0, textField.text.length-1)];
        }
    }

    if (range.location==0&&textField.text.length==1) {
        [self.mutableArraySearch removeAllObjects]; self.mutableArraySearch = nil;
        self.mutableArraySearch = [[NSMutableArray alloc] initWithArray:self.mutableArrayFriends];
        [self.tableView reloadData];
        return YES;
    }

    if (textField.text.length>range.location) {
        [self SearchData:stringText];
    }else if (range.location == 0){
        [self SearchData:stringText];
    }else{
        [self SearchData:stringText];
    }

    return YES;
}

//点击Cancle按钮
//清除记录退回屏幕键盘，返回初始状态。显示索引。
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    [self.mutableArraySearch removeAllObjects]; self.mutableArraySearch = nil;
    self.mutableArraySearch = [[NSMutableArray alloc] initWithArray:self.mutableArrayFriends];
    [self.tableView reloadData];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _buttonKeyBoard.hidden = YES;
    [_textFieldSearch resignFirstResponder];
    return YES;
}





//点击输入框时被触发
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _buttonKeyBoard.hidden = NO;
}

#pragma mark------addFriendDelegate--------
- (void)buttonAddTouchUpInside:(UIButton_custom *)sender{
    lowooPOPFriendsAddRequest *addRequest = [[lowooPOPFriendsAddRequest alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    [addRequest confirmDataWithUser:[_mutableArrayFriendRequest objectAtIndex:sender.tag]];
    [[lowooAlertViewDemo sharedAlertViewManager] show:addRequest];
}

#pragma mark------stateCellDelegate 叫醒好友 --------
-(void)buttonStateAction:(UIButton_custom *)button Name:(NSString *)name indexPath:(NSIndexPath *)indexPath{
    if (self.boolPush) {
        return;
    }
    [self setBoolPushYES];
    _indexPathCell = indexPath;
    [[activityView sharedActivityView] showHUD:20];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rightSwipeAction" object:nil];
    [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: [[self.mutableArrayFriends objectAtIndex:indexPath.row] fid], @"fid", self.memoryAddress, MEMORY_ADDRESS, nil] requestType:showstate];
}

- (void)memoryNotificationAction:(NSNotification *)notification{
    if ([[notification.userInfo objectForKey:MEMORY_ADDRESS] isEqualToString:self.memoryAddress]) {
        [[activityView sharedActivityView] removeHUD];
        modelUser *user = notification.object;
        switch (user.state) {
            case 1://可叫醒
            {
                lowooWeakUpDetails *weakUpDetail = [[lowooWeakUpDetails alloc] init];
                weakUpDetail.user = [self.mutableArrayFriends objectAtIndex:_indexPathCell.row];
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
                    [gettingup confirmDataWithUser:[self.mutableArrayFriends objectAtIndex:_indexPathCell.row] propID:user.propID];
                }else{
                    lowooPOPhadbeencalled *called = [[lowooPOPhadbeencalled alloc] init];
                    [self.navigationController pushViewController:called animated:YES];
                    [called confirmDataWithUser:[self.mutableArrayFriends objectAtIndex:_indexPathCell.row]];
                }
            }
                break;
            case 3://已起床
            {}
                break;
            case 4://休息中
            {}
                break;
            default:
                break;
        }
    }
}


#pragma mark----------- 点击好友头像 -----------
- (void)buttonHeadDidTouchUpInside:(NSIndexPath *)indexPath{
    if (self.boolPush) {
        return;
    }
    [self setBoolPushYES];
    _personalDetails = [[lowooPersonalDetails alloc]init];
    _personalDetails.selfSetting = NO;
    _personalDetails.fid = [[self.mutableArrayFriends objectAtIndex:indexPath.row] fid];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (void)buttonNoFriendTouchUpInside:(UIButton_custom *)sender {
    [self rightButtonTouchUpInside];
}



@end
