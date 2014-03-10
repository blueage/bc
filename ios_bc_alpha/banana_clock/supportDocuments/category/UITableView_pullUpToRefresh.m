//
//  UITableView_pullUpToRefresh.m
//  banana_clock
//
//  Created by MAC on 13-12-17.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "UITableView_pullUpToRefresh.h"


#define REFRESH_HEADER_HEIGHT  52.0f

@implementation UITableView_pullUpToRefresh

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupStrings];
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self addPullToRefreshFooter];
    }
    return self;
}

- (void)setupStrings{
    _stringPull = @"上拉刷新...";
    _stringRelease = @"释放开始刷新...";
    _stringLoading = @"正在加载...";
    _stringNoMore  = @"";
    _boolHasMore = YES;
}

- (void)addPullToRefreshFooter{
    _viewRefreshFooter = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height+20, self.frame.size.width, 0)];
    _viewRefreshFooter.backgroundColor = [UIColor clearColor];
    
    _labelRefresh = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, REFRESH_HEADER_HEIGHT)];
    _labelRefresh.backgroundColor = [UIColor clearColor];
    _labelRefresh.font = [UIFont boldSystemFontOfSize:12.0];
    _labelRefresh.textColor = [UIColor grayColor];
    _labelRefresh.textAlignment = NSTextAlignmentCenter;
    
    //_imageViewArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pullArrow.png"]];
    _imageViewArrow = [[UIImageView alloc] init];
    _imageViewArrow.frame = CGRectMake(floorf(REFRESH_HEADER_HEIGHT - 27)/2, floorf(REFRESH_HEADER_HEIGHT - 44)/2, 27, 44);
    
    _activityRefresh = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityRefresh.frame = CGRectMake(floorf(REFRESH_HEADER_HEIGHT-20)/2, floorf((REFRESH_HEADER_HEIGHT-20)/2), 20, 20);
    _activityRefresh.hidesWhenStopped = YES;
    
    [_viewRefreshFooter addSubview:_labelRefresh];
    [_viewRefreshFooter addSubview:_imageViewArrow];
    [_viewRefreshFooter addSubview:_activityRefresh];
    [self setTableFooterView:_viewRefreshFooter];
   // [self addSubview:_viewRefreshFooter];
}

- (void)stopLoading {
    _boolLoading = NO;
    
    // Hide the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    self.contentInset = UIEdgeInsetsZero;
    UIEdgeInsets tableContentInset = self.contentInset;
    tableContentInset.top = 0.0;
    self.contentInset = tableContentInset;
    [_imageViewArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    [UIView commitAnimations];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    _labelRefresh.text = _stringPull;
    _imageViewArrow.hidden = NO;
    
    [_viewRefreshFooter setFrame:CGRectMake(0, self.contentSize.height, 320, 0)];
    
    [_activityRefresh stopAnimating];
}

- (void)refresh {
    // This is just a demo. Override this method with your custom reload action.
    // Don't forget to call stopLoading at the end.
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
    
}




@end
