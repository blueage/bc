//
//  phoneNumberCell.h
//  banana_clock
//
//  Created by MAC on 13-7-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THLabel.h"

@protocol phoneNumberCellDelegate <NSObject>
- (void)phoneNumberCellButtonTouchupInside:(UIButton_custom *)sender;
@end

@interface phoneNumberCell : UITableViewCell

@property (nonatomic, weak) id<phoneNumberCellDelegate>delegate;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIButton_custom *buttonAdd;
@property (nonatomic, strong) NSString *stringFid;
@property (nonatomic, strong) THLabel *labelAdd;

- (void)confirmData:(NSDictionary *)sender;


@end
