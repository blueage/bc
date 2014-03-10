//
//  lowooAddFriends.h
//  banana clock
//
//  Created by MAC on 12-10-17.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lowooHTTPManager.h"
#import "lowooBaseView.h"
#import "lowooAddFriendsListVC.h"
#import "ZBarSDK.h"
#import "lowooZBar.h"
#import "lowooSina.h"
#import "viewIntroduceButton.h"
#import "phoneNumberBinding.h"
#import "lowooPhoneBookViewController.h"

@interface lowooAddFriends : lowooBaseView<UITextFieldDelegate,ZBarReaderDelegate,phoneNumberBindingDelegate>

@property (nonatomic, strong) UIButton_custom *buttonTap;
@property (nonatomic, strong) UITextField *textFieldID;
@property (nonatomic, strong) lowooSina *sina;
@property (nonatomic, strong) lowooZBar *zbarView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) viewIntroduceButton *viewIntroduceSina;
@property (nonatomic, strong) viewIntroduceButton *viewIntroduceQR;
@property (nonatomic, strong) viewIntroduceButton *viewIntroducePhoneBook;
@property (nonatomic, strong) lowooPhoneBookViewController *phoneBook;


@end
