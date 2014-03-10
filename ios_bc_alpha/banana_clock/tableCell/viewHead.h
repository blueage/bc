//
//  viewHead.h
//  banana_clock
//
//  Created by MAC on 13-8-27.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface viewHead : NSObject

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UILabel *label;

- (void)setImageWithUrl:(NSString *)url name:(NSString *)name;

- (void)setSmallImageWithUrl:(NSString *)url name:(NSString *)name;

- (void)setCallBackImageWithUrl:(NSString *)url name:(NSString *)name;

@end
