//
//  lowooHTTPManager.h
//  banana clock
//
//  Created by MAC on 12-9-18.
//  Copyright (c) 2012年 MAC. All rights reserved.
//http://banana.low/

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "JSON.h"
#import "AFNetworking.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import "Reachability.h"


#define PATH_PLIST_PROP             [[NSBundle mainBundle]pathForResource:@"prop" ofType:@"plist"]//先在Supporting Files中建立此字典
///var/mobile/Applications/6AE42438-B156-4759-9A54-C82BE9195E1C/banana_clock.app/prop.plist
///var/mobile/Applications/1EED2327-7FA9-4027-A0A7-BFD6E7B9B217/Documents/prop.plist
#define PATH                        [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
///var/mobile/Applications/6AE42438-B156-4759-9A54-C82BE9195E1C/Documents
#define PATHS                       [NSHomeDirectory() stringByAppendingString:@"Documents"]
///var/mobile/Applications/6AE42438-B156-4759-9A54-C82BE9195E1CDocuments


#define USER_INFO_KEY_TYPE          @"requestType"
#define BananaNUM                   @"bananaNumber"
#define EXPIRATION_DATE             @"expirationDate"//登录时得到的有效期


typedef enum {
    loginURL = 0,//登录URL
    userRegist, //注册URL
    offline,//用户退出
    
    ranking,//好友排行榜
    refreshFriendList,//获取用户好友列表
    RecentFriendsList,//最近联系人列表
    applayFriendRequest,//同意好友请求
    ignoreFriendRequest,//拒绝好友请求
    removeFromBlackNameList,//移除黑名单
    searchUser, //搜索用户
    addFriend,//添加好友
    deleteUsers,//删除好友
    deleteRecentFriends,//删除最近联系人
    
    buyprops,//香蕉币购买道具
    showstate,//单独获取某位好友的状态
    weakupFriend,//叫醒 推送
    changedays,//更改重复天数
    userpropsinfo,//获取用户道具列表
    setcalledtime,//设置被叫时间
    continuousGetup,//连续起床
    bananaShield,//使用香蕉盾
    gameSuccess,//玩游戏成功
    gameFailed,//游戏失败
    retime,//实时调用更新时间
    uploadpic,//更改头像
    
    achievelist,//个人信息
    gettools,//下载道具
    backtobed,//赖床
    
    upLoadSinaID,//上传sinaID  绑定微博
    transferMicrobloggingFriendsID,//传递并验证sina好友是否为app用户
    upLoadPhoneNumber,//绑定手机号
    deletePhoneNumber,//解除绑定手机号
    deleteSinaID,//解除新浪绑定
    transferPhoneBookNumber,//上传并验证通讯录好友
    modifyMailbox,//更改邮箱
    changePassWord,//修改密码
    RMBbuySuccess,//购买金币成功
    refreshBlackNameList,//黑名单列表
    checkUID,//判断id是否已经被注册
    downloadMusic,//下载声音文件
    moon_sun,//是否可叫
    //localCall,//闹铃
    shareList,//分享
    weiboLogin,//sina登录
    userInfo,//获取好友信息
    forgotPassword,//忘记密码
    foucs,//是否关注好友
    newFriendList,//新版好友列表
}RequestType;



@interface lowooHTTPManager : NSObject

@property (nonatomic, strong) NSDictionary *returnDict;//请求后返回的数据
@property (nonatomic, strong) NSOperationQueue *requestQueue;
@property (nonatomic, strong) NSMutableDictionary *mutableDictionaryProps;
@property (nonatomic, strong) NSDictionary *dictionaryProps;
@property (nonatomic, strong) NSMutableDictionary *musicDict;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;



- (id)init;

+ (lowooHTTPManager *) getInstance;

- (void)doHTTPRequestWithPostFields:(NSDictionary *)postFields requestType:(RequestType)requestType;
- (NSArray *)userModel:(NSDictionary *)responseObject;
- (NSArray *)propModel:(NSDictionary *)responseObject;
- (BOOL)isExistenceNetwork;


@end
