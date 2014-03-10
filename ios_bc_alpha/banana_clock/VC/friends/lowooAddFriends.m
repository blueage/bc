//
//  lowooAddFriends.m
//  banana clock
//
//  Created by MAC on 12-10-17.
//  Copyright (c) 2012年 MAC. All rights reserved.
//
#define ADDheight -35

#import "lowooAddFriends.h"
#import "lowooAppDelegate.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "JSON.h"
#import "JSONKit.h"

@implementation lowooAddFriends

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"ADD FRIEND";
    [self changeTitle];
    [self.tabBarController hidesBottomBarViewWhenPushed:NO];
    [self.tabBarController hidesTimeTitleWhenPushed:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _zbarView = nil;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushTwoDimensionCode:) name:@"TwoDimensionCode" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSearchUser:) name:@"getSearchUser" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    //主view为scrollView
    if (_scrollView) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
    }
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -4, 320, SCREEN_HEIGHT)];
    _scrollView.backgroundColor = [UIColor clearColor];
    if (iPhone5||iPhone5_0) {
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-48);
    }else{
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+.1);
    }
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    {
    //sina  新浪
    _viewIntroduceSina = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 190+ADDheight, 276, 55)];
    _viewIntroduceSina.button.userInteractionEnabled = YES;
    [_viewIntroduceSina.button addTarget:self action:@selector(buttonWeiboTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    _viewIntroduceSina.imageView.image = GetPngImage(@"jiantou");
    [_scrollView addSubview:_viewIntroduceSina];
    
    //二维码
    _viewIntroduceQR = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 244+ADDheight, 276, 55)];
    _viewIntroduceQR.button.userInteractionEnabled = YES;
    [_viewIntroduceQR.button addTarget:self action:@selector(buttonQRCodeTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    _viewIntroduceQR.imageView.image = GetPngImage(@"jiantou");
    [_scrollView addSubview:_viewIntroduceQR];
    
    //通讯录
    _viewIntroducePhoneBook = [[viewIntroduceButton alloc] initWithFrame:CGRectMake(22, 298+ADDheight, 276, 55)];
    _viewIntroducePhoneBook.button.userInteractionEnabled = YES;
    [_viewIntroducePhoneBook.button addTarget:self action:@selector(buttonPhoneBookTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    _viewIntroducePhoneBook.imageView.image = GetPngImage(@"jiantou");
    [_scrollView addSubview:_viewIntroducePhoneBook];
    }//使键盘返回键在其上面
    
    //使键盘返回
    _buttonTap = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [_buttonTap setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _buttonTap.backgroundColor = [UIColor clearColor];
    [_buttonTap addTarget:self action:@selector(tapBtnPressed:)];
    [_scrollView addSubview:_buttonTap];
    _buttonTap.userInteractionEnabled = NO;
    
    //搜索框
    UIImageView *imageViewTextField = [[UIImageView alloc]initWithFrame:CGRectMake(20, 70+ADDheight, 280, 55)];
    [imageViewTextField setImage:GetPngImage(@"List_item_bg01")];
    [_scrollView addSubview:imageViewTextField];
    
    UILabel *labelID = [[UILabel alloc]initWithFrame:CGRectMake(36, 74+ADDheight, 80, 42)];
    labelID.backgroundColor = [UIColor clearColor];
    labelID.text = @"ID:";
    [labelID setTextAlignment:NSTextAlignmentLeft];
    [labelID setFont:[UIFont systemFontOfSize:16.0f]];
    [labelID setTextColor:COLOR_CHINESE];
    [_scrollView addSubview:labelID];
    
    _textFieldID = [[UITextField alloc] initWithFrame:CGRectMake(65, 83+ADDheight+[BASE height5_ISO6], 220, 25)];
    _textFieldID.backgroundColor = [UIColor clearColor];
    _textFieldID.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textFieldID.placeholder = [BASE International:@"请输入用户ID"];
    [_textFieldID setTextAlignment:NSTextAlignmentLeft];
    [_textFieldID setFont:[UIFont systemFontOfSize:14.0f]];
    _textFieldID.delegate = self;
    [_textFieldID setReturnKeyType:UIReturnKeyDone];
    [_scrollView addSubview:_textFieldID];
    
    //搜素按钮
    UIButton_custom *buttonSearch = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonSearch setFrame:CGRectMake(176, 130+ADDheight, 119, 53)];
    buttonSearch.highlighted = NO;
    [buttonSearch setImageNormal:GetPngImage(@"add-friends-search")];
    [buttonSearch setImageHighlited:GetPngImage(@"add-friends-searchb")];
    [buttonSearch addTarget:self action:@selector(buttonSearchTouchUpInside:)];
    [_scrollView addSubview:buttonSearch];
    
    

 
    
    
    if (LANGUAGE_CHINESE) {
        //新浪微博
        _viewIntroduceSina.viewIntroduce.labelChinese.text = @"新浪微博";
        _viewIntroduceSina.viewIntroduce.labelChineseEnglish.text = @"Sina Weibo";
        
        //二维码
        _viewIntroduceQR.viewIntroduce.labelChinese.text = @"二维码扫描";
        _viewIntroduceQR.viewIntroduce.labelChineseEnglish.text = @"QR Code";
        
        //通讯录
        _viewIntroducePhoneBook.viewIntroduce.labelChinese.text = @"通讯录";
        _viewIntroducePhoneBook.viewIntroduce.labelChineseEnglish.text = @"Phone Book";
        
    }else{
        _viewIntroduceSina.viewIntroduce.labelEnglish.text = @"Sina Weibo";
        _viewIntroduceQR.viewIntroduce.labelEnglish.text = @"QR Code";
        _viewIntroducePhoneBook.viewIntroduce.labelEnglish.text = @"Phone Book";
    }
    
    [self.view addSubview:_scrollView];
}


- (void)pushTwoDimensionCode:(NSNotification *)sender{
    NSString *params = [sender.userInfo objectForKey:@"string"];
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSDictionary *param = [parser objectWithString:params];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[param objectForKey:@"fid"], @"fid", nil];
    if ([self.manager isExistenceNetwork]) {
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:dictionary requestType:searchUser];
    }
}


#pragma mark----tapView------
- (void)tapBtnPressed:(id)sender {
    [_textFieldID resignFirstResponder];
    if (_textFieldID.text.length==0 && [_textFieldID.text isEqualToString:[NSString stringWithFormat:@""]]) {
        
    }
}

#pragma mark--------UITextFieldDelegate-------
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _buttonTap.userInteractionEnabled = YES;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textFieldID resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    _buttonTap.userInteractionEnabled = NO;
    return YES;
}



- (void)buttonSearchTouchUpInside:(UIButton_custom *)sender {
    [self textFieldShouldReturn:_textFieldID];
    
    if (![_textFieldID.text isEqualToString:@""]&&_textFieldID.text.length!=0 ) {
        [[activityView sharedActivityView] showHUD:5];
        if ([self.manager isExistenceNetwork]) {
            [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:_textFieldID.text, @"fid", nil] requestType:searchUser];
        }
    }else{

    }
}

- (void)getSearchUser:(NSNotification *)sender{
    [[activityView sharedActivityView] removeHUD];
    if (sender.object == nil) {
        [liboTOOLS alertViewMSG:[BASE International:@"此用户不存在"]];
        return;
    }
    modelUser *user = sender.object;
    
    if (user.relation == 5 || user.relation == 0 || user.relation == 2 || user.relation == 3){//申请中
        lowooAddFriendsListVC *addFriendsList = [[lowooAddFriendsListVC alloc] init];
        addFriendsList.user = user;
        [self.navigationController pushViewController:addFriendsList animated:YES];
    }else if (user.relation == 1){//已经是好友
        lowooAddFriendsListVC *addFriendsList = [[lowooAddFriendsListVC alloc] init];
        addFriendsList.user = user;
        [self.navigationController pushViewController:addFriendsList animated:YES];
        //[liboTOOLS alertViewMSG:[NSString stringWithFormat:@"%@ %@",_textFieldID.text,[BASE International:@"已经是你的好友"]]];
    }else if (user.relation == 6){//我在他的黑名单中
        [liboTOOLS alertViewMSG:[BASE International:@"此用户不存在"]];
    }else if (user.relation == 4){//他在我的黑名单中
        [liboTOOLS alertViewMSG:[BASE International:@"该用户已被你加入黑名单，若想添加好友，请先从黑名单中移除"]];
    }else if (user.relation == 7){//搜索的是自己
        lowooAddFriendsListVC *addFriendsList = [[lowooAddFriendsListVC alloc] init];
        addFriendsList.user = user;
        [self.navigationController pushViewController:addFriendsList animated:YES];
    }else{
        [liboTOOLS alertViewMSG:[BASE International:@"此用户不存在"]];
    }

}

- (void)buttonWeiboTouchUpInside:(UIButton_custom *)sender {
    [[activityView sharedActivityView] showHUD:10];
    lowooSina *sinaView = [[lowooSina alloc] init];
    [self.navigationController pushViewController:sinaView animated:YES];
}

//通讯录
- (void)buttonPhoneBookTouchUpInside:(UIButton_custom *)sender{
    if ([[userModel sharedUserModel] getUserInformationWithKey:USER_PHONENUMBER]&&![[[userModel sharedUserModel] getUserInformationWithKey:USER_PHONENUMBER] isEqualToString:@""]) {
        _phoneBook = [[lowooPhoneBookViewController alloc]init];
        [self.navigationController pushViewController:_phoneBook animated:YES];
    }else{
        phoneNumberBinding *phoneNumber = [[phoneNumberBinding alloc] init];
        phoneNumber.delegate = self;
        [self.navigationController pushViewController:phoneNumber animated:YES];
    }
}

- (void)phoneNumberBinded{
    [self buttonPhoneBookTouchUpInside:Nil];
}

- (void)buttonQRCodeTouchUpInside:(UIButton_custom *)sender {
    //跳到firstvc进行push
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QRCode" object:nil userInfo:nil];

    [self.tabBarController hidesBottomBarViewWhenPushed:YES];
    [self.tabBarController hidesTimeTitleWhenPushed:YES];
  //  [self setHidesBottomBarWhenPushed:YES];
    _zbarView = [[lowooZBar alloc] init];
    [self.navigationController presentViewController:_zbarView animated:YES completion:^{
        
    }];
}



@end
