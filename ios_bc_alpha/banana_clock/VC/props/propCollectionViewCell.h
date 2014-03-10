//
//  propCollectionViewCell.h
//  banana_clock
//
//  Created by MAC on 13-6-25.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THLabel.h"


@protocol propCollectionViewCellDelegate <NSObject>
- (void)collectionViewCellTouch:(UIButton_custom *)sender;
@end



@interface propCollectionViewCell : UICollectionViewCell


@property (nonatomic, weak) id<propCollectionViewCellDelegate>delegate;
@property (nonatomic, strong) UIButton_custom *button;
@property (nonatomic, strong) THLabel *label;
@property (nonatomic, strong) UIView *viewNumber;
@property (nonatomic, strong) modelProp *prop;
@property (nonatomic, assign) NSInteger number;

@property (nonatomic, strong) NSDictionary *dictionaryProps;

- (void)confirmProp:(modelProp *)prop;
- (void)initNumber:(NSInteger *)string;




@end
