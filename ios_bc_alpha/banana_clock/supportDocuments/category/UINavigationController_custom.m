//
//  UINavigationController_custom.m
//  banana_clock
//
//  Created by MAC on 13-11-1.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "UINavigationController_custom.h"

@interface UINavigationController_custom ()

@end

@implementation UINavigationController_custom

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadLayerWithImage{
    UIGraphicsBeginImageContext(self.visibleViewController.view.bounds.size);
    [self.visibleViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    [animationLayer setContents: (id)viewImage.CGImage];
    [animationLayer setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    animationLayer = [CALayer layer] ;
    CGRect layerFrame = self.view.frame;
    layerFrame.size.height = self.view.frame.size.height-self.navigationBar.frame.size.height;
    layerFrame.origin.y = self.navigationBar.frame.size.height+20;
    animationLayer.frame = layerFrame;
    animationLayer.masksToBounds = YES;
    [animationLayer setContentsGravity:kCAGravityBottomLeft];
//    [self.view.layer insertSublayer:animationLayer atIndex:0];
//    animationLayer.delegate = self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [animationLayer removeFromSuperlayer];
    [self.view.layer insertSublayer:animationLayer atIndex:0];
    if(animated)
    {
        [self loadLayerWithImage];
        
        UIView * toView = [viewController view];
        
        
        //例如这里是transform，就是图像的transform的改变，常见的有翻页，渐变，上，下拉进，拉出的效果，如果是bounds的话，那么就是该UIView的bounds属性变化，如变大变小，如果是position，那么就是UIView整体位置的改变
        CABasicAnimation *Animation  = [CABasicAnimation animationWithKeyPath:@"transform"];
        [Animation setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(self.view.bounds.size.width, 0, 0)]];
        [Animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];
        [Animation setDuration:0.3];
        Animation.delegate = self;
        Animation.removedOnCompletion = NO;
        Animation.fillMode = kCAFillModeBoth;
        [toView.layer addAnimation:Animation forKey:@"fromRight"];

        
        CABasicAnimation *Animation2  = [CABasicAnimation animationWithKeyPath:@"transform"];
        [Animation2 setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];
        [Animation2 setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-320, 0, 0)]];
        [Animation2 setDuration:0.3];
        Animation2.delegate = self;
        Animation2.removedOnCompletion = NO;
        Animation2.fillMode = kCAFillModeBoth;
        [animationLayer addAnimation:Animation2 forKey:@"fromRight"];
        
    }
    [super pushViewController:viewController animated:NO];
}

//-(UIViewController*)popViewControllerAnimated:(BOOL)animated
//{
//    [animationLayer removeFromSuperlayer];
//    [self.view.layer insertSublayer:animationLayer above:self.view.layer];
//    if(animated)
//    {
//        [self loadLayerWithImage];
//        
//        
//        
//        UIView * toView = [[self.viewControllers objectAtIndex:[self.viewControllers indexOfObject:self.visibleViewController]-1] view];
//
//        CABasicAnimation *Animation  = [CABasicAnimation animationWithKeyPath:@"transform"];
//        [Animation setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];
//        [Animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(320, 0, 0)]];
//        [Animation setDuration:0.3];
//        Animation.delegate = self;
//        Animation.removedOnCompletion = NO;
//        Animation.fillMode = kCAFillModeBoth;
//        [animationLayer addAnimation:Animation forKey:@"scale"];
//        
//        
//        CABasicAnimation *Animation2  = [CABasicAnimation animationWithKeyPath:@"transform"];
//        [Animation2 setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-320, 0, 0)]];
//        [Animation2 setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];
//        [Animation2 setDuration:0.3];
//        Animation2.delegate = self;
//        Animation2.removedOnCompletion = NO;
//        Animation2.fillMode = kCAFillModeBoth;
//        [toView.layer addAnimation:Animation2 forKey:@"scale"];
//        
//    }
//    return [super popViewControllerAnimated:NO];
//}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [animationLayer setContents:nil];
    [animationLayer removeAllAnimations];
    [self.visibleViewController.view.layer removeAllAnimations];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
