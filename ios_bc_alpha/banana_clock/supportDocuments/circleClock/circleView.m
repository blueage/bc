//
//  circleView.m
//  circleNew
//
//  Created by MAC on 14-2-11.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "circleView.h"

@implementation circleView

#define DISTANCE (360.0/144.0)

#define ToRad(deg)      ((M_PI*(deg))/180.0)
#define ToDeg(rad)      ((180.0*(rad))/M_PI)
#define SQR(x)          ((x)*(x))

#define lineWidth 5

static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped){
    CGPoint v = CGPointMake(p2.x-p1.x, p2.y-p1.y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)) , result = 0;
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y, v.x);
    result = ToDeg(radians);
    return (result>=0? result:result+360.0);
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.center = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imageView.image = [UIImage imageNamed:@"timepan.png"];
        [self addSubview:imageView];
    }
    return self;
}

- (void)loadViewWithStartTime:(NSInteger)start EndTime:(NSInteger)end{
    NSInteger allTime = 12*12;
    double time = M_PI*2/allTime;
    
    self.initailStartAngle = time*(12*6 - start);
    self.initailEndAngle = time*(12*6 - end);
    self.initailProgress = time*(12*6 - start + 14);
    
    [self addGesture];
    [self showImage];
}

/*
 显示圆环
 显示方式是确定圆心正下方的点，然后逆时针绘制点
 */
- (void)showImage{
    self.average_radina = 2*M_PI/2;
//    circleImageView *dragImageView = self.imageViewStart;
//    CGFloat width = dragImageView.frame.size.width;
//    CGFloat heigh = dragImageView.frame.size.height;
    //计算半径
//    self.radius = MIN(self.frame.size.width-width, self.frame.size.height-heigh)/2.0;
//    self.radius = MIN(self.frame.size.width-width, self.frame.size.height-heigh)/2.0 - 6;
    
    CGPoint pointStart = [self getPointByRadian:self.initailStartAngle centreOfCircle:self.center radiusOfCircle:self.radius];
    CGPoint pointImageViewProgress = [self getPointByRadian:self.initailProgress centreOfCircle:self.center radiusOfCircle:self.imageViewProgress.radius];
    
    self.imageViewProgress.center = pointImageViewProgress;
    self.imageViewProgress.userInteractionEnabled = NO;
    self.imageViewProgress.current_radian = self.initailProgress;
    self.imageViewProgress.userInteractionEnabled = NO;
    [self addSubview:self.imageViewProgress];
    self.imageViewProgress.transform = CGAffineTransformMakeRotation(-self.imageViewProgress.current_radian + M_PI);
    
    
    
    
    self.imageViewStart.center = pointStart;
    self.imageViewStart.current_radian = self.initailStartAngle;
    self.imageViewStart.radian = self.initailStartAngle;
    self.imageViewStart.view_point = pointStart;
    self.imageViewStart.current_animation_radian = [self getAnimationRadianByRadian:self.initailStartAngle];
    self.imageViewStart.animation_radian = [self getAnimationRadianByRadian:self.initailStartAngle];
    self.imageViewStart.userInteractionEnabled = YES;
    [self addSubview:self.imageViewStart];
    self.imageViewStart.angleOld = self.imageViewStart.current_radian/(2*M_PI)*360;
    self.imageViewStart.countOld = self.imageViewStart.count;
    self.imageViewStart.transform = CGAffineTransformMakeRotation(-self.imageViewStart.current_radian);
    
    
    CGPoint pointEnd = [self getPointByRadian:self.initailEndAngle centreOfCircle:self.center radiusOfCircle:self.radius];
    self.imageViewEnd.center = pointEnd;
    self.imageViewEnd.current_radian = self.initailEndAngle;
    self.imageViewEnd.radian = self.initailEndAngle;
    self.imageViewEnd.view_point = pointEnd;
    self.imageViewEnd.current_animation_radian = [self getAnimationRadianByRadian:self.initailEndAngle];
    self.imageViewEnd.animation_radian = [self getAnimationRadianByRadian:self.initailEndAngle];
    self.imageViewEnd.userInteractionEnabled = YES;
    [self addSubview:self.imageViewEnd];
    self.imageViewEnd.angleOld = self.imageViewEnd.current_radian/(2*M_PI)*360;
    self.imageViewEnd.countOld = self.imageViewEnd.count;
    self.imageViewEnd.transform = CGAffineTransformMakeRotation(-self.imageViewEnd.current_radian);
}



/*
 添加手势
 */
- (void)addGesture{
    UIPanGestureRecognizer *panStart = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(startPanAction:)];
    [self.imageViewStart addGestureRecognizer:panStart];
    
    UIPanGestureRecognizer *panEnd = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(endPanAction:)];
    [self.imageViewEnd addGestureRecognizer:panEnd];
}

- (void)startPanAction:(UIPanGestureRecognizer *)pan{
    self.boolStart = YES;
    [self handleSinglePan:pan];
}

- (void)endPanAction:(UIPanGestureRecognizer *)pan{
    self.boolStart = NO;
    [self handleSinglePan:pan];
}

//手势操作
- (void)handleSinglePan:(id)sender{
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)sender;
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.pointDrag = [panGesture locationInView:self];
            if ([_delegate respondsToSelector:@selector(circleViewStartMove:)]) {
                [_delegate circleViewStartMove:self];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
            CGPoint pointMove = [panGesture locationInView:self];
            [self dragPoint:self.pointDrag movePoint:pointMove centerPoint:self.center];
            self.pointDrag = pointMove;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint pointMove = [panGesture locationInView:self];
            [self dragPoint:self.pointDrag movePoint:pointMove centerPoint:self.center];
            
            if ([_delegate respondsToSelector:@selector(circleViewFinishedSelect:)]) {
                [_delegate circleViewFinishedSelect:self];
            }
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
            CGPoint pointMove = [panGesture locationInView:self];
            [self dragPoint:self.pointDrag movePoint:pointMove centerPoint:self.center];
            if ([_delegate respondsToSelector:@selector(circleViewFinishedSelect:)]) {
                [_delegate circleViewFinishedSelect:self];
            }
            
        }
            break;
            
        default:
            break;
    }
}

//随着拖动改变子view位置，子view与y轴的夹角，子view与x轴的夹角
- (void)dragPoint:(CGPoint)dragPoint movePoint:(CGPoint)movePoint centerPoint:(CGPoint)centerPoint{
    CGFloat drag_radian   = [self schAtan2f:dragPoint.x - centerPoint.x theB:dragPoint.y - centerPoint.y];
    CGFloat move_radian   = [self schAtan2f:movePoint.x - centerPoint.x theB:movePoint.y - centerPoint.y];
    CGFloat change_radian = (move_radian - drag_radian);
//    NSLog(@"move");
    _endMove = 144/2 - self.imageViewEnd.current_radian/(2*M_PI)*144;
    if (_endMove<0) {
        _endMove += 144;
    }
    
    if (self.boolStart) {//开始按钮
        //移动开始按钮
        self.imageViewStart.center = [self getPointByRadian:(self.imageViewStart.current_radian+change_radian) centreOfCircle:self.center radiusOfCircle:self.radius];
        self.imageViewStart.current_radian = [self getRadinaByRadian:self.imageViewStart.current_radian + change_radian];
        self.imageViewStart.transform = CGAffineTransformMakeRotation(-self.imageViewStart.current_radian);

        //移动结束按钮
        self.imageViewEnd.center = [self getPointByRadian:(self.imageViewEnd.current_radian+change_radian) centreOfCircle:self.center radiusOfCircle:self.radius];
        self.imageViewEnd.current_radian = [self getRadinaByRadian:self.imageViewEnd.current_radian + change_radian];
        self.imageViewEnd.transform = CGAffineTransformMakeRotation(-self.imageViewEnd.current_radian);
        //移动进度条

        CGFloat progressAngle = self.imageViewStart.current_radian + 2;
        if (2*M_PI - progressAngle < 0) {
            progressAngle = progressAngle - 2*M_PI;
        }
        self.imageViewProgress.center = [self getPointByRadian:(self.imageViewProgress.current_radian+change_radian) centreOfCircle:self.center radiusOfCircle:self.imageViewProgress.radius];
        
        self.imageViewProgress.current_radian = [self getRadinaByRadian:self.imageViewProgress.current_radian + change_radian];
        self.imageViewProgress.transform = CGAffineTransformMakeRotation(-self.imageViewProgress.current_radian + M_PI);
        
       
        //判断是否移动一个单位
        if (self.imageViewStart.countOld != self.imageViewStart.count) {
            self.imageViewStart.countOld = self.imageViewStart.count;
            //设置结束按钮的实际位置，防止不同步
            NSInteger endcount = self.imageViewStart.count - self.endDistance;
            if (endcount<0) {
                endcount += 144;
            }
            self.imageViewEnd.countOld = endcount;
            if ([_delegate respondsToSelector:@selector(circleView:didSelectStart:End:)]) {
                [_delegate circleView:self didSelectStart:self.imageViewStart.count End:self.imageViewEnd.count];
            }
        }
    }else{//结束按钮
//        NSLog(@"end");
        CGPoint centerStart = self.imageViewStart.center;
        CGPoint centerEnd = [self getPointByRadian:(self.imageViewEnd.current_radian+change_radian) centreOfCircle:self.center radiusOfCircle:self.radius];
        NSInteger angleStart = [self computerViewAngle:centerStart];
        NSInteger angleEnd = [self computerViewAngle:centerEnd];
        
        NSInteger distance =  angleStart - angleEnd;
        if (distance<0) {
            distance +=360;
        }

        //移动范围内
        if (distance >= (float)[_dataSource CircleViewMinDistance]/144.0*360.0 && distance<=(float)[_dataSource CircleViewMaxDistance]/144.0*360.0) {
            self.imageViewEnd.center = [self getPointByRadian:(self.imageViewEnd.current_radian+change_radian) centreOfCircle:self.center radiusOfCircle:self.radius];
            self.imageViewEnd.current_radian = [self getRadinaByRadian:self.imageViewEnd.current_radian + change_radian];
            self.imageViewEnd.current_animation_radian = [self getAnimationRadianByRadian:self.imageViewEnd.current_radian];
            self.imageViewEnd.transform = CGAffineTransformMakeRotation(-self.imageViewEnd.current_radian);
        }else{
        }
        
        
        //判断是否移动一个单位
        if (self.imageViewEnd.countOld != self.imageViewEnd.count) {
            self.imageViewEnd.countOld = self.imageViewEnd.count;
            self.endDistance = self.imageViewStart.count - self.imageViewEnd.count;
            if (self.endDistance<0) {
                self.endDistance += 144;
            }else if (self.endDistance>144){
                self.endDistance -= 144;
            }

            NSInteger distance = self.imageViewStart.count - self.imageViewEnd.count;
            if (distance<0) {
                distance = self.imageViewStart.count + (144-self.imageViewEnd.count);
            }
            if ([_delegate respondsToSelector:@selector(circleView:selectEnd:endDistance:)]) {
                [_delegate circleView:self selectEnd:self.imageViewEnd.count endDistance:distance];
            }
        }
    }
}

//根据点计算角度
- (NSInteger)computerViewAngle:(CGPoint)point{
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    int currentAngle = floor(AngleFromNorth(centerPoint, point, NO));
    return currentAngle;
    NSInteger viewAngle = 360 - 90 - currentAngle;
    return viewAngle+90;
}

//计算schAtan值
- (CGFloat)schAtan2f:(CGFloat)a theB:(CGFloat)b
{
    CGFloat rd = atan2f(a,b);
    
    if(rd < 0.0f)
        rd = M_PI * 2 + rd;
    
    return rd;
}

//计算线与y轴的夹角,确保在0～2*M_PI之间
- (CGFloat)getRadinaByRadian:(CGFloat)radian
{
    if(radian > 2 * M_PI)//floorf表示不大于该数的最大整数
        return (radian - floorf(radian / (2.0f * M_PI)) * 2.0f * M_PI);
    
    if(radian < 0.0f)//ceilf表示不小于于该数的最小整数
        return (2.0f * M_PI + radian - ceilf(radian / (2.0f * M_PI)) * 2.0f * M_PI);
    
    return radian;
}

//根据夹角（与y轴），中心点，半径就出点坐标
- (CGPoint)getPointByRadian:(CGFloat)radian centreOfCircle:(CGPoint)circle_point radiusOfCircle:(CGFloat)circle_radius
{
    CGFloat c_x = sinf(radian) * circle_radius + circle_point.x;
    CGFloat c_y = cosf(radian) * circle_radius + circle_point.y;
    
    return CGPointMake(c_x, c_y);
}

//根据和y轴的夹角换算成与x轴的夹角用于拖动后旋转
- (CGFloat)getAnimationRadianByRadian:(CGFloat)radian
{
    
    CGFloat an_r = 2.0f * M_PI -  radian + M_PI_2;
    
    if(an_r < 0.0f)
        an_r =  - an_r;
    
    return an_r;
}

@end
