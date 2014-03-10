//
//  lowooShareWeibo.h
//  banana_clock
//
//  Created by MAC on 13-8-20.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBaseView.h"


@protocol lowooShareWeiboDelegate <NSObject>
- (void)shareWeiboWithText:(NSString *)text;
- (void)shareRenren:(NSString *)text;
@end



@interface lowooShareWeibo : lowooBaseView<UITextViewDelegate>

@property (nonatomic, weak) id<lowooShareWeiboDelegate>delegate;
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) NSInteger textCount;
@property (nonatomic, strong) UIView *viewBase;
@property (nonatomic, strong) UIImageView *imageViewTextBack;
@property (nonatomic, strong) UIView *viewImageView;
@property (nonatomic, assign) CGRect rectTextBackEnglish;
@property (nonatomic, assign) CGRect rectTextBackChinese;
@property (nonatomic, assign) CGRect rectTextEnglish;
@property (nonatomic, assign) CGRect rectTextChinese;
@property (nonatomic, assign) CGPoint pointImageCenterEnglish;
@property (nonatomic, assign) CGPoint pointImageCenterChinese;
@property (nonatomic, strong) NSString *postText;

@end
