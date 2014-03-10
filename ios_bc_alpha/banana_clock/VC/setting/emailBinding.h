//
//  emailBinding.h
//  banana_clock
//
//  Created by MAC on 13-7-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//
#import "RegexKitLite.h"
#import "lowooBaseView.h"

@interface emailBinding : lowooBaseView<UITextFieldDelegate>



@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *labelPrompt;
@property (nonatomic, strong) UIImageView *imageview;

@property (nonatomic, assign) BOOL boolbinding;
@property (nonatomic, strong) NSString *email;


@end
