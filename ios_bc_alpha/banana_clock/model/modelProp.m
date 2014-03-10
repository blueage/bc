//
//  modelProp.m
//  banana_clock
//
//  Created by MAC on 14-1-23.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "modelProp.h"

@implementation modelProp

- (NSString *)nameChinese{
    return [self checkNSStringJSONdictionary:@"name"];
}

- (NSString *)nameEnglish{
    return [self checkNSStringJSONdictionary:@"english"];
}

- (NSInteger)propID{
    return [[self.JSONdictionary objectForKey:@"id"] intValue];
}

- (NSInteger)propPrice{
    return [[self.JSONdictionary objectForKey:@"price"] intValue];
}

- (NSString *)term{
    return [self.JSONdictionary objectForKey:@"term"];
}

- (NSInteger)number{
    return [[self.JSONdictionary objectForKey:@"num"] intValue];
}


@end
