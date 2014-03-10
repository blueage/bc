//
//  lowooViewController.m
//  banana_clock
//
//  Created by MAC on 13-3-31.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooViewController.h"
#import "UINavigationBar_custom.h"

@interface lowooViewController ()

@end

@implementation lowooViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //self.boolPush = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //self.boolPush = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_viewLeftButton removeFromSuperview];
    _viewLeftButton = nil;
    [_viewRightButton removeFromSuperview];
    _viewRightButton = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"international" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(offline) name:@"offline" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memoryChech:) name:MEMORY_ADDRESS object:nil];
    }
    return self;
}

- (void)memoryChech:(NSNotification *)notification{
    if ([[notification.userInfo objectForKey:MEMORY_ADDRESS] isEqualToString:self.memoryAddress]) {
        [self memoryNotificationAction:notification];
    }
}

- (void)memoryNotificationAction:(NSNotification *)notification{

}

- (void)offline{
//    if (self) {
//        if (self.superclass) {
//            [self removeFromParentViewController];
//        }
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //libo  顶替第一个加载到试图的tableview 第一个的尾部空间会多出一定距离
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableview];
    _manager = [lowooHTTPManager getInstance];
    self.view.backgroundColor = [UIColor clearColor];//背景图在firstview上，push界面时保持不动
}

#pragma mark------------navigationBar 初始化导航栏左右按钮------
- (void)initNavigationBar{
    if (!_viewLeftButton) {
        //左按钮
        _viewLeftButton = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 49, 90)];
        _viewLeftButton.clipsToBounds = NO;
        _viewLeftButton.backgroundColor = [UIColor clearColor];

        _leftBtn = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"topBtnL01.png"] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"topBtnL02.png"] forState:UIControlEventTouchDown];
        [_leftBtn setHighlighted:NO];
        [_leftBtn setFrame:CGRectMake(0,0,49,40)];
        [_leftBtn addTarget:self action:@selector(leftButtonDidTouchedUpInside) forControlEvents:UIControlEventTouchUpInside];
        [_viewLeftButton addSubview:_leftBtn];
        //_leftBtn.userInteractionEnabled = NO;
        
        _imageViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 19)];
        _imageViewLeft.image = [UIImage imageNamed:@"topicon01.png"];
        [_viewLeftButton addSubview:_imageViewLeft];
        
        //右按钮
        _viewRightButton = [[UIView alloc] initWithFrame:CGRectMake(320-49, 0, 449, 40)];
        _viewRightButton.hidden = YES;
        
        _buttonRight = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonRight setImage:[UIImage imageNamed:@"topBtnR01.png"] forState:UIControlStateNormal];
        [_buttonRight setImage:[UIImage imageNamed:@"topBtnR02.png"] forState:UIControlEventTouchDown];
        [_buttonRight setHighlighted:NO];
        [_buttonRight setFrame:CGRectMake(0,0,49,40)];
        [_buttonRight addTarget:self action:@selector(rightButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [_viewRightButton addSubview:_buttonRight];
        
        _imageViewRight = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 19)];
        [_viewRightButton addSubview:_imageViewRight];
        
        [self.navigationController.navigationBar addSubview:_viewLeftButton];
        [self.navigationController.navigationBar addSubview:_viewRightButton];
        //self.navigationItem.leftItemsSupplementBackButton = YES;
        
        if (IOS_7) {
            UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.leftBarButtonItem = left;
        }
        [self.navigationController.navigationBar setNeedsDisplay];
        [self.navigationItem setHidesBackButton:YES];
    }
    
    self.leftBtn.userInteractionEnabled = YES;
}


#pragma mark----------- 更改语言 ----------
- (void)changeLanguage{
    [self changeTitleWith:self.stringTitle];
    [self updataNetworkData];
    [self initView];
}

- (void)initView{

}

- (void)changeTitle{
    if (self == [self.navigationController.viewControllers lastObject]) {
        [self changeTitleWith:_stringTitle];
    }
}

- (void)changeTitleWith:(NSString *)title{
    _timeTitle = [time_title shareInstance];
    _timeTitle.labelTitle.text = [BASE International:title];
    CGSize sizeContent = CGSizeMake(320, 40);
    CGSize size = [[BASE International:title] sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:sizeContent lineBreakMode:NSLineBreakByCharWrapping];

    
    CGRect frame = _timeTitle.labelTitle.frame;
    frame.origin.x = (SCREEN_WIDTH - 100 - (size.width))/2;
    frame.size.width = size.width + 1;
    _timeTitle.labelTitle.frame = frame;
    
//    CGRect frameButton = _timeTitle.buttonTitle.frame;
//    frameButton.origin.x = CGRectGetMaxX(_timeTitle.labelTitle.frame) + 5;
//    _timeTitle.buttonTitle.frame = frameButton;
    CGRect frameViewButton = _timeTitle.viewButtonTitle.frame;
    frameViewButton.origin.x = CGRectGetMaxX(_timeTitle.labelTitle.frame);
    _timeTitle.viewButtonTitle.frame = frameViewButton;

    [_timeTitle transitionToTitle];
}

#pragma mark-------rightBtnPressed-------------
- (void)rightButtonTouchUpInside{
    
}

#pragma mark-------leftBtnPressed-------------
- (void)leftButtonDidTouchedUpInside{
    self.leftBtn.userInteractionEnabled = NO;
    self.viewLeftButton.hidden = YES;
    self.viewRightButton.hidden = YES;
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


//必须被子类覆盖，已使用不同的参数进行网络交互
- (void)updataNetworkData{
    //self.boolPush = NO;
}

- (void)didUpdataNetworkData:(NSNotification *)notification{

}

- (void)setBoolPushYES{
    self.boolPush = YES;
    [self performSelector:@selector(setboolPushNO) withObject:nil afterDelay:1];
}

- (void)setboolPushNO{
    self.boolPush = NO;
}
//- (void)setBoolPush:(BOOL)boolPush{
//    if (boolPush) {
//        [self performSelector:@selector(setBoolPush:) withObject:NO afterDelay:3];
//    }
//}

- (NSString *)memoryAddress{
    return [NSString stringWithFormat:@"%p",self];
}

- (void)httpFailed{
    [liboTOOLS dismissHUD];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [_viewLeftButton removeFromSuperview]; _viewLeftButton = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
