//
//  lowooBananaView.h
//  test
//
//  Created by MAC on 13-2-18.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol lowooBananaViewDelegate <NSObject>

- (void)judgmentScoreWithBananaCenter:(float )center withIndex:(NSInteger )index;
- (void)destoryBanana:(UIView *)bananaView WithIndex:(NSInteger )index;

@end


@interface lowooBananaView : UIView{
    NSInteger Count;
}
@property (nonatomic, weak) id<lowooBananaViewDelegate>delegate;
@property (nonatomic, assign) BOOL impact;
@property (nonatomic, assign) BOOL destory;
@property (nonatomic, assign) BOOL fire;
@property (nonatomic, assign) float X;
//@property (nonatomic, assign) float Y;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, assign) BOOL judgmentCollision;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL animation;


- (void)bananaMoveWithX:(float )X;


@end
