//
//  SinaBinding.h
//  banana_clock
//
//  Created by MAC on 13-7-31.
//  Copyright (c) 2013年 MAC. All rights reserved.
//
#import "RegexKitLite.h"
#import "lowooBaseView.h"
#import "lowooSinaWeibo.h"

@interface SinaBinding : lowooBaseView<UITextFieldDelegate,lowooSinaWeiboDelegate>



@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *labelPrompt;
@property (nonatomic, strong) UIButton_custom *buttonBinding;
@property (nonatomic, strong) UIButton_custom *buttonUnbind;
@property (nonatomic, strong) UIImageView *imageview;

@property (nonatomic, assign) BOOL boolbinding;
@property (nonatomic, strong) NSString *phoneNumber;


@property (nonatomic, strong) lowooSinaWeibo *sina;




@end
