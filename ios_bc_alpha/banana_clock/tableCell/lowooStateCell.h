//
//  lowooStateCell.h
//  banana_clock
//
//  Created by MAC on 12-12-17.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THLabel.h"



@class lowooStateCell;
@protocol lowooStateCellDelegate <NSObject>
@optional
- (void)buttonHeadDidTouchUpInside:(NSIndexPath *)indexPath;
- (void)buttonStateAction:(UIButton_custom *)button Name:(NSString *)name indexPath:(NSIndexPath *)indexPath;
- (void)cellDidSelectDelete:(lowooStateCell *)cell;
@end

extern NSString *const LowooStateCellShouldHideMenuNotification;

@interface lowooStateCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<lowooStateCellDelegate>delegate;
@property (nonatomic, strong) UIView *viewCellBase;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) NSString *stringUid;
@property (strong, nonatomic) UIButton_custom *buttonState;
@property (strong, nonatomic) UIButton_custom *buttonHead;
@property (nonatomic, strong) UIImageView *imageViewState;
@property (nonatomic, strong) THLabel *labelState;
@property (nonatomic, strong) UIImageView_custom *imageViewHead;
@property (nonatomic, strong) UIImageView *imageViewFoucs;//关注
@property (nonatomic, strong) UIView *viewMedal;
@property (nonatomic, strong) UIImageView *imageViewMedal;//勋章
@property (nonatomic, strong) UIImageView *imageViewMoss;//青苔
@property (nonatomic, strong) UIView *viewHead;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRight;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) BOOL boolScrollToLeft;

-(void)stateCellConfirmDataWithDictionary:(modelUser *)user;//叫醒页，和好友页

- (void)confirmMedal:(NSArray *)sender;






@end
