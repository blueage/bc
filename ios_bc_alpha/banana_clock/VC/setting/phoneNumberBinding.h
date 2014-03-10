//
//  phoneNumberBinding.h
//  banana_clock
//
//  Created by MAC on 13-7-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//
#import "RegexKitLite.h"
#import "lowooBaseView.h"

@protocol phoneNumberBindingDelegate <NSObject>
- (void)phoneNumberBinded;
@end

@interface phoneNumberBinding : lowooBaseView<UITextFieldDelegate>

@property (nonatomic, assign) BOOL boolAddFriend;
@property (nonatomic, assign) id<phoneNumberBindingDelegate>delegate;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *labelPrompt;
@property (nonatomic, strong) UIButton_custom *buttonBinding;
@property (nonatomic, strong) UIButton_custom *buttonUnbind;
@property (nonatomic, strong) UIImageView *imageview;

@property (nonatomic, assign) BOOL boolbinding;
@property (nonatomic, strong) NSString *phoneNumber;






@end
