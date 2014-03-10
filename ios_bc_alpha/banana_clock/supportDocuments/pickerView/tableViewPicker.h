//
//  tableViewPicker.h
//  time
//
//  Created by MAC on 14-1-25.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class tableViewPicker;

@protocol tableViewPickerDataSource <NSObject>
- (void)pickerSelectAtRow:(NSInteger)row tableViewPixker:(tableViewPicker *)picker;
@end

@interface tableViewPicker : UITableView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id <tableViewPickerDataSource>pickerDataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) float currentY;
@property (nonatomic) CGSize cellSize;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) BOOL boolStop;
@property (nonatomic) NSInteger cellNumber;

- (void)setSelectRow:(NSInteger)row;

@end
