//
//  lowooSinaWeibo.h
//  banana_clock
//
//  Created by MAC on 14-1-11.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "sinaCell.h"
#import "lowooShareWeibo.h"
@class lowooSinaWeibo;

@protocol lowooSinaWeiboDelegate <NSObject>
@optional
- (void)SinaLogIn:(NSDictionary *)dictionary;
- (void)sinaLogInDidCancel:(lowooSinaWeibo *)sina;
- (void)sinaWeiboLoginFaild:(lowooSinaWeibo *)sina;
- (void)sinaGetUserFriendsList:(NSDictionary *)dictionary;
@end

@interface lowooSinaWeibo : NSObject<SinaWeiboDelegate,SinaWeiboRequestDelegate>

@property (nonatomic, assign) id<lowooSinaWeiboDelegate>delegate;
@property (nonatomic, retain) NSDictionary *dictionarySinaUserInfo;
@property (nonatomic, retain) NSDictionary *dictionarySinaUserFriendsList;
@property (nonatomic, retain) NSMutableArray *mutableArrayUserFriendsList;
@property (nonatomic, retain) NSMutableArray *mutableArrayUser;
@property (nonatomic, retain) lowooShareWeibo *share;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL boolDataSourceIsLoading;
@property (nonatomic, assign) BOOL boolAllLoaded;
@property (nonatomic, assign) int cursor;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) BOOL boolappuser;//先动画生成app好友，再从新刷新出所有sina好友
@property (nonatomic, strong) NSMutableDictionary *mutableDict;
@property (nonatomic, strong) UIView *aview;


- (void)doMicrobloggingCertification;
- (void)postWeibo:(NSString *)title;
- (void)postWeibo:(NSString *)title picture:(UIImage *)image;
- (void)postWeibo:(NSString *)text pictureUrl:(NSString *)url;
- (void)logout;
- (void)userInfo;

- (void)getSinaFriendsList:(int )cursor;

@end
