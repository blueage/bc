//
//  lowooDeleteFromeBlackListViewController.m
//  banana_clock
//
//  Created by MAC on 13-8-14.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooDeleteFromeBlackListViewController.h"
#import "JSONKit.h"
#import "JSON.h"

@interface lowooDeleteFromeBlackListViewController ()

@end

@implementation lowooDeleteFromeBlackListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"REMOVE BLACKLIST";
    [self changeTitle];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *viewBase = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
    if (iPhone5) {
        
    }else{
        [viewBase setFrame:CGRectMake(0, 80, 320, 200)];
    }
    [self.view addSubview:viewBase];

    _viewHead  = [[viewHead alloc] init];
    _viewHead.view = [[UIView alloc] initWithFrame:CGRectZero];
    [viewBase addSubview:_viewHead.view];
    [_viewHead.view setFrame:CGRectMake(0, 0, 0, 0)];
    
    UIButton_custom *buttonDelete = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonDelete setFrame:CGRectMake(54, 140, 212, 53)];
    [buttonDelete addTarget:self action:@selector(buttonDeleteAction:)];
    if (LANGUAGE_CHINESE) {
        [buttonDelete setImageNormal:GetPngImage(@"Remove_blacklist")];
        [buttonDelete setImageHighlited:GetPngImage(@"Remove_blacklistb")];
    }else{
        [buttonDelete setImageNormal:GetPngImage(@"Remove_blacklistEnglish")];
        [buttonDelete setImageHighlited:GetPngImage(@"Remove_blacklistbEnglish")];
    }
    [viewBase addSubview:buttonDelete];
    
    [self initView];
}

- (void)initView{

}

- (void)confirmUser:(modelUser *)user{
    if (user.avatarUrl) {
        [_viewHead setImageWithUrl:user.avatarUrl name:user.name];
    }else{
        [_viewHead setImageWithUrl:@"" name:user.name];
    }
    
    _stringID = user.fid;
}

- (void)buttonDeleteAction:(UIButton_custom *)sender{
    [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: _stringID, @"fid", nil] requestType:removeFromBlackNameList];
    sender.userInteractionEnabled = NO;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
