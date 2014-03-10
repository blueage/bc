//
//  lowooBananaView.m
//  test
//
//  Created by MAC on 13-2-18.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBananaView.h"
#import <QuartzCore/QuartzCore.h>

@implementation lowooBananaView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _impact = NO;
        _destory = NO;
        _animation = NO;
        _fire = NO;
        _judgmentCollision = YES;
        Count = 1;
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.image = [UIImage imageNamed:@"gameBanana1.png"];
        NSMutableArray *mutableArrayImage = [[NSMutableArray alloc] init];
        for (int i=1; i<9; i++) {
            NSString *bananaName = [NSString stringWithFormat:@"gameBanana%d.png",i];
            UIImage *image = [UIImage imageNamed:bananaName];
            [mutableArrayImage addObject:image];
        }
        _imageView.animationImages = mutableArrayImage;
        _imageView.animationDuration = 1.0f;
        _imageView.animationRepeatCount = 0;
        [_imageView startAnimating];
        
        [self addSubview:_imageView];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)bananaMoveWithX:(float )X{
    if (Count==63+166) {
        _destory = YES;
    }
    
    CGPoint point = self.center;
    point.x = point.x - X*10;
    point.y = point.y -21 + Count/2;
    
    //移出屏幕外
    if (point.x <= (0 - self.frame.size.width/2 || point.x >= (320 + self.frame.size.width/2))) {
        //[_delegate judgmentScoreWithBananaCenter:self.center.x withIndex:_index];
        [self destoryBanana:self.center.x withIndex:_index];
    }

    if (-21 + Count/2>0 && self.frame.origin.y+self.frame.size.height>BED_HEIGHT) {
        //判断得分
        if (_judgmentCollision) {
            //[_delegate judgmentScoreWithBananaCenter:self.center.x withIndex:_index];
            [self destoryBanana:self.center.x withIndex:_index];
            _judgmentCollision = NO;//只判断一次
            
            if (_impact) {//击中
                [_delegate destoryBanana:self WithIndex:_index];
            }else{
            
            }
        }
    }
    
    NSInteger random = arc4random()%6;
    NSInteger random1 = arc4random()%2;
    if (-21 + Count/2>0&&self.center.y>(GROUND_HEIGHT-(random*2+random1*3))) {//Y 撞击地面
        //撞击 _impact
        if (!_impact&&self.center.x<290) {//X
            _impact = YES;
            NSInteger random = arc4random()%3;
            [_imageView stopAnimating];
            NSString *namepng = [NSString stringWithFormat:@"impact%d.png",random];
            _imageView.image = [UIImage imageNamed:namepng];//GetPngImage(namepng);
            
        }
        if (!_impact&&self.center.x<=285) {
            
        }
    }

     if (!_impact) {
         self.center = point;
         if (Count%3==0) {
             self.transform =  CGAffineTransformScale(CGAffineTransformRotate(self.transform, -X*M_PI/18),0.96, 0.96);
         }
     }
    Count ++;
}

- (void)destoryBanana:(float )center withIndex:(NSInteger )index{
    if ([_delegate respondsToSelector:@selector(judgmentScoreWithBananaCenter:withIndex:)]) {
        [_delegate judgmentScoreWithBananaCenter:center withIndex:index];
    }
}

@end
