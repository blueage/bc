//
//  lowooPropsBuy.m
//  banana_clock
//
//  Created by MAC on 13-3-17.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPropsBuy.h"
#import <QuartzCore/QuartzCore.h>
#import "lowooProductManager.h"


static CATransform3D CATransform3DMakePerspective(CGFloat z) {
    CATransform3D t = CATransform3DIdentity;
    t.m34 = - 1.0 / z;
    return t;
}

@interface lowooPropsBuy () <lowooProductManagerDelegate>

@property (nonatomic, strong) lowooProductManager *pmanager;

@end


@implementation lowooPropsBuy

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"SHOP";
    [self changeTitle];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_timerRight invalidate]; _timerRight = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpFailed) name:@"httpFailed" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sianShare) name:@"sianShare" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareList:) name:USER_SHARELIST object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _currentPage = 0;

    [self initView];
}

- (void)initView{
    [_pageScrollView removeFromSuperview];
    [_viewBase removeFromSuperview];
    [_buttonBuy removeFromSuperview];
    
    _arrayImage = nil;
    if (LANGUAGE_CHINESE) {
        _arrayImage = [[NSArray alloc] initWithObjects:@"BuyPic01", @"BuyPic02", @"BuyPic03", @"BuyPic04a", @"BuyPic05", @"BuyPic06", @"BuyPic07", @"BuyPic08", nil];
    }else{
        _arrayImage = [[NSArray alloc] initWithObjects:@"BuyPic01", @"BuyPic02", @"BuyPic03", @"BuyPic04b", @"BuyPic05", @"BuyPic06", @"BuyPic07", @"BuyPic08", nil];
    }
    _pageControl = [[UIPageControl_custom alloc] init];
    _buttonBuy = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    
    if (iPhone5||iPhone5_0) {
        _pageScrollView = [[PagedScrollView alloc] initWithFrame:CGRectMake(0, 20, 320, 227)];
        _viewBase = [[UIView alloc]initWithFrame:CGRectMake(0, 230, 320, 75)];
        _pageControl.frame = CGRectMake(110, 300+[BASE statusBarHeight], 100, 20);
        [_buttonBuy setFrame:CGRectMake(54, 360, 212, 53) image:[BASE International:@"share"] image:[BASE International:@"shareb"]];
    }else{
        _pageScrollView = [[PagedScrollView alloc] initWithFrame:CGRectMake(0, 15, 320, 227)];
        _viewBase = [[UIView alloc]initWithFrame:CGRectMake(0, 217, 320, 75)];
        _pageControl.frame = CGRectMake(110, 285, 100, 20);
        [_buttonBuy setFrame:CGRectMake(54, 305, 212, 53) image:[BASE International:@"share"] image:[BASE International:@"shareb"]];
    }

    _pageControl.numberOfPages = _arrayImage.count;
    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
    
    
    _pageScrollView.delegate = self;
    _pageScrollView.dataSource = self;
    _pageScrollView.minimumPageAlpha = 1;
    _pageScrollView.minimumPageScale = 1;
    [self.view addSubview:_pageScrollView];

    //text动画
    _viewBase.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewBase];
    _viewOne = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 75)];
    _viewOne.backgroundColor = [UIColor clearColor];
    [_viewBase addSubview:_viewOne];
    _viewTwo = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 75)];
    _viewTwo.backgroundColor = [UIColor clearColor];
    [_viewBase addSubview:_viewTwo];
    
    _mutableArrayCell = [[NSMutableArray alloc]init];
    for (int i=0; i<_arrayImage.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 75)];
        NSString *namepng;
        if (LANGUAGE_CHINESE) {
            namepng = [NSString stringWithFormat:@"BuyText%02da",i+1];
        }else{
            namepng = [NSString stringWithFormat:@"BuyText%02db",i+1];
        }
        
        imageView.image = GetPngImage(namepng);
        imageView.backgroundColor = [UIColor clearColor];
        imageView.tag = i;
        [_viewTwo addSubview:imageView];
        imageView.hidden = YES;
        if (i==0) {
            imageView.hidden = NO;
        }
        [_mutableArrayCell addObject:imageView];
    }
    
    
    [self.view addSubview:_buttonBuy];
    [_buttonBuy addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    if ([[[[userModel sharedUserModel] getUserInformationWithKey:USER_SHARELIST] objectForKey:@"weixin"] intValue] == 1) {
        _buttonBuy.alpha = 0.5;
        _buttonBuy.userInteractionEnabled = NO;
    }else{
        _buttonBuy.alpha = 1;
        _buttonBuy.userInteractionEnabled = YES;
    }
    
    //左右箭头
    _imageLeftMore = [[UIImageView alloc] initWithFrame:(CGRect){ 10, 230, 49, 56}];
    _imageLeftMore.image = GetPngImage(@"jiantouLeftMore");
    [self.view addSubview:_imageLeftMore];
    _imageLeftMore.hidden = YES;
    if (iPhone5_0||iPhone5) {
        _imageRightMore = [[UIImageView alloc] initWithFrame:(CGRect){ 260, 130, 49, 56}];
    }else{
        _imageRightMore = [[UIImageView alloc] initWithFrame:(CGRect){ 260, 100, 49, 56}];
    }
    _imageRightMore.image = GetPngImage(@"jiantouRightMore");
    [self.view addSubview:_imageRightMore];
    
    _timerRight = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(rightImageAction) userInfo:nil repeats:YES];
    [_timerRight fire];
}

#pragma mark ---------- 箭头动画 -------------
- (void)rightImageAction{
    if (_imageRightMore.alpha == 1) {
        [UIView animateWithDuration:1 animations:^{
            _imageRightMore.alpha = 0;
        }];
    }else{
        [UIView animateWithDuration:1 animations:^{
            _imageRightMore.alpha = 1;
        }];
    }
}

#pragma mark ---------- pageControlAction ---------------
- (void)changePage:(UIPageControl *)pageControl{
    [_pageScrollView scrollToPage:pageControl.currentPage];
}

#pragma mark -----------  PagedFlowView Delegate cell大小 ------------
- (CGSize)sizeForPageInFlowView:(PagedScrollView *)flowView;{
    return CGSizeMake(235, 200);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(PagedScrollView *)flowView {
    _currentPage = pageNumber;
    [_pageControl setCurrentPage:pageNumber];
    if (pageNumber == 0) {//微信
        if ([[[[userModel sharedUserModel] getUserInformationWithKey:USER_SHARELIST] objectForKey:@"weixin"] intValue] == 1) {
            _buttonBuy.alpha = 0.5;
            _buttonBuy.userInteractionEnabled = NO;
        }else{
            _buttonBuy.alpha = 1;
            _buttonBuy.userInteractionEnabled = YES;
        }
        [_buttonBuy setImageNormal:GetPngImage([BASE International:@"share"])];
        [_buttonBuy setImageHighlited:GetPngImage([BASE International:@"shareb"])];
    }else if (pageNumber == 1){//微博
        if ([[[[userModel sharedUserModel] getUserInformationWithKey:USER_SHARELIST] objectForKey:@"sinaid"] intValue] == 1) {
            _buttonBuy.alpha = 0.5;
            _buttonBuy.userInteractionEnabled = NO;
        }else {
            _buttonBuy.alpha = 1;
            _buttonBuy.userInteractionEnabled = YES;
        }
        [_buttonBuy setImageNormal:GetPngImage([BASE International:@"share"])];
        [_buttonBuy setImageHighlited:GetPngImage([BASE International:@"shareb"])];
    }else if (pageNumber == 2){//renren
        if ([[[[userModel sharedUserModel] getUserInformationWithKey:USER_SHARELIST] objectForKey:@"renren"] intValue] == 1) {
            _buttonBuy.alpha = 0.5;
            _buttonBuy.userInteractionEnabled = NO;
        }else{
            _buttonBuy.alpha = 1;
            _buttonBuy.userInteractionEnabled = YES;
        }
        [_buttonBuy setImageNormal:GetPngImage([BASE International:@"share"])];
        [_buttonBuy setImageHighlited:GetPngImage([BASE International:@"shareb"])];
    }else{
        _buttonBuy.alpha = 1;
        _buttonBuy.userInteractionEnabled = YES;
        [_buttonBuy setImageNormal:GetPngImage([BASE International:@"btn_5"])];
        [_buttonBuy setImageHighlited:GetPngImage([BASE International:@"btn_5b"])];
    }
    //箭头
    if (_currentPage == 0) {
        _timerRight = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(rightImageAction) userInfo:nil repeats:YES];
        [_timerRight fire];
    }else{
        [_timerRight invalidate];
        _timerRight = nil;
        _imageRightMore.hidden = YES;
    }
    
    //价格变化动画
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.2;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //animation.type = @"oglFlip";
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromBottom;

    NSUInteger one = [[self.view subviews] indexOfObject:_viewOne];
    NSUInteger two = [[self.view subviews] indexOfObject:_viewTwo];
    [_viewBase exchangeSubviewAtIndex:one withSubviewAtIndex:two];
    [_viewBase.layer addAnimation:animation forKey:@""];
    [self performSelector:@selector(changeImage) withObject:nil afterDelay:0.1];
}

- (void)changeImage{
    for (UIImageView *imageView in _mutableArrayCell) {
        imageView.hidden = YES;
        if (imageView.tag == _currentPage) {
            imageView.hidden = NO;
        }
    }
}

#pragma mark ---------- PagedFlowView Datasource 返回显示View的个数 -----
- (NSInteger)numberOfPagesInFlowView:(PagedScrollView *)flowView{
    return [_arrayImage count];
}

//返回给某列使用的View
- (UIView *)flowView:(PagedScrollView *)flowView cellForPageAtIndex:(NSInteger)index{
    UIImageView *imageView = (UIImageView *)[flowView dequeueReusableCell];
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 6;
        imageView.layer.masksToBounds = YES;
    }
    NSString *namepng = [_arrayImage objectAtIndex:index];
    imageView.image = GetPngImage(namepng);
    return imageView;
}

#pragma mark --------- 购买 ----------
- (void)buyAction{
    //无网络
    if (![[lowooHTTPManager getInstance] isExistenceNetwork]) {
        return;
    }
    
    //微信
    if (_currentPage == 0){
        //WXSceneSession 会话  WXSceneTimeline 朋友圈  WXSceneFavorite 收藏
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"Banana'Clock";
        message.description = @"还不起床？要睡到什么时候嘛！美好的一天开始喽，我的小伙伴们快和我一起banana call吧~";
        [message setThumbImage:GetPngImage(@"weixinShare")];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = @"http://bc.lowoo.cc/mobile/";
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneTimeline;
        
        [WXApi sendReq:req];
    }
    //微博分享 查看是否已经微博绑定s
    else if (_currentPage == 1){
        if ([[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME] && ![[[userModel sharedUserModel] getUserInformationWithKey:SINA_NAME] isEqualToString:@""]) {
            _sina = [[lowooSinaWeibo alloc] init];
            _sina.delegate = self;
            [self postweibo];
        }else{
            _sina = [[lowooSinaWeibo alloc] init];
            _sina.delegate = self;
            [_sina doMicrobloggingCertification];
        }
    }
    //人人分享
    else if (_currentPage == 2){
        [RennClient initWithAppId:renrenAPPID apiKey:renrenAPPKEY secretKey:renrenSecretKey];
        [RennClient setScope:@"read_user_blog read_user_photo read_user_status read_user_album read_user_comment read_user_share publish_blog publish_share send_notification photo_upload status_update create_album publish_comment publish_feed operate_like"];
        
        [RennClient loginWithDelegate:self];
//        if ([RennClient isLogin]) {
//            [RennClient logoutWithDelegate:self];
//        }else{
//            [RennClient loginWithDelegate:self];
//        }
    }
    // In-App-Purchase
    else{
        if (LANGUAGE_CHINESE) {
            [liboTOOLS showHUD:@"正在连接..."];
        }else{
            [liboTOOLS showHUD:@"Connecting..."];
        }
        
        if (!self.pmanager) {
            self.pmanager = [[lowooProductManager alloc] init];
            [self.pmanager setDelegate:self];
        }
        [self.pmanager requestProductWithIndex:_currentPage - 3];
    }
}

#pragma mark ----------- sina授权成功回调 --------
- (void)SinaLogIn:(NSDictionary *)dictionary{
    //发微博
    [self postweibo];//点击分享后才将delegate设为self 可以直接展示分享界面
}

- (void)sinaWeiboLoginFaild:(lowooSinaWeibo *)sina{
    [[activityView sharedActivityView] removeHUD];
}

- (void)sinaLogInDidCancel:(lowooSinaWeibo *)sina{
    [[activityView sharedActivityView] removeHUD];
}

- (void)postweibo{
    lowooShareWeibo *shareweibo = [[lowooShareWeibo alloc] init];
    shareweibo.delegate = self;
    [self.navigationController pushViewController:shareweibo animated:YES];
    [shareweibo.textView becomeFirstResponder];
}

- (void)shareWeiboWithText:(NSString *)text{
    [_sina postWeibo:text picture:GetJpgImage(@"bananaclock_weibo")];
}

#pragma mark --------- sina分享成功 ------------
- (void)sianShare{
    //[[activityView sharedActivityView] showHUD:20];
    [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: @"1",@"sinaid", nil] requestType:shareList];
    [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: @"2", @"productID", nil] requestType:RMBbuySuccess];
}

#pragma mark -------------  人人网 renren  ----------
- (void)rennLoginSuccess{
    lowooShareWeibo *share = [[lowooShareWeibo alloc] init];
    share.titleName = @"renren";
    share.delegate = self;
    [self.navigationController pushViewController:share animated:YES];
}

- (void)shareRenren:(NSString *)text{
    PutShareUrlParam *param = [[PutShareUrlParam alloc] init];
    param.comment = text;
    param.url = @"http://bc.lowoo.cc/mobile/";
    [RennClient sendAsynRequest:param delegate:self];
}

- (void)rennService:(RennService *)service requestSuccessWithResponse:(id)response{
    //[[activityView sharedActivityView] showHUD:20];
    [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: @"1" ,@"renren", nil] requestType:shareList];
    [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: @"3", @"productID", nil] requestType:RMBbuySuccess];
}

- (void)rennService:(RennService *)service requestFailWithError:(NSError*)error{
    [[activityView sharedActivityView] removeHUD];
    [liboTOOLS alertViewMSG:error.domain];
}

#pragma mark - ProductManager Delegate

- (void)ProductManager:(lowooProductManager *)manager failedGetProduct:(id)pid{
    [liboTOOLS dismissHUD];
}

- (void)ProductManager:(lowooProductManager *)manager
             PayFailed:(NSString *)reason{
    [liboTOOLS dismissHUD];
}

//根据商品ID购买
- (void)ProductManager:(lowooProductManager *)manager ReceiveProduct:(SKProduct *)product{
    [self.pmanager payforProduct:product];
}

- (void)ProductManager:(lowooProductManager *)manager PayFinished:(SKProduct *)product{
    [liboTOOLS dismissHUD];
    [liboTOOLS alertViewMSG:[BASE International:@"成功购买"]];
    [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:_currentPage+1], @"productID", nil] requestType:RMBbuySuccess];
}

//Transaction is being added to the server queue.
- (void)ProductManager:(lowooProductManager *)manager
            Purchasing:(SKProduct *)product{
    //[liboTOOLS dismissHUD];
}

- (void)ProductManager:(lowooProductManager *)manager
                Failed:(SKProduct *)product{
    [liboTOOLS dismissHUD];
    [liboTOOLS alertViewMSG:[BASE International:@"购买失败"]];
}

- (void)ProductManager:(lowooProductManager *)manager
              Restored:(SKProduct *)product{
    [liboTOOLS dismissHUD];
}

#pragma mark --------- 分享保存 ----------
- (void)shareList:(NSNotification *)sender{
    [[userModel sharedUserModel] setUserInformation:[sender.userInfo objectForKey:USER_SHARELIST] forKey:USER_SHARELIST];
    if (_currentPage == 0) {
        if ([[[sender.userInfo objectForKey:USER_SHARELIST] objectForKey:@"weixin"] isEqualToString:@"1"]) {
            _buttonBuy.alpha = 0.5;
            _buttonBuy.userInteractionEnabled = NO;
        }
    }
    else if (_currentPage == 1) {
        if ([[[sender.userInfo objectForKey:USER_SHARELIST] objectForKey:@"sinaid"] isEqualToString:@"1"]) {
            _buttonBuy.alpha = 0.5;
            _buttonBuy.userInteractionEnabled = NO;
        }
    }
    else if (_currentPage == 2) {
        if ([[[sender.userInfo objectForKey:USER_SHARELIST] objectForKey:@"renren"] isEqualToString:@"1"]) {
            _buttonBuy.alpha = 0.5;
            _buttonBuy.userInteractionEnabled = NO;
        }
    }
}

- (void)offline{
    [_timerRight invalidate]; _timerRight = nil;
    _sina.delegate = nil; _sina = nil;
}

- (void)dealloc{
    _sina.delegate = self; _sina = nil;
    _pmanager.delegate = nil;
}


@end
