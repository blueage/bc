//
//  lowooAllProps.h
//  banana_clock
//
//  Created by MAC on 13-7-11.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooViewController.h"
#import "lowooBaseVC.h"
#import "propBuyCell.h"
#import "lowooPropsDetail.h"

@class lowooAllProps;

@protocol lowooAllPropsDelegate <NSObject>
- (void)viewDismiss:(lowooAllProps *)viewController;
@end

@protocol lowooAllPropsDataSource <NSObject>
- (void)viewLoaded:(lowooAllProps *)viewController;
@end

@interface lowooAllProps : lowooBaseVC<propBuyCellDelegate>
@property (nonatomic, assign) id<lowooAllPropsDelegate>delegate;
@property (nonatomic, assign) id<lowooAllPropsDataSource>dataSource;
@property (nonatomic, strong) NSMutableArray *mutableArray1;
@property (nonatomic, strong) NSMutableArray *mutableArray2;
@property (nonatomic, strong) NSMutableArray *mutableArray3;
@property (nonatomic, strong) NSMutableArray *mutableArray4;
@property (nonatomic, strong) NSMutableArray *arrayCells;
@property (nonatomic, strong) UIButton_custom *ButtonSectiona1;
@property (nonatomic, strong) UIButton_custom *ButtonSectiona2;
@property (nonatomic, strong) UIButton_custom *ButtonSectiona3;
@property (nonatomic, strong) UIButton_custom *ButtonSectiona4;
@property (nonatomic, strong) NSArray *arrayProps;

@property (nonatomic, strong) UIView *viewBase;
@property (nonatomic, assign) NSInteger viewHeight;
@property (nonatomic, strong) UIScrollView *scrollView;

- (void)initPropsGroup;

@end
