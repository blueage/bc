//
//  phoneNumberBinding.m
//  banana_clock
//
//  Created by MAC on 13-7-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "phoneNumberBinding.h"


@interface phoneNumberBinding ()

@end

@implementation phoneNumberBinding

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpFailed) name:@"httpFailed" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upLoadPhoneNumber:) name:@"upLoadPhoneNumber" object:nil];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"PHONE BINDING";
    [self changeTitle];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	_boolbinding = YES;
    [self initView];
}

- (void)initView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -2, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
//    if (iPhone5||iPhone5_0) {
//        
//    }else{
//        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+1);
//    }
    [self.view addSubview:scrollView];
    
    _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(22, 37, 270, 55)];
    _imageview.image = GetPngImage(@"List_item_bg01");
    [scrollView addSubview:_imageview];
    _imageview.hidden = YES;
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 53, 250, 30)];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.delegate = self;
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.textColor = [UIColor colorWithRed:24/255.0 green:52/255.0 blue:66/255.0 alpha:1];
    [scrollView addSubview:_textField];
    _textField.hidden = YES;


    _labelPrompt = [[UILabel alloc] initWithFrame:CGRectMake(22, 90, 270, 60)];
    _labelPrompt.font = [UIFont systemFontOfSize:12];
    _labelPrompt.textColor = [UIColor colorWithRed:98/255.0 green:98/255.0 blue:98/255.0 alpha:1];
    _labelPrompt.lineBreakMode = NSLineBreakByCharWrapping;
    _labelPrompt.numberOfLines = 0;
    _labelPrompt.backgroundColor = [UIColor clearColor];
    _labelPrompt.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:_labelPrompt];

    
    _buttonBinding = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [_buttonBinding setFrame:CGRectMake(54, 170, 212, 53)];
    [_buttonBinding addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:_buttonBinding];
    _buttonBinding.hidden = YES;
    
    _buttonUnbind = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [_buttonUnbind setFrame:CGRectMake(54, 170, 212, 53)];
    [_buttonUnbind addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:_buttonUnbind];
    _buttonUnbind.hidden = YES;
    
    if (iPhone5 || iPhone5_0) {
        
    }else{
        [_buttonBinding setFrame:CGRectMake(54, 210, 212, 53)];
        [_buttonUnbind setFrame:CGRectMake(54, 210, 212, 53)];
    }

    
    if ([[userModel sharedUserModel] getUserInformationWithKey:USER_PHONENUMBER]&&![[[userModel sharedUserModel] getUserInformationWithKey:USER_PHONENUMBER] isEqualToString:@""]) {
        _textField.text = [[userModel sharedUserModel] getUserInformationWithKey:USER_PHONENUMBER];
        _textField.hidden = NO;
        _imageview.hidden = NO;
        _buttonUnbind.hidden = NO;
        _textField.userInteractionEnabled = NO;

        if (LANGUAGE_CHINESE) {
            _labelPrompt.text = @"绑定手机，系统会帮你找到手机通讯录中使用BananaClock的朋友，并且让你通讯中的好友更方便的找到你。";
            [_buttonUnbind setImage:GetPngImage(@"Unbind") forState:UIControlStateNormal];
            [_buttonUnbind setImage:GetPngImage(@"Unbindb") forState:UIControlEventTouchDown];
            [_buttonBinding setImage:GetPngImage(@"Binding") forState:UIControlStateNormal];
            [_buttonBinding setImage:GetPngImage(@"Bindingb") forState:UIControlEventTouchDown];
        }else{
            _labelPrompt.text = @"Linked Address Book Matching to find phone contacts using BananaClock.";
            [_buttonUnbind setImage:GetPngImage(@"UnbindEnglish") forState:UIControlStateNormal];
            [_buttonUnbind setImage:GetPngImage(@"UnbindbEnglish") forState:UIControlEventTouchDown];
            [_buttonBinding setImage:GetPngImage(@"BindingEnglish") forState:UIControlStateNormal];
            [_buttonBinding setImage:GetPngImage(@"BindingbEnglish") forState:UIControlEventTouchDown];
        }
    }else{
        _buttonBinding.hidden = NO;
        [_labelPrompt setFrame:CGRectMake(22, 50, 270, 60)];
        if (LANGUAGE_CHINESE) {
            _labelPrompt.text = @"绑定手机，系统会帮你找到手机通讯录中使用BananaClock的朋友，并且让你通讯中的好友更方便的找到你。不保存通讯录的任何资料，仅使用特征码作匹配识别。";
            [_buttonUnbind setImage:GetPngImage(@"Unbind") forState:UIControlStateNormal];
            [_buttonUnbind setImage:GetPngImage(@"Unbindb") forState:UIControlEventTouchDown];
            [_buttonBinding setImage:GetPngImage(@"Binding") forState:UIControlStateNormal];
            [_buttonBinding setImage:GetPngImage(@"Bindingb") forState:UIControlEventTouchDown];
        }else{
            _labelPrompt.text = @"Linked Address Book Matching to find phone contacts using BananaClock. Your address book data will be encrypted.";
            [_buttonUnbind setImage:GetPngImage(@"UnbindEnglish") forState:UIControlStateNormal];
            [_buttonUnbind setImage:GetPngImage(@"UnbindbEnglish") forState:UIControlEventTouchDown];
            [_buttonBinding setImage:GetPngImage(@"BindingEnglish") forState:UIControlStateNormal];
            [_buttonBinding setImage:GetPngImage(@"BindingbEnglish") forState:UIControlEventTouchDown];
        }
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction{
    [_textField resignFirstResponder];
}

- (void)buttonAction:(UIButton_custom *)sender{
    if ([self.manager isExistenceNetwork]) {
        if (!_boolbinding) {
            //绑定操作
            //检查格式 并上传服务器
            if ([self CheckPhoneNumInput:_textField.text]) {
                [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: _textField.text, @"phoneNumber", nil] requestType:upLoadPhoneNumber];
                [liboTOOLS showHUD:[BASE International:@"请稍后.."]];
            }else{
                [liboTOOLS alertViewMSG:[BASE International:@"手机号码格式不正确"]];
            }
        }else{
            //已绑定
            if ([[userModel sharedUserModel] getUserInformationWithKey:USER_PHONENUMBER]&&![[[userModel sharedUserModel] getUserInformationWithKey:USER_PHONENUMBER] isEqualToString:@""]){
                //解除bangd
                _textField.userInteractionEnabled = YES;
                [self.manager doHTTPRequestWithPostFields:nil requestType:deletePhoneNumber];
                _imageview.hidden = YES;
                _textField.hidden = YES;
                [_textField resignFirstResponder];
                [[userModel sharedUserModel] setUserInformation:@"" forKey:USER_PHONENUMBER];
                _buttonBinding.hidden = NO;
                _buttonUnbind.hidden = YES;
                [_labelPrompt setFrame:CGRectMake(22, 50, 270, 60)];
                if (LANGUAGE_CHINESE) {
                    _labelPrompt.text = @"绑定手机通讯录，系统会帮你找到手机通讯录中使用BananaClock的朋友。不保存通讯录的任何资料，仅使用特征码作匹配识别。";
                }else{
                    _labelPrompt.text = @"Linked Address Book Matching to find phone contacts using BananaClock. Your address book data will be encrypted.";
                }
            }else{
                //显示绑定界面
                _boolbinding = NO;
                _imageview.hidden = NO;
                _textField.text = @"";
                _textField.hidden = NO;
                _textField.userInteractionEnabled = YES;
                [_textField becomeFirstResponder];
                [_labelPrompt setFrame:CGRectMake(22, 80, 270, 60)];
                if (LANGUAGE_CHINESE) {
                    _labelPrompt.text = @"绑定手机通讯录，系统会帮你找到手机通讯录中使用BananaClock的朋友。";
                }else{
                    _labelPrompt.text = @"Linked Address Book Matching to find phone contacts using BananaClock.";
                }
            }
        }
    }
}

#pragma mark--------- ---------------
- (void)upLoadPhoneNumber:(NSNotification *)sender{
    [liboTOOLS dismissHUD];
    /**
     state = 1 绑定成功
     
     state = 2 此手机号已经被绑定
     
     state = 3 其他错误
     */
    if (![BASE isNotNull:sender.userInfo]) {
        return;
    }
    if ([[sender.userInfo objectForKey:@"state"] intValue]==1) {
        //成功绑定
        _boolbinding = YES;
        _buttonBinding.hidden = YES;
        _buttonUnbind.hidden = NO;
        [[userModel sharedUserModel] setUserInformation:_textField.text forKey:USER_PHONENUMBER];
        [_textField resignFirstResponder];
        _textField.userInteractionEnabled = NO;
        
        if ([_delegate respondsToSelector:@selector(phoneNumberBinded)]) {
            [self.navigationController popViewControllerAnimated:NO];
            [_delegate phoneNumberBinded];
        }
    }else if ([[sender.userInfo objectForKey:@"state"] intValue]==2){
        [liboTOOLS alertViewMSG:[BASE International:@"手机号绑定失败"]];
    }else{
        
    }

}

#pragma mark----------正则表达式,判断手机号---------
-(BOOL)CheckPhoneNumInput:(NSString *)_text{
    
    NSString *Regex =@"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    
    return [mobileTest evaluateWithObject:_text];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    
    return YES;
}









@end
