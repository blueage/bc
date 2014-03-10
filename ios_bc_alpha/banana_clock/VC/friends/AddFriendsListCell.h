//
//  AddFriendsListCell.h
//  banana_clock
//
//  Created by MAC on 12-12-18.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THLabel.h"


@protocol AddFriendsListCellDelegate <NSObject>
- (void)buttonAddTouchUpInside:(UIButton_custom *)sender;
@end


@interface AddFriendsListCell : UITableViewCell


@property (nonatomic, weak) id<AddFriendsListCellDelegate>delegate;
@property (nonatomic, strong) UIImageView_custom *imageViewHead;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIImageView *imageViewState;
@property (nonatomic, strong) UIButton_custom *buttonAddfriend;
@property (nonatomic, strong) UIImageView *imageViewExclamation;
@property (nonatomic, strong) THLabel *labelExclamation;



- (void)confirmDataWithUser:(modelUser *)user;

@end
