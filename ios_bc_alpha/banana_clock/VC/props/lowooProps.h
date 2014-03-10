//
//  lowooProps.h
//  banana clock
//
//  Created by MAC on 12-10-29.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooBaseVC.h"
#import "lowooPropsDetail.h"
#import "lowooGame.h"
#import "propCollectionViewCell.h"
#import "lowooAllProps.h"
#import "systemBoot.h"


@interface lowooProps : lowooBaseVC<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,propCollectionViewCellDelegate,lowooAllPropsDelegate,lowooAllPropsDataSource>


@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UITableViewCell_custom *jungleThrowingCell;
@property (strong, nonatomic) UITableViewCell_custom *cellPropStore;
@property (nonatomic ,strong) UIButton_custom *buttonAllProps;
@property (nonatomic, assign) BOOL boolPushAllProps;
@property (nonatomic, strong) systemBoot *boot;
@property (nonatomic, strong) lowooAllProps *allProps;



@end

