//
//  userModel.h
//  banana_clock
//
//  Created by MAC on 13-8-29.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userModel : NSObject

//@property (nonatomic, strong) NSArray *arrayProps;
@property (nonatomic, strong) NSString *myNumber;


@property (nonatomic, strong) NSString *localNotificationSound;


+ (id)sharedUserModel;
- (void)setMyNumber:(NSString *)myNumber;
- (id)getCache:(NSString *)title;
- (void)writeCache:(id)data title:(NSString *)title;
- (void)bananaUserLogout;

- (id)getUserInformationWithKey:(NSString *)key;
- (void)setUserInformation:(id )value forKey:(NSString *)key;

@end
