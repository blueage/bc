//
//  pickerCell.h
//  time
//
//  Created by MAC on 14-1-25.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pickerCell : UITableViewCell

@property (nonatomic) CGSize cellSize;
@property (nonatomic, strong) UILabel *label;

- (void)initView;

@end
