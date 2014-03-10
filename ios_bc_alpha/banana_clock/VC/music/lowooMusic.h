//
//  lowooMusic.h
//  banana clock
//
//  Created by MAC on 12-9-27.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface lowooMusic : NSObject<AVAudioPlayerDelegate,NSCopying>

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) AVAudioPlayer *ShortPlayer;

+ (lowooMusic *)sharedLowooMusic;


- (void)SystemSoundID:(NSString *)name type:(NSString *)type;
- (void)playMusic:(NSString *)name type:(NSString *)type numberOfLoops:(NSInteger )number volume:(float )volume;
- (void)stopPlayer;
- (void)playShortMusic:(NSString *)name Type:(NSString *)type;


- (BOOL)isMusicAllow;



@end



