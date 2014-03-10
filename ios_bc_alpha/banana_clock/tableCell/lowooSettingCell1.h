//
//  lowooSettingCell1.h
//  banana clock
//
//  Created by MAC on 12-10-9.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseCell.h"

@protocol lowooSettingCell1Delegate <NSObject>
- (void)settingCell1ButtonTouchUpInsideWithTag:(NSInteger )tag;
@end



@interface lowooSettingCell1 : baseCell

@property (nonatomic, weak) id<lowooSettingCell1Delegate>delegate;
@property (nonatomic, strong) UIButton_custom *button;
@property (nonatomic, strong) UIImageView *imageViewIcon;
@property (nonatomic, strong) UILabel *labelChinese;
@property (nonatomic, strong) UILabel *labelEnglish;
@property (nonatomic, strong) UILabel *labelDay;
@property (nonatomic, assign) CGRect labelDayFrame;
@property (nonatomic, assign) CGRect labelDayFrameBig;

//@property (nonatomic, strong) UIImageView *imageViewjiantou;

@property (nonatomic, strong) UILabel *labelEG;

//- (void)setImageViewjiantouNil;

@end
