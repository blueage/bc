//
//  lowooChangePassword.h
//  banana_clock
//
//  Created by MAC on 13-1-5.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBaseView.h"
#import "viewIntroduceButton.h"

@interface lowooChangePassword : lowooBaseView<UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *scrollViewOld;
@property (strong, nonatomic) UITextField *textFieldPassword;
@property (strong, nonatomic) UITextField *textFieldConfirmPassword;
@property (nonatomic, strong) UITextField *textFieldOld;

@property (nonatomic, strong) viewIntroduceButton *viewIntroducePassword;
@property (nonatomic, strong) viewIntroduceButton *viewIntroduceConfirmPassword;
@property (nonatomic, strong) viewIntroduceButton *viewIntroduceOld;

@property (nonatomic, strong) UILabel *labelOld;
@property (nonatomic, strong) UILabel *labelNew;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) UIButton_custom *buttonOld;
@property (nonatomic, assign) CGRect frameNew;
@property (nonatomic, assign) CGRect frameOld;



@end
