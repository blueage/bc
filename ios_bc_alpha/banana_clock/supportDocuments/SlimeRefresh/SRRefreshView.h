//
//  SRRefreshView.h
//  SlimeRefresh
//
//  A refresh view looks like UIRefreshControl
//
//  Created by apple on 12-6-15.
//  Copyright (c) 2012年 zrz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRSlimeView.h"

@class SRRefreshView;

typedef void (^SRRefreshBlock)(SRRefreshView* sender);

@protocol SRRefreshDelegate;

@interface SRRefreshView : UIView{
    UIImageView     *_refleshView;
    SRSlimeView     *_slime;
}

//set the state loading or not.
@property (nonatomic, assign)   BOOL    loading;
//set the slime's style by this property.
@property (nonatomic, strong, readonly) SRSlimeView *slime;
//set your refresh icon.
@property (nonatomic, strong, readonly) UIImageView *refleshView;
//select one to receive the refreshing message.
@property (nonatomic, copy)     SRRefreshBlock  block;
@property (nonatomic, weak)   id<SRRefreshDelegate>   delegate;

// 
@property (nonatomic, assign)   CGFloat upInset;

//
- (void)scrollViewDidScroll;

//自动刷新
@property (nonatomic, assign)   BOOL    broken;
- (void)scrollViewDidEndDraging;
@property (nonatomic, strong) NSTimer *timer;
//
- (void)endRefresh;

@end

@protocol SRRefreshDelegate <NSObject>

@optional
//start refresh.
- (void)slimeRefreshStartRefresh:(SRRefreshView*)refreshView;

@end