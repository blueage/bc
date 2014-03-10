//
//  lowooAppDelegate.m
//  banana_clock
//
//  Created by MAC on 12-12-17.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "SinaWeibo.h"
#import "lowooAppDelegate.h"
#import "lowooSina.h"
#import "APService.h"
#import "LocalNotification.h"
#import "lowooLoginVC.h"
#import "RennSDK/RennSDK.h"
#import "Week.h"
#import "Reachability.h"
#import "liboTOOLS.h"
#import "UITabBarController_custom.h"


@implementation lowooAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PUSHAction:) name:@"checkServerAPNS" object:nil];
    [self registerForPushNotifications:application];
    [self jiguangPush:launchOptions];
    [self registeWeiboWeixin];
    [self detectNetwork];
    [self selectTheInitialScreen];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[LocalNotification sharedLocalNotification] checkCancelLocalNotification];
    if (launchOptions) {
        //推送
        NSNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (notification) {

        }
        //本地闹铃
        UILocalNotification *localNotifi = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
        if (localNotifi) {
            [self checkLocalNotification];
        }
    }

    return YES;
}

- (void)checkLocalNotification{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    liboTOOLS *tool = [[liboTOOLS alloc] init];

    UIApplication *app = [UIApplication sharedApplication];
    NSInteger now = [tool timeDate_timeStamp:[NSString stringWithFormat:@"%@",[NSDate new]]];
    for (NSNotification *notifi in [app scheduledLocalNotifications]) {
        NSString *date = [NSString stringWithFormat:@"%@",[notifi.userInfo objectForKey:@"date"]];
        NSInteger fireDate = [tool timeDate_timeStamp:date];
        if (fireDate<now && fireDate>now-60*5) {
            NSString *str = [notifi.userInfo objectForKey:@"sound"]; //[[dict objectForKey:@"arraySound"] objectAtIndex:today-1];
            NSString *term = @"0";
            NSDictionary *propsCache = [[userModel sharedUserModel] getCache:@"userpropsinfo"];
            NSArray *array = [[lowooHTTPManager getInstance] propModel:propsCache];
            for (modelProp *prop in array) {
                if (prop.propID == [str intValue]) {
                    term = prop.term;
                    _dictionaryGame = [[NSDictionary alloc] initWithObjectsAndKeys:@"/images/stories/face/200_200.jpg", @"face",
                                       USERID, @"id",
                                       [[userModel sharedUserModel] getUserInformationWithKey:USER_NAME], @"name",
                                       @"1", @"state",
                                       str, @"tid",
                                       term, @"term",
                                       [[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:USER_ENDTIME], @"time",
                                       [[NSUserDefaults standardUserDefaults] objectForKey:USER_UID], @"uid",
                                       @"localCall", @"localCall",nil];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"getupGame" object:nil userInfo:_dictionaryGame];
                    break;
                }
            }
            break;
        }
    }
}

// Register for push notifications
- (void)registerForPushNotifications:(UIApplication *)application{
    [application registerForRemoteNotificationTypes:

     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeSound];
}
//极光推送
- (void)jiguangPush:(NSDictionary *)launchOptions{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];
    
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    [APService setupWithOption:launchOptions];
    [APService setTags:[NSSet setWithObjects:USERID,nil] alias:USERID callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
}
//微博 微信
- (void)registeWeiboWeixin{
    //微博
    _sinaWeibo = [[SinaWeibo alloc] initWithAppKey:AppKey appSecret:AppSecret appRedirectURI:AppRedirectURI andDelegate:self];
    NSDictionary *sinaweiboInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaWeibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaWeibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaWeibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    //微信
    [WXApi registerApp:WXAppID];
}
//检测网络情况
- (void)detectNetwork{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    //Reachability *hostReach;//libo---------------- 必须在.h中声明
    hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];//无http 后台成熟后改为后台网址
    [hostReach startNotifier];
}

//选择初始画面
- (void)selectTheInitialScreen{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:OPENING_ANIMATION]) {
        
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:OPENING_ANIMATION];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:OPENING_ANIMATION] boolValue]) {
        videoBC *vi = [[videoBC alloc] init];
        self.window.rootViewController = vi;
    }else{
        lowooLoginVC *login = [[lowooLoginVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
        nav.viewControllers = @[login];
        self.window.rootViewController = nav;
    }
}

//检测网络
- (void)reachabilityChanged:(NSNotification *)note{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus *status = [curReach currentReachabilityStatus];
    if (status==NotReachable) {
        lowooPOPnetworkError *networkError = [[lowooPOPnetworkError alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [[lowooAlertViewDemo sharedAlertViewManager] show:networkError];
    }
}

#pragma mark ------------ weixin --------------
- (void)onResp:(BaseResp *)resp{
    if (resp.errCode == 0) {
        [[activityView sharedActivityView] showHUD:20];
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:@"1" ,@"weixin", nil] requestType:shareList];
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: @"1", @"productID", nil] requestType:RMBbuySuccess];
    }else{

    }
}


/** creates a folder at a given path */
- (void)createFolder:(NSString *)paramPath{
    NSError *error = nil;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager createDirectoryAtPath:paramPath withIntermediateDirectories:YES attributes:nil error:&error]) {
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"applicationDidEnterBackground" object:nil userInfo:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSString *sound = [notification.userInfo objectForKey:@"sound"];
    application.applicationIconBadgeNumber = 0;
    NSString *term = @"0";
    NSDictionary *propsCache = [[userModel sharedUserModel] getCache:@"userpropsinfo"];
    NSArray *array = [[lowooHTTPManager getInstance] propModel:propsCache];
    for (modelProp *prop in array) {
        if (prop.propID == [sound intValue]) {
            term = prop.term;
            break;
        }
    }

    _dictionaryGame = [[NSDictionary alloc] initWithObjectsAndKeys:@"/images/stories/face/200_200.jpg", @"face",
                                                                            USERID, @"id",
                                                                            [[userModel sharedUserModel] getUserInformationWithKey:USER_NAME], @"name",
                                                                            @"1", @"state",
                                                                            sound, @"tid",
                                                                            term, @"term",
                                                                            [[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:USER_ENDTIME], @"time",
                                                                            [[NSUserDefaults standardUserDefaults] objectForKey:USER_UID], @"uid",
                                                                            @"localCall", @"localCall", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getupGame" object:nil userInfo:_dictionaryGame];

}


//每次唤醒  
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if (application.applicationIconBadgeNumber>0) {
        //计算出今天闹铃的时间和现在的时间对比
        Week *week = [[Week alloc] init];
        if ([[[[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:@"array"] objectAtIndex:[week dayOfWeekType]] intValue] == 0) {
            return;//今天不可叫
        }
        int endTiem = [[[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION] objectForKey:USER_ENDTIME] intValue];
        NSDate *now = [NSDate date];
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[now timeIntervalSince1970]];
        while ([timeSp intValue] > endTiem+86400) {
            endTiem +=86400;
        }//得到今天的可叫结束时间，即本地闹铃的启动时间
        if ([timeSp intValue]>=endTiem && [timeSp intValue]<endTiem + 60*60) {//是否超时
            [self performSelector:@selector(checkLocalNotification) withObject:nil afterDelay:5];
        }
        application.applicationIconBadgeNumber = 0;
    }

    [self.sinaWeibo applicationDidBecomeActive];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationDidBecomeActive" object:nil userInfo:nil];//通知可能需要更新的界面进行更新
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //libo--------------------- 未执行
    return [self.sinaWeibo handleOpenURL:url];
    return [WXApi handleOpenURL:url delegate:self];
    return [RennClient handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([sourceApplication isEqualToString:@"com.sina.weibo"]) {
        return [self.sinaWeibo handleOpenURL:url];
    }
    return [WXApi handleOpenURL:url delegate:self];
}

/** 接收从苹果服务器返回的唯一的设备token，保存*/ //需注册推送
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [APService registerDeviceToken:deviceToken];
    
    //将 device token 转换为字符串
    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    deviceTokenStr = [[deviceTokenStr substringWithRange:NSMakeRange(0, 72)] substringWithRange:NSMakeRange(1, 71)];
    //保存 device token 令牌，并去掉空格
    //deviceTokenStr = @"5425c7fd0dd6b5caadb61aecd71b44ace43240c36acdad9a694703e99ed65b9a";
    [[NSUserDefaults standardUserDefaults] setObject:[deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"token"];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
}


#pragma mark-------获取远程通知----------
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    if ([[[userInfo objectForKey:@"aps"] objectForKey:@"sound"] isEqualToString:@"friendFollow.caf"]) {
        [[lowooMusic sharedLowooMusic] SystemSoundID:@"friendFollow" type:@"caf"];
        return;
    }
    
    [APService handleRemoteNotification:userInfo];
    //叫醒
    
    //提醒好友可叫
    if (USERID && ![USERID isEqualToString:@""]) {
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: [[NSUserDefaults standardUserDefaults] objectForKey:DeviceTokenRegisteredKEY],@"token", nil] requestType:retime];
    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"getupGame" object:nil userInfo:userInfo];

    //当用户打开程序的时候收到远程通知后执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        application.applicationIconBadgeNumber = 0;
    });
}


- (void)applicationWillTerminate:(UIApplication *)application{}

- (void)networkDidSetup:(NSNotification *)notification {}

- (void)networkDidClose:(NSNotification *)notification {}

- (void)networkDidRegister:(NSNotification *)notification {}

- (void)networkDidLogin:(NSNotification *)notification {}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSLog(@"%@",notification.userInfo);
    if ([[notification.userInfo objectForKey:@"title"] isEqualToString:@"friendFollow.caf"]) {
        return;//让IOS远程通知处理，防止铃声响两次
    }
    if (USERID && ![USERID isEqualToString:@""]) {
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: [[NSUserDefaults standardUserDefaults] objectForKey:DeviceTokenRegisteredKEY],@"token", nil] requestType:retime];
    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"getupGame" object:nil userInfo:[notification.userInfo objectForKey:@"extras"]];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    });
}

- (void)PUSHAction:(NSNotification *)sender{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    if (![BASE isNotNull:sender.userInfo]) {
        return;
    }
    if ([sender.userInfo count] == 0) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getupGame" object:nil userInfo:[sender.userInfo objectForKey:@"token"]];
}

- (void)changeVC:(NSInteger )name{
    [[lowooAlertViewDemo sharedAlertViewManager].alertViewQueue removeAllObjects];
    if (name==0) {//登录
        UITabBarController_custom *TabBarControllerVC = (UITabBarController_custom *)self.window.rootViewController;

        lowooLoginVC *login = [[lowooLoginVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
        nav.viewControllers = @[login];
        self.window.rootViewController = nav;
        
        
        [TabBarControllerVC removeFromParentViewController]; TabBarControllerVC = nil;
    }else if (name==1){//主界面
        lowooLoginVC *login = (lowooLoginVC *)self.window.rootViewController;
        
        UITabBarController_custom *TabBarControllerVC = [[UITabBarController_custom alloc] init];
        UINavigationController *nav  = [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
        nav.viewControllers = @[TabBarControllerVC];
        nav.navigationBarHidden = YES;
        [self.window setRootViewController:nav];
        
        [login removeFromParentViewController]; login = nil;
    }
}

@end
