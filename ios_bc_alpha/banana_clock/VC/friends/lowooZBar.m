//
//  lowooZBar.m
//  banana_clock
//
//  Created by MAC on 13-3-26.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooZBar.h"
#import "lowooAppDelegate.h"


@implementation lowooZBar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController hidesBottomBarViewWhenPushed:NO];
    [self.tabBarController hidesTimeTitleWhenPushed:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _viewZBarBase = [[UIView alloc]initWithFrame:self.view.bounds];//CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    _viewZBarBase.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewZBarBase];
    
    ZBarReaderViewController *zbarView = [[ZBarReaderViewController alloc]init];
    [zbarView.view setFrame:self.view.bounds];
    zbarView.readerDelegate = self;
    ZBarImageScanner *scanner = zbarView.scanner;
    zbarView.tracksSymbols = YES;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    UIView *removeView = nil;
    for (UIView *view in zbarView.view.subviews){
        if (view.frame.size.width == 320 && view.frame.size.height == 51) {//iphone4 ios6
            UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(160, 0, 160, 51)];
            aview.backgroundColor = [UIColor clearColor];
            [view addSubview:aview];
        }else if (view.frame.size.width == 320 && view.frame.size.height == 54) {//iphone4 ios7
            UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(160, 0, 160, 54)];
            aview.backgroundColor = [UIColor clearColor];
            [view addSubview:aview];
        }else if (view.frame.size.width == 320 && view.frame.size.height == 60) {//iphone5 ios6
            UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(160, 0, 160, 63)];
            aview.backgroundColor = [UIColor clearColor];
            [view addSubview:aview];
        }else if (view.frame.size.width == 320 && view.frame.size.height == 63) {//iphone5 ios7
            UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(160, 0, 160, 63)];
            aview.backgroundColor = [UIColor clearColor];
            [view addSubview:aview];
        }
        if (view.frame.size.width == 15 && view.frame.size.height == 15){
            removeView = view;
        }
    }
    if (removeView){
        [removeView removeFromSuperview];
    }
    
    [self addChildViewController:zbarView];
    [_viewZBarBase addSubview:zbarView.view];
    
    UIImageView *imageViewMask = [[UIImageView alloc]init];
    UILabel *labelChinese = [[UILabel alloc]init];
    UILabel *labelEnglish = [[UILabel alloc]init];
    
    
    if (iPhone5||iPhone5_0) {
        [imageViewMask setFrame:CGRectMake(0, 5+[BASE height10], SCREEN_WIDTH, 509)];
        [imageViewMask setImage:GetPngImage(@"twodimensionalcodemaskphone5")];
        [labelChinese setFrame:CGRectMake(25, 340, 271, 24)];
        [labelEnglish setFrame:CGRectMake(25, 360, 271, 24)];
    }else{
        [imageViewMask setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 430)];
        [imageViewMask setImage:GetPngImage(@"twodimensionalcodemaskphone4")];
        [labelChinese setFrame:CGRectMake(25, 320, 271, 24)];
        [labelEnglish setFrame:CGRectMake(25, 340, 271, 24)];
    }
    
    if (!IOS_7) {
        CGRect frame = zbarView.view.frame;
        frame.origin.y += 20;
        zbarView.view.frame = frame;
    }
    
    [_viewZBarBase addSubview:imageViewMask];
    
    
    labelChinese.backgroundColor = [UIColor clearColor];
    labelChinese.text = @"将二维码图案放到取景框内，即可完成自动扫描。";
    [labelChinese setFont:[UIFont systemFontOfSize:12.0f]];
    [labelChinese setTextAlignment:NSTextAlignmentCenter];
    [labelChinese setTextColor:COLOR_CHINESE];
    [_viewZBarBase addSubview:labelChinese];
    
    labelEnglish.backgroundColor = [UIColor clearColor];
    labelEnglish.text = @"Align the QR code within the frame to start scanning.";
    [labelEnglish setFont:[UIFont systemFontOfSize:9.0f]];
    [labelEnglish setTextAlignment:NSTextAlignmentCenter];
    [labelEnglish setTextColor:COLOR_CHINESE];
    [_viewZBarBase addSubview:labelEnglish];
    
    _imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 5)];
    _imageViewLine.image = GetPngImage(@"phone_line");
    [_viewZBarBase addSubview:_imageViewLine];
    if (iPhone5||iPhone5_0) {
        [_imageViewLine setCenter:CGPointMake(160, 100)];
    }else{
        [_imageViewLine setCenter:CGPointMake(160, 80)];
    }
    _imageViewLine.hidden = YES;
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scanAnimation) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)scanAnimation{
    _imageViewLine.hidden = NO;
    if (IOS_7) {
        if (iPhone5_0||iPhone5) {
            [_imageViewLine setCenter:CGPointMake(160, 100)];
            [UIView animateWithDuration:2 animations:^{
                [_imageViewLine setCenter:CGPointMake(160, 315)];
            }];
        }else{
            [_imageViewLine setCenter:CGPointMake(160, 70)];
            [UIView animateWithDuration:2 animations:^{
                [_imageViewLine setCenter:CGPointMake(160, 295)];
            }];
        }
    }else{
        if (iPhone5_0||iPhone5) {
            [_imageViewLine setCenter:CGPointMake(160, 100)];
            [UIView animateWithDuration:2 animations:^{
                [_imageViewLine setCenter:CGPointMake(160, 315)];
            }];
        }else{
            [_imageViewLine setCenter:CGPointMake(160, 80)];
            [UIView animateWithDuration:2 animations:^{
                [_imageViewLine setCenter:CGPointMake(160, 295)];
            }];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [_timer invalidate];
    _timer = nil;
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    NSString *string = symbol.data;
    
    //判断是否包含 头'http:'
    NSString *regex = @"http+:[^\\s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    //判断是否包含 头'ssid:'
    NSString *ssid = @"ssid+:[^\\s]*";
    NSPredicate *ssidPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ssid];
    
    
    
    
    if ([predicate evaluateWithObject:string]) {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil
                                                        message:@"It will use the browser to this URL。"
                                                       delegate:nil
                                              cancelButtonTitle:@"Close"
                                              otherButtonTitles:@"Ok", nil];
        alert.delegate = self;
        alert.tag=1;
        [alert show];
        
        
        
    }
    else if([ssidPre evaluateWithObject:string]){
        
        NSArray *arr = [string componentsSeparatedByString:@";"];
        
        NSArray * arrInfoHead = [[arr objectAtIndex:0] componentsSeparatedByString:@":"];
        
        NSArray * arrInfoFoot = [[arr objectAtIndex:1] componentsSeparatedByString:@":"];
        
        
        string = [NSString stringWithFormat:@"ssid: %@ \n password:%@",[arrInfoHead objectAtIndex:1],[arrInfoFoot objectAtIndex:1]];
        
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:string
                                                        message:@"The password is copied to the clipboard , it will be redirected to the network settings interface"
                                                       delegate:nil
                                              cancelButtonTitle:@"Close"
                                              otherButtonTitles:@"Ok", nil];
        
        
        alert.delegate = self;
        alert.tag=2;
        [alert show];
        
        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
        //        然后，可以使用如下代码来把一个字符串放置到剪贴板上：
        pasteboard.string = [arrInfoFoot objectAtIndex:1];
    }
    //检查是否有lowoo标记，判断是不是项目的二维码
    NSString *string1 = @"lowooChinaBananaClock";
    NSString *params = string;
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSDictionary *param = [parser objectWithString:params];
    if ([[param objectForKey:@"index"] isEqualToString:string1]) {//不是项目的二维码
        NSDictionary *dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:image,@"image",string,@"string", nil];
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"TwoDimensionCode" object:nil userInfo:dictionary]];
        [self.navigationController popViewControllerAnimated:NO];
        [picker dismissViewControllerAnimated:YES completion:^{
        }];
    }else{
        
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [_timer invalidate];
    _timer = nil;
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
