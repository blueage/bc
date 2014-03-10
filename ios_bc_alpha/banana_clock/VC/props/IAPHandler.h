/*
 IAPHandler实现ECPurchase与的两个代理接口：ECPurchaseTransactionDelegate和ECPurchaseProductDelegate，ECPurchase的执行结果会被IAPHandler接收处理。 IAPHandler被设计为单例类，目的是防止在iap请求过程中IAPHandler的实例被销毁，导致iap购买结果返回后找不到处理的实例对象。
 IAPHandler处理了玩家的购买请求后会使用消息中心（NSNotificationCenter）对外发送一条消息，我们可以在相关的视图里接收该消息，更新视图
 
 导入以下库：
 StoreKit.framework
 CFNetwork.framework
 SystemConfiguration.framework
 libz.1.2.5.dylib
 
 */

#define IAPDidReceivedProducts                          @"IAPDidReceivedProducts"
#define IAPDidFailedTransaction                         @"IAPDidFailedTransaction"
#define IAPDidRestoreTransaction                        @"IAPDidRestoreTransaction"
#define IAPDidCompleteTransaction                       @"IAPDidCompleteTransaction"
#define IAPDidCompleteTransactionAndVerifySucceed       @"IAPDidCompleteTransactionAndVerifySucceed"
#define IAPDidCompleteTransactionAndVerifyFailed        @"IAPDidCompleteTransactionAndVerifyFailed"


#import <Foundation/Foundation.h>
#import "ECPurchase.h"

@interface IAPHandler : NSObject<ECPurchaseProductDelegate,ECPurchaseTransactionDelegate>




+(void)initECPurchaseWithHandler;



@end
