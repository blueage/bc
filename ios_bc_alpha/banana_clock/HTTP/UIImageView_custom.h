//
//  UIImageView_custom.h
//  banana_clock
//
//  Created by MAC on 13-10-15.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "lowooAppDelegate.h"
//#import "ASIHTTPRequest.h"
//#import "ASIDownloadCache.h"
//#import "ASINetworkQueue.h"


@interface UIImageView_custom : UIImageView

//@property (nonatomic, strong) ASIHTTPRequest *request;



- (void)setImageURL:(NSString *)url;

- (void)downLoadImage:(NSString *)url;

- (void)storeImageUrl:(NSString *)url;



@end
