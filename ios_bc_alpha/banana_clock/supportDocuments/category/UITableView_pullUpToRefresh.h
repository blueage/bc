//
//  UITableView_pullUpToRefresh.h
//  banana_clock
//
//  Created by MAC on 13-12-17.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableView_pullUpToRefresh : UITableView


@property (nonatomic, strong) UIView *viewRefreshFooter;
@property (nonatomic, strong) UILabel *labelRefresh;
@property (nonatomic, strong) UIImageView *imageViewArrow;
@property (nonatomic, strong) UIActivityIndicatorView *activityRefresh;
@property (nonatomic, strong) NSString *stringPull;
@property (nonatomic, strong) NSString *stringRelease;
@property (nonatomic, strong) NSString *stringLoading;
@property (nonatomic, strong) NSString *stringNoMore;
@property (nonatomic, assign) BOOL boolHasMore;
@property (nonatomic, assign) BOOL boolDragging;
@property (nonatomic, assign) BOOL boolLoading;

- (void)setupStrings;
- (void)addPullToRefreshFooter;
- (void)stopLoading;
- (void)refresh;


@end
