//
//  lowooNavigationView.m
//  banana_clock
//
//  Created by MAC on 13-4-27.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooNavigationView.h"
#import "lowooHTTPManager.h"
#import "lowooCoinView.h"

@interface lowooNavigationView (){
}
@end

@implementation lowooNavigationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self resetNumber];
        _viewGold.hidden = YES;
    }
    return self;
}

- (void)resetNumber{
    [_viewGold removeFromSuperview];
    _viewGold = nil;
    
    _viewGold = [[lowooCoinView alloc] init];
    @try {
        int number = [[[userModel sharedUserModel] getUserInformationWithKey:USER_COIN] intValue];
        [_viewGold setNumber:number];
    }
    @catch (NSException *exception) {
        int number = 0;
        [_viewGold setNumber:number];
    }
    @finally {
        
    }
    
    [self addSubview:_viewGold];
}

- (void)resetNumberWithNotification:(NSNotification *)sender{
    [self resetNumber];
}



@end
