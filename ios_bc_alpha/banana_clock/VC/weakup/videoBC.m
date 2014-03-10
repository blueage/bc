//
//  video.m
//  banana_clock
//
//  Created by MAC on 13-10-21.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "videoBC.h"
#import "UITabBarController_custom.h"
#import "lowooAppDelegate.h"
//@class lowooAppDelegate;

@interface videoBC ()

@end

@implementation videoBC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoStart) name:@"applicationDidBecomeActive" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoStop) name:@"applicationDidEnterBackground" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self hideTabBar:YES];
    [self startPlayingVideo];
}

- (void)videoStop{
    if (_moviePlayer) {
        [_moviePlayer prepareToPlay];
        [_moviePlayer pause];
    }
}

- (void)videoStart{
    if (_moviePlayer) {
        [_moviePlayer prepareToPlay];
        [_moviePlayer play];
    }
}

- (void)startPlayingVideo{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *urlAsString = [mainBundle pathForResource:@"startBC1" ofType:@"m4v"];
    NSURL *url = [NSURL fileURLWithPath:urlAsString];
    
    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoHasFinishedPlaying:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [_moviePlayer setScalingMode:MPMovieScalingModeAspectFill];
    [_moviePlayer.view setFrame:self.view.bounds];
    [self.view addSubview:self.moviePlayer.view];//设置写在添加之后
    _moviePlayer.shouldAutoplay = YES;
    [_moviePlayer setControlStyle:MPMovieControlStyleNone];
    [_moviePlayer setFullscreen:YES];

}

- (void)videoHasFinishedPlaying:(NSNotification *)paramNotification{
    
    /* Find out what the reason was for the player to stop */
    NSNumber *reason =
    [paramNotification.userInfo
     valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    if (reason != nil){
        NSInteger reasonAsInteger = [reason integerValue];
        
        switch (reasonAsInteger){
            case MPMovieFinishReasonPlaybackEnded:{
                /* The movie ended normally */
                break;
            }
            case MPMovieFinishReasonPlaybackError:{
                /* An error happened and the movie ended */
                break;
            }
            case MPMovieFinishReasonUserExited:{
                /* The user exited the player */
                break;
            }
        }
        [self stopPlayingVideo:nil];
    } /* if (reason != nil){ */
    
}

- (void) stopPlayingVideo:(id)paramSender {
    if (self.moviePlayer != nil){
        [[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:MPMoviePlayerPlaybackDidFinishNotification
         object:self.moviePlayer];
        [self.moviePlayer pause];
        [self.moviePlayer stop];
        
        if ([self.moviePlayer.view.superview isEqual:self.view]){
            [self.moviePlayer.view removeFromSuperview];
        }
        self.moviePlayer = nil;
    }
    LOWOO_APP(app);
//    lowooLoginVC *loginVC = [[lowooLoginVC alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar_custom class] toolbarClass:nil];
//    nav.viewControllers = @[loginVC];
//    [app.window setRootViewController:nav];
    [app changeVC:0];
    
    if ([_delegate respondsToSelector:@selector(videoEnd)]) {
        [_delegate videoEnd];
    }
}


- (void) hideTabBar:(BOOL) hidden{
    
    [UIView beginAnimations:nil context:NULL];
    if (hidden) {
        [UIView setAnimationDuration:0];
        
    }
    else {
        [UIView setAnimationDuration:0];
    }
    
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, 431, view.frame.size.width, view.frame.size.height)];
            }
        }
        else
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 431)];
            }
        }
    }
    
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self stopPlayingVideo:Nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [super dealloc];
    _moviePlayer = nil;
    [_moviePlayer release];
}

@end
