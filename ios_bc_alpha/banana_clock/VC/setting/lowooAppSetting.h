//
//  lowooAppSetting.h
//  banana_clock
//
//  Created by MAC on 13-3-18.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBaseView.h"
#import "viewIntroduceButton.h"

@interface lowooAppSetting : lowooBaseView


@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UISwitch *switchSound;
@property (nonatomic, strong) UISwitch *switchHelp;
@property (nonatomic, strong) UISwitch *switchMove;
@property (nonatomic, strong) UIButton_custom *buttonInternational;


@property (nonatomic, assign) CGRect framScrollView;
@property (nonatomic, assign) CGRect framLanguage;
@property (nonatomic, strong) UIView *viewlanguage;

@property (nonatomic, strong) viewIntroduceButton *viewButtonSound;
@property (nonatomic, strong) viewIntroduceButton *viewButtonHelp;
@property (nonatomic, strong) viewIntroduceButton *viewButtonInternational;
@property (nonatomic, strong) viewIntroduceButton *viewButtonMove;

@property (nonatomic, strong) viewIntroduceButton *viewButtonChinese;
@property (nonatomic, strong) viewIntroduceButton *viewButtonEnglish;


@end
