//
//  lowooViewController.h
//  test
//
//  Created by MAC on 13-2-17.
//  Copyright (c) 2013年 MAC. All rights reserved.
//


#define START_X 150.00
#define START_Y 375.00


#import <UIKit/UIKit.h>
#import "lowooBananaView.h"
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>
#import "lowooLifeValueView.h"
#import "lowooTimeView.h"
#import "lowooTarget.h"
#import "lowooCloud.h"
#import "lowooAlertViewDemo.h"
#import "lowooGetUpGame.h"
#import <AVFoundation/AVFoundation.h>
#import "LocalNotification.h"

@protocol lowooGameDelegate <NSObject>
- (void)gameStartNew;
- (void)getupGameStartNew;
- (void)gameEnd;
@end



@interface lowooGame : UIViewController<lowooBananaViewDelegate,lowooTimeViewDelegate,UIAlertViewDelegate>

@property (nonatomic, weak) id<lowooGameDelegate>delegate;

@property (nonatomic, strong) UIView *viewBackground;
@property (nonatomic, assign) NSInteger gameNumber;
@property (nonatomic, assign) NSInteger repeatCount;
@property (nonatomic, assign) NSInteger bananaIndex;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger bananaNumber;
@property (nonatomic, assign) BOOL boolEnterToBack;//进入后台
@property (nonatomic, assign) BOOL boolGetupGame;//被别人叫起
@property (nonatomic, assign) BOOL boolGameStart;
@property (nonatomic, assign) BOOL boolPOPview;//退出按钮是否可用
@property (nonatomic, assign) BOOL boolGameOver;
@property (nonatomic, assign) BOOL banana;
@property (nonatomic, assign) BOOL needRest;
@property (nonatomic, assign) BOOL hitMorpheus;
@property (nonatomic, strong) NSMutableArray *arrayHit;
@property (nonatomic, assign) BOOL needTouchAgain;

@property (nonatomic, assign) CGPoint beginPoint;//触摸起点
@property (nonatomic, assign) CGPoint startPoint;//香蕉起点
@property (nonatomic, assign) CGPoint endPoint;//移动过程中的终点
@property (nonatomic, assign) CGPoint targetPoint;//触摸终点

@property (nonatomic, strong) UIView *sleepBedView;

//时间
@property (nonatomic, assign) CGPoint maskViewStartPoint;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) float boxX;
@property (nonatomic, assign) float boxY;



//香蕉子弹图层
@property (nonatomic, strong) UIView *viewBanana;

//炮筒
@property (strong, nonatomic) UIView *viewPeople;
@property (nonatomic, strong) UIImageView *gunImageView;
@property (nonatomic, strong) UIImageView *imageViewBullet;
@property (nonatomic, strong) UIView *gunBarrelView;
//弹药库
@property (nonatomic, strong) UIView *magazineView;
@property (nonatomic, strong) UIImageView *magazineImageView;
//陀螺仪
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) NSOperationQueue *queue;
//人物
@property (nonatomic, assign) CGPoint pointPeople;
@property (nonatomic, strong) UIImageView *imageViewPeople;

@property (nonatomic, strong) NSMutableArray *mutableArrayMoveQueue;

@property (nonatomic, assign) BOOL move;
@property (strong, nonatomic) UIImageView *backImage;

@property (strong, nonatomic) UIView *baseview;


@property (strong, nonatomic) UIView *boundary;

@property (nonatomic, strong) lowooCloud *viewCloud;

//生命值
@property (strong, nonatomic) lowooLifeValueView *lifeValueView;

//时间
@property (strong, nonatomic) lowooTimeView *timeView;


//睡神
@property (strong, nonatomic) lowooTarget *viewTarget;


@property (nonatomic, strong) UIButton_custom *buttonExit;
@property (nonatomic, strong) lowooGetUpFailure *getupFaild;
@property (nonatomic, strong) lowooGameOver *gameOver;
@property (nonatomic, strong) lowooGameExit *gameExit;

@property (nonatomic, strong) UIImageView *imageViewGame1;
@property (nonatomic, strong) UIImageView *imageViewGame2;
@property (nonatomic, strong) UIImageView *imageViewGame3;
@property (nonatomic, strong) UIView *view321;

//首次允许
@property (nonatomic, strong) UIView *viewFirst;
@property (nonatomic, assign) BOOL boolFirstRock;
@property (nonatomic, assign) BOOL boolFirstRockInit;
@property (nonatomic, strong) UIImageView *imageViewArrow;
@property (nonatomic, strong) UIImageView *imageViewFinger;
@property (nonatomic, strong) UIImageView *imageViewRock;

@property (nonatomic, strong) NSTimer *timerGame;//用于起床游戏计时
@property (nonatomic, strong) NSString *stringFID;
@property (nonatomic, strong) NSString *stringTID;
@property (nonatomic, strong) lowooGetUpGame *gameup;



- (void)gameStart;
- (void)someOneCallGame;
- (void)resetGame;
- (void)buttonGameOver;


@end
