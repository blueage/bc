//
//  lowooChangeOfPersonalInformationVC.h
//  banana_clock
//
//  Created by MAC on 13-1-5.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBaseView.h"
#import "lowooChangePassword.h"
#import "viewIntroduce.h"

@protocol lowooChangeOfPersonalInformationVCDelegate <NSObject>
- (void)didChangePersonalInformation;
@end

@interface lowooChangeOfPersonalInformationVC : lowooBaseView<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign) id<lowooChangeOfPersonalInformationVCDelegate>delegate;
@property (nonatomic, assign) BOOL boolFemale;//yes 为女
@property (nonatomic, strong) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView_custom *imageViewHead;
@property (strong, nonatomic) UIImageView *imageViewMale;
@property (strong, nonatomic) UITextField *textFieldNikeName;
@property (strong, nonatomic) UITextField *textFieldCity;


@property (nonatomic, assign) BOOL boolHeadImage;
@property (nonatomic, assign) BOOL boolName;
@property (nonatomic, assign) BOOL boolRegion;
@property (nonatomic, assign) BOOL boolGender;
@property (nonatomic, strong) UIButton_custom *buttonTextField;
@property (nonatomic, assign) BOOL boolCropImage;


- (void)initView;
- (void)confirmUser:(modelUserDetail *)user;


@end
