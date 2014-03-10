//
//  baseCell.m
//  banana_clock
//
//  Created by MAC on 13-7-15.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "baseCell.h"

@implementation baseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _viewOne = [[UIView alloc] init];
        [self addSubview:_viewOne];

    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
