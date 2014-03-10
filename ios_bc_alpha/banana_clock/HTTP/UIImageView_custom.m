//
//  UIImageView_custom.m
//  banana_clock
//
//  Created by MAC on 13-10-15.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "UIImageView_custom.h"
#import "UIImageView+AFNetworking.h"
#import "TMCache.h"


@implementation UIImageView_custom

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setImageURL:(NSString *)url{
    if (url == nil) {
        return;
    }
    NSString *requestUrl;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"] boolValue]) {
        requestUrl = [NSString stringWithFormat:@"%@%@",BASEURL,url];
    }else{
        requestUrl = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"base_server_url"],url];
    }

    [self downLoadImage:requestUrl];
}

- (void)storeImageUrl:(NSString *)url{
    NSString *requestUrl;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"baseurl"] boolValue]) {
        requestUrl = [NSString stringWithFormat:@"%@%@",BASEURL,url];
    }else{
        requestUrl = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"base_server_url"],url];
    }

    [[TMMemoryCache sharedCache] objectForKey:[[NSURL URLWithString:requestUrl] absoluteString]
                                        block:^(TMMemoryCache *cache, NSString *key, id object) {
                                            if (object) {
                                                [self setImageOnMainThread:(UIImage *)object];
                                                return;
                                            }
                                            
                                            NSURLResponse *response = nil;
                                            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
                                            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
                                            
                                            UIImage *image = [[UIImage alloc] initWithData:data];// scale:[[UIScreen mainScreen] scale]];
                                            [self setImageOnMainThread:image];
                                            
                                            [[TMMemoryCache sharedCache] setObject:image forKey:[[NSURL URLWithString:requestUrl] absoluteString]];
    }];
}

- (void)downLoadImage:(NSString *)url{
    [[TMCache sharedCache] objectForKey:[[NSURL URLWithString:url] absoluteString]
                                  block:^(TMCache *cache, NSString *key, id object) {
                                      if (object) {
                                          [self setImageOnMainThread:(UIImage *)object];
                                          return;
                                      }

                                          NSURLResponse *response = nil;
                                          NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
                                          NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
                                          
                                          UIImage *image = [[UIImage alloc] initWithData:data];// scale:[[UIScreen mainScreen] scale]];
                                          [self setImageOnMainThread:image];
                                          
                                          [[TMCache sharedCache] setObject:image forKey:[[NSURL URLWithString:url] absoluteString]];

                                  }];
}

- (void)setImageOnMainThread:(UIImage *)image
{
    if (!image)
        return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = image;
    });
}

- (void)dealloc{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
