//
//  lowooViewController.m
//  test
//
//  Created by MAC on 13-2-17.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooGame.h"
#import "lowooAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "UINavigationBar_custom.h"

@interface lowooGame ()

@end

@implementation lowooGame

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"international" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonGameRepeateTouchUpInside:) name:@"buttonGameRepeatTouchUpinside" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonExitCancelTouchUpInside:) name:@"buttonGameExitCancelTouchUpinside" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonHomeTouchUpInside) name:@"applicationDidEnterBackground" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonExitCancelTouchUpInside:) name:@"applicationDidBecomeActive" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameStart) name:@"startToGetup" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonGameOver) name:@"gameLazy" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonGameOver) name:@"buttonGetUpSuccessfullyTouchUpinside" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonGameOver) name:@"buttonGameSuccessCloseTouchUpinside" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonGameOver) name:@"buttonGameOverCloseTouchUpinside" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonGameOver) name:@"gameOver" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonGameOver) name:@"buttonGetUpFailureTouchUpinside" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonGameOver) name:@"buttonGameExitDetermineTouchUpinside" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continuousGetup:) name:@"continuousGetup" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(offline) name:@"offline" object:nil];
    
    if (IOS_7) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        view.backgroundColor = [UIColor blackColor];
        [self.view addSubview:view];
    }
    
    _viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, [BASE statusBarHeight], SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_viewBackground];
    
    _motionManager = [[CMMotionManager alloc]init];//陀螺仪
    _queue = [[NSOperationQueue alloc]init];

    [self resetGame];

    _view321 = [[UIView alloc]initWithFrame:CGRectMake(146, SCREEN_HEIGHT/2-30, 28, 41)];
    [_view321 setBackgroundColor:[UIColor clearColor]];
    _view321.userInteractionEnabled = NO;
    [_viewBackground addSubview:_view321];


    
    if (_boolGetupGame) {
        [self someOneCallGame];
    }
}

#pragma mark --------- offline ---------
- (void)offline{
    [[lowooMusic sharedLowooMusic] stopPlayer];
    [_timerGame invalidate]; _timerGame = nil;
    [_timer invalidate]; _timer = nil;
    [self removeFromParentViewController];
}

- (void)gameStart{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonHomeTouchUpInside) name:@"applicationDidEnterBackground" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonExitCancelTouchUpInside:) name:@"applicationDidBecomeActive" object:nil];
    _boolEnterToBack = YES;
    [self buttonExitCancelTouchUpInside:nil];
    [[lowooMusic sharedLowooMusic] playMusic:@"gamebc" type:@"mp3" numberOfLoops:-1 volume:0.5];
    if (_boolGetupGame) {
        _timerGame = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timerGameAction) userInfo:nil repeats:NO];
    }
}

- (void)timerGameAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"timeOut" object:nil];
}

- (void)someOneCallGame{
    _gameup = [[lowooGetUpGame alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"applicationDidEnterBackground" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"applicationDidBecomeActive" object:nil];
    [_viewBackground addSubview:_gameup];
}



//切换到后台  暂停游戏
- (void)buttonHomeTouchUpInside{
    _boolEnterToBack = YES;
    if (_boolGetupGame) {
        //直接赖床
        
    }
    if (_timer) {
        if (_timer.isValid) {
            [_timer invalidate]; _timer = nil;
        }
        if (!_boolGetupGame) {
            _gameExit = [[lowooGameExit alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [[lowooAlertViewDemo sharedAlertViewManager] show:_gameExit];
        }
    
        //[[lowooMusic sharedLowooMusic] stopPlayer];
    }
}


#pragma mark--------------游戏失败  游戏时间到----------
#pragma mark------------lowooTimeViewDelegate------------
- (void)timeOut{
    _boolPOPview = YES;
    if (_timer.isValid) {
        [_timer invalidate]; _timer = nil;
    }
    for (lowooBananaView *bananaView in _mutableArrayMoveQueue) {
        [bananaView.imageView stopAnimating];
    }

    _boolGameOver = YES;

#pragma mark-------------起床失败-------------
    if (_boolGetupGame) {
        [_motionManager stopAccelerometerUpdates]; _motionManager = nil;
        lowooGetUpFailure *getupFaild = [[lowooGetUpFailure alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [[lowooAlertViewDemo sharedAlertViewManager] show:getupFaild];
        

#pragma mark------------游戏失败-------------
    }else{
        [_motionManager stopAccelerometerUpdates]; _motionManager = nil;
        _gameOver = [[lowooGameOver alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [[lowooAlertViewDemo sharedAlertViewManager] show:_gameOver];
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:gameFailed];
    }
    [[lowooMusic sharedLowooMusic] playShortMusic:@"gamelose" Type:@"mp3"];
    [[lowooMusic sharedLowooMusic] stopPlayer];
}

- (void)resetGame{
    _boolFirstRockInit = YES;
    _boolPOPview = NO;
    _boolGameOver = NO;
    _hitMorpheus = NO;
    _needRest = NO;
    _banana = YES;//初始有香蕉
    _move = NO;
    _repeatCount = 1;
    _bananaIndex = 1;
    _bananaNumber = BANANANUMBER;
    _score = 0;
    
    if (_arrayHit) {
        [_arrayHit removeAllObjects];
    }
    _arrayHit = [[NSMutableArray alloc]init];
    
    //先清空香蕉
    if (_mutableArrayMoveQueue) {
        [_mutableArrayMoveQueue removeAllObjects];
    }
    _mutableArrayMoveQueue = [[NSMutableArray alloc]init];

    //背景图片
    if (!_backImage) {
        _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];///////
        [_backImage setImage:GetPngImage(@"gameBack")];
        [_viewBackground addSubview:_backImage];
    }
    
    _boundary = [[UIView alloc] initWithFrame:CGRectMake(0, -10, 320, 587)];
    [_viewBackground addSubview:_boundary];
    
    
    //底图层
    if (!_baseview) {
        if (iPhone5||iPhone5_0) {
            _baseview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            _baseview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        _baseview.backgroundColor = [UIColor clearColor];
        [_viewBackground addSubview:_baseview];
        _baseview.userInteractionEnabled = NO;
    }
    
    //云
    if (!_viewCloud) {
        _viewCloud = [[lowooCloud alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
        [_baseview addSubview:_viewCloud];
    }
    
    
    //睡神
    [_viewTarget removeFromSuperview];
    _viewTarget = [[lowooTarget alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    _viewTarget.userInteractionEnabled = NO;
    _viewTarget.backgroundColor = [UIColor clearColor];
    [_baseview addSubview:_viewTarget];
    
    
    //弹药库
    if (!_magazineImageView) {
        _magazineView = [[UIView alloc]initWithFrame:CGRectMake(270, 210, 182*0.5*2, 276*0.5*2)];
        _magazineView.userInteractionEnabled = NO;
        _magazineView.backgroundColor = [UIColor clearColor];
        [_baseview addSubview:_magazineView];
        _magazineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 0, 182*0.5, 276*0.5)];
        _magazineImageView.userInteractionEnabled = NO;
        _magazineImageView.image = GetPngImage(@"magazineClip");
        [_magazineView addSubview:_magazineImageView];
    }
    
    //时间
    [_timeView removeFromSuperview];
    _timeView = [[lowooTimeView alloc]initWithFrame:CGRectMake(173, 12, _timeView.frame.size.width, _timeView.frame.size.height)];
    _maskViewStartPoint = _timeView.maskView.center;
    _timeView.userInteractionEnabled = NO;
    _timeView.backgroundColor = [UIColor clearColor];
    _timeView.delegate = self;
    _timeView.imageViewClock.transform = CGAffineTransformMakeRotation(M_PI/180*10);    //先旋转，否则程序运行时，转动已开始，frame已经改变
    [_baseview addSubview:_timeView];
    
    
    //生命值
    [_lifeValueView removeFromSuperview];
    _lifeValueView = [[lowooLifeValueView alloc]initWithFrame:CGRectMake(7, 6, _lifeValueView.frame.size.width, _lifeValueView.frame.size.height)];
    _lifeValueView.userInteractionEnabled = NO;
    _lifeValueView.backgroundColor = [UIColor clearColor];
    [_baseview addSubview:_lifeValueView];
    
    
    //香蕉图层
    if (_viewBanana) {
        
    }else{
        _viewBanana = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 548)];
        _viewBanana.userInteractionEnabled = NO;
        _viewBanana.backgroundColor = [UIColor clearColor];
        [_baseview addSubview:_viewBanana];
    }
    
    
    //炮筒
    if (_viewPeople) {
        
    }else{
        _viewPeople = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 320, 548)];
        _viewPeople.userInteractionEnabled = NO;
        _viewPeople.backgroundColor = [UIColor clearColor];
        [_baseview addSubview:_viewPeople];
    }
    
    
    if (_gunBarrelView) {
        
    }else{
        _gunBarrelView = [[UIView alloc]initWithFrame:CGRectMake(38, 293, 244, 420)];
        _gunBarrelView.userInteractionEnabled = NO;
        _gunBarrelView.backgroundColor = [UIColor clearColor];
        [_viewPeople addSubview:_gunBarrelView];
    }
    
    if (_gunImageView) {
        
    }else{
        _gunImageView = [[UIImageView alloc]initWithFrame:CGRectMake(38, 0, 208, 185)];
        _gunImageView.image = GetPngImage(@"gun");
        [_gunBarrelView addSubview:_gunImageView];
    }
    
    if (_imageViewBullet) {
        
    }else{
        _imageViewBullet = [[UIImageView alloc]initWithFrame:CGRectMake(38, 0, 208, 185)];
        [_imageViewBullet setImage:GetPngImage(@"bulletFull")];
        _imageViewBullet.userInteractionEnabled = NO;
        [_gunBarrelView addSubview:_imageViewBullet];
    }
    
    
    //人物
    if (_imageViewPeople) {
        
    }else{
        if (iPhone5||iPhone5_0) {
            _imageViewPeople = [[UIImageView alloc]initWithFrame:CGRectMake(80, 380, 155, 167)];
        }else{
            _imageViewPeople = [[UIImageView alloc]initWithFrame:CGRectMake(80, 370, 155, 167)];
        }
        
        _pointPeople = _imageViewPeople.center;
        [_imageViewPeople setImage:GetPngImage(@"people")];
        [_viewPeople addSubview:_imageViewPeople];
    }
    
    [self initNextBanana];

    
    //exit
    _buttonExit = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    _buttonExit.hidden = YES;
    [_buttonExit setFrame:CGRectMake(0, SCREEN_HEIGHT-108, 93, 88)];
    [_buttonExit setHighlighted:NO];
    [_buttonExit setImageNormal:GetPngImage(@"exit01")];
    [_buttonExit setImageHighlited:GetPngImage(@"exit02")];
    [_buttonExit addTarget:self action:@selector(buttonExitTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_viewBackground addSubview:_buttonExit];
}

#pragma mark--------- 退出游戏 ------------
- (void)buttonExitTouchUpInside:(UIButton_custom *)sender{
    //任务游戏不可暂停
    if (_boolGetupGame) {
        return;
    }
    sender.userInteractionEnabled = NO;
    _boolGameStart = NO;
    //[[lowooMusic sharedLowooMusic] stopPlayer];
    if (!_boolPOPview) {
        if (_timer.isValid) {
            [_timer invalidate]; _timer = nil;
        }
        _gameExit = [[lowooGameExit alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [[lowooAlertViewDemo sharedAlertViewManager] show:_gameExit];
    }
}


#pragma mark ------------ 填充弹药 --------
- (void)initGyro{
    if (_motionManager.gyroAvailable) {
        _motionManager.gyroUpdateInterval = 1.0/10.0;
        [_motionManager startGyroUpdatesToQueue:_queue withHandler:^(CMGyroData *gyroData, NSError *error) {
            if (error) {
                [_motionManager stopAccelerometerUpdates];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"gyro" message:[NSString stringWithFormat:@"%@",error] delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [alertView show];
            }else{
                NSDictionary *dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithFloat:gyroData.rotationRate.x],@"X",[NSNumber numberWithFloat:gyroData.rotationRate.y],@"Y",[NSNumber numberWithFloat:gyroData.rotationRate.z],@"Z",@"gyro",@"name", nil];
                [self performSelectorOnMainThread:@selector(gyroAction:) withObject:dictionary waitUntilDone:YES];
            }
        }];
    }else{
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"gyro" message:@"this device has no gyro" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
//        [alertView show];
    }
}


- (void)gyroAction:(NSDictionary *)sender{
    if (_boolFirstRockInit) {
        _imageViewRock = [[UIImageView alloc]initWithFrame:CGRectMake(48, 53, 225, 225)];
        _imageViewRock.image = GetPngImage(@"game_03");
        [_viewFirst addSubview:_imageViewRock];
        _boolFirstRock = YES;
        _boolFirstRockInit = NO;
    }

    
    if ([[sender objectForKey:@"X"] floatValue]>1.7 || [[sender objectForKey:@"Y"] floatValue]>1.7 || [[sender objectForKey:@"Z"] floatValue]>1.7) {
        //检测到晃动
        _boolFirstRock = NO;
        _imageViewRock.hidden = YES;
        
        _magazineImageView.image = GetPngImage(@"magazineClipFull");
        [UIView animateWithDuration:0.4f
                              delay:0.5f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             if(_needRest){
                                 _needRest = NO;
                                 [_motionManager stopGyroUpdates];
                                 _magazineView.transform = CGAffineTransformMakeRotation(0);
                                 [[lowooMusic sharedLowooMusic] playShortMusic:@"reload" Type:@"mp3"];
                                 _bananaNumber = BANANANUMBER;
                                 [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstRock"];
                             }
                         } completion:^(BOOL finished) {
                             _magazineImageView.image = GetPngImage(@"magazineClip");
                             
                         }];
        [_imageViewBullet setImage:GetPngImage(@"bulletFull")];
        [self performSelector:@selector(setBulletImageNIL) withObject:nil afterDelay:0.3];
        [self performSelector:@selector(setBulletImage) withObject:nil afterDelay:0.6];
    }
}

- (void)setBulletImage{
    [_imageViewBullet setImage:GetPngImage(@"bulletFull")];
}
- (void)setBulletImageNIL{
    [_imageViewBullet setImage:nil];
}

#pragma mark--------------touchAction--------------
//起点固定 香蕉出现后开始判断触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_boolGameStart) {

    _needTouchAgain = NO;
    //固定香蕉起点
    _startPoint = CGPointMake((_gunBarrelView.frame.origin.x+_gunBarrelView.frame.size.width/2), 568);
    
    if (_banana) {//香蕉未初始化前禁止
        UITouch *touch = [touches anyObject];
        if ([touch view]==_boundary) {
            _beginPoint = [touch locationInView:_baseview];
            _endPoint = [touch locationInView:_baseview];
            //触摸开始，起点即终点，炮筒方向需移到触摸点，然后跟随手指移动，计算角度
            float angle = atan((_endPoint.x-_startPoint.x)/(_endPoint.y-_startPoint.y));
            CGPoint point = _pointPeople;
            point.x = point.x + (angle*30);
        }
    }
   }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_boolGameStart) {

    UITouch *touch = [touches anyObject];
    _endPoint = [touch locationInView:self.baseview];
    
    //计算移动距离
    float movementDistance = sqrt((_endPoint.x - _beginPoint.x)*(_endPoint.x - _beginPoint.x)+(_endPoint.y - _beginPoint.y)*(_endPoint.y - _beginPoint.y)) ;
    
    //方向向下则取消
    if (_endPoint.y>_beginPoint.y) {
        return;
    }
    
    if (!_needRest) {
        //香蕉出现后
        if (_banana) {
            //炮筒跟随手指移动
            float angle = atan((_endPoint.x-_startPoint.x)/(_endPoint.y-_startPoint.y))*0.43+3*M_PI/180;
            if (_targetPoint.y > _startPoint.y) {
                //angle = 1 - angle;
            }
            _gunBarrelView.transform = CGAffineTransformMakeRotation(-angle);
            CGPoint point = _pointPeople;
            point.x = point.x + (angle*20);
            _imageViewPeople.center = point;

            //计算移动距离    手势滑动超出触摸区域，以触摸区域边界为终点
            if (_endPoint.x<_boundary.frame.origin.x||_endPoint.x>(_boundary.frame.size.width+_boundary.frame.origin.x)||_endPoint.y<_boundary.frame.origin.y||_endPoint.y>(_boundary.frame.size.height+_boundary.frame.origin.y)) {
                if (_endPoint.x<_boundary.frame.origin.x) {
                    _targetPoint.x = _boundary.frame.origin.x;
                }
                if (_endPoint.x>(_boundary.frame.size.width+_boundary.frame.origin.x)) {
                    _targetPoint.x = _boundary.frame.size.width+_boundary.frame.origin.x;
                }
                if (_endPoint.y<_boundary.frame.origin.y) {
                    _targetPoint.y = _boundary.frame.origin.y;
                }
                if (_endPoint.y>(_boundary.frame.size.height+_boundary.frame.origin.y)) {
                    _targetPoint.y = (_boundary.frame.size.height+_boundary.frame.origin.y);
                }
                

                //滑动距离大于特定值才能发射子弹
                if (movementDistance > MINIMUM_SLIDING_DISTANCE) {
                    [self fireBullet];
                }
            }
        }
    }else{
        if (!_needTouchAgain) {
            [[lowooMusic sharedLowooMusic] playShortMusic:@"empty" Type:@"mp3"];
            _needTouchAgain = !_needTouchAgain;
        }
    }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_boolGameStart) {

    UITouch *touch = [touches anyObject];
    _endPoint = [touch locationInView:self.baseview];
    
    //计算移动距离
    float movementDistance = sqrt((_endPoint.x - _beginPoint.x)*(_endPoint.x - _beginPoint.x)+(_endPoint.y - _beginPoint.y)*(_endPoint.y - _beginPoint.y)) ;

    //滑动距离大于特定值才能发射子弹
    //方向向下则取消
    if (_endPoint.y>_beginPoint.y) {
        return;
    }
    
    if (!_needRest) {
        if (_banana) {
            //炮筒跟随手指移动
            
            //计算移动距离
            _targetPoint = _endPoint;

            if (movementDistance > MINIMUM_SLIDING_DISTANCE) {
                [self fireBullet];
                }
            }

    }else{
        if (!_needTouchAgain) {
            [[lowooMusic sharedLowooMusic] playShortMusic:@"empty" Type:@"mp3"];
            _needTouchAgain = !_needTouchAgain;
        }
    }
    _beginPoint = CGPointMake(0, 0);
    }
}
#pragma mark--------------发射子弹----------------
- (void)fireBullet{
    if (_mutableArrayMoveQueue.count>0) {
        lowooBananaView *bananaView = (lowooBananaView *)[_mutableArrayMoveQueue lastObject];
        //计算角度
        if (_targetPoint.x == _startPoint.x && _targetPoint.y==_startPoint.y) {
            _startPoint = CGPointMake(_boundary.frame.origin.x+_boundary.frame.size.width/2, _boundary.frame.origin.y+_boundary.frame.size.height+1);
        }
        
        bananaView.X = atan((_targetPoint.x-_startPoint.x)/(_targetPoint.y-_startPoint.y));
        bananaView.animation = YES;//标记香蕉在运动中  发射子弹
        if (!bananaView.fire) {
            //炮筒动画
            [UIView animateWithDuration:0.1f
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 CGRect frame = _viewPeople.frame;
                                 frame.origin.y += 5;
                                 _viewPeople.frame = frame;
                                 
                                 CGRect rect = _imageViewBullet.frame;
                                 rect.origin.y = rect.origin.y + 5;
                                 _imageViewBullet.frame = rect;
                             } completion:^(BOOL finished) {
                                 [UIView animateWithDuration:0.1f
                                                       delay:0
                                                     options:UIViewAnimationOptionCurveEaseOut
                                                  animations:^{
                                                      CGRect frame = _viewPeople.frame;
                                                      frame.origin.y -= 5;
                                                      _viewPeople.frame = frame;
                                                      
                                                      CGRect rect = _imageViewBullet.frame;
                                                      rect.origin.y = rect.origin.y - 5;
                                                      _imageViewBullet.frame = rect;
                                                  } completion:^(BOOL finished) {
                                                      
                                                  }];
                             }];
            [[lowooMusic sharedLowooMusic] playShortMusic:@"fire" Type:@"mp3"];
            bananaView.fire = YES;
        }
        _bananaNumber--;
        //弹壳变化
        if (_bananaNumber<=(BANANANUMBER*3/4)) {
            [_imageViewBullet setImage:GetPngImage(@"bullet3")];
        }
        if (_bananaNumber<=(BANANANUMBER*2/4)) {
            [_imageViewBullet setImage:GetPngImage(@"bullet2")];
        }
        if (_bananaNumber<=(BANANANUMBER*1/4)) {
            [_imageViewBullet setImage:GetPngImage(@"bullet1")];
        }
        if (_bananaNumber==0) {//没有子弹
            [_imageViewBullet setImage:nil];
            [self initMagazineView];
        }
        _banana = NO;
    }
}

- (void)initNextBanana{
    lowooBananaView *bananaView = [[lowooBananaView alloc]initWithFrame:CGRectMake(_gunBarrelView.frame.origin.x+_gunBarrelView.frame.size.width/2-670*0.15/2,_gunBarrelView.frame.origin.y+_gunBarrelView.frame.size.height/2-574*0.15, 670*0.15, 574*0.15)];
    bananaView.index = _bananaIndex;
    _bananaIndex ++;
    bananaView.backgroundColor = [UIColor clearColor];
    bananaView.delegate = self;
    bananaView.animation = NO;
    [_viewBanana addSubview:bananaView];
    [_mutableArrayMoveQueue addObject:bananaView];
    _banana = YES;
}

- (void)initMagazineView{
    _needRest = YES;
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _magazineView.transform = CGAffineTransformMakeRotation(-M_PI/2);
                         [self initGyro];
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)judgmentScoreWithBananaCenter:(float )center withIndex:(NSInteger )index{
    if (center>_viewTarget.center.x-_viewTarget.imageViewMorpheus.frame.size.width/2 && center<(_viewTarget.center.x+_viewTarget.imageViewMorpheus.frame.size.width/2)) {
        _hitMorpheus = YES;
        [_arrayHit addObject:[NSNull null]];
        [self performSelector:@selector(hitState) withObject:nil afterDelay:0.1];
        _score ++;
        
        //得分
        [_lifeValueView knockdownTheBossWithScore:_score];
        if (_mutableArrayMoveQueue.count>0) {
            for (lowooBananaView *bananaView in _mutableArrayMoveQueue) {
                if (bananaView.index == index) {
                    bananaView.impact = YES;
                    [[lowooMusic sharedLowooMusic] playShortMusic:@"hitTheTarget" Type:@"mp3"];
                    [[lowooMusic sharedLowooMusic] playShortMusic:@"hitTheGround" Type:@"mp3"];
                };
            }
        }
    }
}

//是否击中目标 击中目标的动画结束时间递延
- (void)hitState{
    if (_arrayHit.count>0) {
        [_arrayHit removeLastObject];
        if (_arrayHit.count==0) {
            _hitMorpheus = NO;
        }
    }
}

#pragma mark---------lowooPOPViewDismiss-----------
- (void)buttonGameOver{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [_timerGame invalidate]; _timerGame = nil;
        [_timer invalidate]; _timer = nil;
        [self gameEndDelegate];
    }];
}

- (void)buttonGameRepeateTouchUpInside:(NSNotification *)sender{
    [[lowooMusic sharedLowooMusic] stopPlayer];
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        [_timerGame invalidate]; _timerGame = nil;
        [_timer invalidate]; _timer = nil;
        [self gameEndDelegate];
    }];
    
    if (_boolGetupGame) {
        [_delegate getupGameStartNew];
    }else{
        [_delegate gameStartNew];
    }
}

- (void)gameEndDelegate{
    if ([_delegate respondsToSelector:@selector(gameEnd)]) {
        [_delegate gameEnd];
    }
}

#pragma mark-------------------321-----------------
- (void)buttonExitCancelTouchUpInside:(NSNotification *)sender{
    if (!_boolEnterToBack) {//防止ios7的下滑栏
        return;
    }
    if (_boolPOPview) {
        return;
    }else{
        _boolPOPview = YES;
    }
    [_timer invalidate]; _timer = nil;
  //  [[lowooMusic sharedLowooMusic] stopPlayer];
    _boolGameStart = NO;
    if (_boolGetupGame) {
        _buttonExit.userInteractionEnabled = NO;
        _buttonExit.hidden = YES;
    }else{
        _buttonExit.userInteractionEnabled = YES;
        _buttonExit.hidden = NO;
    }

    [self performSelector:@selector(gameContinue) withObject:nil afterDelay:2.1f];

    
    _imageViewGame1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 41)];
    [_imageViewGame1 setImage:GetPngImage(@"game1")];
    _imageViewGame1.hidden = YES;
    [_view321 addSubview:_imageViewGame1];
    
    _imageViewGame2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 41)];
    [_imageViewGame2 setImage:GetPngImage(@"game2")];
    _imageViewGame2.hidden = YES;
    [_view321 addSubview:_imageViewGame2];
    
    _imageViewGame3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 41)];
    [_imageViewGame3 setImage:GetPngImage(@"game3")];
    _imageViewGame3.hidden = YES;
    [_view321 addSubview:_imageViewGame3];
    

    [UIView animateWithDuration:0.7
                          delay:1.4
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _imageViewGame1.hidden = NO;
                         _imageViewGame1.transform = CGAffineTransformScale(_imageViewGame1.transform, 1.3, 1.3) ;
                     } completion:^(BOOL finished) {
                         _imageViewGame1.hidden = YES;
                         _boolPOPview = NO;
                         _buttonExit.userInteractionEnabled = YES;
                     }];
    [UIView animateWithDuration:0.7
                          delay:0.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _imageViewGame2.hidden = NO;
                         _imageViewGame2.transform = CGAffineTransformScale(_imageViewGame1.transform, 1.3, 1.3) ;
                     } completion:^(BOOL finished) {
                         _imageViewGame2.hidden = YES;
                     }];
    [UIView animateWithDuration:0.7
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _imageViewGame3.hidden = NO;
                         _imageViewGame3.transform = CGAffineTransformScale(_imageViewGame1.transform, 1.3, 1.3) ;
                     } completion:^(BOOL finished) {
                         _imageViewGame3.hidden = YES;
                     }];
}

#pragma mark----------动画引导-------------
- (void)animationFirst{
    if (_bananaNumber<=BANANANUMBER-2) {
        if (_imageViewFinger) {
            [_imageViewFinger removeFromSuperview]; _imageViewFinger = nil;
            [_imageViewArrow removeFromSuperview]; _imageViewArrow = nil;
        }
        return;
    }
    //多线程
//    if (_boolFirstAnimation) {
//        _boolFirstAnimation = NO;
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [_imageViewFinger setCenter:CGPointMake(228, 170)];
                         } completion:^(BOOL finished) {
                             
                         }];

        [UIView animateWithDuration:0.5 animations:^{
            _imageViewFinger.alpha = 1;
        }];
        [UIView animateWithDuration:0.3
                              delay:0.7
                            options:UIViewAnimationCurveEaseOut
                         animations:^{
                             _imageViewFinger.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             if (_bananaNumber<=BANANANUMBER-2) {
                                 [_imageViewFinger removeFromSuperview]; _imageViewFinger = nil;
                                 [_imageViewArrow removeFromSuperview]; _imageViewArrow = nil;
                             }
                         }];
        [self performSelector:@selector(fingerAnimationAgain) withObject:nil afterDelay:1.7];
    //}
}

- (void)fingerAnimationAgain{
    //_boolFirstAnimation = YES;
    if (_imageViewFinger) {
        [_imageViewFinger setCenter:CGPointMake(228, 430)];
        [self animationFirst];
    }
}

- (void)firstGameRockAnimation{
 
        if (_repeatCount%20==0) {
            [UIView animateWithDuration:0.03*10
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 _imageViewRock.transform = CGAffineTransformMakeRotation(M_PI/180*10);
                             } completion:^(BOOL finished) {
                                 //震动
                                  //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                             }];
        }else if(_repeatCount%20==10){
            [UIView animateWithDuration:0.03*10
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 _imageViewRock.transform = CGAffineTransformMakeRotation(-M_PI/180*10);
                             } completion:^(BOOL finished) {
                                 
                             }];
        }
    
}

- (void)gameContinue{
    _buttonExit.userInteractionEnabled = YES;
    _boolPOPview = YES;
    _boolGameStart = YES;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(NSTimerAction) userInfo:nil repeats:YES];
 //   [[lowooMusic sharedLowooMusic] playMusic:@"gamebc" type:@"mp3" numberOfLoops:-1 volume:0.5];
#pragma mark---------- 首次运行 动画引导 -----------
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstPlayGame"]) {
        return;
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstPlayGame"];
        _viewFirst = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _viewFirst.backgroundColor = [UIColor clearColor];
        _viewFirst.userInteractionEnabled = NO;
        [_viewBackground addSubview:_viewFirst];
        [_viewBackground bringSubviewToFront:_viewFirst];
        
        _imageViewArrow = [[UIImageView alloc]initWithFrame:CGRectMake(114, 249, 92, 184)];
        _imageViewArrow.userInteractionEnabled = NO;
        _imageViewArrow.image = GetPngImage(@"game_01");
        [_viewFirst addSubview:_imageViewArrow];
        
        _imageViewFinger = [[UIImageView alloc]initWithFrame:CGRectMake(138, 381, 180, 95)];
        _imageViewFinger.userInteractionEnabled = NO;
        _imageViewFinger.alpha = 0.3;
        _imageViewFinger.image = GetPngImage(@"game_02");
        [_viewFirst addSubview:_imageViewFinger];
        
        [self animationFirst];
    }
}

- (void)NSTimerAction{
    if (_score == SCORE) {
#pragma mark----------------游戏成功-------------
        [[lowooMusic sharedLowooMusic] stopPlayer];
        _boolGameOver = YES;
        if (_timer.isValid) {
            [_timer invalidate]; _timer = nil;
        }
        for (lowooBananaView *bananaView in _mutableArrayMoveQueue) {
            [bananaView.imageView stopAnimating];
        }
        //弹出云雾
        CGPoint point1 = CGPointMake(168, 164);
        CGSize size1 = CGSizeMake(73*0.3, 62*0.3);
        UIImageView *imageViewFog1 = [[UIImageView alloc]initWithImage:GetPngImage(@"gamefog01")];
        [imageViewFog1 setFrame:CGRectMake(point1.x-size1.width/2, point1.y-size1.height/2 , size1.width, size1.height)];
        [_viewTarget addSubview:imageViewFog1];
        
        CGPoint point2 = CGPointMake(155, 196);
        CGSize size2 = CGSizeMake(94*0.3, 72*0.3);
        UIImageView *imageViewFog2 = [[UIImageView alloc]initWithImage:GetPngImage(@"gamefog02")];
        [imageViewFog2 setFrame:CGRectMake(point2.x-size2.width/2, point2.y-size2.height/2, size2.width, size2.height)];
        [_viewTarget addSubview:imageViewFog2];
        
        _boolPOPview = YES;
#pragma mark--------玩游戏成功----------
        [[lowooMusic sharedLowooMusic] playShortMusic:@"gamewin" Type:@"mp3"];
        if (!_boolGetupGame) {
            [_motionManager stopAccelerometerUpdates]; _motionManager = nil;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 [imageViewFog1 setFrame:CGRectMake(point1.x-73/2, point1.y-62/2, 73 , 62)];
                                 [imageViewFog2 setFrame:CGRectMake(point2.x-94/2, point2.y-72/2, 94 , 72)];
                             } completion:^(BOOL finished) {

                                 lowooPOPgameSuccess *popGameSuccess = [[lowooPOPgameSuccess alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                                 [[lowooAlertViewDemo sharedAlertViewManager]show:popGameSuccess];
                                 [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:gameSuccess];
                                 
                             }];
            
#pragma mark---------起床成功--------------
        }else{
            
            [_motionManager stopAccelerometerUpdates]; _motionManager = nil;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 [imageViewFog1 setFrame:CGRectMake(point1.x-73/2, point1.y-62/2, 73 , 62)];
                                 [imageViewFog2 setFrame:CGRectMake(point2.x-94/2, point2.y-72/2, 94 , 72)];
                             } completion:^(BOOL finished) {
                                 if ([[lowooHTTPManager getInstance] isExistenceNetwork]) {
                                     [[activityView sharedActivityView] showHUD:-1];
                                     [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: _gameup.fid, @"fid", _gameup.tid, @"tid", nil] requestType:continuousGetup];
                                 }else{
                                     [self getupGameSuccessWithOutNetwork];
                                 }
                                 //取消当天本地闹铃
                                 [[LocalNotification sharedLocalNotification] cancelLocalNotificationOfToday];
                                 if (![self.gameup.stringIndex isEqualToString:@""]) {
                                        [[LocalNotification sharedLocalNotification]cancelLocalNotificationWithIndex:self.gameup.stringIndex];
                                 }
                             }];
            
        }
    }
    
    if (_boolGameOver) {
        if (_timer.isValid) {
            [_timer invalidate]; _timer = nil;
        }
    }else{
        [_viewCloud scrollImageWithRepeatCount:_repeatCount];
        [_timeView TimeViewMaskViewMoveWithRepeatCount:_repeatCount startPoint:_maskViewStartPoint score:_score];
        _repeatCount ++;
        [_viewTarget sleepBedMoveWithRepeatCount:_repeatCount score:_score hitMorpheus:_hitMorpheus];
        
        //销毁
        if (_mutableArrayMoveQueue.count>0) {
            //子页面最好不要销毁父视图创建的对象，在子页面中标记destory，在父页面中判断destory进行销毁
            [self destoryBanana];
        }
        
        //香蕉运动
        for (int i = 0; i<_mutableArrayMoveQueue.count; i++) {
            lowooBananaView *bananaView = [_mutableArrayMoveQueue objectAtIndex:i];
            if (bananaView.animation) {
                [bananaView bananaMoveWithX:bananaView.X];
            }
        }
        
        if (!_banana) {
            [self initNextBanana];
        }
    }
    
    if (_boolFirstRock) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstRock"]) {
            return;
        }
        [self firstGameRockAnimation];
    }
}

#pragma mark -------------- 无网络下起床成功 -------------
- (void)getupGameSuccessWithOutNetwork{
    [[activityView sharedActivityView] removeHUD];

    lowooPOPGetUpSuccessfully *getUpSuccess = [[lowooPOPGetUpSuccessfully alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    getUpSuccess.imageViewGold.hidden = YES;
    [[lowooAlertViewDemo sharedAlertViewManager] show:getUpSuccess];
}

#pragma mark --------------- 起床成功返回 ----------
- (void)continuousGetup:(NSNotification *)notification{
    [[activityView sharedActivityView] removeHUD];
    int coin = [[notification.userInfo objectForKey:@"coin"] intValue];
    [[userModel sharedUserModel] setUserInformation:[notification.userInfo objectForKey:@"total"] forKey:USER_COIN];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buyCoin" object:[notification.userInfo objectForKey:@"total"] userInfo:nil];

    lowooPOPGetUpSuccessfully *getUpSuccess = [[lowooPOPGetUpSuccessfully alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    NSString *stringCoin = [NSString stringWithFormat:@"Gold%02d",coin];
    getUpSuccess.imageViewGold.image = GetPngImage(stringCoin);
    [[lowooAlertViewDemo sharedAlertViewManager] show:getUpSuccess];
}

- (void)destoryBanana{
    for (int t = 0; t<_mutableArrayMoveQueue.count; t++) {
        lowooBananaView *view = [_mutableArrayMoveQueue objectAtIndex:t];
        if (view.destory) {
            [view removeFromSuperview];
            [_mutableArrayMoveQueue removeObjectAtIndex:t];
        }
    }
}

- (void)destoryBanana:(UIView *)bananaView WithIndex:(NSInteger )index{
    for (int t = 0; t<_mutableArrayMoveQueue.count; t++) {
        lowooBananaView *view = [_mutableArrayMoveQueue objectAtIndex:t];
        if (view.index == index) {
            [view removeFromSuperview];
            [_mutableArrayMoveQueue removeObjectAtIndex:t];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [_motionManager stopGyroUpdates];
}


#pragma mark -------------- 是否开启音乐 --------------
- (BOOL)isMusicAllow{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:MUSIC_ALLOW]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:MUSIC_ALLOW] boolValue]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark-------AVAudioPlayerDelegate--------
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (player) {
        [player stop];
        player = nil;
    }
}

- (void)playShortMusic:(NSString *)name Type:(NSString *)type{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
    NSError *error = nil;
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    if (error == nil) {
        if ([self isMusicAllow]) {
            //player.delegate = self;
            [player prepareToPlay];
            [player play];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[lowooMusic sharedLowooMusic] stopPlayer];
    [_motionManager stopAccelerometerUpdates]; _motionManager = nil;
    [_gameup removeFromSuperview];
    _gameup = nil;
}

@end
