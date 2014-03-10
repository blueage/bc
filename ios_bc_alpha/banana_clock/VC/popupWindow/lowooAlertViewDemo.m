//
//  lowooAlertViewDemo.m
//  banana clock
//
//  Created by MAC on 12-12-3.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooAlertViewDemo.h"
#import "lowooMusic.h"


CGRect ScreenBounds(){
    CGRect bounds = [UIScreen mainScreen].bounds;
    return bounds;
}



@implementation lowooAlertViewDemo


static lowooAlertViewDemo *sharedAlertViewManager = nil;

+(lowooAlertViewDemo *)sharedAlertViewManager{
    @synchronized(self){
        if (!sharedAlertViewManager) {
            sharedAlertViewManager = [[lowooAlertViewDemo alloc]init];
            
        }
    }
    return sharedAlertViewManager;
}

-(id)init{
    self = [super init];
    if (self) {
        _alertViewQueue = [[NSMutableArray alloc]init];
        boolDismiss = NO;
    }
    return self;
}


#pragma mark------------检查弹出窗口队列---------------
-(void)checkoutInStackAlertView{
    if (_alertViewQueue.count>0) {
        id entity = [_alertViewQueue lastObject];
        [self showWithAnimation:entity];
    }
}

-(void)showWithAnimation:(UIView *)entity{
    [[lowooMusic sharedLowooMusic] SystemSoundID:@"message" type:@"mp3"];
    
    entity.clipsToBounds = YES;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    if (windows.count>0) {//可能有多个window
        keyWindow = [windows objectAtIndex:0];
    }

    UIView *aview;
    
#pragma mark-------------赖床---------------
    if([entity isKindOfClass:[lowooPOPLazy class]]){
        [_viewNavigationView removeFromSuperview];
        lowooPOPLazy *lazy = (lowooPOPLazy *)entity;
        lazy.delegate = self;
        
        [keyWindow addSubview:lazy];
        [lazy animation];
    }

#pragma mark-------------使用盾---------------
    else if([entity isKindOfClass:[lowooPOPUseOfShied class]]){
        [_viewNavigationView removeFromSuperview];
        //[entity setFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        lowooPOPUseOfShied *userOfShields = (lowooPOPUseOfShied *)entity;
        userOfShields.delegate = self;
        
        [keyWindow addSubview:userOfShields];
        [userOfShields animation];
    }
    
#pragma mark-------------成功起床---------------
    else if([entity isKindOfClass:[lowooPOPGetUpSuccessfully class]]){
        lowooPOPGetUpSuccessfully *getUpSuccessfully = (lowooPOPGetUpSuccessfully *)entity;
        getUpSuccessfully.delegate = self;
        
        [keyWindow addSubview:getUpSuccessfully];
        [getUpSuccessfully animation];
    }
#pragma mark-------------起床失败---------------
    else if([entity isKindOfClass:[lowooGetUpFailure class]]){
        lowooGetUpFailure *getUpFailure = (lowooGetUpFailure *)entity;
        getUpFailure.delegate = self;
        aview = getUpFailure.viewBack;
        [keyWindow addSubview:getUpFailure];
       // [getUpFailure animation];
    }
#pragma mark-------------游戏成功--------------
    else if ([entity isKindOfClass:[lowooPOPgameSuccess class]]) {
        lowooPOPgameSuccess *gameSuccess = (lowooPOPgameSuccess *)entity;
        gameSuccess.delegate = self;

        [keyWindow addSubview:gameSuccess];
        [gameSuccess animation];
    }
#pragma mark-------------游戏失败-----------------
    else if([entity isKindOfClass:[lowooGameOver class]]){
        lowooGameOver *gameOver = (lowooGameOver *)entity;
        gameOver.delegate = self;
        aview = gameOver.viewBack;
        [keyWindow addSubview:gameOver];
    }
#pragma mark-------------游戏暂停---------------
    else if([entity isKindOfClass:[lowooGameExit class]]){
        lowooGameExit *gameExit = (lowooGameExit *)entity;
        gameExit.delegate = self;
        aview = gameExit.viewBack;
        [keyWindow addSubview:gameExit];
    }
#pragma mark-------------获得一个勋章---------------
    else if([entity isKindOfClass:[lowooPOPAwardedMedals class]]){
        lowooPOPAwardedMedals *AwardedMedals = (lowooPOPAwardedMedals *)entity;
        AwardedMedals.delegate = self;
        aview = AwardedMedals.viewBack;
        [keyWindow addSubview:AwardedMedals];
    }
#pragma mark-------------获得一个成就---------------
    else if([entity isKindOfClass:[lowooPOPAwardedAchievement class]]){
        lowooPOPAwardedAchievement *Achievement = (lowooPOPAwardedAchievement *)entity;
        Achievement.delegate = self;
        aview = Achievement.viewBack;
        [keyWindow addSubview:Achievement];
    }
#pragma mark-------------好友添加请求---------------
    else if([entity isKindOfClass:[lowooPOPFriendsAddRequest class]]){
        lowooPOPFriendsAddRequest *FriendsAddRequest = (lowooPOPFriendsAddRequest *)entity;
        FriendsAddRequest.delegate = self;
        aview = FriendsAddRequest.viewBack;
        [keyWindow addSubview:FriendsAddRequest];
    }
#pragma mark-------------赖床---------------
    else if([entity isKindOfClass:[lowooPOPSlob class]]){
        lowooPOPSlob *Slob = (lowooPOPSlob *)entity;
        Slob.delegate = self;
        aview = Slob.viewBack;
        [keyWindow addSubview:Slob];
    }
#pragma mark-------------香蕉盾---------------
    else if([entity isKindOfClass:[lowooPOPShield class]]){
        lowooPOPShield *Shield = (lowooPOPShield *)entity;
        Shield.delegate = self;
        aview = Shield.viewBack;
        [keyWindow addSubview:Shield];
    }
#pragma mark-------------已经起床---------------
    else if([entity isKindOfClass:[lowooPOPHadGetUp class]]){
        lowooPOPHadGetUp *HadGetUp = (lowooPOPHadGetUp *)entity;
        HadGetUp.delegate = self;
        aview = HadGetUp.viewBack;
        [keyWindow addSubview:HadGetUp];
    }
#pragma mark-------------删除好友---------------
    else if([entity isKindOfClass:[lowooPOPDeleteFriend class]]){
        lowooPOPDeleteFriend *DeleteFriend = (lowooPOPDeleteFriend *)entity;
        DeleteFriend.delegate = self;
        aview = DeleteFriend.viewBack;
        [keyWindow addSubview:DeleteFriend];
    }
#pragma mark-------------成功添加好友---------------
    else if([entity isKindOfClass:[lowooPOPAddedSuccessfully class]]){
        lowooPOPAddedSuccessfully *AddedSuccessfully = (lowooPOPAddedSuccessfully *)entity;
        AddedSuccessfully.delegate = self;
        aview = AddedSuccessfully.viewBack;
        [keyWindow addSubview:AddedSuccessfully];
    }
#pragma mark-------------请求已发送---------------
    else if([entity isKindOfClass:[lowooPOPRequestHasBeenSent class]]){
        lowooPOPRequestHasBeenSent *RequestHasBeenSent = (lowooPOPRequestHasBeenSent *)entity;
        RequestHasBeenSent.delegate = self;
        aview = RequestHasBeenSent.viewBack;
        [keyWindow addSubview:RequestHasBeenSent];
    }
#pragma mark-------------邀请已发送---------------
    else if([entity isKindOfClass:[lowooPOPTheInvitationHasBeenSent class]]){
        lowooPOPTheInvitationHasBeenSent *TheInvitationHasBeenSent = (lowooPOPTheInvitationHasBeenSent *)entity;
        TheInvitationHasBeenSent.delegate = self;
        aview = TheInvitationHasBeenSent.viewBack;
        [keyWindow addSubview:TheInvitationHasBeenSent];
    }
#pragma mark-------------查看成就---------------
    else if([entity isKindOfClass:[lowooPOPViewAchievements class]]){
        lowooPOPViewAchievements *ViewAchievements = (lowooPOPViewAchievements *)entity;
        ViewAchievements.delegate = self;
        aview = ViewAchievements.viewBack;
        [keyWindow addSubview:ViewAchievements];
    }
#pragma mark-------------查看勋章---------------
    else if([entity isKindOfClass:[lowooPOPViewMedal class]]){
        lowooPOPViewMedal *ViewMedal = (lowooPOPViewMedal *)entity;
        ViewMedal.delegate = self;
        aview = ViewMedal.viewBack;
        [keyWindow addSubview:ViewMedal];
    }
#pragma mark-------------没有获得该成就---------------
    else if([entity isKindOfClass:[lowooDidNotGetTheAchievement class]]){
        lowooDidNotGetTheAchievement *DidNotGetTheAchievement = (lowooDidNotGetTheAchievement *)entity;
        DidNotGetTheAchievement.delegate = self;
        aview = DidNotGetTheAchievement.viewBack;
        [keyWindow addSubview:DidNotGetTheAchievement];
    }
#pragma mark------------- 道具详细信息 ---------------
    else if([entity isKindOfClass:[lowooPOPPropKind class]]){
        lowooPOPPropKind *propKinde = (lowooPOPPropKind *)entity;
        propKinde.delegate = self;
        aview = propKinde.viewBack;
        [keyWindow addSubview:propKinde];
    }
#pragma mark------------- 蜘蛛网 ---------------
    else if([entity isKindOfClass:[lowooPOPMoss class]]){
        lowooPOPMoss *moss = (lowooPOPMoss *)entity;
        moss.delegate = self;
        aview = moss.viewBack;
        [keyWindow addSubview:moss];
    }
#pragma mark------------- 未开起道具 ---------------
    else if([entity isKindOfClass:[lowooPOPpropObtain class]]){
        lowooPOPpropObtain *notObtain = (lowooPOPpropObtain *)entity;
        notObtain.delegate = self;
        aview = notObtain.viewBack;
        [keyWindow addSubview:notObtain];
    }
#pragma mark------------- 注意 ---------------
    else if([entity isKindOfClass:[lowooPOPattention class]]){
        lowooPOPattention *attention = (lowooPOPattention *)entity;
        attention.delegate = self;
        aview = attention.viewBack;
        [keyWindow addSubview:attention];
    }
#pragma mark------------- 网络连接错误 ---------------
    else if([entity isKindOfClass:[lowooPOPnetworkError class]]){
        lowooPOPnetworkError *network = (lowooPOPnetworkError *)entity;
        network.delegate = self;
        aview = network.viewBack;
        [keyWindow addSubview:network];
    }
#pragma mark-------------没有获得该勋章---------------
    else if([entity isKindOfClass:[lowooDidNotGetTheMedal class]]){
        lowooDidNotGetTheMedal *DidNotGetTheMedal = (lowooDidNotGetTheMedal *)entity;
        DidNotGetTheMedal.delegate = self;
        aview = DidNotGetTheMedal.viewBack;
        [keyWindow addSubview:DidNotGetTheMedal];
    }
#pragma mark------------- 服务条款 ---------------
    else if([entity isKindOfClass:[lowooPOPTermsOfService class]]){
        lowooPOPTermsOfService *service = (lowooPOPTermsOfService *)entity;
        service.delegate = self;
        aview = service.viewBack;
        [keyWindow addSubview:service];
    }
#pragma mark------------- 成功关注 ---------------
    else if([entity isKindOfClass:[lowooPOPFlollowSuccess class]]){
        lowooPOPFlollowSuccess *followSuccess = (lowooPOPFlollowSuccess *)entity;
        followSuccess.delegate = self;
        aview = followSuccess.viewBack;
        [keyWindow addSubview:followSuccess];
    }
        [UIView animateWithDuration:0.4
                              delay:0.0
                            options:UIViewAnimationCurveEaseOut
                         animations:^{
                             CGPoint point = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
                             aview.center = point;
                         } completion:^(BOOL finished) {
                             
                         }];
    
    
}


#pragma mark---------lowooPOPgameSuccessDelegate---------
- (void)buttonGameSuccessCloseTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooGameOverDelegate---------
- (void)buttonGameOverColoseTouchUpinsideWithEntity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPgameExitDelegate---------
- (void)buttonGameExitTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPAwardedMedalsDelegate---------
- (void)buttonAwardedMedalsTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPAchievementDelegate---------
- (void)buttonAchievementTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPFriendsAddRequestDelegate---------
- (void)buttonFriendsAddRequestTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPSlobDelegate---------
- (void)buttonSlobTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPShieldDelegate---------
- (void)buttonShieldTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPHadGetUpDelegate---------
- (void)buttonHadGetUpTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPDeleteFriendDelegate---------
- (void)buttonDeleteFriendTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPAddedSuccessfullyDelegate---------
- (void)buttonAddedSuccessfullyTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPRequestHasBeenSentDelegate---------
- (void)buttonRequestHasBeenSentTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPTheInvitationHasBeenSentDelegate---------
- (void)buttonTheInvitationHasBeenSentTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPViewAchievementsDelegate---------
- (void)buttonViewAchievementsTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPViewMedalDelegate---------
- (void)buttonViewMedalTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooDidNotGetTheAchievementDelegate---------
- (void)buttonDidNotGetTheAchievementTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPDidNotGetTheMedalDelegate---------
- (void)buttonDidNotGetTheMedalTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}


#pragma mark---------lowooPOPGetUpSuccessfullyDelegate---------
- (void)buttonGetUpSuccessfullyTouchUpinsideWithentity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooGetUpFailureDelegate---------
- (void)buttonGetUpFailureTouchUpinsideWithEntity:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPUseOfShiedDelegate----------
- (void)buttonUseOfShieldTouchupInsideWithView:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark---------lowooPOPLazyDelegate----------
- (void)buttonLazyTouchupInsideWithView:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark--------- lowooPOPPropDelegate ----------
- (void)buttonPOPPropCloseTouchUpInside:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark--------- lowooPropObtainCloseTouchUpInside ----------
- (void)buttonpropObtainCloseTouchUpInsideWithView:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark--------- lowooPOPattentionDelegate ----------
- (void)buttonAttentionCloseTouchUpInsideWithView:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark -------- lowooPOPMossDelegate --------------
- (void)buttonlowooPOPMossCloseTouchUpInside:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark -------- lowooPOPnetworkErrorDelegate --------------
- (void)networkError:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark -------- lowooPOPTermsOfServiceDelegate --------------
- (void)lowooPOPTermsOfServiceDismiss:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

#pragma mark -------- lowooPOPFollowSuccessDelegate --------------
- (void)buttonFollowCloseTouchUpInsideWithView:(UIView *)entity{
    [self dismissWithAnimation:entity];
}

-(void)dismissWithAnimation:(id)entity{
    UIView *aview = (UIView *)entity;
    [UIView animateWithDuration:0.2
                     animations:^{
                         aview.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [aview removeFromSuperview];
                         [_alertViewQueue removeObject:aview];
                         boolDismiss = YES;
                         [self checkoutInStackAlertView];
                     }];
}



#pragma mark--------------新窗口先判断------------
-(void)show:(UIView *)entity{
    if (_alertViewQueue.count>0) {
        //已经显示其他alert，先加入队列
        [_alertViewQueue insertObject:entity atIndex:_alertViewQueue.count-1];
    }else{
        [_alertViewQueue addObject:entity];
        [self showWithAnimation:entity];
    }
    
    
}

- (void)dismiss:(id)entity{
}



//-(void)dealloc{
//
//    [_alertViewQueue removeAllObjects];//清除alert数组
//    [super dealloc];
//}

@end
