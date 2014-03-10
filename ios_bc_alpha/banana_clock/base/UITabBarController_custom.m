//
//  UITabBarController_custom.m
//  banana_clock
//
//  Created by MAC on 13-10-9.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "UITabBarController_custom.h"
#import "lowooWeakupVC.h"
#import "lowooFriendsVC.h"
#import "lowooProps.h"
#import "lowooSettingVC.h"
#import "UINavigationBar_custom.h"
#import "UIButton_custom.h"
#import "UINavigationBar_custom.h"
#import "lowooStory.h"
#import "lowooCoinView.h"
#import "lowooDeleteFromeBlackListViewController.h"
#import "lowooPOPhadbeencalled.h"
#import "lowooGettingUpViewController.h"
#import "LocalNotification.h"
@class lowooAppDelegate;

@interface UITabBarController_custom ()

@end

@implementation UITabBarController_custom

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self banana];
    [self didLogin];
}

- (void)loadUITabBarViewController{
    //背景图片
    UIImageView *imageViewBackgound;
    if (iPhone5||iPhone5_0) {
        imageViewBackgound = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, 320, 460)];
        imageViewBackgound.image = GetPngImage(@"iphone5bc");
    }else{
        imageViewBackgound = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, 320, 370)];
        imageViewBackgound.image = GetPngImage(@"iphone4bc");
    }
    [self.view addSubview:imageViewBackgound];
    [self.view sendSubviewToBack:imageViewBackgound];
	
    //初始化视图
    [self setArrayViewController:nil];
    [self setViewTabBar:nil];
}

- (void)setArrayViewController:(NSMutableArray *)arrayViewController{
//    lowooWeakupVC *weakup = [[lowooWeakupVC alloc] init];
    clockVC *weakup = [[clockVC alloc] init];
    _nav1 = [[UINavigationController_custom alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
    _nav1.viewControllers = @[weakup];
//    lowooFriendsVC *friends = [[lowooFriendsVC alloc] init];
    FriendsVC *friends = [[FriendsVC alloc] init];
    _nav2 = [[UINavigationController_custom alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
    _nav2.viewControllers = @[friends];
    lowooProps *props = [[lowooProps alloc] init];
    _nav3 = [[UINavigationController_custom alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
    _nav3.viewControllers = @[props];
    lowooSettingVC *settings = [[lowooSettingVC alloc] init];
    _nav4 = [[UINavigationController_custom alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
    _nav4.viewControllers = @[settings];
    
    _arrayViewController = [[NSMutableArray alloc] initWithObjects:_nav1, _nav2, _nav3, _nav4, nil];
    self.viewControllers = _arrayViewController;//[NSArray arrayWithArray:_arrayViewController];
}

- (void)setViewTabBar:(UIView *)viewTabBar{
    _viewTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-59, SCREEN_WIDTH, 59)];
    UIImageView *imageViewTabBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _viewTabBar.frame.size.width, _viewTabBar.frame.size.height)];
    [imageViewTabBar setImage:GetPngImage(@"down_bc")];
    [_viewTabBar addSubview:imageViewTabBar];
    
//    NSArray *arrayTabBarButtonText = [[NSArray alloc] initWithObjects:@"Momingcall",
//                                                                      @"Friends",
//                                                                      @"ClockShop",
//                                                                      @"Settings", nil];
    _arrayImages = [[NSArray alloc] initWithObjects:GetPngImage(@"btn01a"),
                                                            GetPngImage(@"btn02a"),
                                                            GetPngImage(@"btn03a"),
                                                            GetPngImage(@"btn04a"), nil];
    _arrayImagesDown = [[NSArray alloc] initWithObjects:GetPngImage(@"btn01b"),
                                                                GetPngImage(@"btn02b"),
                                                                GetPngImage(@"btn03b"),
                                                                GetPngImage(@"btn04b"), nil];
    
    _arrayTabButton = [[NSMutableArray alloc] init];
    
    for (int i=0; i<4; i++) {
        UIButton_custom *button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [button setMusic:@"clicknew"];
        button.tag = i;
        [button removeTarget];
        button.frame = CGRectMake(80 * i +1.7, 9, 76.5, 50);
        [button setImage:[_arrayImages objectAtIndex:i] forState:UIControlStateNormal];
        [button setImage:[_arrayImagesDown objectAtIndex:i] forState:UIControlEventTouchDown];
        [button addTarget:self action:@selector(tabBarButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button setHighlighted:NO];
        [_arrayTabButton addObject:button];
        [_viewTabBar addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(1.7+i*80, 38, 76, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.tag = i+1000;
        [label setFont:[UIFont systemFontOfSize:8]];
        label.textColor = [UIColor colorWithRed:48/255.0 green:48/255.0 blue:48/255.0 alpha:1];
        [label setTextAlignment:NSTextAlignmentCenter];
        label. userInteractionEnabled = NO;
        [_viewTabBar addSubview:label];
    }
    
    [self.view addSubview:_viewTabBar];
    [self tabBarButtonTouchUpInside:[_arrayTabButton objectAtIndex:0]];
    [self setTabBarName];
}

- (void)setTabBarName{
    if (LANGUAGE_CHINESE) {
        NSArray *arrayTabBarButtonText = [[NSArray alloc] initWithObjects:@"闹闹",
                                          @"好友",
                                          @"道具",
                                          @"设置", nil];
        
        
        for (int i=0; i<4; i++) {
            UILabel *label = (UILabel *)[_viewTabBar viewWithTag:i+1000];
            label.text = [arrayTabBarButtonText objectAtIndex:i];
        }
    }else{
        NSArray *arrayTabBarButtonText = [[NSArray alloc] initWithObjects:@"Clock",
                                          @"Friends",
                                          @"ClockShop",
                                          @"Settings", nil];
        
        for (int i=0; i<4; i++) {
            UILabel *label = (UILabel *)[_viewTabBar viewWithTag:i+1000];
            label.text = [arrayTabBarButtonText objectAtIndex:i];
        }
    }
}

- (void)tabBarButtonTouchUpInside:(UIButton *)button{
    if (self.selectedIndex == button.tag) {
        switch (button.tag) {
            case 0:
                [[_arrayViewController objectAtIndex:button.tag] popToRootViewControllerAnimated:YES];
                break;
            case 1:
                [[_arrayViewController objectAtIndex:button.tag] popToRootViewControllerAnimated:YES];
                break;
            case 2:
                [[_arrayViewController objectAtIndex:button.tag] popToRootViewControllerAnimated:YES];
                break;
            case 3:
                [[_arrayViewController objectAtIndex:button.tag] popToRootViewControllerAnimated:YES];
                break;
            default:
                break;
        }
    }else{
        switch (button.tag) {
            case 0:
                [self setSelectedViewController:[_arrayViewController objectAtIndex:button.tag]];
                break;
            case 1:
                [self setSelectedViewController:[_arrayViewController objectAtIndex:button.tag]];
                break;
            case 2:
                [self setSelectedViewController:[_arrayViewController objectAtIndex:button.tag]];
                break;
            case 3:
                [self setSelectedViewController:[_arrayViewController objectAtIndex:button.tag]];
                break;
            default:
                break;
        }
    }
    
    for (UIButton_custom *button in _arrayTabButton) {
        if (button.tag == self.selectedIndex) {
            [button setImage:[_arrayImagesDown objectAtIndex:button.tag] forState:UIControlStateNormal];
        }else{
            [button setImage:[_arrayImages objectAtIndex:button.tag] forState:UIControlStateNormal];
        }
    }
    //金币是否隐藏
    switch (button.tag) {
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"navigation1" object:nil];
            [self navigationGoldHidden];
            break;
        case 1:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"navigation2" object:nil];
            [self navigationGoldHidden];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"navigation3" object:nil];
            if (_currentPage != self.selectedIndex) {
                [self navigationGoldHiddenno];
            }
            break;
        case 3:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"navigation4" object:nil];
            [self navigationGoldHidden];
            break;
        default:
            break;
    }
    _currentPage = button.tag;
}


#pragma mark ---------- bananaClock ------------
- (void)banana{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUpGame:) name:@"getupGame" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameStartNew) name:@"startGame" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userShield) name:@"userShield" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lazy) name:@"lazy" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initUpdateServerTime:) name:@"didReturnTime" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyCoin:) name:@"buyCoin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetBananaNumber:) name:@"bananaNumberChange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigationViewHidden) name:@"navigationViewHidden" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigationViewHiddenno) name:@"navigationViewHiddenno" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigationGoldHidden) name:@"navigationViewGoldHidden" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigationGoldHiddenno) name:@"navigationViewGoldHiddenno" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QRCode) name:@"QRCode" object:nil];
    //各种成就返回数据，可能更新香蕉币数量,弹出获得成就视图遮罩
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obtainAchievement:) name:@"obtainAchievement" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RMBbuySuccess:) name:@"RMBbuySuccess" object:nil];//防止页面返回后收不到http返回的信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTabBarName) name:@"international" object:nil];

    
    LOWOO_APP(app);
    if (app.dictionaryGame) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getupGame" object:nil userInfo:[[NSDictionary alloc] initWithDictionary:app.dictionaryGame]];
        app.dictionaryGame = nil;
    }
}

#pragma mark----------- 使用盾----------
- (void)userShield{
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: _stringCallFid, @"fid", _stringTid, @"tid", nil] requestType:bananaShield];
    lowooPOPUseOfShied *shield = [[lowooPOPUseOfShied alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[lowooAlertViewDemo sharedAlertViewManager] show:shield];
    [[lowooMusic sharedLowooMusic] stopPlayer];
    _stringCallFid = nil;
    _stringTid = nil;
    //取消当天本地闹铃
    [[LocalNotification sharedLocalNotification] checkCancelLocalNotification];
}
#pragma mark----------- 赖床-----------
- (void)lazy{
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: _stringCallFid, @"fid", _stringTid, @"tid", nil] requestType:backtobed];
    lowooPOPLazy *lazy = [[lowooPOPLazy alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    NSDictionary *propsCache = [[userModel sharedUserModel] getCache:@"userpropsinfo"];
    NSArray *array = [[lowooHTTPManager getInstance] propModel:propsCache];
    lazy.imageViewDown.image = GetPngImage(@"coin-1");
    for (modelProp *prop in array) {
        if (prop.propID == [_stringTid intValue]) {
            if ([prop.term intValue] == 5) {
                lazy.imageViewDown.image = GetPngImage(@"coin-3");//libo
            }else{
                lazy.imageViewDown.image = GetPngImage(@"coin-1");
            }
        }
    }
    
    [[lowooAlertViewDemo sharedAlertViewManager] show:lazy];
    [[lowooMusic sharedLowooMusic] stopPlayer];
    _stringCallFid = nil;
    _stringTid = nil;
    //取消当天本地闹铃
    [[LocalNotification sharedLocalNotification] checkCancelLocalNotification];
}

- (void)didLogin{
    [self loadUITabBarViewController];
    [_viewNavigationView removeFromSuperview];
    _viewNavigationView = nil;
    _viewNavigationView = [[lowooNavigationView alloc]initWithFrame:CGRectMake(0, 44, 320, 58)];
    [self.view addSubview:_viewNavigationView];
    
    if (!_timeTitle) {//只初始化一次即可
        _timeTitle = [time_title shareInstance];
        _timeTitle.delegate = self;
        [_timeTitle start];
        _timeTitle.labelTitle.text = @"";
        [self.view addSubview:_timeTitle.viewBase];
    }
    _timeTitle.labelTitle.text = @"";
    _timeTitle.viewTitle.hidden = NO;
}

#pragma mark----------- 叶子 ---------
- (void)navigationViewHidden{
    _viewNavigationView.hidden = YES;
    _timeTitle.viewTitle.hidden = YES;
    _viewTabBar.hidden = YES;
}
- (void)navigationViewHiddenno{
    _viewNavigationView.hidden = NO;
    _timeTitle.viewTitle.hidden = NO;
    _viewTabBar.hidden = NO;
}

#pragma mark----------- 金币 ----------
- (void)navigationGoldHidden{
    if (_viewNavigationView.viewGold) {
        _viewNavigationView.viewGold.hidden = YES;
    }
}
- (void)navigationGoldHiddenno{
    [_viewNavigationView resetNumber];
}


#pragma mark----------- 获取更新时间--------------
- (void)initUpdateServerTime:(NSNotification *)sender{
    if (!_viewNavigationView) {
        return;
    }
    time_title *timeTitle = [time_title shareInstance];
    [timeTitle initUpdateServerTime:sender];
}

- (void)resetBananaNumber{
    if (!_viewNavigationView) {
        return;
    }
    if (self.selectedIndex == 2) {
        [_viewNavigationView resetNumber];
    }
}

- (void)buyCoin:(NSNotification *)sender{
    if ([BASE isNotNull:sender.object]) {
        [_viewNavigationView.viewGold setNumber:[sender.object intValue]];
    }
}

- (void)resetBananaNumber:(NSNotification *)sender{
    if (!_viewNavigationView) {
        return;
    }
    if ([BASE isNotNull:[sender.userInfo objectForKey:USER_COIN]]) {
        if ([[sender.userInfo objectForKey:USER_COIN] intValue]<0) {
            return;
        }
    }else{
        return;
    }
    [[userModel sharedUserModel] setUserInformation:[sender.userInfo objectForKey:USER_COIN] forKey:USER_COIN];
    if (self.selectedIndex == 2) {
        [_viewNavigationView resetNumberWithNotification:sender];
    }
}

#pragma mark----------- 玩游戏-------------
-(void)gameStartNew{
    lowooGame *game = [[lowooGame alloc]init];
    game.delegate = self;
    game.boolGetupGame = NO;
    game.gameNumber = 1;
    UINavigationController *navGame = [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
    navGame.viewControllers = @[game];
    [self.navigationController presentViewController:navGame animated:YES completion:^{
        [game gameStart];
        if (!_arrayGame) {
            _arrayGame = [[NSMutableArray alloc] init];
        }
        [_arrayGame addObject:game];
    }];
}

- (void)gameEnd{
    [_arrayGame removeAllObjects];
    _arrayGame = nil;
    _boolSomeoneCall = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gameEnd" object:nil];
}

#pragma mark ---------- 重新起床 ------------
- (void)getupGameStartNew{
    [[lowooMusic sharedLowooMusic] stopPlayer];
    lowooGame *game = [[lowooGame alloc]init];
    game.delegate = self;
    game.boolGetupGame = YES;
    game.gameNumber = 1;
    game.stringFID = _stringCallFid;
    game.stringTID = _stringTid;
    UINavigationController *navGame = [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
    navGame.viewControllers = @[game];
    [self.navigationController presentViewController:navGame animated:YES completion:^{
        [game gameStart];
    }];
}

#pragma mark----------- 叫醒游戏-----------
- (void)getUpGame:(NSNotification *)sender{
    if (![BASE isNotNull:sender] || [[sender.userInfo objectForKey:@"state"] isEqualToString:@"0"] || _boolSomeoneCall) {//阻止他人叫和本地叫 主动从后台请求的数据
        return;
    }
    
    if (![[sender.userInfo objectForKey:@"localCall"] isEqualToString:@"localCall"]) {
        _boolSomeoneCall = YES;
    }
    
    if (_arrayGame && _boolSomeoneCall) {//起床游戏结束本地游戏
        [self performSelector:@selector(removeGametoGetup0) withObject:nil afterDelay:4];
        [self performSelector:@selector(removeGametoGetup:) withObject:sender afterDelay:4];
    }else if (_arrayGame){//本地游戏被忽略
        
    }else{//没有任何游戏 单独执行游戏或叫醒游戏
        [self removeGametoGetup:sender];
    }
}

- (void)removeGametoGetup0{
    lowooGame *game = [_arrayGame objectAtIndex:0];
    [game dismissViewControllerAnimated:NO completion:^{
        [[lowooMusic sharedLowooMusic] stopPlayer];
        [game.timerGame invalidate];
        game.timerGame = nil;
        [game.timer invalidate];
        game.timer = nil;
        [NSObject cancelPreviousPerformRequestsWithTarget:game];
    }];
    [_arrayGame removeAllObjects];
    _arrayGame = nil;
}

- (void)removeGametoGetup:(NSNotification *)sender{
    [[lowooMusic sharedLowooMusic] stopPlayer];
    lowooGame *game = [[lowooGame alloc]init];
    game.delegate = self;
    game.boolGetupGame = YES;
    game.gameNumber = 1;
    _stringCallFid = [sender.userInfo objectForKey:@"fid"];
    _stringTid = [sender.userInfo objectForKey:@"t_id"];
    UINavigationController *navGame = [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
    navGame.viewControllers = @[game];
    
    [[activityView sharedActivityView] showHUD:-1];
    [self performSelector:@selector(popGameVC:) withObject:[NSDictionary dictionaryWithObjectsAndKeys:navGame, @"vc", game, @"game", sender.userInfo, @"data", nil] afterDelay:1];

    if ([[sender.userInfo objectForKey:@"localCall"] isEqualToString:@"localCall"]) {
        _arrayGame = [[NSMutableArray alloc] init];
        [_arrayGame addObject:game];
    }else{
        _boolSomeoneCall = YES;
    }
}

- (void)popGameVC:(NSDictionary *)dictionary{
    [self.navigationController presentViewController:[dictionary objectForKey:@"vc"] animated:YES completion:^{
        [[(lowooGame *)[dictionary objectForKey:@"game"] gameup] confirmDataWith:[dictionary objectForKey:@"data"]];
    }];
}

#pragma mark----------- 二维码 ------------
- (void)QRCode{
    lowooZBar *zbarView = [[lowooZBar alloc]init];
    [self.navigationController presentViewController:zbarView animated:YES completion:^{
        
    }];
}

- (void)setImageViewMessageNotificationREDHidden:(BOOL)hidden{
    if (!_imageViewMessageNotificationRED) {
        _imageViewMessageNotificationRED = [[UIImageView alloc] initWithFrame:CGRectMake(132, 8, 20, 20)];
        _imageViewMessageNotificationRED.image = GetPngImage(@"messageNotificationRED");
        [_viewTabBar addSubview:_imageViewMessageNotificationRED];
    }
    if (hidden) {
        [_imageViewMessageNotificationRED removeFromSuperview];
        _imageViewMessageNotificationRED = nil;
    }
}


- (void)hidesBottomBarViewWhenPushed:(BOOL)hidden{
    CGRect frame = _viewTabBar.frame;
    if (hidden) {
        frame.origin.y = SCREEN_HEIGHT;
        [UIView animateWithDuration:0.3 animations:^{
            _viewTabBar.frame = frame;
        }];
    }else{
        frame.origin.y = SCREEN_HEIGHT - 59;
        [UIView animateWithDuration:0.3 animations:^{
            _viewTabBar.frame = frame;
        }];
    }
    [self.view bringSubviewToFront:_viewTabBar];
}

- (void)hidesTimeTitleWhenPushed:(BOOL)hidden{
    _timeTitle.viewBase.hidden = hidden;
}

//获取系统语言
- (NSString *)currentLanguage{
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    return [languages objectAtIndex:0];
}

#pragma mark ---------  购买成功 后台返回 --------
- (void)RMBbuySuccess:(NSNotification *)sender{
    [[userModel sharedUserModel] setUserInformation:[sender.userInfo objectForKey:@"coin"] forKey:USER_COIN];
    [self resetBananaNumber];

    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:userpropsinfo];//可能是解锁所有道具
}

- (id)UITabBarController_custom_view{
    return self.view;
}

- (void)systemBootAction{
    _boot = [[systemBoot alloc] init];
    if (_currentPage == 0) {
        [_boot addBaseView:1];
    }else if (_currentPage == 1){
        NSString *title =  [(lowooViewController *)[_nav2.viewControllers lastObject] stringTitle];
        if ([title isEqualToString:@"FRIENDS LIST"]) {//好友列表
            [_boot addBaseView:2];
        }else if ([title isEqualToString:@"WEAKUP FRIEND"]){//叫醒页
            [_boot addBaseView:4];
//        }else if ([title isEqualToString:@"FRIEND‘s PROFILE"]){//好友详情页
//            [_boot addBaseView:8];
//        }else if ([title isEqualToString:@"FRIENDS TOP"]){//好友排行榜
//            [_boot addBaseView:3];
//        }else if ([title isEqualToString:@"ADD FRIEND"]){//添加好友
//            [_boot addBaseView:3];
//        }else if ([title isEqualToString:@"SINA"]){//新浪
//            [_boot addBaseView:3];
//        }else if ([title isEqualToString:@"PHONE BINDING"]){//手机号绑定
//            [_boot addBaseView:3];
        }else{
            [_boot addBaseView:2];
        }
    }else if (_currentPage == 2){
        NSString *title =  [(lowooViewController *)[_nav3.viewControllers lastObject] stringTitle];
        if ([title isEqualToString:@"MY PROPS"]) {//我的道具页
            [_boot addBaseView:5];
        }else if ([title isEqualToString:@"PROPS SHOP"]){//道具商店
            [_boot addBaseView:6];
        }else if ([title isEqualToString:@"PROPS DETAIL"]){//道具详情页
            [_boot addBaseView:8];
        }else if ([title isEqualToString:@"SHOP"]){//购买页
            [_boot addBaseView:7];
        }else{
            [_boot addBaseView:4];
        }
    }else if (_currentPage == 3){
        NSString *title =  [(lowooViewController *)[_nav4.viewControllers lastObject] stringTitle];
        if ([title isEqualToString:@"SETTING"]) {//设置页
            [_boot addBaseView:9];
        }else if ([title isEqualToString:@"PROFILE"]){//个人信息页
            [_boot addBaseView:10];
//        }else if ([title isEqualToString:@"TIME SETTING"]){//时间设置页
//            [_boot addBaseView:7];
        }else{
            [_boot addBaseView:7];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{

}

@end
