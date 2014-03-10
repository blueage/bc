//
//  pickerCell.m
//  time
//
//  Created by MAC on 14-1-25.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "pickerCell.h"

@implementation pickerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)initView{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _cellSize.width, _cellSize.height)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = RGB(77.0, 76.0, 86.0);
    _label.alpha = 0.8;
    [_label setFont:[UIFont fontWithName:@"Futura" size:16.0]];
    [self addSubview:_label];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
