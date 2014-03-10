//
//  video.h
//  banana_clock
//
//  Created by MAC on 13-10-21.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@protocol videoPlayerDelegate <NSObject>

- (void)videoEnd;

@end

@interface videoBC : UIViewController

@property (nonatomic, assign) id<videoPlayerDelegate>delegate;
@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;

@end
