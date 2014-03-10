//
//  lowooPropsDetail.m
//  banana clock
//
//  Created by MAC on 12-9-26.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooPropsDetail.h"
#import "lowooHTTPManager.h"
#import "propNumber.h"


@interface lowooPropsDetail()
@property (nonatomic, strong) propNumber *viewNumber;
@property (nonatomic, assign) NSInteger number;
@end
 
@implementation lowooPropsDetail

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"PROPS DETAIL";
    [self changeTitle];
    [self.imageViewRight setFrame:CGRectMake(8, 8, 35, 21)];
    [self.imageViewRight setImage:GetPngImage(@"topicon04")];
    self.viewRightButton.alpha = 0.0f;
    self.viewRightButton.hidden = NO;
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.viewRightButton.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_player stop];
    _player = nil;
    _buttonSuspended.hidden = YES;
    _buttonAudition.hidden = NO;
    //刷新道具列表数据
    if (_buyCount>0) {
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",_prop.propID], @"tid", [NSNumber numberWithInt:_buyCount], @"num", nil] requestType:buyprops];
        [[activityView sharedActivityView] showHUD:-1];
    }
    _buyCount = 0;
}

- (void)changeLanguage{
    [self initView];
    [self changeTitle];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpFailed) name:@"httpFailed" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseMusic) name:@"navigation1" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseMusic) name:@"navigation2" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseMusic) name:@"navigation4" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playMusic) name:@"navigation3" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initView) name:@"userPropsChanged" object:nil];
    }
    return self;
}

- (void)pauseMusic{
    if (_buttonAudition.hidden == YES) {
        [_player pause];
    }
}

- (void)playMusic{
    if (_buttonAudition.hidden == YES) {
        [_player prepareToPlay];
        [_player play];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _buyCount = 0;
    _coin = [[[userModel sharedUserModel] getUserInformationWithKey:USER_COIN] intValue];
    [self initView];
}

- (void)initView{
    for (UIView *aview in self.view.subviews) {
        [aview removeFromSuperview];
    }

    UIImageView *imagePropDescription;
    UIButton_custom *buttonBuy = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    UIImageView *imageviewPropertPrice;
    //层次
    if (iPhone5||iPhone5_0) {
        _viewProp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 250)];
        if (LANGUAGE_CHINESE) {
            imagePropDescription = [[UIImageView alloc]initWithFrame:CGRectMake(49, 226, 238, 55)];
            NSString *textName = [NSString stringWithFormat:@"%02d.png.text",_prop.propID];
            [imagePropDescription setImage:GetPngImage(textName)];
        }else{
            imagePropDescription = [[UIImageView alloc]initWithFrame:CGRectMake(49, 226, 238, 77)];
            NSString *englishName = [NSString stringWithFormat:@"%02d.png.textEnglish",_prop.propID];
            [imagePropDescription setImage:GetPngImage(englishName)];
        }
        
        imageviewPropertPrice = [[UIImageView alloc]initWithFrame:CGRectMake(135, 315, 50, 30)];
        [buttonBuy setFrame:CGRectMake(54, 366, 212, 53) image:[BASE International:@"button_buy"] image:[BASE International:@"button_buyb"]];

    }else{
        _viewProp = [[UIView alloc]initWithFrame:CGRectMake(0, -17, 320, 250)];
        if (LANGUAGE_CHINESE) {
            imagePropDescription = [[UIImageView alloc]initWithFrame:CGRectMake(49, 190, 238, 55)];
            NSString *textName = [NSString stringWithFormat:@"%02d.png.text",_prop.propID];
            [imagePropDescription setImage:GetPngImage(textName)];
        }else{
            imagePropDescription = [[UIImageView alloc]initWithFrame:CGRectMake(49, 190, 238, 77)];
            NSString *englishName = [NSString stringWithFormat:@"%02d.png.textEnglish",_prop.propID];
            [imagePropDescription setImage:GetPngImage(englishName)];
        }
        imageviewPropertPrice = [[UIImageView alloc]initWithFrame:CGRectMake(130, 263, 50, 30)];
        [buttonBuy setFrame:CGRectMake(54, 300, 212, 53) image:[BASE International:@"button_buy"] image:[BASE International:@"button_buyb"]];
    }
    
    _viewProp.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewProp];
    [self.view addSubview:imagePropDescription];
    
    //大道具图片
    UIImageView *imageBigProp = [[UIImageView alloc]initWithFrame:CGRectMake(92, 69, 136, 136)];
    NSString *bigName = [NSString stringWithFormat:@"%02d.png.big",_prop.propID];
    [imageBigProp setImage:GetPngImage(bigName)];
    [_viewProp addSubview:imageBigProp];
    //道具种类
    UIButton_custom *buttonKind = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonKind setFrame:CGRectMake(80, 50, 40, 50)];
    [buttonKind addTarget:self action:@selector(buttonKindAction:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonKind.tag = _prop.propID;
    NSString *pngName = [NSString stringWithFormat:@"CTiticon0%@",_prop.term];
    [buttonKind setImage:GetPngImage(pngName) forState:UIControlStateNormal];
    [buttonKind setImage:GetPngImage(pngName) forState:UIControlEventTouchDown];
    [_viewProp addSubview:buttonKind];
    //播放按钮
    _buttonAudition = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [_buttonAudition setFrame:CGRectMake(190, 165, 46, 46) image:@"button_audition" image:@"button_auditionb"];
    [_buttonAudition addTarget:self action:@selector(buttonAuditionDidTouchedUpInside:)];
    _buttonAudition.tag = -1;
    [_viewProp addSubview:_buttonAudition];
    
    _buttonSuspended = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [_buttonSuspended setFrame:CGRectMake(190, 165, 46, 46) image:@"button_suspended" image:@"button_suspendedb"];
    [_buttonSuspended addTarget:self action:@selector(buttonSuspendedDidTouchedUpInside:)];
    _buttonSuspended.hidden = YES;
    _buttonSuspended.tag = -1;
    [_viewProp addSubview:_buttonSuspended];
    //道具价格
    NSString *priceName = [NSString stringWithFormat:@"price_gold%02d",_prop.propPrice];
    imageviewPropertPrice.image = GetPngImage(priceName);
    [self.view addSubview:imageviewPropertPrice];
    //描述
    
    //购买按钮
    [buttonBuy addTarget:self action:@selector(buttonBuyDidTouchedUpInside:) forControlEvents:UIControlEventTouchUpInside];
    buttonBuy.tag = _prop.propID;
    [self.view addSubview:buttonBuy];
    if (_prop.propID == 1) {
        buttonBuy.userInteractionEnabled = NO;
        buttonBuy.alpha = 0.5;
        _viewNumber = [[propNumber alloc] init];
        [_viewNumber setNumber:-1];
        [self.view addSubview:_viewNumber];
    }else{
        if (_number == 0) {//第一次
            _number = _prop.number;
        }
        _viewNumber = [[propNumber alloc] init];
        [_viewNumber setNumber:_number];
        [self.view addSubview:_viewNumber];
    }
}

#pragma mark ----------- 购买假数据 -----------
- (void)didBuyFalseData{
    _buyCount ++;
    _coin -=  _prop.propPrice;
    if (_coin<0) {
        return;
    }
    _number = _number + 1;
    [_viewNumber removeFromSuperview];
    _viewNumber = [[propNumber alloc] init];
    [_viewNumber setNumber:_number];
    [self.view addSubview:_viewNumber];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"buyCoin" object:[NSNumber numberWithInteger:_coin]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)buttonShoppingCartDidTouchedUpInside:(UIButton_custom *)sender {
    lowooPropsBuy *propBuy = [[lowooPropsBuy alloc]init];
    [self.navigationController pushViewController:propBuy animated:YES];
}

- (void)rightButtonTouchUpInside{
    lowooPropsBuy *propBuy = [[lowooPropsBuy alloc]init];
    [self.navigationController pushViewController:propBuy animated:YES];
}

#pragma mark----------播放按钮---------
- (void)buttonAuditionDidTouchedUpInside:(UIButton_custom *)sender {
    if (_player) {
        [_player prepareToPlay];
        [_player play];
    }else{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d",_prop.propID] ofType:@"caf"];
        NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
        NSError *error = nil;
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        _player.delegate = self;
        _player.numberOfLoops = 0;
        if (error == nil) {
            if ([self isMusicAllow]) {
                [_player prepareToPlay];
                [_player play];
            }
        }
    }

    _buttonAudition.hidden = YES;
    _buttonSuspended.hidden = NO;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    _buttonAudition.hidden = NO;
    _buttonSuspended.hidden = YES;
}

- (void)initViewProgress{
    _viewProgress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.3;
    [_viewProgress addSubview:view];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSArray *windows = [UIApplication sharedApplication].windows;
    if (windows.count>0) {//可能有多个window
        keyWindow = [windows objectAtIndex:0];
    }
    [keyWindow addSubview:_viewProgress];
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    [_progressView setCenter:self.view.center];
    [_viewProgress addSubview:_progressView];
    
    [self downloadMusic];
}

- (void)downloadMusic{
//    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSString *downloadPath = [path stringByAppendingString:[NSString stringWithFormat:@"/music/%@.caf",_stringID]];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    //初始化道具目录
//    BOOL boolpropspath = [fileManager fileExistsAtPath:[path stringByAppendingPathComponent:@"/music"]];
//    if (!boolpropspath) {
//        [fileManager createDirectoryAtPath:[path stringByAppendingPathComponent:@"/music"] withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    
//    NSString *url = @"/images/banners/props_ring/1.caf";
//    NSRange range = NSMakeRange(27, 1);
//    NSString *stringurl = [url stringByReplacingCharactersInRange:range withString:_stringID];
//    NSString *stringRing = [NSString stringWithFormat:@"%@%@",BASEURL,stringurl];
    
//    ASINetworkQueue *netQueue = [[ASINetworkQueue alloc] init];
//    [netQueue reset];
//    [netQueue setDownloadProgressDelegate:_progressView];
//    [netQueue setRequestDidFinishSelector:@selector(netQueueFinish:)];
//    [netQueue setRequestDidFailSelector:@selector(netQueueFail:)];
//    [netQueue setShowAccurateProgress:YES];
//    [netQueue setDelegate:self];
//    
//    ASIHTTPRequest *request;
//    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:stringRing]];
//    [request setDownloadDestinationPath:downloadPath];
//    [netQueue addOperation:request];
//    [netQueue go];
}

//- (void)netQueueFinish:(ASIHTTPRequest *)request{
//    NSString *path1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSString *downloadPath = [path1 stringByAppendingString:[NSString stringWithFormat:@"/music/%@.caf",_stringID]];
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *document = [paths objectAtIndex:0];
//    NSString *path = [document stringByAppendingPathComponent:@"music.plist"];
//    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
//    
//    NSMutableDictionary *mutabledict = [[NSMutableDictionary alloc] initWithDictionary:dict];
//    [mutabledict setObject:downloadPath forKey:_stringID];
//    NSDictionary *dictWrite = [[NSDictionary alloc] initWithDictionary:mutabledict];
//    [dictWrite writeToFile:path atomically:YES];
//    
//    
//    [_viewProgress removeFromSuperview];
//    _viewProgress = nil;
//    [self buttonAuditionDidTouchedUpInside:nil];
//    
//    SystemSoundID soundID;
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
//}
//
//- (void)netQueueFail:(ASIHTTPRequest *)request{
//    [_viewProgress removeFromSuperview];
//    _viewProgress = nil;
//    [tooles MsgBox:@"下载失败"];
//}


#pragma mark---------暂停按钮----------
- (void)buttonSuspendedDidTouchedUpInside:(UIButton_custom *)sender {
    [_player pause];
    [_player stop];
    _player = nil;

    _buttonAudition.hidden = NO;
    _buttonSuspended.hidden = YES;
}
- (void)buttonSuspendedDidTouchedUpOutside:(UIButton_custom *)sender{
    _buttonAudition.hidden = YES;
    _buttonSuspended.hidden = NO;
}


#pragma mark---------购买动作----------
- (void)buttonBuyDidTouchedUpInside:(UIButton_custom *)sender {
    //无网络
    if (![[lowooHTTPManager getInstance] isExistenceNetwork]) {
        return;
    }
    //金币数量
    if (_coin < _prop.propPrice) {
        sender.music = @"nomoney";
        return;
    }
    [self didBuyFalseData];
}

- (void)buttonKindAction:(UIButton_custom *)sender{
    lowooPOPPropKind *propKind = [[lowooPOPPropKind alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [propKind confirmDataWithTag:[_prop.term intValue]];
    [[lowooAlertViewDemo sharedAlertViewManager] show:propKind];
}

- (BOOL)isMusicAllow{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:MUSIC_ALLOW]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:MUSIC_ALLOW] boolValue]) {
            return YES;
        }
    }
    return NO;
}




@end
