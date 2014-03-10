//
//  sinaCell.h
//  banana_clock
//
//  Created by MAC on 13-7-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THLabel.h"


@protocol sinaCellDelegate <NSObject>
- (void)sinaCellButtonTouchupInside:(NSString *)fid toSinaID:(NSString *)sinaid;
@end

@interface sinaCell : UITableViewCell


@property (nonatomic, weak) id<sinaCellDelegate>delegate;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) NSString *stringfid;
@property (nonatomic, strong) NSString *stringSinaid;
@property (nonatomic, strong) UIImageView *imageviewBackGound;
@property (strong, nonatomic) UIButton_custom *button;
@property (nonatomic, strong) THLabel *labelAdd;
@property (nonatomic, strong) UIImageView_custom *imageViewHead;



-(void)ConfirmDataWithDictionary:(NSDictionary *)dictionary;











@end
