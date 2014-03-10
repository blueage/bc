//
//  lowooProductManager.h
//  banana_clock
//
//  Created by LowooMac02 on 8/10/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#define UnSupportPay @"不支持内购服务"

typedef void (^RequestProductFinished)(SKProduct *product);
typedef void (^RequestProductFailed)(NSString *reason);

@protocol lowooProductManagerDelegate;


@interface lowooProductManager : NSObject

@property (nonatomic, assign) id <lowooProductManagerDelegate> delegate;

+ (lowooProductManager *)shared;


- (void)payforProduct:(SKProduct *)product;
- (void)requestProductWithIndex:(int)index;
- (void)requestProductWithPid:(NSString *)pid;

@end


@protocol lowooProductManagerDelegate <NSObject>


- (void)ProductManager:(lowooProductManager *)manager
           PayFinished:(SKProduct *)product;


- (void)ProductManager:(lowooProductManager *)manager
             PayFailed:(NSString *)reason;


- (void)ProductManager:(lowooProductManager *)manager
        ReceiveProduct:(SKProduct *)product;

- (void)ProductManager:(lowooProductManager *)manager
      failedGetProduct:(id)pid;

- (void)ProductManager:(lowooProductManager *)manager
      Purchasing:(SKProduct *)product;

- (void)ProductManager:(lowooProductManager *)manager
            Failed:(SKProduct *)product;

- (void)ProductManager:(lowooProductManager *)manager
            Restored:(SKProduct *)product;

@end