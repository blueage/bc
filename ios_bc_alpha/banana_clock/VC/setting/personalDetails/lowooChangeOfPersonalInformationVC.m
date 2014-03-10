//
//  lowooChangeOfPersonalInformationVC.m
//  banana_clock
//
//  Created by MAC on 13-1-5.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooChangeOfPersonalInformationVC.h"
#import "lowooAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "GTMBase64.h"
#import "UIImage+Extensions.h"


@implementation lowooChangeOfPersonalInformationVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"INFORMATION SETTING";
    [self changeTitle];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadpic:) name:@"uploadpic" object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _boolHeadImage = NO;
    _boolName = NO;
    _boolRegion = NO;
    _boolGender = NO;
}

- (void)initView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -10, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height+1)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    

    
//    //键盘回收
//    _buttonTextField = [UIButton_custom buttonWithType:UIButtonTypeCustom];
//    [_buttonTextField setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [_buttonTextField addTarget:self action:@selector(buttonTextFieldAction) forControlEvents:UIControlEventTouchUpInside];
//    _buttonTextField.userInteractionEnabled = NO;
//    _buttonTextField.backgroundColor = [UIColor clearColor];
//    [_scrollView addSubview:_buttonTextField];
    
    //头像
    UIButton_custom *buttonProfilePhoto = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonProfilePhoto setFrame:CGRectMake(22, 42, 276, 69)];
    buttonProfilePhoto.backgroundColor = [UIColor clearColor];
    [buttonProfilePhoto setImageNormal:GetPngImage(@"List_item_bg01")];
    [buttonProfilePhoto setImageHighlited:GetPngImage(@"List_item_bg02")];
    [buttonProfilePhoto addTarget:self action:@selector(buttonProfilePhotoTouchUpInside:)];
    [_scrollView addSubview:buttonProfilePhoto];
    UIImageView *imageviewBack = [[UIImageView alloc] initWithFrame:CGRectMake(22.5, 43.5, 67, 65)];
    imageviewBack.image = GetPngImage(@"default_head_small");
    [_scrollView addSubview:imageviewBack];
    _imageViewHead = [[UIImageView_custom alloc]initWithFrame:CGRectMake(23, 43.5, 67.5, 65)];
    [_scrollView addSubview:_imageViewHead];
    
    viewIntroduce *viewIntroduceHead = [[viewIntroduce alloc] initWithFrame:CGRectMake(100, 61, 100, 40)];
    [_scrollView addSubview:viewIntroduceHead];
    
    UIImageView *imageViewjiantou = [[UIImageView alloc] initWithFrame:CGRectMake(270, 70, 7, 11)];
    imageViewjiantou.image = GetPngImage(@"jiantou");
    [_scrollView addSubview:imageViewjiantou];
    
    //邮箱
    UIImageView *imageviewEmail = [[UIImageView alloc] initWithFrame:CGRectMake(22, 117, 277, 55)];
    imageviewEmail.image = GetPngImage(@"List_item_bg01");
    imageviewEmail.alpha = 0.5;
    [_scrollView addSubview:imageviewEmail];
    
    viewIntroduce *viewIntroduceEmail = [[viewIntroduce alloc] initWithFrame:CGRectMake(40, 130, 100, 40)];
    [_scrollView addSubview:viewIntroduceEmail];
    
    UITextField *textFieldEmail = [[UITextField alloc]initWithFrame:CGRectMake(115, 134, 180, 25)];
    textFieldEmail.delegate = self;
    textFieldEmail.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldEmail.textAlignment = NSTextAlignmentLeft;
    [textFieldEmail setReturnKeyType:UIReturnKeyNext];
    [textFieldEmail setBackgroundColor:[UIColor clearColor]];
    [textFieldEmail setTextColor:COLOR_CHINESE];
    [textFieldEmail setFont:[UIFont systemFontOfSize:14.0f]];
    [_scrollView addSubview:textFieldEmail];
    textFieldEmail.userInteractionEnabled = NO;
    textFieldEmail.text = [[userModel sharedUserModel] getUserInformationWithKey:USER_EMAIL];
    
    //昵称
    UIImageView *imageviewName = [[UIImageView alloc] initWithFrame:CGRectMake(22, 117+60, 277, 55)];
    imageviewName.image = GetPngImage(@"List_item_bg01");
    [_scrollView addSubview:imageviewName];
    
    viewIntroduce *viewIntroduceName = [[viewIntroduce alloc] initWithFrame:CGRectMake(40, 129+60, 100, 40)];
    [_scrollView addSubview:viewIntroduceName];
    
    _textFieldNikeName = [[UITextField alloc]initWithFrame:CGRectMake(97, 132+60+[BASE height2_IOS6], 200, 25)];
    _textFieldNikeName.delegate = self;
    _textFieldNikeName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textFieldNikeName.textAlignment = NSTextAlignmentLeft;
    _textFieldNikeName.tag = 0;
    [_textFieldNikeName setReturnKeyType:UIReturnKeyNext];
    [_textFieldNikeName setBackgroundColor:[UIColor clearColor]];
    [_textFieldNikeName setTextColor:COLOR_CHINESE];
    [_textFieldNikeName setFont:[UIFont systemFontOfSize:14.0f]];
    [_scrollView addSubview:_textFieldNikeName];
    
    
    //地区
    UIImageView *imageviewRegion = [[UIImageView alloc] initWithFrame:CGRectMake(22, 117+60*2, 212, 55)];
    imageviewRegion.image = GetPngImage(@"List_item_bg01");
    [_scrollView addSubview:imageviewRegion];
    
    viewIntroduce *viewIntroduceRegion = [[viewIntroduce alloc] initWithFrame:CGRectMake(40, 129+60*2, 100, 40)];
    [_scrollView addSubview:viewIntroduceRegion];
    
    _textFieldCity = [[UITextField alloc]initWithFrame:CGRectMake(97, 132+60*2+[BASE height2_IOS6], 130, 25)];
    _textFieldCity.delegate = self;
    _textFieldCity.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textFieldCity.textAlignment = NSTextAlignmentLeft;
    _textFieldCity.tag = 1;
    [_textFieldCity setReturnKeyType:UIReturnKeyDone];
    [_textFieldCity setBackgroundColor:[UIColor clearColor]];
    [_textFieldCity setTextColor:COLOR_CHINESE];
    [_textFieldCity setFont:[UIFont systemFontOfSize:14.0f]];
    [_scrollView addSubview:_textFieldCity];
    
    
    //性别
    UIImageView *imageviewGender = [[UIImageView alloc] initWithFrame:CGRectMake(241, 117+60*2, 58, 55)];
    imageviewGender.image = GetPngImage(@"List_item_bg01");
    [_scrollView addSubview:imageviewGender];
    _imageViewMale = [[UIImageView alloc]initWithFrame:CGRectMake(262, 134+60*2, 17, 21)];
    [_scrollView addSubview:_imageViewMale];

    UIButton_custom *buttonImageViewMale = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    buttonImageViewMale.backgroundColor = [UIColor clearColor];
    [buttonImageViewMale setFrame:CGRectMake(244, 134+60*2, 52, 45)];
    [buttonImageViewMale addTarget:self action:@selector(buttonMaleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:buttonImageViewMale];
    

    
    if (LANGUAGE_CHINESE) {
        viewIntroduceHead.labelChinese.text = @"个人头像";
        viewIntroduceHead.labelChineseEnglish.text = @"Profile Photo";
        viewIntroduceEmail.labelChinese.text = @"我的账号";
        viewIntroduceEmail.labelChineseEnglish.text = @"My Account";
        viewIntroduceName.labelChinese.text = @"昵称";
        viewIntroduceName.labelChineseEnglish.text = @"Name";
        viewIntroduceRegion.labelChinese.text = @"城市";
        viewIntroduceRegion.labelChineseEnglish.text = @"Region";

        [_textFieldNikeName setPlaceholder:@"请输入昵称"];
        [_textFieldCity setPlaceholder:@"请输入城市"];
    }else{
        viewIntroduceHead.labelEnglish.text = @"Profile Photo";
        viewIntroduceEmail.labelEnglish.text = @"Account";
        viewIntroduceName.labelEnglish.text = @"Name";
        viewIntroduceRegion.labelEnglish.text = @"Region";

        [_textFieldNikeName setPlaceholder:@"New name"];
        [_textFieldCity setPlaceholder:@"New city"];
    }
}

- (void)confirmUser:(modelUserDetail *)user{
    [_imageViewHead setImageURL:user.avatarUrl];
    _textFieldCity.text = user.location;
    if (![user.sex isEqualToString:@"f"]) {
        self.imageViewMale.image = GetPngImage(@"regist_male");
        self.boolFemale = YES;
    }else{
        self.imageViewMale.image = GetPngImage(@"regist_female");
        self.boolFemale = NO;
    }
}

- (void)buttonTextFieldAction{
    [_textFieldCity resignFirstResponder];
    [_textFieldNikeName resignFirstResponder];
    _buttonTextField.userInteractionEnabled = NO;
}


#pragma mark-------leftBtnPressed-------------
- (void)leftButtonDidTouchedUpInside{
    NSString *stringmale = _boolFemale? [NSString stringWithFormat:@"m" ]:[NSString stringWithFormat:@"f"];
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] init];

    if (_boolName) {
        if (_textFieldNikeName.text.length<2) {
            [liboTOOLS alertViewMSG:[BASE International:@"昵称长度不能少于2位"]];
            return;
        }
        [mutableDict setObject:_textFieldNikeName.text forKey:@"name"];
        [[userModel sharedUserModel] setUserInformation:_textFieldNikeName.text forKey:USER_NAME];
    }
    if (_boolRegion) {
        [mutableDict setObject:_textFieldCity.text forKey:@"region"];
        [[userModel sharedUserModel] setUserInformation:_textFieldCity.text forKey:USER_CITY];
    }
    if (_boolGender) {
        [mutableDict setObject:stringmale forKey:@"gender"];
        [[userModel sharedUserModel] setUserInformation:stringmale forKey:USER_SEX];
    }
    if (mutableDict.count>0) {
        if ([self.manager isExistenceNetwork]) {
            [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:mutableDict requestType:uploadpic];
        }
    }

    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark-----------UITextFieldDelegate-----------
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 0)];
    if (iPhone5||iPhone5_0) {
        [_scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }else{
        [_scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    }
    
    _buttonTextField.userInteractionEnabled = YES;
    [self animateView:textField.tag];
    if (textField.tag == 0) {
        _boolName = YES;
    }
    if (textField.tag == 1) {
        _boolRegion = YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.tag==1) {
        _buttonTextField.userInteractionEnabled = NO;
        [textField resignFirstResponder];
        [self animateView:0];
        [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, _scrollView.frame.size.height+1)];
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        return YES;
    }
    
    [self animateView:textField.tag+1];
    UITextField *textFieldNext = (UITextField *)[_scrollView viewWithTag:textField.tag+1];
    [textFieldNext becomeFirstResponder];
    return YES;
}

-(void)animateView:(NSUInteger)tag{
//    if (tag > 1) {
//        [_scrollView setContentOffset:CGPointMake(0, 50.0f*(tag-1)) animated:YES];
//    } else {
//        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }
}




- (void)buttonProfilePhotoTouchUpInside:(UIButton_custom *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"图片库/照相机" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"手机相册",@"照相机", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    
    
    [actionSheet showInView:[self.navigationController.tabBarController UITabBarController_custom_view]];
}

#pragma mark---------UIActionSheetDelegate-----------
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self addPhoto];
            break;
        case 1:
            [self takePhoto];
            break;
        case 2:
            break;
        default:
            break;
    }
}

- (void)addPhoto{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"navigationViewHidden" object:nil];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.navigationBar.tintColor = [UIColor colorWithRed:72.0/255.0 green:106.0/255.0 blue:154.0/255.0 alpha:1.0];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;//UINavigationControllerDelegate
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

- (void)takePhoto
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [liboTOOLS alertViewMSG:[BASE International:@"该设备不支持拍照功能"]];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"navigationViewHidden" object:nil];
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}



#pragma mark----------UIImagePickerControllerDelegate------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([self.manager isExistenceNetwork]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"navigationViewHiddenno" object:nil];
        [picker dismissViewControllerAnimated:YES completion:^{}];
        UIImage * image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        _imageViewHead.image = image;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setHeadImage" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:_imageViewHead, @"imageview", nil]];
        _boolHeadImage = YES;
        
        NSString *stringBase64 = [[NSString alloc]initWithData:[GTMBase64 encodeData:UIImagePNGRepresentation([info objectForKey:@"UIImagePickerControllerEditedImage"])] encoding:NSUTF8StringEncoding];
        
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:stringBase64, @"face", nil] requestType:uploadpic];
        [[activityView sharedActivityView] showHUD:-1];
    }
}

- (void)uploadpic:(NSNotification *)notification{
    [[activityView sharedActivityView] removeHUD];
    if (notification.userInfo == nil) {
        return;
    }
    
    if ([[notification.userInfo objectForKey:@"state"] intValue]==1) {
        if ([_delegate respondsToSelector:@selector(didChangePersonalInformation)]) {
            [_delegate didChangePersonalInformation];
        }
    }else{
        if ([[notification.userInfo objectForKey:@"createimg"] intValue]==0){
            [liboTOOLS alertViewMSG:[BASE International:@"头像上传失败"]];
        }else{
            [liboTOOLS alertViewMSG:[BASE International:@"信息修改失败"]];
        }
    }
    

    

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{

    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"navigationViewHiddenno" object:nil];
}

- (void)buttonMaleTouchUpInside:(UIButton_custom *)sender {
    _boolGender = YES;
    if (!_boolFemale) {//现在为女
        _imageViewMale.image = GetPngImage(@"regist_male");
    }else{
        _imageViewMale.image = GetPngImage(@"regist_female");
    }
    _boolFemale = !_boolFemale;
}


@end
