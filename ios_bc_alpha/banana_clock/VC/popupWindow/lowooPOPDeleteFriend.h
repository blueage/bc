//
//  lowooPOPDeleteFriend.h
//  banana_clock
//
//  Created by MAC on 13-3-8.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"


@protocol lowooPOPDeleteFriendDelegate <NSObject>
- (void)buttonDeleteFriendTouchUpinsideWithentity:(UIView *)entity;
@end


@interface lowooPOPDeleteFriend : popView

@property (nonatomic, weak) id<lowooPOPDeleteFriendDelegate>delegate;
@property (nonatomic, strong) UIButton_custom *buttonCancel;









@end
