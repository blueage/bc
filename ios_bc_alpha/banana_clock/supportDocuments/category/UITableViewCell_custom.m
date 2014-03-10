//
//  UITableViewCell_custom.m
//  banana_clock
//
//  Created by MAC on 13-9-13.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "UITableViewCell_custom.h"

@implementation UITableViewCell_custom

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
