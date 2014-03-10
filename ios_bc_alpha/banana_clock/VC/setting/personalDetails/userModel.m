//
//  userModel.m
//  banana_clock
//
//  Created by MAC on 13-8-29.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "userModel.h"
#import "lowooSina.h"
#import <RennSDK/RennSDK.h>
#import "lowooLoginVC.h"
#import "lowooGame.h"
#import "JSONKit.h"
#import "JSON.h"
#import "lowooAppDelegate.h"

@interface userModel ()

@end


@implementation userModel

+ (id)sharedUserModel{

    static userModel *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[self alloc] init];
    });
    return model;
}

- (id)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}

- (void)setMyNumber:(NSString *)myNumber{
    _myNumber = myNumber;
}

- (id)getCache:(NSString *)title{
    //return Nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [paths objectAtIndex:0];
    NSString *path = [document stringByAppendingPathComponent:@"cache.plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];

    if ([dict objectForKey:USER_ID]) {
        if ([[dict objectForKey:USER_ID] isEqualToString:USERID]) {
            NSDictionary *dictUID = [dict objectForKey:@"data"];
            if ([dictUID objectForKey:title]) {
                NSString *jsonString = [dictUID objectForKey:title];
                SBJsonParser *parser = [[SBJsonParser alloc]init];
                id param = [parser objectWithString:jsonString];
                if ([param isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dictionary = param;
                    return dictionary;
                }else if ([param isKindOfClass:[NSArray class]]){
                    NSArray *array = param;
                    return array;
                }
            }
        }
    }
    return nil;
}

/**
 id -> USER_ID
 data - > dict
 */

- (void)writeCache:(id)data title:(NSString *)title{
    NSString *jsonString = [data JSONString];
    if (![BASE isNotNull:USERID]||![BASE isNotNull:data]) {
        return;
    }
    @autoreleasepool {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *document = [paths objectAtIndex:0];
        NSString *path = [document stringByAppendingPathComponent:@"cache.plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];

        NSMutableDictionary *mutableUID = [NSMutableDictionary dictionaryWithDictionary:dict];
        NSMutableDictionary *mutableData;
        if ([mutableUID objectForKey:USER_ID]) {//存在ID
            if ([[mutableUID objectForKey:USER_ID] isEqualToString:USERID]) {//id相同即取字典，否则从新生成空字典
                if ([mutableUID objectForKey:USER_ID] && [mutableUID objectForKey:@"data"] && [[mutableUID objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                    mutableData = [NSMutableDictionary dictionaryWithDictionary:[mutableUID objectForKey:@"data"]];
                }else{
                    mutableData = [[NSMutableDictionary alloc] init];
                }
                
            }else{//不是同一个ID 将数据清空
                mutableData = [[NSMutableDictionary alloc] init];
                [mutableUID setObject:USERID forKey:USER_ID];
                [[NSDictionary dictionaryWithDictionary:mutableData] writeToFile:path atomically:YES];
            }
        }else{//不存在ID从新生成
            mutableData = [[NSMutableDictionary alloc] init];
            [mutableUID setObject:USERID forKey:USER_ID];
            [[NSDictionary dictionaryWithDictionary:mutableData] writeToFile:path atomically:YES];
        }
        
        [mutableData setObject:jsonString forKey:title];
        
        NSDictionary *dictData = [NSDictionary dictionaryWithDictionary:mutableData];
        [mutableUID setObject:dictData forKey:@"data"];
        NSDictionary *dictUID = [NSDictionary dictionaryWithDictionary:mutableUID];
        [dictUID writeToFile:path atomically:YES];
    }
}

- (id)getUserInformationWithKey:(NSString *)key{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"userInformation"]) {
        NSDictionary *dictionary = [[NSDictionary alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:@"userInformation"];
    }
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInformation"];
    if ([dictionary objectForKey:key]) {
        return [dictionary objectForKey:key];
    }
    return nil;
}

- (void)setUserInformation:(id)value forKey:(NSString *)key{
    if ([BASE isNotNull:value]) {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"userInformation"]) {
            NSDictionary *dictionary = [[NSDictionary alloc] init];
            [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:@"userInformation"];
        }
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInformation"]];
        [dictionary setObject:value forKey:key];//////////////
        [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:dictionary] forKey:@"userInformation"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)bananaUserLogout{
    NSURL *url = [NSURL URLWithString:@"http://bc.lowoo.cc/index.php?option=com_bcuser&task=logout"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        data = nil;
    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autoLogin"] isEqualToString:@"sina"]) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:USER_UID];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithObjectsAndKeys: nil] forKey:@"userInformation"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"autoLogin"];
    
    
    lowooSinaWeibo *sina = [[lowooSinaWeibo alloc] init];
    [sina logout];
    //解除绑定
    [RennClient initWithAppId:renrenAPPID apiKey:renrenAPPKEY secretKey:renrenSecretKey];
    if ([RennClient isLogin]) {
        [RennClient logoutWithDelegate:nil];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"offline" object:nil];
    LOWOO_APP(app);
//    app.navTabBarController = nil;
//
//    
//    lowooLoginVC *loginVC = [[lowooLoginVC alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
//    nav.viewControllers = @[loginVC];
//    [app.window setRootViewController:nav];
    
    [app changeVC:0];
}




//libo----------- self. 死循环
//- (void)setBoolWeixin:(NSString *)boolWeixin{
//    _boolWeixin = boolWeixin;
//}
//- (void)setBoolWeibo:(NSString *)boolWeibo{
//    _boolWeibo = boolWeibo;
//}
//- (void)setBoolRenren:(NSString *)boolRenren{
//    _boolRenren = boolRenren;
//}




@end
