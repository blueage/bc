//
//  lowooPOPTheInvitationHasBeenSent.h
//  banana_clock
//
//  Created by MAC on 13-3-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popView.h"

@protocol lowooPOPTheInvitationHasBeenSentDelegate <NSObject>
- (void)buttonTheInvitationHasBeenSentTouchUpinsideWithentity:(UIView *)entity;
@end


@interface lowooPOPTheInvitationHasBeenSent : popView


@property (nonatomic, weak) id<lowooPOPTheInvitationHasBeenSentDelegate>delegate;



@end
