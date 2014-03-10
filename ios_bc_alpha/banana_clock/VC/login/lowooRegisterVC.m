//
//  lowooRegisterVC.m
//  banana clock
//
//  Created by MAC on 12-9-18.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooRegisterVC.h"
#import "APService.h"
#import "RegexKitLite.h"

@interface lowooRegisterVC ()
@property (nonatomic) CGSize size;
@property (nonatomic) CGSize sizeMove;
@end

@implementation lowooRegisterVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _booTextField = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _booTextField = NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpFailed) name:@"httpFailed" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkUID:) name:@"checkUID" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRegist:) name:@"didRegist" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    _booTextField = YES;
    
    //背景图片
    if (iPhone5||iPhone5_0) {
        UIImageView *imageViewBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [imageViewBack setImage:GetJpgImage(@"login_bk5")];
        [self.view addSubview:imageViewBack];
    }else{
        UIImageView *imageViewBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [imageViewBack setImage:GetJpgImage(@"login_bk4")];
        [self.view addSubview:imageViewBack];
    }

    _boolAgreed = YES;
    _scrollView = [[UIScrollView alloc]init];
    if (iPhone5_0||iPhone5) {
        [_scrollView setFrame:CGRectMake(0, -70, SCREEN_WIDTH, SCREEN_HEIGHT+44)];
        //[_scrollView setContentSize:CGSizeMake(320, _scrollView.frame.size.height+1)];
    }else{
        [_scrollView setFrame:CGRectMake(0, -100, SCREEN_WIDTH, SCREEN_HEIGHT+50)];
        //[_scrollView setContentSize:CGSizeMake(320, _scrollView.frame.size.height+100)];
    }
    [_scrollView setContentSize:CGSizeMake(320, _scrollView.frame.size.height+1)];
    _scrollView.backgroundColor = [UIColor clearColor];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setScrollsToTop:NO];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    //键盘返回按钮
    UIButton *buttonTap = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonTap setFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    buttonTap.backgroundColor = [UIColor clearColor];
    buttonTap.tag = 0;
    [buttonTap addTarget:self action:@selector(selfViewTaped) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:buttonTap];
    
    NSInteger viewHeight = 100;
    NSInteger viewSpace = 60;
    NSInteger textFieldHeight = 110+[BASE height10_ISO6];
    
    //用户ID
    _viewEmail = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, viewHeight+viewSpace, 276, 55)];
    _viewEmail.button.userInteractionEnabled = NO;
    [_scrollView addSubview:_viewEmail];
    
    _textFieldUserEmail = [[UITextField_custom alloc]initWithFrame:CGRectMake(95, textFieldHeight+viewSpace, 188, 34)];
    _textFieldUserEmail.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textFieldUserEmail.delegate = self;
    [_textFieldUserEmail setTag:0];
    [_textFieldUserEmail setReturnKeyType:UIReturnKeyNext];
    [_textFieldUserEmail setBackgroundColor:[UIColor clearColor]];
    [_textFieldUserEmail setFont:[UIFont systemFontOfSize:14.0f]];
    [_scrollView addSubview:_textFieldUserEmail];

    //密码
    _viewPassWord = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, viewHeight+2*viewSpace, 276, 55)];
    _viewPassWord.button.userInteractionEnabled = NO;
    [_scrollView addSubview:_viewPassWord];
    
    _textFieldPassword = [[UITextField_custom alloc]initWithFrame:CGRectMake(95, textFieldHeight+2*viewSpace, 188, 34)];
    _textFieldPassword.delegate = self;
    _textFieldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_textFieldPassword setTag:1];
    [_textFieldPassword setReturnKeyType:UIReturnKeyNext];
    [_textFieldPassword setBackgroundColor:[UIColor clearColor]];
    [_textFieldPassword setFont:[UIFont systemFontOfSize:14.0f]];
    [_textFieldPassword setSecureTextEntry:YES];
    [_scrollView addSubview:_textFieldPassword];
    //确认密码
    _viewConfirm = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, viewHeight+3*viewSpace, 276, 55)];
    _viewConfirm.button.userInteractionEnabled = NO;
    [_scrollView addSubview:_viewConfirm];
    
    _textFieldConfirmPassword = [[UITextField_custom alloc]initWithFrame:CGRectMake(95, textFieldHeight+3*viewSpace, 188, 34)];
    _textFieldConfirmPassword.delegate = self;
    _textFieldConfirmPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_textFieldConfirmPassword setTag:2];
    [_textFieldConfirmPassword setSecureTextEntry:YES                                                           ];
    [_textFieldConfirmPassword setReturnKeyType:UIReturnKeyDone];
    [_textFieldConfirmPassword setBackgroundColor:[UIColor clearColor]];
    [_textFieldConfirmPassword setFont:[UIFont systemFontOfSize:14.0f]];
    [_scrollView addSubview:_textFieldConfirmPassword];
    
#pragma mark----------服务条款-----------------
    UIButton_custom *buttonTermsOfService = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonTermsOfService setFrame:CGRectMake(25, 460-2*viewSpace, 20, 20)];
    [buttonTermsOfService setBackgroundColor:[UIColor clearColor]];
    [buttonTermsOfService addTarget:self action:@selector(agreeImageChanged) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:buttonTermsOfService];
    
    _imageViewTersOfServie = [[UIImageView alloc]initWithFrame:CGRectMake(25, 460-2*viewSpace, 20, 20)];
    [_imageViewTersOfServie setImage:GetPngImage(@"agree")];
    [_scrollView addSubview:_imageViewTersOfServie];
    
    _label = [[UnderLineLabel alloc] initWithFrame:CGRectMake(52, 463-2*viewSpace, 100, 14)];
    [_label setBackgroundColor:[UIColor clearColor]];
    _label.highlightedColor = [UIColor clearColor];
    _label.textColor = [UIColor blackColor];
    _label.shouldUnderline = YES;
    [_label setFont:[UIFont systemFontOfSize:12]];
    [_label addTarget:self action:@selector(termsOfServiceBtnPressed:)];
    [_scrollView addSubview:_label];

    //取消
    UIButton_custom *buttonCancel = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonCancel setFrame:CGRectMake(30, 500-2*viewSpace, 117, 56)];
    if (LANGUAGE_CHINESE) {
        [buttonCancel setImageNormal:GetPngImage(@"regist_cancel")];
        [buttonCancel setImageHighlited:GetPngImage(@"regist_cancelb")];
    }else{
        [buttonCancel setImageNormal:GetPngImage(@"regist_cancelEnglish")];
        [buttonCancel setImageHighlited:GetPngImage(@"regist_cancelbEnglish")];
    }
    [buttonCancel addTarget:self action:@selector(cancelButtonDidTouchedUpInside:)];
    [_scrollView addSubview:buttonCancel];
    //确定
    UIButton_custom *buttonEnter = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonEnter setFrame:CGRectMake(171, 500-2*viewSpace, 117, 56)];
    if (LANGUAGE_CHINESE) {
        [buttonEnter setImageNormal:GetPngImage(@"regist_enter")];
        [buttonEnter setImageHighlited:GetPngImage(@"regist_enterb")];
    }else{
        [buttonEnter setImageNormal:GetPngImage(@"regist_enterEnglish")];
        [buttonEnter setImageHighlited:GetPngImage(@"regist_enterbEnglish")];
    }
    [buttonEnter addTarget:self action:@selector(enterButtonDidTouchedUpInside:)];
    [_scrollView addSubview:buttonEnter];
    //logo
    UIImageView *imageViewLogo = [[UIImageView alloc]init];
    imageViewLogo.backgroundColor = [UIColor clearColor];
    if (iPhone5||iPhone5_0) {
        [imageViewLogo setFrame:CGRectMake(8, 45+viewSpace, 121.5, 41.5)];
    }else{
        [imageViewLogo setFrame:CGRectMake(8, 55+viewSpace, 121.5, 41.5)];
    }
    [imageViewLogo setImage:GetPngImage(@"banana_logo")];
    [_scrollView addSubview:imageViewLogo];

    if (LANGUAGE_CHINESE) {
        _viewEmail.viewIntroduce.labelChinese.text = @"用户邮箱";
        [_viewEmail.viewIntroduce.labelChinese setFrame:CGRectMake(_viewEmail.viewIntroduce.labelChinese.frame.origin.x-3, _viewEmail.viewIntroduce.labelChinese.frame.origin.y, _viewEmail.viewIntroduce.labelChinese.frame.size.width, _viewEmail.viewIntroduce.labelChinese.frame.size.height)];
        _viewEmail.viewIntroduce.labelChineseEnglish.text = @"User Email";
        [_textFieldUserEmail setPlaceholder:@"请输入邮箱"];
        
        _viewPassWord.viewIntroduce.labelChinese.text = @"密码";
        _viewPassWord.viewIntroduce.labelChineseEnglish.text = @"Password";
        [_textFieldPassword setPlaceholder:@"请输入密码"];
        
        _viewConfirm.viewIntroduce.labelChinese.text = @"确认密码";
        _viewConfirm.viewIntroduce.labelChineseEnglish.text = @"Confirm";
        [_textFieldConfirmPassword setPlaceholder:@"请确认密码"];
        
        _label.text = @"服务条款";
        [_label setFrame:CGRectMake(52, 463-2*viewSpace, 50, 14)];
    }else{
        [_textFieldUserEmail setPlaceholder:@"Enter user Email"];
        [_textFieldUserEmail setFrame:CGRectMake(55, textFieldHeight+viewSpace, 200, 34)];
        
        [_textFieldPassword setPlaceholder:@"Enter password"];
        [_textFieldPassword setFrame:CGRectMake(55, textFieldHeight+2*viewSpace, 200, 34)];
        
        [_textFieldConfirmPassword setPlaceholder:@"Confirm password"];
        [_textFieldConfirmPassword setFrame:CGRectMake(55, textFieldHeight+3*viewSpace, 200, 34)];
        
        _label.text = @"Terms of Service";
    }
    
    _size = _scrollView.contentSize;
    _sizeMove = CGSizeMake(_size.width, _size.height+100);
}

#pragma mark--------agreeImageChanged:--------
- (void)agreeImageChanged{
    if (_boolAgreed) {
        _imageViewTersOfServie.image = GetPngImage(@"disagree");
    }else{
        _imageViewTersOfServie.image = GetPngImage(@"agree");
    }
    _boolAgreed = !_boolAgreed;
}

#pragma mark---------- selfViewTaped  ----------
- (void)selfViewTaped{
    [_scrollView setContentSize:_size];
    [_textFieldUserEmail resignFirstResponder];
    [_textFieldPassword resignFirstResponder];
    [_textFieldConfirmPassword resignFirstResponder];
    [self animateView:0];
}

#pragma mark-----------UITextFieldDelegate-----------
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.textColor = [UIColor blackColor];
    [_scrollView setContentSize:_sizeMove];
    NSInteger tag = textField.tag;
    [self animateView:tag];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [[userModel sharedUserModel] setUserInformation:@"" forKey:USER_ID];
    if (textField == _textFieldUserEmail && textField.text.length>0) {
        if ([self checkInPutEmail:_textFieldUserEmail.text]) {
            [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:_textFieldUserEmail.text, @"username", nil] requestType:checkUID];
        }else{
            if (_booTextField) {
                [liboTOOLS alertViewMSG:[BASE International:@"邮箱格式不正确"]];
                _textFieldUserEmail.textColor = [UIColor redColor];
                //[_textFieldUserEmail becomeFirstResponder];//libo 人性化处理
            }
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSInteger tag = textField.tag;
    if (tag == 2) {
        [textField resignFirstResponder];
        [_scrollView setContentSize:_size];
        [self enterButtonDidTouchedUpInside:nil];
        return YES;
    }
    UITextField *nextField = (UITextField *)[_scrollView viewWithTag:(tag + 1)];
    [nextField becomeFirstResponder];
    return YES;
}



- (void)checkUID:(NSNotification *)sender{//查看注册邮箱是否已经被使用
    if ([[sender.userInfo objectForKey:@"state"] intValue] == 1) {
        _textFieldUserEmail.textColor = [UIColor blackColor];
    }else{
        [liboTOOLS alertViewMSG:[BASE International:@"该用户已存在，请返回直接登录或重新注册其他账号"]];
        _textFieldUserEmail.textColor = [UIColor redColor];
    }
}

- (void)animateView:(NSUInteger)tag{
    CGPoint point = CGPointMake(0, 0);
    if (tag>0) {
        point.y = point.y +(tag-1)*50+50;
        [_scrollView setContentOffset:point animated:YES];
    }else{
        [_scrollView setContentOffset:point animated:YES];
    }
}

#pragma mark -------------- 服务条款 ------------
- (void)termsOfServiceBtnPressed:(UIButton_custom *)sender {
    _booTextField = NO;
    lowooWebVC *webVC = [[lowooWebVC alloc]init];
    webVC.urlString = [NSString stringWithFormat:@"http://bc.lowoo.cc/term.html"];
    webVC.navTitle = [BASE International:@"服务条款"];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark --------------- 注册 -----------
- (void)regist{
    [self selfViewTaped];//回收键盘，重新布局页面到初始布局
    if (!_boolAgreed) {
        [liboTOOLS alertViewMSG:[BASE International:@"必须同意服务条款才能注册使用"]];
        return;
    }
    if (_textFieldUserEmail.text.length == 0) {
        [liboTOOLS alertViewMSG:[BASE International:@"用户邮箱不能为空"]];
        return;
    }else{
        _textFieldUserEmail.textColor = [UIColor blackColor];
        if (![self checkInPutEmail:_textFieldUserEmail.text]) {
            [liboTOOLS alertViewMSG:[BASE International:@"邮箱格式不正确"]];
            _textFieldUserEmail.textColor = [UIColor redColor];
            return;
        }
    }
    if (_textFieldPassword.text.length == 0) {
        [liboTOOLS alertViewMSG:[BASE International:@"密码不能为空"]];
        return;
    }
    
    if (![_textFieldPassword.text isEqualToString:_textFieldConfirmPassword.text]) {
        [liboTOOLS alertViewMSG:[BASE International:@"两次密码不同"]];
        return;
    }

    
    NSMutableDictionary *UserDataDict = [[NSMutableDictionary alloc]init];
    [UserDataDict setObject:_textFieldUserEmail.text forKey:@"uid"];
    [UserDataDict setObject:_textFieldPassword.text forKey:@"password"];
    [liboTOOLS showHUD:[BASE International:@"正在注册...."]];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:UserDataDict requestType:userRegist];
}

#pragma mark ---------- 注册返回 ---------
- (void)didRegist:(NSNotification *)sender{
    if (![BASE isNotNull:sender.userInfo]) {
        return;
    }
    
    if ([[sender.userInfo objectForKey:@"state"] intValue]==1) {
        [self selfViewTaped];
        if ([_delegate respondsToSelector:@selector(didRegist:pass:)]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SYSTEM_BOOT_0];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:HELP_CENTER];
            [_delegate didRegist:_textFieldUserEmail.text pass:_textFieldPassword.text];
        }
    }else{
        //注册失败
        [liboTOOLS dismissHUD];
        if (LANGUAGE_CHINESE) {
            [liboTOOLS alertViewMSG:(NSString *)[sender.userInfo objectForKey:@"msg"]];
        }else{
            [liboTOOLS alertViewMSG:(NSString *)[sender.userInfo objectForKey:@"e_msg"]];
        }
        
        return;
    }
}

#pragma mark----------cancelButton---------
- (void)cancelButtonDidTouchedUpInside:(UIButton_custom *)sender {
    _booTextField = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark----------enterButton---------
- (void)enterButtonDidTouchedUpInside:(UIButton_custom *)sender {
    [self regist];
}



#pragma mark----------正则表达式,判断邮箱---------
//判断邮箱
- (BOOL)checkInPutEmail:(NSString *)text{
    NSString *Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [emailTest evaluateWithObject:text];
}

//判断用户名，在2－16位
- (BOOL)CheckInputNikeName:(NSString *)_text
{
    NSString *Regex = @"^\\w{2,16}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [emailTest evaluateWithObject:_text];
}

//判断密码，6－16位
- (BOOL)CheckInputPassword:(NSString *)_text
{
    NSString *Regex = @"\\w{6,16}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [emailTest evaluateWithObject:_text];
}

//判断中文
- (BOOL)Chinese:(NSString *)string{
    if (!string && [string isEqualToString:@""]) {
        return NO;
    }else{
        for (int i=0; i<string.length; i++) {
            int utfCode = 0;
            void *buffer = &utfCode;
            NSRange range = {i,1};
            NSString *word = [string substringWithRange:range];//取得单个字符
            BOOL b = [word getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
            if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5)) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)dealloc{

}


@end
