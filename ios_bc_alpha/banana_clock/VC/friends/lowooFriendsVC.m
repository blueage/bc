//
//  lowooFriendsVC.m
//  banana clock
//
//  Created by MAC on 12-9-20.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooFriendsVC.h"
#import "UITabBarController+custom.h"

@interface lowooFriendsVC ()
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) lowooStateCell *cellDisplayingMenuOptions;
@end

@implementation lowooFriendsVC

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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpDataNetworkData:) name:@"getUserFriendsList" object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFriendState:) name:@"getFriendsState" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(medalHidden:) name:MEDAL_HIDDEN object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(medalHidden:) name:TIME_HIDDEN object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(friendReload) name:@"friendReload" object:nil];

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
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:refreshFriendList];
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
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:refreshFriendList];
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
        [self initSectionIndex:_mutableArrayFriends];
    }

    if (_mutableArrayFriendRequest.count>0) {
        [self.tabBarController setImageViewMessageNotificationREDHidden:NO];
    }else{
        [self.tabBarController setImageViewMessageNotificationREDHidden:YES];
    }
    
    [self.slimeView endRefresh];
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
    return [[_mutableArraySections objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _mutableArraySections.count;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *array = [NSMutableArray arrayWithArray:_mutableArraySectionKeys];
    //NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    [array insertObject:@"#" atIndex:0];
    return array;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [self.tableView headerViewForSection:section];
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 20)];
        label.text = [_mutableArraySectionKeys objectAtIndex:section];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:16];
        [view addSubview:label];
        UIImageView *imageViewDividingLine = [[UIImageView alloc] initWithFrame:CGRectMake(40, -8, 250, 35)];
        imageViewDividingLine.image = GetPngImage(@"light02");
        [view addSubview:imageViewDividingLine];
    }
    
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_mutableArrayFriends.count > 0){
            static NSString *stateCellIdentifier = @"stateCellIdentifier";
            lowooStateCell *stateCell = [tableView dequeueReusableCellWithIdentifier:stateCellIdentifier];
            if (!stateCell) {
                stateCell = [[lowooStateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stateCellIdentifier];
            }
            //保证初始位置正确，防止cell 重用造成位置混乱
            CGPoint point = stateCell.viewCellBase.center;
            point.x = 160;
            stateCell.viewCellBase.center = point;
            
            NSMutableArray *mutableArray = [_mutableArraySections objectAtIndex:indexPath.section];
            stateCell.delegate = self;
            stateCell.indexPath = indexPath;
            stateCell.buttonHead.tag = indexPath.row;
            stateCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [stateCell stateCellConfirmDataWithDictionary:[mutableArray objectAtIndex:indexPath.row]];

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
    NSMutableArray *mutableArrayRow = [_mutableArraySections objectAtIndex:_indexPathDelete.section];
    modelUser *user = [mutableArrayRow objectAtIndex:_indexPathDelete.row];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:user.fid, @"fid", nil] requestType:deleteUsers];
    [mutableArrayRow removeObjectAtIndex:_indexPathDelete.row];
    
    
    if (mutableArrayRow.count>0) {
        [_mutableArraySections replaceObjectAtIndex:_indexPathDelete.section withObject:mutableArrayRow];
        [self.tableView deleteRowsAtIndexPaths:@[_indexPathDelete] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        [_mutableArraySections removeObjectAtIndex:_indexPathDelete.section];
        NSMutableIndexSet *idxSet = [[NSMutableIndexSet alloc] init];
        [idxSet addIndex:_indexPathDelete.section];
        [self.tableView deleteSections:idxSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [self updataNetworkData];
}


//把名字分解成字母字典
#pragma mark----------- 搜索控件初始化 searchbar -----------
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
    NSMutableArray *array = [[NSMutableArray alloc]init];
    _mutableArrayFriends = nil;
    _mutableArrayFriends = [[NSMutableArray alloc]initWithArray:_mutableArrayFriends];
    for (modelUser *user in _mutableArrayFriends) {
        NSString *name = user.name;
        NSRange foundObj = [name rangeOfString:searchtext options:NSCaseInsensitiveSearch];
        if (foundObj.length>0) {
            
        }else{
            [array addObject:user];
        }
    }
    [_mutableArrayFriends removeObjectsInArray:array];
    [self initSectionIndex:_mutableArrayFriends];
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
//        _mutableArrayFriends = [[NSMutableArray alloc]initWithArray:_mutableArrayFriends];//还原数据
        [self initSectionIndex:_mutableArrayFriends];
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
//    _mutableArrayFriends = [[NSMutableArray alloc]initWithArray:_mutableArrayFriends];//还原数据
    [self initSectionIndex:_mutableArrayFriends];
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
    [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: [[[_mutableArraySections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] fid], @"fid", self.memoryAddress, MEMORY_ADDRESS, nil] requestType:showstate];
}

- (void)memoryNotificationAction:(NSNotification *)notification{
    if ([[notification.userInfo objectForKey:MEMORY_ADDRESS] isEqualToString:self.memoryAddress]) {
        [[activityView sharedActivityView] removeHUD];
        modelUser *user = notification.object;
        switch (user.state) {
            case 1://可叫醒
            {
                lowooWeakUpDetails *weakUpDetail = [[lowooWeakUpDetails alloc] init];
                weakUpDetail.user = [[_mutableArraySections objectAtIndex:_indexPathCell.section] objectAtIndex:_indexPathCell.row];
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
                    [gettingup confirmDataWithUser:[[_mutableArraySections objectAtIndex:_indexPathCell.section] objectAtIndex:_indexPathCell.row] propID:user.propID];
                }else{
                    lowooPOPhadbeencalled *called = [[lowooPOPhadbeencalled alloc] init];
                    [self.navigationController pushViewController:called animated:YES];
                    [called confirmDataWithUser:[[_mutableArraySections objectAtIndex:_indexPathCell.section] objectAtIndex:_indexPathCell.row]];
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


//- (void)getFriendState:(NSNotification *)sender{
//    [[activityView sharedActivityView] removeHUD];
//    switch ([[sender.userInfo objectForKey:@"state"] intValue]) {
//        case 1://可叫醒
//            {
//                lowooWeakUpDetails *weakUpDetail = [[lowooWeakUpDetails alloc]init];
//                weakUpDetail.stringFather = @"friends";
//                weakUpDetail.user = [[_mutableArraySections objectAtIndex:_indexPathCell.section] objectAtIndex:_indexPathCell.row];
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
//                    [gettingup confirmDataWithUser:[[_mutableArraySections objectAtIndex:_indexPathCell.section] objectAtIndex:_indexPathCell.row] propID:[[sender.userInfo objectForKey:@"list"] objectForKey:@"t_id"]];
//                }else{
//                    lowooPOPhadbeencalled *called = [[lowooPOPhadbeencalled alloc]init];
//                    [self.navigationController pushViewController:called animated:YES];
//                    [called confirmDataWithUser:[[_mutableArraySections objectAtIndex:_indexPathCell.section] objectAtIndex:_indexPathCell.row]];
//                    [called animation];
//                }
//            }
//            break;
//            case 3://已起床
//            break;
//            case 4://休息中
//            break;
//        default:
//            break;
//    }
//
//}

#pragma mark----------- 点击好友头像 -----------
- (void)buttonHeadDidTouchUpInside:(NSIndexPath *)indexPath{
    if (self.boolPush) {
        return;
    }
    [self setBoolPushYES];
    _personalDetails = [[lowooPersonalDetails alloc]init];
    _personalDetails.selfSetting = NO;
    _personalDetails.fid = [[[_mutableArraySections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] fid];
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


- (void)initSectionIndex:(NSArray *)sender{
    _mutableArraySections = [[NSMutableArray alloc] init];
    _mutableArraySectionKeys = [[NSMutableArray alloc] init];
    _mutableArrayA = [[NSMutableArray alloc] init];
    _mutableArrayB = [[NSMutableArray alloc] init];
    _mutableArrayC = [[NSMutableArray alloc] init];
    _mutableArrayD = [[NSMutableArray alloc] init];
    _mutableArrayE = [[NSMutableArray alloc] init];
    _mutableArrayF = [[NSMutableArray alloc] init];
    _mutableArrayG = [[NSMutableArray alloc] init];
    _mutableArrayH = [[NSMutableArray alloc] init];
    _mutableArrayI = [[NSMutableArray alloc] init];
    _mutableArrayJ = [[NSMutableArray alloc] init];
    _mutableArrayK = [[NSMutableArray alloc] init];
    _mutableArrayL = [[NSMutableArray alloc] init];
    _mutableArrayM = [[NSMutableArray alloc] init];
    _mutableArrayN = [[NSMutableArray alloc] init];
    _mutableArrayO = [[NSMutableArray alloc] init];
    _mutableArrayP = [[NSMutableArray alloc] init];
    _mutableArrayQ = [[NSMutableArray alloc] init];
    _mutableArrayR = [[NSMutableArray alloc] init];
    _mutableArrayS = [[NSMutableArray alloc] init];
    _mutableArrayT = [[NSMutableArray alloc] init];
    _mutableArrayU = [[NSMutableArray alloc] init];
    _mutableArrayV = [[NSMutableArray alloc] init];
    _mutableArrayW = [[NSMutableArray alloc] init];
    _mutableArrayX = [[NSMutableArray alloc] init];
    _mutableArrayY = [[NSMutableArray alloc] init];
    _mutableArrayZ = [[NSMutableArray alloc] init];
    
    for (modelUser *user in sender) {
        NSString *name = user.name;
        name = [POAPinyin Convert:name];
        
        if (name.length<2) {
            return;
        }
        NSString *Alphabet = [name substringWithRange:NSMakeRange(0, 1)];

        if ([Alphabet isEqualToString:@"A"]) {
            [_mutableArrayA addObject:user];
        }else if ([Alphabet isEqualToString:@"B"]){
            [_mutableArrayB addObject:user];
        }else if ([Alphabet isEqualToString:@"C"]){
            [_mutableArrayC addObject:user];
        }else if ([Alphabet isEqualToString:@"D"]){
            [_mutableArrayD addObject:user];
        }else if ([Alphabet isEqualToString:@"E"]){
            [_mutableArrayE addObject:user];
        }else if ([Alphabet isEqualToString:@"F"]){
            [_mutableArrayF addObject:user];
        }else if ([Alphabet isEqualToString:@"G"]){
            [_mutableArrayG addObject:user];
        }else if ([Alphabet isEqualToString:@"H"]){
            [_mutableArrayH addObject:user];
        }else if ([Alphabet isEqualToString:@"I"]){
            [_mutableArrayI addObject:user];
        }else if ([Alphabet isEqualToString:@"J"]){
            [_mutableArrayJ addObject:user];
        }else if ([Alphabet isEqualToString:@"K"]){
            [_mutableArrayK addObject:user];
        }else if ([Alphabet isEqualToString:@"L"]){
            [_mutableArrayL addObject:user];
        }else if ([Alphabet isEqualToString:@"M"]){
            [_mutableArrayM addObject:user];
        }else if ([Alphabet isEqualToString:@"N"]){
            [_mutableArrayN addObject:user];
        }else if ([Alphabet isEqualToString:@"O"]){
            [_mutableArrayO addObject:user];
        }else if ([Alphabet isEqualToString:@"P"]){
            [_mutableArrayP addObject:user];
        }else if ([Alphabet isEqualToString:@"Q"]){
            [_mutableArrayQ addObject:user];
        }else if ([Alphabet isEqualToString:@"R"]){
            [_mutableArrayR addObject:user];
        }else if ([Alphabet isEqualToString:@"S"]){
            [_mutableArrayS addObject:user];
        }else if ([Alphabet isEqualToString:@"T"]){
            [_mutableArrayT addObject:user];
        }else if ([Alphabet isEqualToString:@"U"]){
            [_mutableArrayU addObject:user];
        }else if ([Alphabet isEqualToString:@"V"]){
            [_mutableArrayV addObject:user];
        }else if ([Alphabet isEqualToString:@"W"]){
            [_mutableArrayW addObject:user];
        }else if ([Alphabet isEqualToString:@"X"]){
            [_mutableArrayX addObject:user];
        }else if ([Alphabet isEqualToString:@"Y"]){
            [_mutableArrayY addObject:user];
        }else if ([Alphabet isEqualToString:@"Z"]){
            [_mutableArrayZ addObject:user];
        }else {//未确定汉字
            [_mutableArrayZ addObject:user];
        }
    }
    if (_mutableArrayA.count>0) {
        [_mutableArraySections addObject:_mutableArrayA];
        [_mutableArraySectionKeys addObject:@"a"];
    }
    if (_mutableArrayB.count>0) {
        [_mutableArraySections addObject:_mutableArrayB];
        [_mutableArraySectionKeys addObject:@"b"];
    }
    if (_mutableArrayC.count>0) {
        [_mutableArraySections addObject:_mutableArrayC];
        [_mutableArraySectionKeys addObject:@"c"];
    }
    if (_mutableArrayD.count>0) {
        [_mutableArraySections addObject:_mutableArrayD];
        [_mutableArraySectionKeys addObject:@"d"];
    }
    if (_mutableArrayE.count>0) {
        [_mutableArraySections addObject:_mutableArrayE];
        [_mutableArraySectionKeys addObject:@"e"];
    }
    if (_mutableArrayF.count>0) {
        [_mutableArraySections addObject:_mutableArrayF];
        [_mutableArraySectionKeys addObject:@"f"];
    }
    if (_mutableArrayG.count>0) {
        [_mutableArraySections addObject:_mutableArrayG];
        [_mutableArraySectionKeys addObject:@"g"];
    }
    if (_mutableArrayH.count>0) {
        [_mutableArraySections addObject:_mutableArrayH];
        [_mutableArraySectionKeys addObject:@"h"];
    }
    if (_mutableArrayI.count>0) {
        [_mutableArraySections addObject:_mutableArrayI];
        [_mutableArraySectionKeys addObject:@"i"];
    }
    if (_mutableArrayJ.count>0) {
        [_mutableArraySections addObject:_mutableArrayJ];
        [_mutableArraySectionKeys addObject:@"j"];
    }
    if (_mutableArrayK.count>0) {
        [_mutableArraySections addObject:_mutableArrayK];
        [_mutableArraySectionKeys addObject:@"k"];
    }
    if (_mutableArrayL.count>0) {
        [_mutableArraySections addObject:_mutableArrayL];
        [_mutableArraySectionKeys addObject:@"l"];
    }
    if (_mutableArrayM.count>0) {
        [_mutableArraySections addObject:_mutableArrayM];
        [_mutableArraySectionKeys addObject:@"m"];
    }
    if (_mutableArrayN.count>0) {
        [_mutableArraySections addObject:_mutableArrayN];
        [_mutableArraySectionKeys addObject:@"n"];
    }
    if (_mutableArrayO.count>0) {
        [_mutableArraySections addObject:_mutableArrayO];
        [_mutableArraySectionKeys addObject:@"o"];
    }
    if (_mutableArrayP.count>0) {
        [_mutableArraySections addObject:_mutableArrayP];
        [_mutableArraySectionKeys addObject:@"p"];
    }
    if (_mutableArrayQ.count>0) {
        [_mutableArraySections addObject:_mutableArrayQ];
        [_mutableArraySectionKeys addObject:@"q"];
    }
    if (_mutableArrayR.count>0) {
        [_mutableArraySections addObject:_mutableArrayR];
        [_mutableArraySectionKeys addObject:@"r"];
    }
    if (_mutableArrayS.count>0) {
        [_mutableArraySections addObject:_mutableArrayS];
        [_mutableArraySectionKeys addObject:@"s"];
    }
    if (_mutableArrayT.count>0) {
        [_mutableArraySections addObject:_mutableArrayT];
        [_mutableArraySectionKeys addObject:@"t"];
    }
    if (_mutableArrayU.count>0) {
        [_mutableArraySections addObject:_mutableArrayU];
        [_mutableArraySectionKeys addObject:@"u"];
    }
    if (_mutableArrayV.count>0) {
        [_mutableArraySections addObject:_mutableArrayV];
        [_mutableArraySectionKeys addObject:@"v"];
    }
    if (_mutableArrayW.count>0) {
        [_mutableArraySections addObject:_mutableArrayW];
        [_mutableArraySectionKeys addObject:@"w"];
    }
    if (_mutableArrayX.count>0) {
        [_mutableArraySections addObject:_mutableArrayX];
        [_mutableArraySectionKeys addObject:@"x"];
    }
    if (_mutableArrayY.count>0) {
        [_mutableArraySections addObject:_mutableArrayY];
        [_mutableArraySectionKeys addObject:@"y"];
    }
    if (_mutableArrayZ.count>0) {
        [_mutableArraySections addObject:_mutableArrayZ];
        [_mutableArraySectionKeys addObject:@"z"];
    }
}


- (void)buttonNoFriendTouchUpInside:(UIButton_custom *)sender {
    [self rightButtonTouchUpInside];
}

//- (void)weakupDetailsDidload:(NSNotification *)sender{
//    if ([sender.object isEqualToString:@"friends"]) {
//        [[activityView sharedActivityView] removeHUD];
//        [self.navigationController pushViewController:[sender.userInfo objectForKey:@"vc"] animated:YES];
//    }
//}




@end
