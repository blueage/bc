//
//  lowooTimeSet.h
//  banana_clock
//
//  Created by MAC on 13-1-6.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBaseView.h"
#import "tableViewPicker.h"


@interface lowooTimeSet : lowooBaseView<tableViewPickerDataSource>

@property (nonatomic, strong) NSString *beginHour;
@property (nonatomic, strong) NSString *beginMinute;
@property (nonatomic, strong) NSString *endHour;
@property (nonatomic, strong) NSString *endMinute;
@property (nonatomic, strong) NSString *stringFather;
@property (nonatomic, strong) UIButton_custom *buttonUp;
@property (nonatomic, strong) UIButton_custom *buttonDown;
@property (nonatomic, strong) UIImageView *imageViewUp;
@property (nonatomic, strong) UIImageView *imageViewDown;
@property (nonatomic, strong) UILabel *labelUpChinese;
@property (nonatomic, strong) UILabel *labelUpChineseEnglish;
@property (nonatomic, strong) UILabel *labelUpEnglish;
@property (nonatomic, strong) UILabel *labelDownChinese;
@property (nonatomic, strong) UILabel *labelDownChineseEnglish;
@property (nonatomic, strong) UILabel *labelDownEnglish;

@property (nonatomic, strong) UILabel *labelUpTime;
@property (nonatomic, strong) UILabel *labelDownTime;
@property (nonatomic, strong) tableViewPicker *picker1;
@property (nonatomic, strong) tableViewPicker *picker2;

@property (nonatomic, strong) UIView *viewBaseLeft;
@property (nonatomic, strong) UIView *viewBaseRight;

@property (nonatomic, strong) UIView *viewMove;
@property (nonatomic, strong) UIView *viewMove1;
@property (nonatomic, strong) UIImageView *imageViewBack;

- (void)confirmDateWithStart:(NSInteger )start Stop:(NSInteger )stop;
- (void)setTime;

@end
