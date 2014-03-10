//
//  lowooHeadCell.h
//  banana clock
//
//  Created by MAC on 12-10-9.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseCell.h"


@protocol lowooHeadCellDelegate <NSObject>
@optional
- (void)buttonEditDidTouchedUpInside;
- (void)imageHeadTaped:(UIImage *)image;
@end


@interface lowooHeadCell : baseCell

@property (nonatomic, weak) id<lowooHeadCellDelegate>delegate;
@property (strong, nonatomic) UIImageView_custom *imageviewUserHead;
@property (nonatomic, strong) UIButton_custom *buttonBig;
@property (strong, nonatomic) UIImageView *imageviewUserMale;
@property (strong, nonatomic) UILabel *labelUserName;
@property (strong, nonatomic) UILabel *labelUserLocation;
@property (strong, nonatomic) UILabel *labelUserID;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) UIImageView *imageviewEditor;
@property (nonatomic, assign) BOOL boolSelf;
@property (nonatomic, strong) UIImageView *imageViewMoss;
@property (nonatomic, strong) UIButton *buttonMoss;
@property (nonatomic, strong) UIButton_custom *buttonFoucs;
@property (nonatomic, strong) NSString *fid;

- (void)confirmDataWithUser:(modelUserDetail *)userg;


@end
