//
//  lowooPOPFriendsAddRequest.h
//  banana_clock
//
//  Created by MAC on 13-3-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lowooHTTPManager.h"
#import "popView.h"


@protocol lowooPOPFriendsAddRequestDelegate <NSObject>
- (void)buttonFriendsAddRequestTouchUpinsideWithentity:(UIView *)entity;
@end



@interface lowooPOPFriendsAddRequest : popView


@property (nonatomic, weak) id<lowooPOPFriendsAddRequestDelegate>delegate;
@property (nonatomic, strong) UIButton_custom *buttonRefuse;
@property (nonatomic, strong) UIButton_custom *buttonBlack;


@property (nonatomic, strong) UIImageView *imageViewAvatarBackground;
@property (nonatomic, strong) UIImageView_custom *imageViewAvatar;
@property (nonatomic, strong) UILabel *labelName;


- (void)confirmDataWithUser:(modelUser *)user;
@property (nonatomic, copy)  NSString *stringfid;

@end
