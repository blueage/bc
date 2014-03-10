//
//  lowooFriendsListCell.h
//  banana_clock
//
//  Created by MAC on 12-12-25.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface lowooFriendsListCell : UITableViewCell


@property (strong, nonatomic) UIImageView *imageViewBackgound;
@property (nonatomic, strong) UIView *viewListNumber;
@property (nonatomic, strong) UIView *viewNumber;
@property (strong, nonatomic) UIImageView_custom *imageViewHeadGetup;
@property (strong, nonatomic) UIImageView_custom *imageViewHeadLazy;
@property (strong, nonatomic) UIImageView_custom *imageViewHeadCall;
@property (nonatomic, strong) UILabel *labelGetup;
@property (nonatomic, strong) UILabel *labelLazy;
@property (nonatomic, strong) UILabel *labelCall;



- (void)confirmUserGetup:(modelUser *)userGetup UserLazy:(modelUser *)userLazy UserCall:(modelUser *)userCall;
- (void)setListNumber:(NSInteger )number;


@end
