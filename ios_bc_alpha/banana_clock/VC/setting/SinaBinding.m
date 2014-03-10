//
//  SinaBinding.m
//  banana_clock
//
//  Created by MAC on 13-7-31.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "SinaBinding.h"

@interface SinaBinding ()

@end

@implementation SinaBinding

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpFailed) name:@"httpFailed" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasGotSinaAuthorize:) name:@"hasGotSinaAuthorize" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sianLogOut) name:@"sianLogOut" object:nil];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"SINA BINDING";
    [self changeTitle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self initView];
}

- (void)initView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -2, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;

    [self.view addSubview:scrollView];
    
    _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(22, 37, 270, 55)];
    _imageview.image = GetPngImage(@"List_item_bg01");
    _imageview.alpha = 0.5;
    [scrollView addSubview:_imageview];
    _imageview.hidden = YES;
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 52, 250, 30)];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.delegate = self;
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.textColor = [UIColor colorWithRed:24/255.0 green:52/255.0 blue:66/255.0 alpha:1];
    [scrollView addSubview:_textField];
    _textField.hidden = YES;
    _textField.userInteractionEnabled = NO;

    
    _labelPrompt = [[UILabel alloc] initWithFrame:CGRectMake(22, 100, 270, 60)];
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
    
    if ([[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME]&&![[[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME] isEqualToString:@""]) {
        _textField.text = [[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME];
        _textField.hidden = NO;
        _imageview.hidden = NO;
        [_labelPrompt setFrame:CGRectMake(22, 80, 270, 60)];
        _buttonUnbind.hidden = NO;
        if (LANGUAGE_CHINESE) {
            _labelPrompt.text = @"你已经绑定了新浪微博，赶快在‘好友列表’添加好友中使用新浪微博查找更多朋友吧。";
            [_buttonUnbind setImage:GetPngImage(@"Unbind") forState:UIControlStateNormal];
            [_buttonUnbind setImage:GetPngImage(@"Unbindb") forState:UIControlEventTouchDown];
            [_buttonBinding setImage:GetPngImage(@"Binding") forState:UIControlStateNormal];
            [_buttonBinding setImage:GetPngImage(@"Bindingb") forState:UIControlEventTouchDown];
        }else{
            _labelPrompt.text = @"You have linked your Sina Weibo ID and can use related features to find more friends.";
            [_buttonUnbind setImage:GetPngImage(@"UnbindEnglish") forState:UIControlStateNormal];
            [_buttonUnbind setImage:GetPngImage(@"UnbindbEnglish") forState:UIControlEventTouchDown];
            [_buttonBinding setImage:GetPngImage(@"BindingEnglish") forState:UIControlStateNormal];
            [_buttonBinding setImage:GetPngImage(@"BindingbEnglish") forState:UIControlEventTouchDown];
        }
    }else{
        [_labelPrompt setFrame:CGRectMake(22, 50, 270, 60)];
        _buttonBinding.hidden = NO;
        if (LANGUAGE_CHINESE) {
            _labelPrompt.text = @"绑定新浪微博，你可以使用相关的功能找到更多的朋友并且让你的好友更方便的找到你。";
            [_buttonUnbind setImage:GetPngImage(@"Unbind") forState:UIControlStateNormal];
            [_buttonUnbind setImage:GetPngImage(@"Unbindb") forState:UIControlEventTouchDown];
            [_buttonBinding setImage:GetPngImage(@"Binding") forState:UIControlStateNormal];
            [_buttonBinding setImage:GetPngImage(@"Bindingb") forState:UIControlEventTouchDown];
        }else{
            _labelPrompt.text = @"Linked your Sina Weibo ID and can use related features to find more friends.";
            [_buttonUnbind setImage:GetPngImage(@"UnbindEnglish") forState:UIControlStateNormal];
            [_buttonUnbind setImage:GetPngImage(@"UnbindbEnglish") forState:UIControlEventTouchDown];
            [_buttonBinding setImage:GetPngImage(@"BindingEnglish") forState:UIControlStateNormal];
            [_buttonBinding setImage:GetPngImage(@"BindingbEnglish") forState:UIControlEventTouchDown];
        }
        [self setRightButton];
    }
}

- (void)setRightButton{
    [self.buttonRight setFrame:CGRectMake(-12, 3, 61, 36)];
    [self.buttonRight setImage:GetPngImage([BASE International:@"save_CNa"]) forState:UIControlStateNormal];
    [self.buttonRight setImage:GetPngImage([BASE International:@"save_CNb"]) forState:UIControlEventTouchDown];
    self.viewRightButton.hidden = NO;
}

- (void)buttonAction:(UIButton_custom *)sender{
    if ([self.manager isExistenceNetwork]) {
        if ([[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME]&&![[[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME] isEqualToString:@""]) {//解除绑定
            _sina = [[lowooSinaWeibo alloc] init];
            [_sina logout];
        }else{//授权绑定
            _sina = [[lowooSinaWeibo alloc] init];
            _sina.delegate = self;
            [_sina doMicrobloggingCertification];
        }
    }
}

- (void)sinaLogInDidCancel:(lowooSinaWeibo *)sina{
    [[activityView sharedActivityView] removeHUD];
}

- (void)sinaWeiboLoginFaild:(lowooSinaWeibo *)sina{
    [[activityView sharedActivityView] removeHUD];
}

//授权成功
- (void)hasGotSinaAuthorize:(NSNotification *)sender{
    [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:[sender.userInfo objectForKey:@"idstr"], @"sinaID", [sender.userInfo objectForKey:@"name"], @"sinaName", nil]  requestType:upLoadSinaID];
    _imageview.hidden = NO;
    _textField.hidden = NO;
    [_labelPrompt setFrame:CGRectMake(22, 80, 270, 60)];
    _textField.text = [[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME];
    if (LANGUAGE_CHINESE) {
        _labelPrompt.text = @"你已经绑定了新浪微博，赶快在‘好友列表’添加好友中使用新浪微博查找更多朋友吧。";
    }else{
        _labelPrompt.text = @"You have linked your Sina Weibo ID and can use related features to find more friends.";
    }
    _buttonBinding.hidden = YES;
    _buttonUnbind.hidden = NO;
}

//取消绑定
- (void)sianLogOut{
    if ([self.manager isExistenceNetwork]) {
        [self.manager doHTTPRequestWithPostFields:nil requestType:deleteSinaID];
        [_labelPrompt setFrame:CGRectMake(22, 70, 270, 60)];
        _imageview.hidden = YES;
        _textField.hidden = YES;
        [[userModel sharedUserModel] setUserInformation:@"" forKey:SINA_NAME];
        if (LANGUAGE_CHINESE) {
            _labelPrompt.text = @"绑定新浪微博，你可以使用相关的功能找到更多的朋友并且让你的好友更方便的找到你。";
        }else{
            _labelPrompt.text = @"Linked your Sina Weibo ID and can use related features to find more friends.";
        }
        _buttonBinding.hidden = NO;
        _buttonUnbind.hidden = YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return YES;
}

- (void)dealloc{
    _sina.delegate = nil; _sina = nil;
}


@end
