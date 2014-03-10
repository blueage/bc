//
//  emailBinding.m
//  banana_clock
//
//  Created by MAC on 13-7-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//
#import "emailBinding.h"

@interface emailBinding ()

@end

@implementation emailBinding

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpFailed) name:@"httpFailed" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyMailbox:) name:@"modifyMailbox" object:nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"EMAIL MODIFICATION";
    [self changeTitle];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.viewRightButton.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.viewRightButton.hidden = YES;
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
    
    _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(22, 37, 276, 55)];
    _imageview.image = GetPngImage(@"List_item_bg01");
    [scrollView addSubview:_imageview];
    _imageview.hidden = YES;
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 51, 250, 30)];
    _textField.delegate = self;
    _textField.clearButtonMode  = UITextFieldViewModeWhileEditing;
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.text = [[userModel sharedUserModel] getUserInformationWithKey:USER_EMAIL];
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
    
    //邮箱地址必须绑定
    _textField.text = [[userModel sharedUserModel] getUserInformationWithKey:USER_EMAIL];
    _textField.hidden = NO;
    _imageview.hidden = NO;

    if (LANGUAGE_CHINESE) {
        _labelPrompt.text = @"你已绑定邮箱地址，当忘记密码时你可以通过此邮箱重置你的BananaClock密码。";
    }else{
        _labelPrompt.text = @"You can reset your BananaClock password via this email.";
    }
    
}

- (void)setRightButton{
    [self.buttonRight setFrame:CGRectMake(-12, 3, 61, 36)];
    [self.buttonRight setImage:GetPngImage([BASE International:@"save_CNa"]) forState:UIControlStateNormal];
    [self.buttonRight setImage:GetPngImage([BASE International:@"save_CNb"]) forState:UIControlEventTouchDown];
    self.viewRightButton.hidden = NO;
}

- (void)rightButtonTouchUpInside{
    //检查格式 并上传服务器
    if ([self checkInPutEmail:_textField.text]) {
        if ([_textField.text isEqualToString:[[userModel sharedUserModel] getUserInformationWithKey:USER_EMAIL]]) {
            [liboTOOLS alertViewMSG:[BASE International:@"上传邮箱已经是你绑定的邮箱"]];
            return;
        }
        if ([self.manager isExistenceNetwork]) {
            [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: _textField.text, @"email", nil] requestType:modifyMailbox];
            [liboTOOLS showHUD:[BASE International:@"请稍后.."]];
        }
    }else{
        [liboTOOLS alertViewMSG:[BASE International:@"邮箱格式不正确"]];
    }
}

- (void)buttonAction:(UIButton_custom *)sender{


}

#pragma mark----------正则表达式,判断邮箱---------
//判断邮箱
- (BOOL)checkInPutEmail:(NSString *)text{
    NSString *Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [emailTest evaluateWithObject:text];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self setRightButton];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    self.viewRightButton.hidden = YES;
    [self rightButtonTouchUpInside];
    return YES;
}

//更改邮箱返回
- (void)modifyMailbox:(NSNotification *)sender{
    [liboTOOLS dismissHUD];
    if ([[sender.userInfo objectForKey:@"state"] intValue]==1) {
        //更改
        _boolbinding = NO;
        _imageview.hidden = NO;
        _textField.hidden = NO;
        _textField.userInteractionEnabled = YES;
        [_textField resignFirstResponder];
        
        if (LANGUAGE_CHINESE) {
            _labelPrompt.text = @"你可以修改你的电子邮件地址，当忘记密码时你可以通过此邮箱重置你的BananaClock密码。";
        }else{
            _labelPrompt.text = @"you can modify your email address. You can reset your BananaClock password via this email.";
        }
        [[userModel sharedUserModel] setUserInformation:_textField.text forKey:USER_EMAIL];
        [_textField resignFirstResponder];
    }else{
        [liboTOOLS alertViewMSG:[BASE International:@"该邮箱已经被占用"]];
    }
    
}



@end
