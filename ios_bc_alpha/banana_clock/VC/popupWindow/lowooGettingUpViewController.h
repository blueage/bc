//
//  lowooGettingUpViewController.h
//  banana_clock
//
//  Created by MAC on 13-5-6.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lowooViewController.h"
#import "lowooBaseView.h"
#import "lowooPOPGettingUp.h"

@interface lowooGettingUpViewController : lowooBaseView



@property (nonatomic, weak) id<lowooPOPGettingUpDelegate>delegate;

@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) UIImageView *imageViewBack;
@property (nonatomic, strong) UIImageView *imageViewProp;
@property (nonatomic, strong) UIImageView *imageViewText;
@property (nonatomic, strong) viewHead *viewHead;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) BOOL boolAnimation;
@property (nonatomic, strong) UIImageView *imageViewPeopleLeft;
@property (nonatomic, strong) UIImageView *imageViewPeopleRight;


- (void)animation;

- (void)confirmDataWithUser:(modelUser *)user propID:(NSString *)propID;






@end
