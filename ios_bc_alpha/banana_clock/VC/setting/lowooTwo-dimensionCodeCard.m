//
//  lowooTwo-dimensionCodeCard.m
//  banana_clock
//
//  Created by MAC on 13-1-28.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooTwo-dimensionCodeCard.h"
#import "JSONKit.h"

@interface lowooTwo_dimensionCodeCard ()
- (void)generateTwoDimensionCodePicture;
@end

@implementation lowooTwo_dimensionCodeCard

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"QR CODE CARD";
    [self changeTitle];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *imageBack = GetPngImage(@"dimensionalCode");
    UIImageView *imageViewBack = [[UIImageView alloc] initWithImage:imageBack];
    [imageViewBack setFrame:(CGRect){CGPointZero,imageBack.size.width/2,imageBack.size.height/2}];
    imageViewBack.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2 - 50 -15);

    [self.view addSubview:imageViewBack];
    [self generateTwoDimensionCodePicture];
}

- (void)generateTwoDimensionCodePicture{
    NSDictionary *dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID], @"fid", @"http://bc.lowoo.cc", @"string",@"lowooChinaBananaClock" , @"index", nil];
    NSString *string = [dictionary JSONString];
    UIImageView *imageViewCodeCard = [[UIImageView alloc] initWithFrame:CGRectMake(0, -30, 200, 200)];
    [self.view addSubview:imageViewCodeCard];
    UIImage *image = [QRCodeGenerator qrImageForString:string imageSize:imageViewCodeCard.bounds.size.width];

    [imageViewCodeCard setCenter:CGPointMake(SCREEN_WIDTH/2 - 4, SCREEN_HEIGHT/2 - 50 +5 -15)];
    imageViewCodeCard.image = image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
