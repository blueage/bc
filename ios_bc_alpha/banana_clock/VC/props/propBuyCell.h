//
//  propBuyCell.h
//  banana_clock
//
//  Created by MAC on 13-7-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THLabel.h"


@protocol propBuyCellDelegate <NSObject>
- (void)collectionViewCellTouch:(UIButton_custom *)sender;
@end


@interface propBuyCell : UICollectionViewCell



@property (nonatomic, weak) id<propBuyCellDelegate>delegate;
@property (nonatomic, strong) UIButton_custom *button;
@property (nonatomic, strong) THLabel *label;



@property (nonatomic, strong) UIView *viewNumber;
@property (nonatomic, strong) UIView *viewPrice;

@property (nonatomic, strong) NSDictionary *dictionaryProps;


- (void)confirmProp:(modelProp *)prop;
- (void)initNumber:(NSString *)string;
- (void)initPrice:(NSString *)string;
- (void)setDefault;


@end
