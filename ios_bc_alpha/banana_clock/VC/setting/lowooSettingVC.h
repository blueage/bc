//
//  lowooSettingVC.h
//  banana clock
//
//  Created by MAC on 12-9-26.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lowooPersonalDetails.h"
#import "lowooBaseView.h"
#import "lowooAboutBananaClock.h"
#import "lowooTwo-dimensionCodeCard.h"
#import "lowooBlackList.h"
#import "lowooAppSetting.h"
#import "viewIntroduceButton.h"
#import "systemBoot.h"

@interface lowooSettingVC : lowooBaseView<lowooPersonalDetailsDelegate,lowooPersonalDetailsDataSource>

@property (nonatomic, strong) UIButton_custom *buttonLogOut;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) viewIntroduceButton *viewIntroduceButtonProfile;
@property (nonatomic, strong) viewIntroduceButton *viewIntroduceButtonQR;
@property (nonatomic, strong) viewIntroduceButton *viewIntroduceButtonAccount;
@property (nonatomic, strong) viewIntroduceButton *viewIntroduceButtonBlackList;
@property (nonatomic, strong) viewIntroduceButton *viewIntroduceButtonNotifications;
@property (nonatomic, strong) viewIntroduceButton *viewIntroduceButtonSetting;
@property (nonatomic, strong) viewIntroduceButton *viewIntroduceButtonBananaStory;
@property (nonatomic, strong) viewIntroduceButton *viewIntroduceButtonAbout;
@property (nonatomic, strong) systemBoot *boot;

@property (nonatomic, strong) lowooPersonalDetails *personalDetails;

@end
