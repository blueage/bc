//
//  lowooCoinView.m
//  banana_clock
//
//  Created by ChenLei on 13-8-13.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooCoinView.h"

#define timeNumberChange 0.1
static float imageSize = 1.0;

@implementation lowooCoinView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _arrayCount = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setNumber:(int)number{//给 _number 赋值 .h 中不用注册此方法即可使用
    
    if (_number==0) {//首次初始化
        _number = number;
        _targetNumber = number;
        [self draw:[NSNumber numberWithInt:number]];
    }else{
        //float time = 1.0/(float)(oldNumber-number);//无论变化多少次，总的变化时间固定
        //先结束上次动画
        if (_targetNumber != number) {
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            [self draw:[NSNumber numberWithInt:_targetNumber]];
            _targetNumber = number;
        }

        int oldNumber = _number;
        [self performSelector:@selector(setImageSize) withObject:nil afterDelay:timeNumberChange*(oldNumber-number)];
        [self performSelector:@selector(draw:) withObject:[NSNumber numberWithInt:_targetNumber] afterDelay:timeNumberChange*(oldNumber-number)];
        for (int i=0; i<(oldNumber-number); i++) {
            imageSize = 1.2;
            _number -= 1;
            [self performSelector:@selector(draw:) withObject:[NSNumber numberWithInt:_number] afterDelay:timeNumberChange*i];
            [self performSelector:@selector(music) withObject:nil afterDelay:timeNumberChange*i];
        }
    }
}

- (void)music{
    [[lowooMusic sharedLowooMusic] SystemSoundID:@"gold" type:@"mp3"];
}

- (void)setImageSize{
    imageSize = 1.0;
}

- (void)draw:(NSNumber *)NUM{
    int number = [NUM intValue];
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }

    NSMutableArray *numbers = [NSMutableArray array];
    int n = number;
    int left = 0;
    UIImage *image = GetPngImage(@"GoldBig");
    UIImageView *coin = [[UIImageView alloc] initWithImage:image];
    [coin setFrame:(CGRect){CGPointMake(0, 5),{image.size.width / 2, image.size.height / 2}}];
    [self addSubview:coin];
    left = image.size.width / 2;
    while (n) {
        int c = n % 10;
        [numbers addObject:[NSNumber numberWithInt:c]];
        n = n / 10;
    }
    if (number<=0) {
        [numbers addObject:[NSNumber numberWithInt:0]];
        [numbers addObject:[NSNumber numberWithInt:0]];
    }
    if (number>9999) {
        [numbers removeAllObjects];
        [numbers addObject:[NSNumber numberWithInt:9]];
        [numbers addObject:[NSNumber numberWithInt:9]];
        [numbers addObject:[NSNumber numberWithInt:9]];
        [numbers addObject:[NSNumber numberWithInt:9]];
    }
    //数字
    for (int i = [numbers count] - 1; i >= 0; i--){
        NSString *name = [NSString stringWithFormat:@"big%@", [numbers objectAtIndex:i]];
        image = GetPngImage(name);
        coin = [[UIImageView alloc] initWithImage:image];
        [coin setFrame:(CGRect){{left, (image.size.height/2-image.size.height/2*imageSize)/2}, {image.size.width/2*imageSize, image.size.height/2*imageSize}}];
        [self addSubview:coin];
        left += image.size.width/2*imageSize - 1.5;
    }
    
    CGPoint point;
    if (iPhone5||iPhone5_0) {
        point = CGPointMake(300-left, [BASE statusBarHeight]-3);
    }else{
        if (IOS_7) {
            point = CGPointMake(300-left, [BASE statusBarHeight]-3);
        }else{
            point = CGPointMake(300-left, 20);
        }
    }
    
    [self setFrame:(CGRect){point,{left, coin.frame.size.height}}];
    if (number>9999) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(left, 0, 16, 16)];
        imageView.image = GetPngImage(@"coin+");
        [self addSubview:imageView];
    }
    
    UIImageView *imageBack = [[UIImageView alloc] initWithFrame:(CGRect){-3,2,175,40}];
    imageBack.image = GetPngImage(@"coinBC");
    [self addSubview:imageBack];
    [self sendSubviewToBack:imageBack];
}





@end
