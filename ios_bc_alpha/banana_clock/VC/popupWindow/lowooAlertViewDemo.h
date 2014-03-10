//
//  lowooAlertViewDemo.h
//  banana clock
//
//  Created by MAC on 12-12-3.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "lowooPOPgameSuccess.h"
#import "lowooGameExit.h"
#import "lowooGameOver.h"
#import "lowooPOPAwardedMedals.h"
#import "lowooPOPAwardedAchievement.h"
#import "lowooPOPFriendsAddRequest.h"
#import "lowooPOPSlob.h"
#import "lowooPOPShield.h"
#import "lowooPOPHadGetUp.h"
#import "lowooPOPDeleteFriend.h"
#import "lowooPOPAddedSuccessfully.h"
#import "lowooPOPRequestHasBeenSent.h"
#import "lowooPOPTheInvitationHasBeenSent.h"
#import "lowooPOPViewAchievements.h"
#import "lowooPOPViewMedal.h"
#import "lowooDidNotGetTheAchievement.h"
#import "lowooDidNotGetTheMedal.h"
#import "lowooPOPGetUpSuccessfully.h"
#import "lowooGetUpFailure.h"
#import "lowooPOPUseOfShied.h"
#import "lowooPOPLazy.h"
#import "lowooNavigationView.h"
#import "lowooPOPPropKind.h"
#import "lowooPOPMoss.h"
#import "lowooPOPpropObtain.h"
#import "lowooPOPattention.h"
#import "lowooPOPnetworkError.h"
#import "lowooPOPTermsOfService.h"
#import "lowooPOPFlollowSuccess.h"

@interface lowooAlertViewDemo : NSObject<lowooPOPgameSuccessDelegate,lowooGameOverDelegate,lowooPOPgameExitDelegate,lowooPOPAwardedMedalsDelegate,lowooPOPAwardedAchievementDelegate,lowooPOPFriendsAddRequestDelegate,lowooPOPSlobDelegate,lowooPOPShieldDelegate,lowooPOPHadGetUpDelegate,lowooPOPDeleteFriendDelegate,lowooPOPAddedSuccessfullyDelegate,lowooPOPRequestHasBeenSentDelegate,lowooPOPTheInvitationHasBeenSentDelegate,lowooPOPViewAchievementsDelegate,lowooPOPViewMedalDelegate,lowooDidNotGetTheAchievementDelegate,lowooPOPDidNotGetTheMedalDelegate,lowooPOPGetUpSuccessfullyDelegate,lowooGetUpFailureDelegate,lowooPOPUseOfShiedDelegate,lowooPOPLazyDelegate,lowooPOPPropKindDelegate,lowooPOPMossDelegate,lowooPropObtainCloseTouchUpInside,lowooPOPattentionDelegate,lowooPOPnetworkErrorDelegate,lowooPOPTermsOfServiceDelegate,lowooPOPFollowSuccessDelegate>{
    
    id currentAlertView;
    bool boolDismiss;
}


@property (nonatomic, strong) NSMutableArray *alertViewQueue;//控制同时出现多个alertview
@property (nonatomic, strong) lowooNavigationView *viewNavigationView;




+ (lowooAlertViewDemo *)sharedAlertViewManager;
- (void)show:(id)entity;
- (void)dismiss:(id)entity;
- (void)checkoutInStackAlertView;



@end
