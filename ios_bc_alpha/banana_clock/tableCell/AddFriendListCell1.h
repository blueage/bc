//
//  AddFriendListCell1.h
//  banana_clock
//
//  Created by MAC on 13-8-11.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THLabel.h"
#import "lowooHTTPManager.h"

@protocol AddFriendListCell1Delegate <NSObject>
- (void)buttonAddTouchUpInside:(UIButton_custom *)sender;
@end

@interface AddFriendListCell1 : UITableViewCell

@property (nonatomic, weak) id<AddFriendListCell1Delegate>delegate;
@property (nonatomic, strong) UIImageView_custom *imageViewHead;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIImageView *imageViewState;
@property (nonatomic, strong) UIButton_custom *buttonAddfriend;
@property (nonatomic, strong) UIImageView *imageViewExclamation;
@property (nonatomic, strong) THLabel *labelExclamation;



- (void)confirmUser:(modelUser *)user;
- (void)cancelTouch;


@end
