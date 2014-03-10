//
//  lowooHTTPManager.m
//  banana clock
//
//  Created by MAC on 12-9-18.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooHTTPManager.h"
#import "lowooAlertViewDemo.h"
#import "LocalNotification.h"

static lowooHTTPManager *instance;

@implementation lowooHTTPManager

//初始化
- (id)initWithDelegate {
    self = [super init];
    if (self) {
        if (!_requestQueue) {
            _requestQueue = [[NSOperationQueue alloc] init];
        }
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
        _requestQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

+(lowooHTTPManager *)getInstance{

    @synchronized(self){
        if (instance == nil) {
            instance = [[lowooHTTPManager alloc]init];
        }
    }
    return instance;
}




#pragma mark-----------根据类型获取URL----------
-(NSString *)getRequestURL:(RequestType)requestType{//////////////////////    &json=
    if (requestType == loginURL) {//登录
        return @"/index.php?option=com_users&task=checkusers&tmpl=json&json=";
    }
    else if (requestType == userRegist) {//注册
        return @"/index.php?option=com_users&task=register&tmpl=json&json=";
    }
    else if (requestType == refreshFriendList){//获取用户好友列表
        return @"/index.php?option=com_users&task=refreshFriendList&tmpl=json&json=";
    }
    else if (requestType == newFriendList){//新版好友列表
        return @"/index.php?option=com_users&task=newFriendList&tmpl=json&json=";
    }
    else if (requestType == applayFriendRequest){//同意好友请求
        return @"/index.php?option=com_bcuser&task=achieve.applyFriendRequest&tmpl=json&json=";
    }
    else if (requestType == ignoreFriendRequest){//拒绝好友请求
        return @"/index.php?option=com_users&task=ignoreFriendRequest&tmpl=json&json=";
    }
    else if (requestType == removeFromBlackNameList){//从黑名单中移除
        return @"/index.php?option=com_users&task=removeFromBlackNameList&tmpl=json&json=";
    }
    else if (requestType == RecentFriendsList){//最近联系人列表
        return @"/index.php?option=com_users&task=RecentFriendsList&tmpl=json&json=";
    }
    else if (requestType == changedays){//更改重复天数
        return @"/index.php?option=com_users&task=changedays&tmpl=json&json=";
    }
    else if (requestType == deleteUsers){//删除好友
        return @"/index.php?option=com_users&task=deleteUsers&tmpl=json&json=";
    }
    else if (requestType == deleteRecentFriends){//删除最近联系人
        return @"/index.php?option=com_users&task=deleteRecentFriends&tmpl=json&json=";
    }
    else if (requestType == addFriend){//添加好友  不处理返回信息
        return @"/index.php?option=com_users&task=addFriend&tmpl=json&json=";
    }
    else if (requestType == searchUser){//搜索好友
        return @"/index.php?option=com_users&task=searchUser&tmpl=json&json=";
    }
    else if (requestType == userpropsinfo){//更新下载道具
        return @"/index.php?option=com_props&task=userpropsinfo&tmpl=json&json=";
    }
    else if (requestType == offline){//退出
        return @"/index.php?option=com_users&task=offline&tmpl=json&json=";
    }
    else if (requestType == ranking){//好友排行榜
        return @"/index.php?option=com_bcuser&task=ranking&tmpl=json&json=";
    }
    else if (requestType == buyprops){//香蕉币购买道具
        return @"/index.php?option=com_props&task=buyprops&tmpl=json&json=";
    }
    else if (requestType == setcalledtime){//设置叫醒时间
        return @"/index.php?option=com_bcuser&task=setCalledtime&tmpl=json&json=";
    }
    else if (requestType == weakupFriend){//叫醒好友
        return @"/index.php?option=com_bcuser&task=achieve.continuousCall&tmpl=json&json=";
    }
    else if (requestType == continuousGetup){//连续起床
        return @"/index.php?option=com_bcuser&task=achieve.continuousGetup&tmpl=json&json=";
    }
    else if (requestType == bananaShield){//使用香蕉盾
        return @"/index.php?option=com_bcuser&task=achieve.dun&tmpl=json&json=";
    }
    else if (requestType == retime){//实时更新时间
        return @"/index.php?option=com_bcuser&task=retime&tmpl=json&json=";
    }
    else if (requestType == uploadpic){//上传头像
        return @"/index.php?option=com_bcuser&task=uploadpic&tmpl=json&json=";
    }
    else if (requestType == gameSuccess){//玩游戏成功
        return @"/index.php?option=com_bcuser&task=achieve.game&tmpl=json&json=";
    }
    else if (requestType == achievelist){//个人信息
        return @"/index.php?option=com_bcuser&task=achieve.achievelist&tmpl=json&json=";
    }
    else if (requestType == gameFailed){//玩游戏失败
        return @"/index.php?option=com_bcuser&task=achieve.gamefail&tmpl=json&json=";
    }
    else if (requestType == gettools){//初始立即更新道具
        return @"/index.php?option=com_props&task=tools.gettools&tmpl=json&json=";
    }
    else if (requestType == showstate){//单独获取某位好友的状态
        return @"/index.php?option=com_bcuser&task=showstate&tmpl=json&json=";
    }
    else if (requestType == backtobed){//赖床
        return @"/index.php?option=com_bcuser&task=achieve.continuousInbed&tmpl=json&json=";
    }
    else if (requestType == transferPhoneBookNumber){//好友电话
        return @"/index.php?option=com_bcuser&task=telbook&tmpl=json&json=";
    }
    else if (requestType == upLoadPhoneNumber){//绑定手机号
        return @"/index.php?option=com_bcuser&task=addtellist&tmpl=json&json=";
    }
    else if (requestType == deletePhoneNumber){//解除绑定手机号
        return @"/index.php?option=com_bcuser&task=deltel&tmpl=json&json=";
    }
    else if (requestType == deleteSinaID){//解除绑定新浪
        return @"/index.php?option=com_bcuser&task=deleteSinaID&tmpl=json&json=";
    }
    else if (requestType == upLoadSinaID){//绑定新浪微博
        return @"/index.php?option=com_bcuser&task=addweblist&tmpl=json&json=";
    }
    else if (requestType == transferMicrobloggingFriendsID){//好友新浪id
        return @"/index.php?option=com_bcuser&task=sinafriend&tmpl=json&json=";
    }
    else if (requestType == modifyMailbox){//更改邮箱
        return @"/index.php?option=com_bcuser&task=changeemail&tmpl=json&json=";
    }
    else if (requestType == changePassWord){//修改密码
        return @"/index.php?option=com_users&task=changePWD&tmpl=json&json=";
    }
    else if (requestType == refreshBlackNameList){//黑名单列表
        return @"/index.php?option=com_users&task=refreshBlackNameList&tmpl=json&json=";
    }
    else if (requestType == RMBbuySuccess){//分享微博成功
        return @"/index.php?option=com_bcuser&task=buycoin&tmpl=json&json=";
    }
    else if (requestType == checkUID){//判断用户id是否已经被注册
        return @"/index.php?option=com_users&task=checkuser&tmpl=json&json=";
    }
    else if (requestType == downloadMusic){//下载音乐文件
        return @"/index.php?option=com_props&task=ring&tmpl=json&json=";
    }
    else if (requestType == moon_sun){//是否可叫
        return @"/index.php?option=com_bcuser&task=dtime&tmpl=json&json=";
    }
    else if (requestType == shareList){//分享列表
        return @"/index.php?option=com_bcuser&task=weblist&tmpl=json&json=";
    }
    else if (requestType == weiboLogin){//微博登录
        return @"/index.php?option=com_users&task=bcWeiboLogin&tmpl=json&json=";
    }
    else if (requestType == userInfo){//获取用户信息
        return @"/index.php?option=com_users&task=getuserinfos&tmpl=json&json=";
    }
    else if (requestType == forgotPassword){//忘记密码，使用邮箱找回
        return @"/index.php?option=com_users&task=reset.bcrequest&tmpl=json&json=";
    }
    else if (requestType == foucs){//忘记密码，使用邮箱找回
        return @"/index.php?option=com_bcuser&task=achieve.foucus&tmpl=json&json=";
    }
    
    return nil;
}

- (NSString *)URLEncodedString:(NSString *)str
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)str,
                                                                           NULL,
                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8));
 
    return result;
}

-(void)doHTTPRequestWithPostFields:(NSDictionary *)postFields requestType:(RequestType)requestType{
    //请求值统一加UID TOKEN
    {
        NSMutableDictionary *muTable = [NSMutableDictionary dictionaryWithDictionary:postFields];
        if (USERID&&[USERID length]>0) {
            [muTable setObject:USERID forKey:USER_ID];
        }
        if (DeviceTokenRegisteredKEY&&[DeviceTokenRegisteredKEY length]>0) {
            [muTable setObject:DeviceTokenRegisteredKEY forKey:@"token"];
        }
        postFields = muTable;
    }
    NSString *apiName = [self getRequestURL:requestType];
    NSString *urlString;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"] boolValue]) {
        urlString = [NSString stringWithFormat:@"%@%@",BASEURL,apiName];
    }else{
        urlString = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"base_server_url"],apiName];
    }
    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    
    if (requestType == uploadpic) {

            [_manager POST:urlString
               parameters:postFields
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      if (requestType == uploadpic){//更改头像
                          [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadpic" object:nil userInfo:responseObject];
                      }
                  }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      if (requestType == uploadpic){//更改头像
                          [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadpic" object:nil userInfo:nil];
                      }
                  }];
        return;
    }
  
    

    {
        
        [_manager GET:urlString
          parameters:postFields
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                 if (![BASE isNotNull:responseObject] || ![BASE isNotNull:[responseObject objectForKey:@"state"]]) {
//                     [[activityView sharedActivityView] removeHUD];
//                     return ;
//                 }
                 if (requestType == loginURL) {//登录
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"doLogin" object:nil userInfo:responseObject];
                     if ([BASE isNotNull:[responseObject objectForKey:@"id"]]) {
                         [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"id"] forKey:USER_ID];
                         [[NSUserDefaults standardUserDefaults] synchronize];
                         [[userModel sharedUserModel] writeCache:responseObject title:@"doLogin"];
                     }
                 }
                 else if (requestType == userRegist) {//注册
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"didRegist" object:nil userInfo:responseObject];
                 }
                 else if (requestType == refreshFriendList){//用户好友列表
                     if ([[responseObject objectForKey:@"state"] intValue] == 1) {
                         [[userModel sharedUserModel] writeCache:responseObject title:@"refreshFriendList"];
                         NSArray *array = [self userModel:responseObject];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"getUserFriendsList" object:array userInfo:nil];
                     }else{
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"getUserFriendsList" object:nil userInfo:nil];
                     }
                 }
                 else if (requestType == newFriendList){//新版用户好友列表
                     if ([[responseObject objectForKey:@"state"] intValue] == 1) {
                         [[userModel sharedUserModel] writeCache:responseObject title:@"newFriendList"];
                         NSArray *array = [self userModel:responseObject];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"newFriendList" object:array userInfo:nil];
                     }
                 }
                 else if (requestType == searchUser){//搜索好友
                     if ([[responseObject objectForKey:@"state"] intValue] == 1) {
                         if ([BASE isNotNull:[responseObject objectForKey:@"list"]]) {
                             if ([[responseObject objectForKey:@"list"] isKindOfClass:[NSDictionary class]]) {
                                 modelUser *user = [[modelUser alloc] init];
                                 user.JSONdictionary = [responseObject objectForKey:@"list"];
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"getSearchUser" object:user userInfo:nil];
                                 return ;
                             }
                         }
                     }
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"getSearchUser" object:nil userInfo:nil];
                 }
                 else if (requestType == applayFriendRequest){//同意好友请求
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFriendList" object:nil];
                 }
                 else if (requestType == ignoreFriendRequest){//拒绝好友请求
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFriendList" object:nil];
                 }
                 else if (requestType == RecentFriendsList){//最近联系人列表
                     if ([[responseObject objectForKey:@"state"] intValue] == 1) {
                         [[userModel sharedUserModel] writeCache:responseObject title:@"RecentFriendsList"];
                         NSArray *array = [self userModel:responseObject];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"getRecentFriendsList" object:array userInfo:nil];
                         return;
                     }
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"getRecentFriendsList" object:nil userInfo:nil];
                 }
                 else if (requestType == changedays){//更改重复天数
                     if ([[responseObject objectForKey:@"state"] intValue] == 1) {
                         if ([BASE isNotNull:[responseObject objectForKey:@"list"]]) {
                             if ([[responseObject objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
                                 if ([[responseObject objectForKey:@"list"] count] == 7) {
                                     NSMutableDictionary *mutableDict =  [[NSMutableDictionary alloc] initWithDictionary:[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION]];
                                     [mutableDict setObject:[responseObject objectForKey:@"list"] forKey:@"array"];
                                     [[userModel sharedUserModel] setUserInformation:mutableDict forKey:LOCAL_NOTIFICATION];
                                     [[LocalNotification sharedLocalNotification] setRepeatWeek:[responseObject objectForKey:@"list"]];//用于显示
                                     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                         [[LocalNotification sharedLocalNotification] setLocalNotification];
                                     });
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"changedays" object:nil];
                                     return;
                                 }
                             }
                         }
                     }
                     if (LANGUAGE_CHINESE) {
                         [liboTOOLS alertViewMSG:[responseObject objectForKey:@"msg"]];
                     }else{
                         [liboTOOLS alertViewMSG:[responseObject objectForKey:@"e_msg"]];
                     }
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"changedays" object:nil];
                 }
                 else if (requestType == deleteUsers){//删除用户
                     
                 }
                 else if (requestType == deleteRecentFriends){//删除最近联系人

                 }
                 else if (requestType == userpropsinfo){//更新拥有道具
                     if ([[responseObject objectForKey:@"state"] intValue] == 1) {
                         if ([BASE isNotNull:[responseObject objectForKey:@"list"]]) {
                             if ([[responseObject objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
                                 [[userModel sharedUserModel] writeCache:responseObject title:@"userpropsinfo"];
                                 NSArray *array = [self propModel:responseObject];
                                 if ([BASE isNotNull:[responseObject objectForKey:@"number"]]) {
                                     [[userModel sharedUserModel] setMyNumber:[responseObject objectForKey:@"number"]];
                                 }else{
                                     [[userModel sharedUserModel] setMyNumber:@"0"];
                                 }
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"getUserPropsInfo" object:array userInfo:nil];
                                 return;
                             }
                         }
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"getUserPropsInfo" object:nil userInfo:nil];
                     }
                 }
                 else if (requestType == gettools){//更新下载道具

                 }
                 else if (requestType == addFriend){//主动添加好友
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"didAddFriend" object:nil userInfo:responseObject];
                     /**
                      state = 1  请求已发送 等待对方同意
                      state = 2  已经是好友
                      state =    未知错误
                      */
                     //等待对方同意
                     if ([[responseObject objectForKey:@"state"] intValue] ==1) {
                         lowooPOPRequestHasBeenSent *addRequest = [[lowooPOPRequestHasBeenSent alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
                         [[lowooAlertViewDemo sharedAlertViewManager] show:addRequest];
                         //已经是好友
                     }else if ([[responseObject objectForKey:@"state"] intValue] == 2){
                         [liboTOOLS alertViewMSG:[BASE International:@"此用户已经是你的好友"]];
                         //其他情况
                     }else{
                         [liboTOOLS alertViewMSG:[BASE International:@"添加好友时出现错误"]];
                     }
                 }
                 else if (requestType == ranking){//好友排行榜
                     if ([[responseObject objectForKey:@"state"] intValue] ==1) {
                         if ([BASE isNotNull:[responseObject objectForKey:@"list"]]) {
                             if ([[responseObject objectForKey:@"list"] isKindOfClass:[NSDictionary class]]) {
                                 if ([BASE isNotNull:[[responseObject objectForKey:@"list"] objectForKey:@"callTimes"]]) {
                                     if ([[[responseObject objectForKey:@"list"] objectForKey:@"callTimes"] isKindOfClass:[NSArray class]]) {
                                         if ([BASE isNotNull:[[responseObject objectForKey:@"list"] objectForKey:@"getupTimes"]]) {
                                             if ([[[responseObject objectForKey:@"list"] objectForKey:@"getupTimes"] isKindOfClass:[NSArray class]]) {
                                                 if ([BASE isNotNull:[[responseObject objectForKey:@"list"] objectForKey:@"inbedTimes"]]) {
                                                     if ([[[responseObject objectForKey:@"list"] objectForKey:@"inbedTimes"] isKindOfClass:[NSArray class]]) {
                                                         [[userModel sharedUserModel] writeCache:responseObject title:@"ranking"];
                                                         [self friendsList:responseObject];
                                                         return;
                                                     }
                                                 }
                                             }
                                         }
                                     }
                                 }
                             }
                         }
                     }
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"getRanking" object:nil userInfo:nil];
                 }
                 else if (requestType == buyprops){//香蕉币购买道具
                     [[activityView sharedActivityView] removeHUD];
                     if ([[responseObject objectForKey:@"state"] intValue] == 1) {
                         if ([BASE isNotNull:[responseObject objectForKey:@"coin"]]) {
                             NSInteger bananaNumber = [[responseObject objectForKey:@"coin"] intValue];
                             [[userModel sharedUserModel] setUserInformation:[responseObject objectForKey:@"coin"] forKey:USER_COIN];
                             [[NSNotificationCenter defaultCenter] postNotificationName:@"buyCoin" object:[NSNumber numberWithInteger:bananaNumber]];
                             [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:userpropsinfo];
                         }
                     }else{
                         [liboTOOLS alertViewMSG:[BASE International:@"购买道具失败"]];
                     }
                 }
                 else if (requestType == weakupFriend){//叫醒好友
                     [[NSNotificationCenter defaultCenter] postNotificationName:MEMORY_ADDRESS object:responseObject userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[postFields objectForKey:MEMORY_ADDRESS], MEMORY_ADDRESS, nil]];
                 }
                 else if (requestType == setcalledtime){//设置被叫时间
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"setcalledtime" object:nil userInfo:responseObject];
                 }
                 else if (requestType == retime){//实时更新时间
                     if ([[responseObject objectForKey:@"state"] intValue] ==1) {
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"didReturnTime" object:nil userInfo:responseObject];
                     }
                 }
                 else if (requestType == uploadpic){//更改头像
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadpic" object:nil userInfo:responseObject];
                 }
                 else if (requestType == gameSuccess){//玩游戏成功    刷新当前金币
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"bananaNumberChange" object:nil userInfo:responseObject];
                 }
                 else if (requestType == achievelist){//个人信息
                     if ([[postFields objectForKey:@"self"] isEqualToString:@"yes"]) {
                         [[userModel sharedUserModel] writeCache:responseObject title:@"achievelist"];
                     }
                     modelUserDetail *user = [[modelUserDetail alloc] init];
                     user.JSONdictionary = responseObject;
                     [[NSNotificationCenter defaultCenter] postNotificationName:MEMORY_ADDRESS object:user userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[postFields objectForKey:MEMORY_ADDRESS], MEMORY_ADDRESS, nil]];
                 }
                 else if (requestType == showstate){//好友状态
                     NSLog(@"%@",responseObject);
                     modelUser *user = [[modelUser alloc] init];
                     user.JSONdictionary = responseObject;
                     [[NSNotificationCenter defaultCenter] postNotificationName:MEMORY_ADDRESS object:user userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[postFields objectForKey:MEMORY_ADDRESS], MEMORY_ADDRESS, nil]];
                 }
                 else if (requestType == transferPhoneBookNumber){//好友电话号码  //libo 正常运行，最后model化
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"transferPhoneBookNumber" object:nil userInfo:responseObject];
                 }
                 else if (requestType == upLoadPhoneNumber){
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"upLoadPhoneNumber" object:nil userInfo:responseObject];
                 }
                 else if (requestType == deletePhoneNumber){//解除绑定手机号
                     if ([[responseObject objectForKey:@"state"] intValue] == 1) {
                         [[userModel sharedUserModel] setUserInformation:@"" forKey:USER_PHONENUMBER];
                     }
                 }
                 else if (requestType == upLoadSinaID){//绑定新浪微博
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"upLoadSinaID" object:nil userInfo:responseObject];
                 }
                 else if (requestType == transferMicrobloggingFriendsID){//好友新浪id
                     if ([[responseObject objectForKey:@"state"] intValue] == 1) {
                         if ([BASE isNotNull:[responseObject objectForKey:@"list"]]) {
                             if ([[responseObject objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"transferMicrobloggingFriendsID" object:[responseObject objectForKey:@"list"] userInfo:nil];
                                 return;
                             }
                         }
                     }
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"transferMicrobloggingFriendsID" object:[[NSArray alloc] init] userInfo:nil];
                 }
                 else if (requestType == modifyMailbox){//更改邮箱
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"modifyMailbox" object:nil userInfo:responseObject];
                 }
                 else if (requestType == changePassWord){//修改密码
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"changePassWord" object:nil userInfo:responseObject];
                 }
                 else if (requestType == RMBbuySuccess){//购买金币成功
                     if ([[responseObject objectForKey:@"state"] intValue] == 1) {
                         if ([BASE isNotNull:[responseObject objectForKey:@"coin"]]) {
                             if ([[responseObject objectForKey:@"coin"] intValue] >= 0) {
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"RMBbuySuccess" object:nil userInfo:responseObject];
                             }
                         }
                     }
                 }
                 else if (requestType == removeFromBlackNameList){//移除黑名单
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"removeFromBlackNameList" object:nil userInfo:responseObject];
                 }
                 else if (requestType == refreshBlackNameList){//黑名单列表
                     if ([[responseObject objectForKey:@"state"] intValue] == 1) {
                         if ([BASE isNotNull:[responseObject objectForKey:@"list"]]) {
                             if ([[responseObject objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
                                 [[userModel sharedUserModel] writeCache:responseObject title:@"refreshBlackNameList"];
                                 NSArray *array = [self userModel:responseObject];
                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshBlackNameList" object:array userInfo:nil];
                             }
                         }
                     }
                 }
                 else if (requestType == backtobed){//赖床
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"bananaNumberChange" object:nil userInfo:responseObject];
                 }
                 else if (requestType == bananaShield){//使用香蕉盾
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"bananaNumberChange" object:nil userInfo:responseObject];
                 }
                 else if (requestType == continuousGetup){//起床成功
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"continuousGetup" object:nil userInfo:responseObject];
                 }
                 else if (requestType == checkUID){//判断id是否已经被注册
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"checkUID" object:nil userInfo:responseObject];
                 }
                 else if (requestType == downloadMusic){//下载音乐
                     
                 }
                 else if (requestType == shareList){//分享列表
                     [[activityView sharedActivityView] removeHUD];
                     if ([[responseObject objectForKey:@"state"] intValue] ==1) {
                         if ([BASE isNotNull:[responseObject objectForKey:@"sharelist"]]) {
                             if ([[responseObject objectForKey:@"sharelist"] isKindOfClass:[NSDictionary class]]) {
                                 if ([BASE isNotNull:[[responseObject objectForKey:@"sharelist"] objectForKey:@"renren"]]) {
                                     if ([BASE isNotNull:[[responseObject objectForKey:@"sharelit"] objectForKey:@"sinaid"]]) {
                                         if ([BASE isNotNull:[[responseObject objectForKey:@"sharelist"] objectForKey:@"weixin"]]) {
                                             [[NSNotificationCenter defaultCenter] postNotificationName:USER_SHARELIST object:nil userInfo:responseObject];
                                             return;
                                         }
                                     }
                                 }
                             }
                         }
                         
                     }
                 }
                 else if (requestType == weiboLogin){//sina登录
                     [[userModel sharedUserModel] writeCache:responseObject title:@"weiboLogin"];
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"weiboLogin" object:nil userInfo:responseObject];
                 }
                 else if (requestType == userInfo){//获取用户信息  //libo state
                     [[userModel sharedUserModel] writeCache:responseObject title:@"userInfo"];
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfo" object:nil userInfo:responseObject];
                 }
                 else if (requestType == forgotPassword){//忘记密码，使用邮箱找回
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"forgotPassword" object:nil userInfo:responseObject];
                 }
                 else if (requestType == foucs){//好友关注  //libo state
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"foucs" object:nil userInfo:responseObject];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFriendList" object:nil];
                 }else if (requestType == offline){
//                     NSLog(@"%@",responseObject);
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 [[activityView sharedActivityView] removeHUD];
                 if (error.code == -1009) {
                     NSDictionary *cache;
                     if (requestType == loginURL) {
                         cache = [[userModel sharedUserModel] getCache:@"doLogin"];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"doLogin" object:nil userInfo:cache];
                     }
                     else if (requestType == refreshFriendList) {
                         cache = [[userModel sharedUserModel] getCache:@"refreshFriendList"];
                         NSArray *array = [self userModel:cache];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"getUserFriendsList" object:array userInfo:nil];
                     }
                     else if (requestType == RecentFriendsList) {
                         cache = [[userModel sharedUserModel] getCache:@"RecentFriendsList"];
                         NSArray *array = [self userModel:cache];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"getRecentFriendsList" object:array userInfo:nil];
                     }
                     else if (requestType == userpropsinfo) {
                         cache = [[userModel sharedUserModel] getCache:@"userpropsinfo"];
                         NSArray *array = [self propModel:cache];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"getUserPropsInfo" object:array userInfo:nil];
                     }
                     else if (requestType == gettools) {
                         //            cache = [[userModel sharedUserModel] getCache:@"gettools"];
                         //            [[NSNotificationCenter defaultCenter] postNotificationName:@"allProps" object:nil userInfo:cache];
                     }
                     else if (requestType == ranking) {
                         cache = [[userModel sharedUserModel] getCache:@"ranking"];
                         [self friendsList:cache];
                     }
                     else if (requestType == achievelist) {
                         if ([[postFields objectForKey:@"self"] isEqualToString:@"yes"]) {
                             cache = [[userModel sharedUserModel] getCache:@"achievelist"];
                             modelUserDetail *user = [[modelUserDetail alloc] init];
                             user.JSONdictionary = cache;
                             [[NSNotificationCenter defaultCenter] postNotificationName:MEMORY_ADDRESS object:user userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[postFields objectForKey:MEMORY_ADDRESS], MEMORY_ADDRESS, nil]];
                         }
                     }
                     else if (requestType == refreshBlackNameList) {
                         cache = [[userModel sharedUserModel] getCache:@"refreshBlackNameList"];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshBlackNameList" object:nil userInfo:cache];
                     }
                     else if (requestType == shareList) {
                         [[activityView sharedActivityView] removeHUD];
                     }
                     else if (requestType == weiboLogin){
                         cache = [[userModel sharedUserModel] getCache:@"weiboLogin"];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"weiboLogin" object:nil userInfo:cache];
                     }
                     else if (requestType == userInfo){
                         cache = [[userModel sharedUserModel] getCache:@"userInfo"];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfo" object:nil userInfo:cache];
                     }else if (requestType == retime){//实时更新时间
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"didReturnTime" object:nil userInfo:nil];
                     }
                 }
             }];
    }
}

- (NSArray *)propModel:(NSDictionary *)responseObject{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *arrayProps = [responseObject objectForKey:@"list"];
    for (int i=0; i<arrayProps.count; i++) {
        modelProp *prop = [[modelProp alloc] init];
        prop.JSONdictionary = [arrayProps objectAtIndex:i];
        [array addObject:prop];
    }
    
    [[userModel sharedUserModel] setMyNumber:[responseObject objectForKey:@"number"]];
    return [NSArray arrayWithArray:array];
}

- (NSArray *)userModel:(NSDictionary *)responseObject{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    if ([BASE isNotNull:[responseObject objectForKey:@"list"]]) {
        if ([[responseObject objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
            NSArray *array = [responseObject objectForKey:@"list"];
            for (int i=0; i<array.count; i++) {
                if ([[array objectAtIndex:i] isKindOfClass:[NSDictionary class]]) {
                    modelUser *user = [[modelUser alloc] init];
                    user.JSONdictionary = [array objectAtIndex:i];
                    [mutableArray insertObject:user atIndex:i];
                }
            }
        }
    }
    return [NSArray arrayWithArray:mutableArray];
}

- (void)friendsList:(NSDictionary *)responseObject{
    NSArray *arrayCalltimes = [[responseObject objectForKey:@"list"] objectForKey:@"callTimes"];
    NSMutableArray *callTimes = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayCalltimes.count; i++) {
        modelUser *user = [[modelUser alloc] init];
        user.JSONdictionary = [arrayCalltimes objectAtIndex:i];
        [callTimes addObject:user];
    }
    NSArray *arrayGetupTimes = [[responseObject objectForKey:@"list"] objectForKey:@"getupTimes"];
    NSMutableArray *getupTimes = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayGetupTimes.count; i++) {
        modelUser *user = [[modelUser alloc] init];
        user.JSONdictionary = [arrayGetupTimes objectAtIndex:i];
        [getupTimes addObject:user];
    }
    NSArray *arrayInbedTimes = [[responseObject objectForKey:@"list"] objectForKey:@"inbedTimes"];
    NSMutableArray *inbedTimes = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayInbedTimes.count; i++) {
        modelUser *user = [[modelUser alloc] init];
        user.JSONdictionary = [arrayInbedTimes objectAtIndex:i];
        [inbedTimes addObject:user];
    }
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSArray arrayWithArray:callTimes], @"call",
                          [NSArray arrayWithArray:getupTimes], @"getup",
                          [NSArray arrayWithArray:inbedTimes], @"lazy", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getRanking" object:dict userInfo:nil];
}

//打印存储目录
- (void)enumerateFilesInFolder:(NSString *)paramPath{
    NSError *error = nil;
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:paramPath error:&error];
    
    if ([contents count]>0 && error==nil) {
        NSLog(@"contents of path %@ = /n %@",paramPath,contents);
    }else if ([contents count]==0){
        
    }else{
        
    }
}

- (BOOL)isExistenceNetwork{
    BOOL isExistenceNetwork = YES;
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            //   NSLog(@"没有网络");
            {
                isExistenceNetwork=NO;
                lowooPOPnetworkError *networkError = [[lowooPOPnetworkError alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                [[lowooAlertViewDemo sharedAlertViewManager] show:networkError];
            }
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=YES;
            //   NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=YES;
            //  NSLog(@"正在使用wifi网络");
            break;
    }
    return isExistenceNetwork;
}





@end
