//
//  lowooProductManager.m
//  banana_clock
//
//  Created by LowooMac02 on 8/10/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import "lowooProductManager.h"


@interface lowooProductManager () <SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    RequestProductFailed    failed;
    RequestProductFinished  finished;
}

@property (nonatomic, strong) NSMutableDictionary *products;

@end

@implementation lowooProductManager

- (void)initProduct{
    NSArray *ids = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Products" ofType:@"plist"]];
    for (NSString *pid in ids){
        [self.products setObject:[NSNull null] forKey:pid];
    }
}

- (id)init{
    if (self = [super init]){
        self.products = [[NSMutableDictionary alloc] init];
        [self initProduct];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
//        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    }
    return self;
}

+ (lowooProductManager *)shared{
    static lowooProductManager *manager = nil;
    if (!manager){
        manager = [[lowooProductManager alloc] init];
    }
    return manager;
} 

//加入购买序列
- (void)payforProduct:(SKProduct *)product{
    if ([SKPaymentQueue canMakePayments]){
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }else{
        if ([_delegate respondsToSelector:@selector(ProductManager:PayFailed:)]){
            [_delegate ProductManager:self PayFailed:UnSupportPay];
        }
    }
}

//点击购买按钮
- (void)requestProductWithIndex:(int)index{
    NSArray *ids = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Products" ofType:@"plist"]];
    NSString *key = [ids objectAtIndex:index];
    SKProduct *product = [self.products objectForKey:key];
    if ([product isKindOfClass:[NSNull class]]){
        NSSet *set = [NSSet setWithObject:[ids objectAtIndex:index]];
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        [request setDelegate:self];
        [request start];
    }else{
        if ([_delegate respondsToSelector:@selector(ProductManager:ReceiveProduct:)]){
            [_delegate ProductManager:self ReceiveProduct:product];
        }
    }
}

- (void)requestProductWithPid:(NSString *)pid{
    NSSet *set = [NSSet setWithObject:pid];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    [request setDelegate:self];
    [request start];
}

#pragma mark ----------- SKProductsRequestDelegate ------------
- (void)productsRequest:(SKProductsRequest *)request
     didReceiveResponse:(SKProductsResponse *)response{
    if ([response.invalidProductIdentifiers count]){
        if ([_delegate respondsToSelector:@selector(ProductManager:failedGetProduct:)]){
            [_delegate ProductManager:self failedGetProduct:[response.invalidProductIdentifiers lastObject]];
        }
    }else{
        if ([_delegate respondsToSelector:@selector(ProductManager:ReceiveProduct:)]){
            SKProduct *product = [response.products lastObject];
            [_delegate ProductManager:self ReceiveProduct:product];
            [self.products setObject:product forKey:product.productIdentifier];
        }
    }
}

#pragma mark ----------- SKRequestDelegate -----------
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    if ([_delegate respondsToSelector:@selector(ProductManager:failedGetProduct:)]){
        [_delegate ProductManager:self failedGetProduct:error];
    }
}

#pragma mark ---------- SKPaymentTransactionObserver ---------
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    SKPaymentTransaction *transaction = [transactions lastObject];
    switch (transaction.transactionState) {
        case SKPaymentTransactionStatePurchasing://Transaction is being added to the server queue.
            if ([_delegate respondsToSelector:@selector(ProductManager:Purchasing:)]) {
                [_delegate ProductManager:self Purchasing:[self.products objectForKey:transaction.payment.productIdentifier]];
            }
            break;
        case SKPaymentTransactionStatePurchased:
            if ([_delegate respondsToSelector:@selector(ProductManager:PayFinished:)]){
                [_delegate ProductManager:self PayFinished:[self.products objectForKey:transaction.payment.productIdentifier]];
            }
            [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
            break;
        case SKPaymentTransactionStateFailed:
            [liboTOOLS dismissHUD];
            [liboTOOLS alertViewMSG:transaction.error.localizedDescription];
//            if ([_delegate respondsToSelector:@selector(ProductManager:Failed:)]) {
//                [_delegate ProductManager:self Failed:[self.products objectForKey:transaction.payment.productIdentifier]];
//            }
            [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
            break;
        case SKPaymentTransactionStateRestored:
            if ([_delegate respondsToSelector:@selector(ProductManager:Restored:)]) {
                [_delegate ProductManager:self Restored:[self.products objectForKey:transaction.payment.productIdentifier]];
            }
            break;
        default:
            break;
    }
    
}


- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{

}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{
    for (SKPaymentTransaction *transation in [queue transactions]){
        [queue finishTransaction:transation];
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray *)downloads{

}






@end
