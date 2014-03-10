//
//  lowooPOPTermsOfService.h
//  banana_clock
//
//  Created by MAC on 14-1-14.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "popView.h"
@class lowooPOPTermsOfService;

@protocol lowooPOPTermsOfServiceDelegate <NSObject>
- (void)lowooPOPTermsOfServiceDismiss:(lowooPOPTermsOfService *)view;
@end

@interface lowooPOPTermsOfService : popView<UIWebViewDelegate>

@property (nonatomic, assign) id<lowooPOPTermsOfServiceDelegate>delegate;



@end
