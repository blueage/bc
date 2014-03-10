//
//  lowooMusic.m
//  banana clock
//
//  Created by MAC on 12-9-27.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooMusic.h"
#import "lowooHTTPManager.h"

@interface lowooMusic(private)
-(void)play;
-(void)stop;
@end

@implementation lowooMusic


static lowooMusic *sharedMusic = nil;
+ (lowooMusic *)sharedLowooMusic{
    @synchronized(self){
        if (sharedMusic == nil) {
            sharedMusic = [[self alloc]init];
        }
    }
    return sharedMusic;
}

+ (id)alloc{
    @synchronized ([self class]){
		if (sharedMusic == nil) {
			sharedMusic = [super alloc];
		}
		return sharedMusic;
	}
	return nil;
}

- (id)copyWithZone:(NSZone *)zone{
    return sharedMusic;
}

#pragma mark -------------- SystemSoundID ----------
- (void)SystemSoundID:(NSString *)name type:(NSString *)type{
    if ([self isMusicAllow]) {
        NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:type];
        SystemSoundID ID = (SystemSoundID )name;
        if (path) {
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &ID);
            AudioServicesPlaySystemSound(ID);
            AudioServicesRemoveSystemSoundCompletion(ID);
        }
    }
}






#pragma mark-------AVAudioPlayerDelegate--------
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [player pause];
    [player stop];
    player = nil;
    [_array removeObject:player];
}



//播放长音乐
-(void)playMusic:(NSString *)name type:(NSString *)type numberOfLoops:(NSInteger )number volume:(float )volume{
    if ([name intValue]>32 || [name intValue]<0) {
        return;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
    NSError *error = nil;
    [_player stop];
    _player = nil;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    _player.volume = volume;
    _player.numberOfLoops = number;
    if (error == nil) {
        if ([self isMusicAllow]) {
            [_player prepareToPlay];
            [_player play];
        }
    }
}

- (void)stopPlayer{
    if (_player) {
        [_player pause];
        [_player stop];
        _player = nil;
    }
}

//播放短音乐
- (void)playShortMusic:(NSString *)name Type:(NSString *)type{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (filePath) {
        NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
        NSError *error = nil;
        _ShortPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if (error == nil) {
            if ([self isMusicAllow]) {
                if (!_array) {_array = [[NSMutableArray alloc] init];}
                [_array insertObject:_ShortPlayer atIndex:0];
                _ShortPlayer = nil;
                AVAudioPlayer *player = (AVAudioPlayer *)[_array objectAtIndex:0];
                player.delegate = self;
                [player prepareToPlay];
                [player play];
            }
        }
    }
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


@end
