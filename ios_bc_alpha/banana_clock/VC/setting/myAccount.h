//
//  myAccount.h
//  banana_clock
//
//  Created by MAC on 13-7-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBaseView.h"
#import "viewIntroduceButton.h"
#import "lowooChangePassword.h"

@interface myAccount : lowooBaseView




@property (nonatomic, strong) viewIntroduceButton *buttonEmail;
@property (nonatomic, strong) viewIntroduceButton *buttonSina;
@property (nonatomic, strong) viewIntroduceButton *buttonPhoneNumber;
@property (nonatomic, strong) viewIntroduceButton *buttonPassword;

@property (nonatomic, strong) UILabel *labelEmail;
@property (nonatomic, strong) UILabel *labelSina;
@property (nonatomic, strong) UILabel *labelPhoneNumber;
@property (nonatomic, strong) UILabel *labelPassword;

@property (nonatomic, assign) BOOL boolSina;
@property (nonatomic, assign) BOOL boolPhoneNumber;




@end
