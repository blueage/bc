//
//  lowooSettingCell3.h
//  banana_clock
//
//  Created by MAC on 13-1-21.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseCell.h"


@interface lowooSettingCell3 : baseCell


@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;
@property (nonatomic, strong) UIImageView *imageViewICON;

@property (nonatomic, strong) UILabel *labelEG1;
@property (nonatomic, strong) UILabel *labelEG2;
@property (nonatomic, strong) UILabel *labelEG3;

@property (nonatomic, strong) UIView *outerview;

@property (strong, nonatomic) UIImageView *imageViewBackground;
@property (nonatomic, strong) UIImageView_custom *imageViewIcon;
@property (nonatomic, strong) NSString *stringtemp;

- (void)confirmData:(modelAchievement *)achieve;




@end
