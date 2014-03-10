//
//  lowooRegisterVC.h
//  banana clock
//
//  Created by MAC on 12-9-18.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lowooHTTPManager.h"
#import "lowooWebVC.h"
#import "lowooBaseView.h"
#import "RegexKitLite.h"
#import "viewIntroduceButton.h"
#import "UnderLineLabel.h"
#import "lowooTimeSet.h"
#import "UITextField_custom.h"

@protocol lowooRegisterVCDelegate <NSObject>
- (void)didRegist:(NSString *)name pass:(NSString *)passWord;
@end

@interface lowooRegisterVC : lowooBaseView<UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate>

@property (nonatomic, assign) BOOL boolAgreed;
@property (nonatomic, assign) id<lowooRegisterVCDelegate>delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField_custom *textFieldUserEmail;
@property (nonatomic, strong) UITextField_custom *textFieldPassword;
@property (nonatomic, strong) UITextField_custom *textFieldConfirmPassword;

@property (nonatomic, strong) viewIntroduceButton *viewEmail;
@property (nonatomic, strong) viewIntroduceButton *viewPassWord;
@property (nonatomic, strong) viewIntroduceButton *viewConfirm;

@property (nonatomic, strong) UIImageView *imageViewTersOfServie;

@property (nonatomic, strong) UnderLineLabel *label;
@property (nonatomic) BOOL booTextField;


@end
