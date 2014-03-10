//
//  lowooRepeat.m
//  banana clock
//
//  Created by MAC on 12-10-11.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooRepeat.h"
#import "lowooHTTPManager.h"
#import "LocalNotification.h"

#define repeatHeight  40

@implementation lowooRepeat


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"WEEKDAY SETTING";
    [self changeTitle];
}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hadChangeDay" object:nil userInfo:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(httpFailed) name:@"httpFailed" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeDay:) name:@"didChangeDay" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mutableDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:nil];
    for (int i = 1; i <= 7; i ++) {
        NSNumber *intNumber = [NSNumber numberWithInt:i];
        [_mutableDictionary setObject:[NSNumber numberWithInt:1] forKey:intNumber];
    }
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    if (iPhone5||iPhone5_0) {
        [scrollView setFrame:CGRectMake(0, -4, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [scrollView setContentSize:CGSizeMake(320, SCREEN_HEIGHT+.1)];
    }else{
        [scrollView setFrame:CGRectMake(0, -4, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [scrollView setContentSize:CGSizeMake(320, SCREEN_HEIGHT+50)];
    }
    scrollView.showsVerticalScrollIndicator = NO;
    
    //设置界面
    _mutableArrayButton = [[NSMutableArray alloc]init];
    _mutableArrayImageView = [[NSMutableArray alloc]init];
    for (int i=0; i<7; i++) {
        UIButton_custom *button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [button setImageNormal:GetPngImage(@"List_item_bg01")];
        [button setImageHighlited:GetPngImage(@"List_item_bg02")];
        [button addTarget:self action:@selector(buttonTouchUpInside:)];
        button.boolMask = YES;
        [button setTag:i];
        [button setFrame:CGRectMake(21, repeatHeight+(i*54), 277, 55)];
        [scrollView addSubview:button];
        [_mutableArrayButton addObject:button];
        
        UIImageView *imageViewSelect = [[UIImageView alloc]initWithFrame:CGRectMake(271, i*54+17+repeatHeight, 15, 15)];
        [imageViewSelect setTag:i];
        imageViewSelect.image = GetPngImage(@"week_selected");
        [scrollView addSubview:imageViewSelect];
        [_mutableArrayImageView addObject:imageViewSelect];
        
        if (LANGUAGE_CHINESE) {
            UILabel *labelChinese = [[UILabel alloc]initWithFrame:CGRectMake(35, 12+repeatHeight+(i*54), 100, 21)];
            labelChinese.backgroundColor = [UIColor clearColor];
            labelChinese.textAlignment = NSTextAlignmentLeft;
            labelChinese.textColor = COLOR_CHINESE;
            labelChinese.font = [UIFont systemFontOfSize:12.0];
            
            UILabel *labelEnglish = [[UILabel alloc]initWithFrame:CGRectMake(35, 23+repeatHeight+(i*54), 250, 21)];
            labelEnglish.backgroundColor = [UIColor clearColor];
            labelEnglish.textAlignment = NSTextAlignmentLeft;
            labelEnglish.textColor = COLOR_ENGLISH;
            labelEnglish.font = [UIFont systemFontOfSize:9.0];
            
            if (i==0) {
                labelChinese.text = @"星期一";
                labelEnglish.text = @"Every Monday";
            }else if (i==1){
                labelChinese.text = @"星期二";
                labelEnglish.text = @"Every Tuesday";
            }else if (i==2){
                labelChinese.text = @"星期三";
                labelEnglish.text = @"Every Wednesday";
            }else if (i==3){
                labelChinese.text = @"星期四";
                labelEnglish.text = @"Every Thursday";
            }else if (i==4){
                labelChinese.text = @"星期五";
                labelEnglish.text = @"Every Friday";
            }else if (i==5){
                labelChinese.text = @"星期六";
                labelEnglish.text = @"Every Saturday";
            }else if (i==6){
                labelChinese.text = @"星期日";
                labelEnglish.text = @"Every Sunday";
            }
            
            [scrollView addSubview:labelEnglish];
            [scrollView addSubview:labelChinese];
        }else{
            UILabel *labelEnglish = [[UILabel alloc]initWithFrame:CGRectMake(35, 15+repeatHeight+(i*54), 200, 21)];
            labelEnglish.backgroundColor = [UIColor clearColor];
            labelEnglish.textAlignment = NSTextAlignmentLeft;
            labelEnglish.textColor = [UIColor colorWithWhite:0.2 alpha:0.8];
            labelEnglish.font = [UIFont systemFontOfSize:16.0];
            [scrollView addSubview:labelEnglish];
            switch (i) {
                case 0:
                    labelEnglish.text = @"Every Monday";
                    break;
                case 1:
                    labelEnglish.text = @"Every Tuesday";
                    break;
                case 2:
                    labelEnglish.text = @"Every Wednesday";
                    break;
                case 3:
                    labelEnglish.text = @"Every Sunday";
                    break;
                case 4:
                    labelEnglish.text = @"Every Friday";
                    break;
                case 5:
                    labelEnglish.text = @"Every Saturday";
                    break;
                case 6:
                    labelEnglish.text = @"Every Sunday";
                    break;
                default:
                    break;
            }
        }
    }
    
    [self.view addSubview:scrollView];
    
    //根据用户信息设置用户的重复设置
    [self settingOptionsState];
}

//显示用户设置的循环   周-》转换成-》按钮点击状态
- (void)settingOptionsState{
    if (![[userModel sharedUserModel] getUserInformationWithKey:@"repeatWeek"]) {
        [self defaultWeek];
    }
    
    //设置对勾
    NSMutableArray *array = [[userModel sharedUserModel] getUserInformationWithKey:@"repeatWeek"];
    for (int i=0; i<array.count; i++) {
        if ([[array objectAtIndex:i] intValue]!=1) {
            [self initButtonTouchUpInside:[_mutableArrayButton objectAtIndex:i]];
        }
    }
}

- (void)defaultWeek{
    NSArray *array = [[NSArray alloc] initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
    [[userModel sharedUserModel] setUserInformation:array forKey:@"repeatWeek"];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//loadview时初始化对勾
- (void)initButtonTouchUpInside:(UIButton_custom *)sender {
    UIImageView *imageView = (UIImageView *)[_mutableArrayImageView objectAtIndex:sender.tag];
    if (imageView.hidden == YES) {
        imageView.hidden = NO;
        [_mutableDictionary setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:sender.tag+1]];
    }
    else{
        imageView.hidden = YES;
        [_mutableDictionary setObject:[NSNumber numberWithInt:0] forKey:[NSNumber numberWithInt:sender.tag+1]];
    }
}

//点击按钮事件
- (void)buttonTouchUpInside:(UIButton_custom *)sender {
    UIImageView *imageView = (UIImageView *)[_mutableArrayImageView objectAtIndex:sender.tag];
    if (imageView.hidden == YES) {
        imageView.hidden = NO;
        [_mutableDictionary setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:sender.tag+1]];
    }
    else{
        imageView.hidden = YES;
        [_mutableDictionary setObject:[NSNumber numberWithInt:0] forKey:[NSNumber numberWithInt:sender.tag+1]];
    }
}

#pragma mark-------leftBtnPressed-------------
- (void)leftButtonDidTouchedUpInside{
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [_mutableDictionary objectForKey:[NSNumber numberWithInt:1]],
                      [_mutableDictionary objectForKey:[NSNumber numberWithInt:2]],
                      [_mutableDictionary objectForKey:[NSNumber numberWithInt:3]],
                      [_mutableDictionary objectForKey:[NSNumber numberWithInt:4]],
                      [_mutableDictionary objectForKey:[NSNumber numberWithInt:5]],
                      [_mutableDictionary objectForKey:[NSNumber numberWithInt:6]],
                      [_mutableDictionary objectForKey:[NSNumber numberWithInt:7]],
                      nil];
    if ([self.manager isExistenceNetwork]) {
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:array,@"value", nil] requestType:changedays];
    }else{
        NSMutableDictionary *mutableDict =  [[NSMutableDictionary alloc] initWithDictionary:[[userModel sharedUserModel] getUserInformationWithKey:LOCAL_NOTIFICATION]];
        [mutableDict setObject:array forKey:@"array"];
        [[userModel sharedUserModel] setUserInformation:mutableDict forKey:LOCAL_NOTIFICATION];
        [[LocalNotification sharedLocalNotification] setRepeatWeek:array];//用于显示
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[LocalNotification sharedLocalNotification] setLocalNotification];
        });
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCell" object:nil userInfo:nil];
}



@end
