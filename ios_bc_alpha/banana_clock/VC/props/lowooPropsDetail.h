//
//  lowooPropsDetail.h
//  banana clock
//
//  Created by MAC on 12-9-26.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lowooPropsBuy.h"
#import "lowooBaseView.h"
#import "lowooMusic.h"
#import <AVFoundation/AVFoundation.h>



@interface lowooPropsDetail : lowooBaseView<AVAudioPlayerDelegate>

@property (nonatomic, strong) UIView *viewProp;
@property (strong, nonatomic) UIButton_custom *buttonAudition;
@property (strong, nonatomic) UIButton_custom *buttonSuspended;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) modelProp *prop;//保存数据，图片未下载时重新刷新
@property (nonatomic, assign) NSInteger buyCount;
@property (nonatomic, assign) int coin;

//下载铃声
@property (nonatomic, strong) UIView *viewProgress;
@property (nonatomic, strong) UIProgressView *progressView;

@end
