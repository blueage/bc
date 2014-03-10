//
//  lowooChangePassword.m
//  banana_clock
//
//  Created by MAC on 13-1-5.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooChangePassword.h"
#import "RegexKitLite.h"


@implementation lowooChangePassword

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"PASSWORD";
    [self changeTitle];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePassWord:) name:@"changePassWord" object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _frameOld = CGRectMake(0, -5, SCREEN_WIDTH, SCREEN_HEIGHT);
    _frameNew = CGRectMake(0, SCREEN_HEIGHT-30, 320, SCREEN_HEIGHT);
    [self initOldView];
    [self initView];
    
}

- (void)initOldView{
    [_scrollViewOld removeFromSuperview];
    _scrollViewOld = [[UIScrollView alloc]initWithFrame:_frameOld];
    _scrollViewOld.backgroundColor = [UIColor clearColor];
    _scrollViewOld.showsHorizontalScrollIndicator = NO;
    _scrollViewOld.showsVerticalScrollIndicator = NO;
    _scrollViewOld.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+1);
    [self.view addSubview:_scrollViewOld];
    
    //旧密码
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(22, 37, 276, 55)];
    imageview.image = GetPngImage(@"List_item_bg01");
    [_scrollViewOld addSubview:imageview];
    
    _textFieldOld = [[UITextField alloc]initWithFrame:CGRectMake(30, 53, 255, 30)];
    _textFieldOld.delegate = self;
    _textFieldOld.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textFieldOld.secureTextEntry = YES;
    _textFieldOld.textAlignment = NSTextAlignmentLeft;
    _textFieldOld.tag = 0;
    [_textFieldOld setReturnKeyType:UIReturnKeyNext];
    [_textFieldOld setBackgroundColor:[UIColor clearColor]];
    [_textFieldOld setFont:[UIFont systemFontOfSize:14.0f]];
    [_scrollViewOld addSubview:_textFieldOld];
    
    _labelOld = [[UILabel alloc] initWithFrame:CGRectMake(22, 85, 270, 60)];
    _labelOld.font = [UIFont systemFontOfSize:12];
    _labelOld.textColor = [UIColor colorWithRed:98/255.0 green:98/255.0 blue:98/255.0 alpha:1];
    _labelOld.lineBreakMode = NSLineBreakByCharWrapping;
    _labelOld.numberOfLines = 0;
    _labelOld.backgroundColor = [UIColor clearColor];
    _labelOld.textAlignment = NSTextAlignmentCenter;
    [_scrollViewOld addSubview:_labelOld];
    
    _buttonOld = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [_buttonOld setFrame:CGRectMake(81, 150, 157, 53) image:[BASE International:@"POPDeterminea"] image:[BASE International:@"POPDetermineb"]];
    [_buttonOld addTarget:self action:@selector(buttonOldAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollViewOld addSubview:_buttonOld];
    
    if (LANGUAGE_CHINESE) {
        [_textFieldOld setPlaceholder:@"请输入旧密码"];
    }else{
        [_textFieldOld setPlaceholder:@"Enter old password"];
    }
}

- (void)buttonOldAction{
    if (_textFieldOld.text.length == 0) {
        if (LANGUAGE_CHINESE) {
            _labelOld.text = @"请输入您的就密码";
        }else{
            _labelOld.text = @"Please ente yor password";
        }
        return;
    }

    if ([_textFieldOld.text isEqualToString:[[userModel sharedUserModel] getUserInformationWithKey:USER_PASSWORD]]) {
        [self moveScrollView];
        
    }else{
        _textFieldOld.text = @"";
        if (LANGUAGE_CHINESE) {
            _labelOld.text = @"旧密码不正确，请重新输入，如果忘记密码，您可以通过绑定的邮箱找回";
        }else{
            _labelOld.text = @"The old password is incorrect, please re-enter, if you forget your password, you can retrieve from the Email you had binding";
        }
        
    }
}

- (void)moveScrollView{
    _frameOld.origin.y = _frameOld.origin.y - SCREEN_HEIGHT;
    _frameNew.origin.y = _frameNew.origin.y - SCREEN_HEIGHT;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _scrollViewOld.frame = _frameOld;
                         _scrollView.frame = _frameNew;
                     } completion:^(BOOL finished) {
                         [self setRightButton];
                     }];
}

- (void)setRightButton{
    //[self.buttonRight setFrame:CGRectMake(-12, 3, 61, 36) image:[BASE International:@"save_CNa"] image:[BASE International:@"save_CNb"]];
    [self.buttonRight setFrame:CGRectMake(-12, 3, 61, 36)];
    [self.buttonRight setImage:GetPngImage([BASE International:@"save_CNa"]) forState:UIControlStateNormal];
    [self.buttonRight setImage:GetPngImage([BASE International:@"save_CNb"]) forState:UIControlEventTouchDown];
    self.viewRightButton.hidden = NO;
}

- (void)initView{
    [_scrollView removeFromSuperview];
    _scrollView = nil;
    _scrollView = [[UIScrollView alloc]initWithFrame:_frameNew];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+1);
    [self.view addSubview:_scrollView];
    
    //密码
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(22, 65, 276, 55)];
    imageview.image = GetPngImage(@"List_item_bg01");
    [_scrollView addSubview:imageview];
    
    _textFieldPassword = [[UITextField alloc]initWithFrame:CGRectMake(30, 84, 255, 30)];
    _textFieldPassword.delegate = self;
    _textFieldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textFieldPassword.secureTextEntry = YES;
    _textFieldPassword.textAlignment = NSTextAlignmentLeft;
    _textFieldPassword.tag = 0;
    [_textFieldPassword setReturnKeyType:UIReturnKeyNext];
    [_textFieldPassword setBackgroundColor:[UIColor clearColor]];
    [_textFieldPassword setFont:[UIFont systemFontOfSize:14.0f]];
    [_scrollView addSubview:_textFieldPassword];
    
    //确认密码
    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(22, 119.5, 276, 55)];
    imageview1.image = GetPngImage(@"List_item_bg01");
    [_scrollView addSubview:imageview1];
    
    _textFieldConfirmPassword = [[UITextField alloc]initWithFrame:CGRectMake(30, 137, 255, 30)];
    _textFieldConfirmPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textFieldConfirmPassword.delegate = self;
    _textFieldConfirmPassword.secureTextEntry = YES;
    _textFieldConfirmPassword.textAlignment = NSTextAlignmentLeft;
    _textFieldConfirmPassword.tag = 0;
    [_textFieldConfirmPassword setReturnKeyType:UIReturnKeyDone];
    [_textFieldConfirmPassword setBackgroundColor:[UIColor clearColor]];
    [_textFieldConfirmPassword setFont:[UIFont systemFontOfSize:14.0f]];
    [_scrollView addSubview:_textFieldConfirmPassword];
    
    _labelNew = [[UILabel alloc] initWithFrame:CGRectMake(22, 200, 276, 55)];
    _labelNew.font = [UIFont systemFontOfSize:12];
    _labelNew.textColor = [UIColor colorWithRed:98/255.0 green:98/255.0 blue:98/255.0 alpha:1];
    _labelNew.lineBreakMode = NSLineBreakByCharWrapping;
    _labelNew.numberOfLines = 0;
    _labelNew.backgroundColor = [UIColor clearColor];
    _labelNew.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_labelNew];
    
    if (LANGUAGE_CHINESE) {
        [_textFieldPassword setPlaceholder:@"请输入密码"];
        [_textFieldConfirmPassword setPlaceholder:@"请确认密码"];
        
        _labelNew.text = @"设置新的登陆密码，设置此密码将覆盖任何以前的密码。";
    }else{

        [_textFieldPassword setPlaceholder:@"enter password"];
        [_textFieldConfirmPassword setPlaceholder:@"confirm password"];
        
        _labelNew.text = @"Please enter a new password for this account. Setting this password will overwrite any previous passwords.";
    }
}

- (void)rightButtonTouchUpInside{
    if (_textFieldPassword.text==nil || [_textFieldPassword.text isEqualToString:@""] || _textFieldConfirmPassword==nil || [_textFieldConfirmPassword.text isEqualToString:@""]) {
        _labelNew.text = @"密码或确认密码不能为空";
    }else{
        if ([_textFieldConfirmPassword.text isEqualToString: _textFieldPassword.text]) {
            if(![self CheckInputPassword:_textFieldConfirmPassword.text]){
                _labelNew.text = @"密码长度错误";
            }else{
                //http
                [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: _textFieldConfirmPassword.text, @"pwd", nil] requestType:changePassWord];
                _labelNew.text = @"";
            }
        }else{
            _labelNew.text = @"两次密码不匹配";
        }
    }
    _password = _textFieldConfirmPassword.text;
}

- (void)changePassWord:(NSNotification *)sender{
    if (![BASE isNotNull:sender.userInfo]) {
        return;
    }
    //后台再把密码返回来
    if ([[sender.userInfo objectForKey:@"state"] intValue] == 1) {
        [[userModel sharedUserModel] setUserInformation:@"" forKey:USER_PASSWORD];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[BASE International:@"成功修改密码"] message:nil delegate:nil cancelButtonTitle:[BASE International:@"请使用新密码重新登录"] otherButtonTitles: nil];
        [alert show];
        [[userModel sharedUserModel] bananaUserLogout];
    }else{
        [liboTOOLS alertViewMSG:[BASE International:@"修改密码失败"]];
    }
}


#pragma mark-----------UITextFieldDelegate-----------
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField == _textFieldPassword) {
        [_textFieldConfirmPassword becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}


//判断密码，6－16位

-(BOOL)CheckInputPassword:(NSString *)_text
{
    NSString *Regex = @"\\w{6,16}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [emailTest evaluateWithObject:_text];
}


@end
