//
//  lowooGetUpGame.h
//  banana_clock
//
//  Created by MAC on 13-8-9.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lowooGetUpGame : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollViewBack;
@property (nonatomic, strong) UIImageView *imageViewBack;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageViewAlpha;
@property (nonatomic, strong) UIView *viewAlpha;

@property (nonatomic, strong) UIView *viewTime;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UILabel *labelTimeText;
@property (nonatomic, strong) UILabel *labelMiddle;
@property (nonatomic, strong) UIImageView *imageViewProp;
@property (nonatomic, strong) UIImageView *imageViewArrow;
@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) viewHead *viewHead;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *fid;

@property (nonatomic, strong) UIButton *buttonShield;
@property (nonatomic, strong) UIImageView *imageViewButton;
@property (nonatomic, strong) NSTimer *timerImageAnimation;
@property (nonatomic, assign) float scrollUP;
@property (nonatomic, assign) float scrollDOWN;
@property (nonatomic, assign) float scrollCenter;
@property (nonatomic, assign) BOOL boolOnce;
@property (nonatomic, strong) NSDictionary *dictionaryConfirm;
@property (nonatomic, strong) NSTimer *timerDelay;
@property (nonatomic, strong) NSTimer *timerMiddal;
@property (nonatomic, strong) NSTimer *timerAnimation;
@property (nonatomic, assign) BOOL boolNoDown;//是否允许下滑
@property (nonatomic, strong) NSString *stringIndex;

- (void)confirmDataWith:(NSDictionary *)sender;



@end
