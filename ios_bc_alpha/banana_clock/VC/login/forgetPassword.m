//
//  forgetPassword.m
//  banana_clock
//
//  Created by MAC on 13-12-3.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "forgetPassword.h"

@interface forgetPassword ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) THLabel *labelTitle;
@end

@implementation forgetPassword

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.navigationController.navigationBarHidden = NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgotPassword:) name:@"forgotPassword" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIImageView *imageview;
    if (iPhone5||iPhone5_0) {
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, -5, 320, SCREEN_HEIGHT)];
        imageview.image = GetPngImage(@"iphone5bc");
    }else{
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, -5, 320, SCREEN_HEIGHT)];
        imageview.image = GetPngImage(@"iphone4bc");
    }
    [self.view addSubview:imageview];
    
    UIImageView *imageviewBack = [[UIImageView alloc] initWithFrame:CGRectMake(22, 88, 276, 55)];
    imageviewBack.image = GetPngImage(@"List_item_bg01");
    [self.view addSubview:imageviewBack];

    _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, 260, 30)];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.placeholder = @"请输入您的邮箱";
    [self.view addSubview:_textField];
    
    UIButton_custom *buttonDetermine = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonDetermine setFrame:CGRectMake(81, 150, 157, 53) image:[BASE International:@"POPDeterminea"] image:[BASE International:@"POPDetermineb"]];
    [buttonDetermine addTarget:self action:@selector(buttonDetermineAction)];
    [self.view addSubview:buttonDetermine];
    
    
    _labelTitle = [[THLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    _labelTitle.backgroundColor = [UIColor clearColor];
    _labelTitle.textColor = [UIColor colorWithRed:110/255 green:116/255 blue:129/255 alpha:0.5];
    [_labelTitle setFont:[UIFont boldSystemFontOfSize:17]];
    [_labelTitle setTextAlignment:NSTextAlignmentCenter];
    _labelTitle.shadowColor = [UIColor blackColor];
    _labelTitle.shadowOffset = CGSizeMake(-0.5f, -0.5f);
    _labelTitle.text = [BASE International:@"找回密码"];
    [self.navigationController.navigationBar addSubview:_labelTitle];
}

- (void)forgotPassword:(NSNotification *)sender{
    [[activityView sharedActivityView] removeHUD];
    if ([[sender.userInfo objectForKey:@"state"] intValue]==1) {
        if (LANGUAGE_CHINESE) {
            [liboTOOLS alertViewMSG:[sender.userInfo objectForKey:@"msg"]];
        }else{
            [liboTOOLS alertViewMSG:[sender.userInfo objectForKey:@"e_msg"]];
        }
    }else{
        if (LANGUAGE_CHINESE) {
            [liboTOOLS alertViewMSG:[sender.userInfo objectForKey:@"msg"]];
        }else{
            [liboTOOLS alertViewMSG:[sender.userInfo objectForKey:@"e_msg"]];
        }
    }
}

- (void)buttonDetermineAction{
    if (_textField.text.length>0) {
        if ([self checkInPutEmail:_textField.text]) {
            [[activityView sharedActivityView] showHUD:-1];
            [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:_textField.text, @"email", nil] requestType:forgotPassword];
        }else{
            [liboTOOLS alertViewMSG:[BASE International:@"邮箱格式不正确"]];
        }
    }else{
       [liboTOOLS alertViewMSG:[BASE International:@"邮箱不能为空"]];
    }
    
}

- (BOOL)checkInPutEmail:(NSString *)text{
    NSString *Regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [emailTest evaluateWithObject:text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
