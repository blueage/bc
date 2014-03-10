//
//  circleImageView.h
//  circleNew
//
//  Created by MAC on 14-2-11.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface circleImageView : UIImageView

//与y轴实时角度（逆时针方向），用于在拖动时候确定DragImageView的中心
@property(nonatomic) CGFloat current_radian;

//记录该位置初始的角度（与y轴）
@property(nonatomic) CGFloat radian;

//与x轴实时角度 用于DragImageView拖动停止后的旋转
@property(nonatomic) CGFloat current_animation_radian;

//记录该位置初始角度（与x轴）
@property(nonatomic) CGFloat animation_radian;

//DragImageView的中心
@property(nonatomic) CGPoint view_point;

@property (nonatomic, assign) CGFloat angle;//角度 360
@property (nonatomic, assign) CGFloat angleOld;
@property (nonatomic, assign) NSInteger count;//以144为总长的距离
@property (nonatomic, assign) NSInteger countOld;
@property (nonatomic, assign) float radius; //旋转的半径

@end
