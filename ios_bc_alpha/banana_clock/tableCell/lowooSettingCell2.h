//
//  lowooSettingCell2.h
//  banana clock
//
//  Created by MAC on 12-10-9.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseCell.h"
#import "achievementView.h"

@protocol lowooSettingCell2Delegate <NSObject>
- (void)rotateWithIndexPath:(NSIndexPath *)indexPath;
- (void)buttonMedalTouchUpInside:(UIButton_custom *)sender;
@end


@interface lowooSettingCell2 : baseCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<lowooSettingCell2Delegate>delegate;
@property (nonatomic) BOOL boolExpanded;
@property (strong, nonatomic) UIImageView *imageviewBackground;
@property (strong, nonatomic) UIButton_custom *buttonExpand;
@property (strong, nonatomic) UIView *viewMove;
@property (nonatomic, strong) UIView *viewAchievement;
@property (strong, nonatomic) UIView *viewMask;
@property (strong, nonatomic) UIView *viewTriangle;
@property (nonatomic, strong) UIImageView *imageViewSanjiao1;
@property (nonatomic, strong) UIImageView *imageViewSanjiao2;
@property (nonatomic, strong) UIButton_custom *buttonMedal;
@property (nonatomic, strong) UIImageView *imageViewOne;
//@property (nonatomic, strong) UIView *aview;
@property (nonatomic, strong) UIView *viewDown;
@property (nonatomic, strong) UIImageView *imageViewDownBack;

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;
@property (nonatomic, strong) UILabel *label5;
@property (nonatomic, strong) NSMutableArray *arrayLabel;

@property (nonatomic, strong) UILabel *labelEG1;
@property (nonatomic, strong) UILabel *labelEG2;
@property (nonatomic, strong) UILabel *labelEG3;

@property (nonatomic, strong) modelMedal *medal;

- (void)rotateExpandButton:(UIButton_custom *)sender;
- (void)determineTheStatus;

- (void)confirmDataWithMedal:(modelMedal *)medal withIndex:(NSInteger )index Expanded:(BOOL)expand;




@end
