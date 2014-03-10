//
//  settingSectionCell.h
//  banana_clock
//
//  Created by MAC on 13-7-19.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "baseCell.h"


@interface settingSectionCell : baseCell

@property (nonatomic, strong) UIButton_custom *button;
@property (nonatomic, strong) UIImageView *imageViewIcon;
@property (nonatomic, strong) UILabel *labelChinese;
@property (nonatomic, strong) UILabel *labelEnglish;
@property (nonatomic, strong) UILabel *labelDay;
@property (nonatomic, strong) UIImageView *imageViewjiantou;

@property (nonatomic, strong) UILabel *labelEG;

- (void)confirmData;

@end
