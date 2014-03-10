//
//  modelProp.h
//  banana_clock
//
//  Created by MAC on 14-1-23.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "model.h"

@interface modelProp : model

@property (nonatomic, strong) NSString *nameChinese;
@property (nonatomic, strong) NSString *nameEnglish;

@property (nonatomic) NSInteger propID;
@property (nonatomic) NSInteger propPrice;
@property (nonatomic, strong) NSString *term;
@property (nonatomic) NSInteger number;


@end
