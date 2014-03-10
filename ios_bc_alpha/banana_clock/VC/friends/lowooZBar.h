//
//  lowooZBar.h
//  banana_clock
//
//  Created by MAC on 13-3-26.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBaseView.h"
#import "ZBarSDK.h"


@interface lowooZBar : lowooBaseView<ZBarReaderDelegate>


@property (nonatomic, strong) UIView *viewZBarBase;
@property (nonatomic, strong) UIImageView *imageViewLine;
@property (nonatomic, strong) NSTimer *timer;

@end
