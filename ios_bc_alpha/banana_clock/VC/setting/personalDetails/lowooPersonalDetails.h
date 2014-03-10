//
//  lowooPersonalDetails.h
//  banana clock
//
//  Created by MAC on 12-10-8.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#define ACHIEVEMENT_CHINESE         @"achievement_chinese"
#define ACHIEVEMENT_ENGLISH         @"achievement_english"
#define ACHIEVEMENT_CONTENT         @"achievement_content"
#define MEDAL_CHINESE               @"medal_chinese"
#define MEDAL_ENGLISH               @"medal_english"
#define MEDAL_CONTENT               @"medal_content"

#import <UIKit/UIKit.h>
#import "lowooHeadCell.h"
#import "lowooSettingCell1.h"
#import "lowooSettingCell2.h"
#import "lowooRepeat.h"
#import "lowooChangeOfPersonalInformationVC.h"
#import "lowooTimeSet.h"
#import "lowooSettingCell3.h"
#import "lowooBaseVC.h"
#import "settingSectionCell.h"
#import "selfStateCell.h"
#import "BigImage.h"

@class lowooPersonalDetails;

@protocol lowooPersonalDetailsDelegate <NSObject>
- (void)viewDismiss:(lowooPersonalDetails *)viewController;
@end

@protocol lowooPersonalDetailsDataSource <NSObject>
- (void)viewLoaded:(lowooPersonalDetails *)viewController;
@end

@interface lowooPersonalDetails : lowooBaseVC<lowooHeadCellDelegate,lowooSettingCell1Delegate,lowooSettingCell2Delegate,UIScrollViewDelegate,lowooChangeOfPersonalInformationVCDelegate,BigImageDelegate>

@property (nonatomic, assign) id<lowooPersonalDetailsDelegate>delegate;
@property (nonatomic, assign) id<lowooPersonalDetailsDataSource>dataSoure;
@property (nonatomic, strong) NSIndexPath *indexPathReload;
@property (nonatomic) BOOL boolReloadCell;//不使用 assign  可以在再次登录时重新定义其值  assign更换账号后可能会保存自身的值
@property (nonatomic, strong) NSString *fid;
@property (nonatomic, assign) BOOL selfSetting;//set 可以在其他文件中引用 标记是不是自己的设置项
@property (nonatomic, strong) UIImageView *imageViewHeader;


@property (nonatomic, strong) NSMutableArray *arrayExpandedIndex;
@property (nonatomic, strong) NSMutableDictionary *dictionarySubItemsAmt;//保存索引，确定哪个cell展开
@property (nonatomic, strong) NSMutableArray *mutableArrayBoolExpanded;
@property (nonatomic, strong) modelUserDetail *user;




@end
