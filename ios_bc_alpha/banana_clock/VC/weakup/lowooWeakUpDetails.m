//
//  lowooWeakUpDetails.m
//  banana_clock
//
//  Created by MAC on 12-12-22.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooWeakUpDetails.h"
#import "lowooGettingUpViewController.h"
#import "lowooPOPhadbeencalled.h"


@implementation lowooWeakUpDetails


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"WEAKUP FRIEND";
    [self changeTitle];
    if (_gettingup) {
        [_gettingup animation];
    }
    [_scrollViewBar setContentOffset:_currentPoint];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_gettingup) {
        [_gettingup.timer invalidate];
    }
    
    //跟新列表好友数据
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:RecentFriendsList];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:refreshFriendList];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callBack) name:@"buttonHadGetUpTouchUpinside" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callBack) name:@"buttonSlobTouchUpinside" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callBack) name:@"buttonShieldTouchUpinside" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userPropsChanged) name:@"userPropsChanged" object:nil];
    }
    return self;
}

- (void)callBack{
    [self leftButtonDidTouchedUpInside];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)userPropsChanged{
    if (_gettingup) {
        return;
    }
    [self initView];
}

- (void)memoryNotificationAction:(NSNotification *)notification{
    [[activityView sharedActivityView] removeHUD];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:RecentFriendsList];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:refreshFriendList];
    if ([[notification.object objectForKey:@"state"] intValue] == 1) {
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:userpropsinfo];
        //记录使用的道具
        modelProp *prop = [_mutableArrayBuy objectAtIndex:self.currentPage];
        [[userModel sharedUserModel] setUserInformation:[NSString stringWithFormat:@"%d",prop.propID] forKey:@"throwPropID"];
        [[userModel sharedUserModel] setUserInformation:@"-1" forKey:@"throwProp"];
    }
    else if ([[notification.object objectForKey:@"state"] intValue] == 2) {//已被别人叫
        [self leftButtonDidTouchedUpInside];
    }else if ([[notification.object objectForKey:@"state"] intValue] == 3) {//状态已不可叫
        [liboTOOLS alertViewMSG:[BASE International:@"好友已进入休息状态"]];
        [self leftButtonDidTouchedUpInside];
    }else{
        [self leftButtonDidTouchedUpInside];
    }
}

- (void)initView{
    if (_gettingup) {
        [_gettingup.timer invalidate];
        [_gettingup removeFromSuperview];
        _gettingup = nil;
        [self initGetupView];
        return;
    }
    [_viewBack removeFromSuperview]; _viewBack = nil;
    _viewBack = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_viewBack];
    //好友头像
    _viewHead = [[viewHead alloc] init];
    _viewHead.view = [[UIView alloc] initWithFrame:CGRectZero];
    _viewPropSmall = [[UIView alloc]initWithFrame:CGRectZero];
    _buttonThrow = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    if (iPhone5||iPhone5_0) {
        _viewLevel2 = [[UIView alloc]initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 285)];
        CGRect frame = _viewHead.view.frame;
        frame.origin.y = 70;
        [_viewHead.view setFrame:frame];
        [_viewPropSmall setFrame:(CGRect){178, 61, 34, 35}];
        [_buttonThrow setFrame:CGRectMake(53, 360, 212, 53)];
    }else{
        _viewLevel2 = [[UIView alloc]initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 245)];
        CGRect frame = _viewHead.view.frame;
        frame.origin.y = 40;
        [_viewHead.view setFrame:frame];
        [_viewPropSmall setFrame:(CGRect){178, 30, 34, 35}];
        [_buttonThrow setFrame:CGRectMake(53, 280, 212, 53)];
    }
    [_viewBack addSubview:_viewHead.view];
    [_viewBack addSubview:_viewPropSmall];
    
    
    //滑动控件底图
    UIImageView *imageVeiwPagedFlowBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 9, 320, 84)];
    imageVeiwPagedFlowBack.image = GetPngImage(@"props_select_background");
    [_viewLevel2 addSubview:imageVeiwPagedFlowBack];
    //滑动控件
    _flowView = [[PagedFlowView alloc]initWithFrame:CGRectMake(0, 10, 320, 80)];
    [_viewLevel2 addSubview:_flowView];
    _viewMask = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 320, 80)];
    _viewMask.backgroundColor = [UIColor clearColor];
    //箭头
    UIImageView *imageViewDown = [[UIImageView alloc]initWithFrame:CGRectMake(150, 3, 21, 18)];
    [imageViewDown setImage:GetPngImage(@"arrow_down")];
    [_viewLevel2 addSubview:imageViewDown];
    UIImageView *imageViewLeft = [[UIImageView alloc]initWithFrame:CGRectMake(1, 84, 15, 15)];
    [imageViewLeft setImage:GetPngImage(@"arrow_left")];
    [_viewLevel2 addSubview:imageViewLeft];
    UIImageView *imageViewRight = [[UIImageView alloc]initWithFrame:CGRectMake(303, 84, 15, 15)];
    [imageViewRight setImage:GetPngImage(@"arrow_right")];
    [_viewLevel2 addSubview:imageViewRight];
    //scrollview导航条
    _scrollViewBar = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 87, 280, 10)];
    [_viewLevel2 addSubview:_scrollViewBar];
    [_viewBack addSubview:_viewLevel2];
    
    //扔 button
    [_buttonThrow addTarget:self action:@selector(buttonGetUpTouchUpInside:)];
    [_viewBack addSubview:_buttonThrow];

    NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithObjects: nil];
    NSMutableArray *mutableArraySmall = [[NSMutableArray alloc]initWithObjects: nil];
    NSDictionary *propsCache = [[userModel sharedUserModel] getCache:@"userpropsinfo"];
    NSArray *array = [[lowooHTTPManager getInstance] propModel:propsCache];
    [_mutableArrayBuy removeAllObjects]; _mutableArrayBuy = nil;
    _mutableArrayBuy = [[NSMutableArray alloc] init];
    for (int i=0; i<array.count; i++) {
        modelProp *prop = [array objectAtIndex:i];
        if (prop.number != 0) {
            if (!_mutableArrayBuy) {
                
            }
            [_mutableArrayBuy addObject:prop];

            //小道具
            NSString *smallName = [NSString stringWithFormat:@"%02d.png.small",prop.propID];
            UIImageView *imageViewSmall = [[UIImageView alloc] init];
            [imageViewSmall setImage:GetPngImage(smallName)];
            imageViewSmall.frame = CGRectMake(0, 0, 34, 35);
            UIView *viewSmall = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 35)];//头像上显示的道具
            [viewSmall addSubview:imageViewSmall];
            [mutableArraySmall addObject:viewSmall];
            //道具
            propCollectionViewCell *cell = [[propCollectionViewCell alloc] init];
            UIView *viewBase = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            CGRect frameCell = cell.frame;
            frameCell.origin.y = frameCell.origin.y + 5;
            frameCell.origin.x = frameCell.origin.x + 5;
            cell.frame = frameCell;
            cell.button.userInteractionEnabled = NO;
            NSString *normalName = [NSString stringWithFormat:@"%02d",prop.propID];
            [cell.button setImageNormal:GetPngImage(normalName)];
            if (LANGUAGE_CHINESE) {
                cell.label.text = prop.nameChinese;
            }else{
                cell.label.text = prop.nameEnglish;
            }
            
            //以本地保存道具数量为准
            NSDictionary *responsObject = [[userModel sharedUserModel] getCache:@"userpropsinfo"];
            NSArray *arrayProps = [self.manager propModel:responsObject];
            for (modelProp *pro in arrayProps) {
                if (prop.propID == pro.propID) {
                    [cell initNumber:pro.number];
                    break;
                }
            }
            arrayProps = nil;

            [viewBase addSubview:cell];
            [mutableArray addObject:viewBase];
        }
    }
    
    //判断是否存在上次使用的道具
    {
        for (int i=0; i<_mutableArrayBuy.count; i++) {
            modelProp *prop = [[modelProp alloc] init];
            if (prop.propID == [[[userModel sharedUserModel] getUserInformationWithKey:@"throwPropID"] intValue]) {
                [[userModel sharedUserModel] setUserInformation:[NSString stringWithFormat:@"%d",i] forKey:@"throwProp"];
                break;
            }
        }
    }
    
    _arrayImage = [mutableArray copy];
    _arraySmallProps = [mutableArraySmall copy];
    _flowView.delegate = self;
    _flowView.dataSource = self;
    _flowView.minimumPageAlpha = 1.0;
    _flowView.minimumPageScale = 1.0;
    _flowView.backgroundColor = [UIColor clearColor];

    if ([[[userModel sharedUserModel] getUserInformationWithKey:@"throwProp"] intValue]>=0 && self.currentPage<_mutableArrayBuy.count) {
        if (self.currentPage == 0) {
            self.currentPage = [[[userModel sharedUserModel] getUserInformationWithKey:@"throwProp"] intValue];
        }
        _flowView.currentPageIndex = [[[userModel sharedUserModel] getUserInformationWithKey:@"throwProp"] intValue];
    }else{
        self.currentPage = floor((_arraySmallProps.count-1)/2.0);
        _flowView.currentPageIndex = floor((_arraySmallProps.count-1)/2.0);
    }
    
    
    for (UIView *aview in _viewPropSmall.subviews) {
        [aview removeFromSuperview];
    }
    if (_arraySmallProps.count>0) {
        [_viewPropSmall addSubview:[_arraySmallProps objectAtIndex:self.currentPage]];//初始显示第0个，其他初始显示需涉及scrollview
    }
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(280+((280-280-((280-50)/32)*(_arrayImage.count-1))/_arrayImage.count*0), 0, 280-((280-50)/32)*(_arrayImage.count-1), 10)];//x=300/_arrayImage.count*_arrayImage.count/2
    imageView.image = GetPngImage(@"scroll_bar");
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-280, 0, 280+280+280, 10)];
    [view addSubview:imageView];
    for (UIView *aview in _scrollViewBar.subviews) {
        [aview removeFromSuperview];
    }
    [_scrollViewBar addSubview:view];
    
    if (LANGUAGE_CHINESE) {
        [_buttonThrow setImageNormal:GetPngImage(@"btn_throw01")];
        [_buttonThrow setImageHighlited:GetPngImage(@"btn_throw02")];
    }else{
        [_buttonThrow setImageNormal:GetPngImage(@"btn_throw01English")];
        [_buttonThrow setImageHighlited:GetPngImage(@"btn_throw02English")];
    }
    
    if (_user.avatarUrl != nil) {
        [_viewHead setImageWithUrl:_user.avatarUrl name:_user.name];
    }else{
        [_viewHead setImageWithUrl:@"" name:_user.name];
    }
    
    [_flowView setFirstView];
}


#pragma mark----------musicButtonTouchUpInside---------
//播放音乐
-(void)buttonTouchUpInside{

}


#pragma mark ------------PagedFlowView Delegate------------
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{
    return CGSizeMake(64, 80);
}

#pragma mark----------小道具切换-------------
-(void)smallPropsSwitchWithFirstIndex:(NSInteger )first SecondIndex:(NSInteger )second{
    UIView *firstView = [_arraySmallProps objectAtIndex:second];
    UIView *secondView = [_arraySmallProps objectAtIndex:first];
    [_viewPropSmall addSubview:firstView];
    [_viewPropSmall addSubview:secondView];
    
    //_imageViewPropSmall.hidden = YES;
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.2;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.subtype = kCATransitionFromBottom;
    NSUInteger green = [[_viewPropSmall subviews]indexOfObject:firstView];
    NSUInteger blue  = [[_viewPropSmall subviews]indexOfObject:secondView];
    [_viewPropSmall exchangeSubviewAtIndex:blue withSubviewAtIndex:green];
    [[_viewPropSmall layer]addAnimation:animation forKey:@"animation"];
}

#pragma mark----------点击移动道具------------
-(void)tapAtPoint:(CGPoint)point{
    [_viewLevel2 addSubview:_viewMask];
    [self performSelector:@selector(removeMask) withObject:nil afterDelay:0.3];
    NSInteger first;
    BOOL *boolHaveImage = NO;
    first = self.currentPage;
    
    if (point.x<64) {
        if (self.currentPage-2>=0) {
            [_flowView scrollToPage:self.currentPage-2];
            self.currentPage -= 2;
            boolHaveImage = YES;
        }
    }else if (point.x<128){
        if (self.currentPage-1>=0) {
            [_flowView scrollToPage:self.currentPage-1];
            self.currentPage -= 1;
            boolHaveImage = YES;
        }
    }else if (point.x<256){
        if (_arrayImage.count-self.currentPage>1) {
            [_flowView scrollToPage:self.currentPage+1];
            self.currentPage += 1;
            boolHaveImage = YES;
        }
    }else if (point.x<320){
        if (_arrayImage.count-self.currentPage>2) {
            [_flowView scrollToPage:self.currentPage+2];
            self.currentPage += 2;
            boolHaveImage = YES;
        }
    }
    if (boolHaveImage) {
        [self smallPropsSwitchWithFirstIndex:first SecondIndex:self.currentPage];
    }

}

- (void)removeMask{
    [_viewMask removeFromSuperview];
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(PagedFlowView *)flowView {
    self.currentPage = pageNumber;
    
    if (pageNumber<_arraySmallProps.count&&pageNumber-1>=0) {
        [self smallPropsSwitchWithFirstIndex:pageNumber-1 SecondIndex:pageNumber];
    }else if (pageNumber>=0&&pageNumber+1<=_arraySmallProps.count) {
        [self smallPropsSwitchWithFirstIndex:pageNumber+1 SecondIndex:pageNumber];
    }
}
//设置导航条移动
-(void)setScrollViewContentOffset:(CGPoint)point{
    _currentPoint = CGPointMake(-point.x/(_arrayImage.count*320/5)*(280-(280-((280-50)/32)*(_arrayImage.count-1))), 0);
    [_scrollViewBar setContentOffset:_currentPoint];
}

#pragma mark --------------PagedFlowView Datasource----------
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView{
    return [_arrayImage count];
}

//返回给某列使用的View
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    UIImageView *imageView = (UIImageView *)[flowView dequeueReusableCell];
    if (!imageView) {

    }
    UIView *view = [_arrayImage objectAtIndex:index];
    return view;
}
 
- (void)buttonGetUpTouchUpInside:(UIButton_custom *)sender {
    if ([self.manager isExistenceNetwork]) {
        [[activityView sharedActivityView] showHUD:-1];
        modelProp *prop = [_mutableArrayBuy objectAtIndex:self.currentPage];
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     _user.fid,@"fid",
                                                                     [NSString stringWithFormat:@"%d",prop.propID], @"tid",
                                                                     self.memoryAddress, MEMORY_ADDRESS, nil] requestType:weakupFriend];
        [self initGetupView];
    }
}

- (void)initGetupView{
    _gettingup = [[lowooPOPGettingUp alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _gettingup.alpha = 0;
    [UIView animateWithDuration:0.5
                     animations:^{
                         for (UIView *aview in _viewHead.view.subviews) {
                             if ([aview isKindOfClass:[UILabel class]]) {
                                 UILabel *lable = (UILabel *)aview;
                                 lable.textColor = [UIColor whiteColor];
                             }
                         }
                         
                         _gettingup.alpha = 1;
                         CGPoint pointLevel2 = _viewLevel2.center;
                         CGPoint pointButton = _buttonThrow.center;
                         pointLevel2.y += 300;
                         pointButton.y += 300;
                         _viewLevel2.center = pointLevel2;
                         _buttonThrow.center = pointButton;
                     } completion:^(BOOL finished) {
                         modelProp *prop = [_mutableArrayBuy objectAtIndex:self.currentPage];
                         [_gettingup confirmDataWithModelUser:_user TID:prop.propID];
                         [_gettingup animation];
                         
                     }];
    [self.view addSubview:_gettingup];
    [self.view sendSubviewToBack:_gettingup];
}


@end
