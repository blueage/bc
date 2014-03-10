//
//  lowooSinaWeibo.m
//  banana_clock
//
//  Created by MAC on 14-1-11.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "lowooSinaWeibo.h"
#import "lowooAppDelegate.h"

@implementation lowooSinaWeibo

#pragma mark ----------- 进行微博授权 ------------
- (void)doMicrobloggingCertification{
    [_dictionarySinaUserInfo release],_dictionarySinaUserInfo = nil;
    SinaWeibo *sinaWeibo = [self sinaWeibo];
    [sinaWeibo logIn];
}

#pragma mark--------sinaWeiboDelegate 新浪认证成功 --------
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    [self storeAuthData];
    [self userInfo];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error{
    if ([_delegate respondsToSelector:@selector(sinaWeiboLoginFaild:)]) {
        [_delegate sinaWeiboLoginFaild:self];
    }
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error{
    if ([_delegate respondsToSelector:@selector(sinaWeiboLoginFaild:)]) {
        [_delegate sinaWeiboLoginFaild:self];
    }
}

#pragma mark ----------- 获取个人信息 ----------------
- (void)userInfo{
    SinaWeibo *sinaweibo = [self sinaWeibo];
    [sinaweibo requestWithURL:@"users/show.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
}

#pragma mark ----------- 获取sina微博好友列表 ------------
- (void)getSinaFriendsList:(int )cursor{
    SinaWeibo *sinaWeibo = [self sinaWeibo];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData]) {
        sinaWeibo.userID = [[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_userIDKey];
        sinaWeibo.accessToken = [[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_accessTokenKey];
        sinaWeibo.expirationDate = [[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_expirationDateKey];
        [sinaWeibo requestWithURL:@"friendships/friends.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys: sinaWeibo.userID, @"uid",  @"50", @"count", [NSString stringWithFormat:@"%d",cursor], @"cursor", nil]
                       httpMethod:@"GET"
                         delegate:self];
    }
}

#pragma mark ----------- 发微博 -----------------
- (void)postWeibo:(NSString *)title{
    SinaWeibo *sinaWeibo = [self sinaWeibo];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData]) {
        sinaWeibo.userID = [[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_userIDKey];
        sinaWeibo.accessToken = [[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_accessTokenKey];
        sinaWeibo.expirationDate = [[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_expirationDateKey];
        
        //        [sinaWeibo requestWithURL:@"statuses/update.json"
        //                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:title,@"status", nil]
        //                       httpMethod:@"POST"
        //                         delegate:self];
        
        [sinaWeibo requestWithURL:@"statuses/upload.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:title,@"status",GetJpgImage(@"weixinShare"),@"pic", nil]
                       httpMethod:@"POST"
                         delegate:self];
    }
}

#pragma mark ----------- 发微博图片 -----------------
- (void)postWeibo:(NSString *)title picture:(UIImage *)image{
    SinaWeibo *sinaWeibo = [self sinaWeibo];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData]) {
        sinaWeibo.userID = [[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_userIDKey];
        sinaWeibo.accessToken = [[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_accessTokenKey];
        sinaWeibo.expirationDate = [[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_expirationDateKey];
        
        
        [sinaWeibo requestWithURL:@"statuses/upload.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:title,@"status",image,@"pic", nil]
                       httpMethod:@"POST"
                         delegate:self];
    }
}

#pragma mark ----------- 发微博图片地址 -----------------
- (void)postWeibo:(NSString *)text pictureUrl:(NSString *)url{
    SinaWeibo *sinaWeibo = [self sinaWeibo];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData]) {
        sinaWeibo.userID = [[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_userIDKey];
        sinaWeibo.accessToken = [[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_accessTokenKey];
        sinaWeibo.expirationDate = [[[NSUserDefaults standardUserDefaults] objectForKey:sina_weibo_authData ] objectForKey:sina_expirationDateKey];
        
        
        [sinaWeibo requestWithURL:@"statuses/upload_url_text.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys: text, @"status", url,@"url", nil]
                       httpMethod:@"POST"
                         delegate:self];
    }
}

#pragma mark ------------ sina -----------------
- (SinaWeibo *)sinaWeibo{
    lowooAppDelegate *delegate = (lowooAppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.sinaWeibo.delegate = self;
    return delegate.sinaWeibo;
}

#pragma mark ----------  存储新浪ID -------
- (void)storeAuthData{
    SinaWeibo *sinaWeibo = [self sinaWeibo];
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaWeibo.accessToken,sina_accessTokenKey,
                              sinaWeibo.expirationDate,sina_expirationDateKey,
                              sinaWeibo.userID,sina_userIDKey,
                              sinaWeibo.refreshToken,sina_refresh_token, nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:sina_weibo_authData];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark ------------ 本机注销微博 --------
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    [self removeAuthData];
    [[userModel sharedUserModel] setUserInformation:@"" forKey:SINA_NAME];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sianLogOut" object:nil userInfo:nil];
}

#pragma mark ------------ 取消微博授权 -------------
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo{
    if ([_delegate respondsToSelector:@selector(sinaLogInDidCancel:)]) {
        [_delegate sinaLogInDidCancel:self];
    }
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:sina_weibo_authData];
}

//解除绑定
- (void)logout{
    SinaWeibo *sinaWeibo = [self sinaWeibo];
    [sinaWeibo logOut];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:sina_weibo_authData];
}



#pragma mark ------------ 新浪请求返回结果 ------------
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    [liboTOOLS dismissHUD];
    //个人信息，取得昵称
    if ([request.url hasSuffix:@"users/show.json"]) {
        [_dictionarySinaUserInfo release];
        _dictionarySinaUserInfo = [result retain];
        //本地存储
        [[userModel sharedUserModel] setUserInformation:[_dictionarySinaUserInfo objectForKey:@"idstr"] forKey:USER_SINA_ID];
        [[userModel sharedUserModel] setUserInformation:[_dictionarySinaUserInfo objectForKey:@"name"] forKey:SINA_NAME];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hasGotSinaAuthorize" object:nil userInfo:_dictionarySinaUserInfo];
        
        //绑定新浪微博
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:[_dictionarySinaUserInfo objectForKey:@"id"], @"sinaid", [_dictionarySinaUserInfo objectForKey:@"screen_name"], @"sinaName", nil]  requestType:upLoadSinaID];
        
        if ([_delegate respondsToSelector:@selector(SinaLogIn:)]) {
            [_delegate SinaLogIn:result];
        }
    }
    //好友信息
    if ([request.url hasSuffix:@"friendships/friends.json"]) {
        if ([_delegate respondsToSelector:@selector(sinaGetUserFriendsList:)]) {
            [_delegate sinaGetUserFriendsList:result];
        }
    }
    
    
    
    /**通知后台服务器，已经分享了app
     转入购买页统一处理
     **/
    if ([request.url hasSuffix:@"statuses/update.json"]) {//文本
    }
    if ([request.url hasSuffix:@"statuses/upload.json"]) {//文本+图片
        if ([result objectForKey:@"error"]) {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"发布失败" message:[result objectForKey:@"error"] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alertview show];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sianShare" object:nil];
        }
        
    }
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    //[liboTOOLS alertViewMSG:@"接口格式错误"];
    if ([request.url hasSuffix:@"users/show.json"])
    {
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
    }
    // [statuses release], statuses = nil;
}



@end
