//
//  propNumber.m
//  banana_clock
//
//  Created by MAC on 13-8-14.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "propNumber.h"

@implementation propNumber

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setNumber:(int)number{
    _number = number;
    //无限
    if (self.number == -1) {
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 25)];
        imageView1.image = GetPngImage(@"GoldxBig");
        [self addSubview:imageView1];
        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(13, 6, 23, 14)];
        imageView2.image = GetPngImage(@"wuxianBig");
        [self addSubview:imageView2];
        if (iPhone5) {
            CGPoint point = CGPointMake(200, 62);//右对齐
            [self setFrame:(CGRect){point,{28, 35}}];
        }else{
            CGPoint point = CGPointMake(200, 45);//右对齐
            [self setFrame:(CGRect){point,{28, 35}}];
        }
        
        return;
    }
    [self draw];
}

- (void)draw{
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }

    NSMutableArray *numbers = [NSMutableArray array];
    int n = self.number;
    int left = 0;
    UIImage *image = GetPngImage(@"GoldxBig");
    UIImageView *coin = [[UIImageView alloc] initWithImage:image];
    [coin setFrame:(CGRect){CGPointMake(0, 0),{image.size.width / 2, image.size.height / 2}}];
    [self addSubview:coin];
    left = image.size.width / 2;
    while (n) {
        int c = n % 10;
        [numbers addObject:[NSNumber numberWithInt:c]];
        n = n / 10;
    }
    if (_number == 0) {
        [numbers addObject:[NSNumber numberWithInt:0]];
    }
    if (numbers.count == 1) {//最少两位数
        [numbers addObject:[NSNumber numberWithInteger:0]];
    }
    for (int i = [numbers count] - 1; i >= 0; i--){
        NSString *name = [NSString stringWithFormat:@"buy%@", [numbers objectAtIndex:i]];
        image = GetPngImage(name);
        coin = [[UIImageView alloc] initWithImage:image];
        [coin setFrame:(CGRect){{left, 0}, {image.size.width / 2, image.size.height / 2}}];
        [self addSubview:coin];
        left += image.size.width / 2 - 1;
    }

    if (iPhone5) {
        CGPoint point = CGPointMake(230-left, 60);//右对齐
        [self setFrame:(CGRect){point,{left, coin.frame.size.height}}];
    }else{
        CGPoint point = CGPointMake(230-left, 45);//右对齐
        [self setFrame:(CGRect){point,{left, coin.frame.size.height}}];
    }
    
    
}



@end
