//
//  lowooWeakUpDetails.h
//  banana_clock
//
//  Created by MAC on 12-12-22.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooBaseView.h"
#import "PagedFlowView.h"
#import <QuartzCore/QuartzCore.h>
#import "propCollectionViewCell.h"
#import "lowooPOPGettingUp.h"
#import "lowooPOPhadbeencalled.h"

@interface lowooWeakUpDetails : lowooBaseView<UIScrollViewDelegate,PagedFlowViewDataSource,PagedFlowViewDelegate>

@property (nonatomic, strong) NSString *stringFather;
@property (strong, nonatomic) viewHead *viewHead;
@property (strong, nonatomic) UIView *viewPropSmall;
@property (nonatomic, strong) modelUser *user;
@property (nonatomic, strong) UIView *viewLevel2;
@property (strong, nonatomic) PagedFlowView *flowView;
@property (strong, nonatomic) UIScrollView *scrollViewBar;
@property (nonatomic, strong) lowooPOPGettingUp *gettingup;
@property (nonatomic, assign) CGPoint currentPoint;
@property (nonatomic, strong) UIButton_custom *buttonThrow;
@property (nonatomic, strong) NSArray *arraySmallProps;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSArray *arrayImage;
@property (nonatomic, strong) UIView *viewMask;//控制用户点击速度 使移动和切换同步
@property (nonatomic, strong) UIView *viewBack;


@property (nonatomic, strong) NSMutableArray *mutableArrayBuy;

- (void)initView;

@end
