//
//  model.h
//  banana_clock
//
//  Created by MAC on 14-1-21.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface model : NSObject

@property (nonatomic, strong) NSDictionary *JSONdictionary;
@property (nonatomic, strong) NSArray *JSONarray;


- (BOOL)checkJSONdictionary:(NSString *)key;
- (NSString *)checkNSStringJSONdictionary:(NSString *)key;

@end
