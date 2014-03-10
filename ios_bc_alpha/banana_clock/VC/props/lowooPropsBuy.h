//
//  lowooPropsBuy.h
//  banana_clock
//
//  Created by MAC on 13-3-17.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBaseView.h"
#import "PagedScrollView.h"
#import "lowooSinaWeibo.h"
#import "lowooShareWeibo.h"
#import <RennSDK/RennSDK.h>
#import "UIPageControl_custom.h"
#import "WXApi.h"

@interface lowooPropsBuy : lowooBaseView<UIScrollViewDelegate,PagedScrollDelegate,PagedScrollViewDataSource,lowooSinaWeiboDelegate,lowooShareWeiboDelegate,RennLoginDelegate,RennServiveDelegate>

@property (nonatomic, strong) PagedScrollView *pageScrollView;
@property (nonatomic, strong) NSArray *arrayImage;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *mutableArrayCell;
@property (nonatomic, strong) UIImageView *imageLeftMore;
@property (nonatomic, strong) UIImageView *imageRightMore;
@property (nonatomic, strong) NSTimer *timerRight;
@property (nonatomic, strong) UIView *viewBase;
@property (nonatomic, strong) UIView *viewOne;
@property (nonatomic, strong) UIView *viewTwo;
@property (nonatomic, strong) UIButton_custom *buttonBuy;
@property (nonatomic, strong) UIPageControl_custom *pageControl;

//购买

@property (nonatomic, strong) NSArray *arrayProducts;
@property (nonatomic, strong) lowooSinaWeibo *sina;




@end
