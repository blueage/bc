//
//  lowooBlackCell.h
//  banana_clock
//
//  Created by MAC on 13-3-18.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol lowooBlackCellDelegate <NSObject>

- (void)blackCellButtonTouchUpInside:(UIButton_custom *)sender;

@end

@interface lowooBlackCell : UITableViewCell

@property (nonatomic, weak) id<lowooBlackCellDelegate>delegate;
@property (nonatomic, strong) UIImageView_custom *imageViewHead;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIButton_custom *button;

- (void)confirmUser:(modelUser *)user;



@end
