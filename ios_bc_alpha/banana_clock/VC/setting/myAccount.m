//
//  myAccount.m
//  banana_clock
//
//  Created by MAC on 13-7-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "myAccount.h"
#import "emailBinding.h"
#import "phoneNumberBinding.h"
#import "SinaBinding.h"

@implementation myAccount

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    [self loadData];
    self.stringTitle = @"MY ACCOUNTS";
    [self changeTitle];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView{
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -2, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+1);
    [self.view addSubview:scrollview];
    
    //邮箱
    _buttonEmail = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 37, 276, 55)];
    _buttonEmail.button.userInteractionEnabled = YES;
    _buttonEmail.button.tag = 0;
    [_buttonEmail.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _buttonEmail.imageView.image = GetPngImage(@"jiantou");
    [scrollview addSubview:_buttonEmail];
    
    _labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(145, 36, 120, 55)];
    _labelEmail.textAlignment = NSTextAlignmentRight;
    _labelEmail.backgroundColor = [UIColor clearColor];
    [scrollview addSubview:_labelEmail];
    _labelEmail.font = [UIFont systemFontOfSize:14.0f];
    _labelEmail.textColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    _labelEmail.text = [[userModel sharedUserModel] getUserInformationWithKey:USER_EMAIL];//邮箱必须存在

    
    //sina
    _buttonSina = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 37+54, 276, 55)];
    _buttonSina.button.userInteractionEnabled = YES;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"autoLogin"]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"autoLogin"] isEqualToString:@"sina"]) {
            _buttonSina.button.userInteractionEnabled = NO;
            _buttonSina.imageView.hidden = YES;
        }
    }
    _buttonSina.button.tag = 1;
    [_buttonSina.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _buttonSina.imageView.image = GetPngImage(@"jiantou");
    [scrollview addSubview:_buttonSina];
    
    _labelSina = [[UILabel alloc] initWithFrame:CGRectMake(145, 36+55, 120, 55)];
    _labelSina.textAlignment = NSTextAlignmentRight;
    _labelSina.backgroundColor = [UIColor clearColor];
    _labelSina.font = [UIFont systemFontOfSize:14.0f];
    _labelSina.textColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    [scrollview addSubview:_labelSina];
    
    //电话
    _buttonPhoneNumber = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 37+54*2, 276, 55)];
    _buttonPhoneNumber.button.userInteractionEnabled = YES;
    _buttonPhoneNumber.button.tag = 2;
    [_buttonPhoneNumber.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _buttonPhoneNumber.imageView.image = GetPngImage(@"jiantou");
    [scrollview addSubview:_buttonPhoneNumber];
    
    _labelPhoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(145, 36+54*2, 120, 55)];
    _labelPhoneNumber.textAlignment = NSTextAlignmentRight;
    _labelPhoneNumber.backgroundColor = [UIColor clearColor];
    _labelPhoneNumber.font = [UIFont systemFontOfSize:14.0f];
    _labelPhoneNumber.textColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    [scrollview addSubview:_labelPhoneNumber];
    

    NSString *name = [[userModel sharedUserModel] getUserInformationWithKey:USER_NAME];
    if (name.length > 8) {
        if ([[name substringWithRange:NSMakeRange(name.length-8, 8)] isEqualToString:@"(来自新浪微博)"]) {
            if (![[userModel sharedUserModel] getUserInformationWithKey:USER_PASSWORD]) {
                return;
            }else if ([[[userModel sharedUserModel] getUserInformationWithKey:USER_PASSWORD] isEqualToString:@""]){
                return;
            }
        }
    }
    //密码
    _buttonPassword = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 37+54*3+10, 277, 55)];
    _buttonPassword.button.userInteractionEnabled = YES;
    _buttonPassword.button.tag = 3;
    [_buttonPassword.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _buttonPassword.imageView.image = GetPngImage(@"jiantou");
    [scrollview addSubview:_buttonPassword];
}

- (void)loadData{
    //中文
    _labelEmail.text = [[userModel sharedUserModel] getUserInformationWithKey:USER_EMAIL];//邮箱必须存在
    
    if (LANGUAGE_CHINESE) {
        _buttonEmail.viewIntroduce.labelChinese.text = @"邮箱";
        _buttonEmail.viewIntroduce.labelChineseEnglish.text = @"Email";
        
        _buttonSina.viewIntroduce.labelChinese.text = @"新浪微博";
        _buttonSina.viewIntroduce.labelChineseEnglish.text = @"sina";

        if ([[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME]&&![[[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME] isEqualToString:@""]) {
            _labelSina.text = [[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME];
        }else{
            _labelSina.text = @"未绑定";
        }
        
        _buttonPhoneNumber.viewIntroduce.labelChinese.text = @"电话号码";
        _buttonPhoneNumber.viewIntroduce.labelChineseEnglish.text = @"Phone Number";
        if ([[[userModel sharedUserModel] getUserInformationWithKey:USER_PHONENUMBER] length]>0) {
            _labelPhoneNumber.text = [[userModel sharedUserModel] getUserInformationWithKey:USER_PHONENUMBER];
        }else{
            _labelPhoneNumber.text = @"未绑定";
        }
        
        _buttonPassword.viewIntroduce.labelChinese.text = @"密码";
        _buttonPassword.viewIntroduce.labelChineseEnglish.text = @"Password";
    }else{
        _buttonEmail.viewIntroduce.labelEnglish.text = @"Email";
        _buttonSina.viewIntroduce.labelEnglish.text = @"sina";
        _buttonPhoneNumber.viewIntroduce.labelEnglish.text = @"Phone Number";
        
        if ([[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME]&&![[[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME] isEqualToString:@""]) {
            _labelSina.text = [[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME];
        }else{
            _labelSina.text = @"Unbound";
        }
        
        if ([[[userModel sharedUserModel] getUserInformationWithKey:USER_PHONENUMBER] length]>0) {
            _labelPhoneNumber.text = [[userModel sharedUserModel] getUserInformationWithKey:USER_PHONENUMBER];
        }else{
            _labelPhoneNumber.text = @"Unbound";
        }
        
        _buttonPassword.viewIntroduce.labelEnglish.text = @"Password";
    }
}

- (void)buttonAction:(UIButton_custom *)sender{
    if (sender.tag==0) {
        emailBinding *email = [[emailBinding alloc] init];
        [self.navigationController pushViewController:email animated:YES];
    }else if (sender.tag==1){
        SinaBinding *sina = [[SinaBinding alloc] init];
        [self.navigationController pushViewController:sina animated:YES];
    }else if (sender.tag==2){
        phoneNumberBinding *phoneNumber = [[phoneNumberBinding alloc] init];
        [self.navigationController pushViewController:phoneNumber animated:YES];
    }else if (sender.tag==3){
        lowooChangePassword *changePassswordVC = [[lowooChangePassword alloc] init];
        [self.navigationController pushViewController:changePassswordVC animated:YES];
    }

}




@end
