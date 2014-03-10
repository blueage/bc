//
//  propBuyCell.m
//  banana_clock
//
//  Created by MAC on 13-7-12.
//  Copyright (c) 2013年 MAC. All rights reserved.
//
#import "lowooHTTPManager.h"
#import "propBuyCell.h"
#import "lowooAlertViewDemo.h"

@implementation propBuyCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;

        
        
        
        _label = [[THLabel alloc] initWithFrame:CGRectMake(0, 53, 54, 13)];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setFont:[UIFont systemFontOfSize:8]];
        [_label setBackgroundColor:[UIColor clearColor]];
        [_label setTextColor:[UIColor blackColor]];

        [_label setStrokeColor:[UIColor whiteColor]];
        [_label setStrokeSize:1];
        
        [_label setShadowColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];
        [_label setShadowOffset:CGSizeMake(0, 0)];
        [_label setShadowBlur:1];
        
        
        [self addSubview:_label];

    }
    return self;
}

- (void)setDefault{
    if (LANGUAGE_CHINESE) {
        _label.text = @"未获得";
    }else{
        _label.text = @"Not Obtained";
    }
    
    [_button removeFromSuperview];
    _button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 54, 58)];
    [_button setImageNormal:[UIImage imageNamed:@"propnota.png"]];
    [_button setImageHighlited:[UIImage imageNamed:@"propnotb.png"]];
    [_button addTarget:self action:@selector(notObtainAction)];
    [self addSubview:_button];
    [self performSelector:@selector(addTargetDelay:) withObject:_button afterDelay:0.5];
}

- (void)addTargetDelay:(UIButton_custom *)button{
    [_button addTarget:self action:@selector(notObtainAction)];
}

- (void)notObtainAction{
    lowooPOPpropObtain *notObtain = [[lowooPOPpropObtain alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    [[lowooAlertViewDemo sharedAlertViewManager] show:notObtain];
}



- (void)confirmProp:(modelProp *)prop{
    [_button removeFromSuperview];
    _button = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 54, 58)];
    [_button addTarget:self action:@selector(buttonTouchUpInside:)];
    [self addSubview:_button];
    _button.tag = prop.propID;

    if (LANGUAGE_CHINESE) {
        _label.text = prop.nameChinese;
    }else{
        _label.text = prop.nameEnglish;
    }
    
//    NSString *index = [sender objectForKey:@"id"];
//    
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *document = [paths objectAtIndex:0];
//    NSString *path = [document stringByAppendingPathComponent:@"props.plist"];
//    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
//    _dictionaryProps = [NSDictionary  dictionaryWithDictionary:dict];
//    NSFileManager *fileManager = [[NSFileManager alloc]init];
//    
//    NSData *dataNormal = [fileManager contentsAtPath:[[_dictionaryProps objectForKey:index] objectForKey:@"icon"]];
//    UIImage *imageNormal = [UIImage imageWithData:dataNormal];
//    NSData *dataHighlited = [fileManager contentsAtPath:[[_dictionaryProps objectForKey:index] objectForKey:@"down"]];
//    UIImage *imageHighlited = [UIImage imageWithData:dataHighlited];
//    
//    if (imageNormal) {
//        [_button setImageNormal:imageNormal];
//    }else{
//        [_button setImageNormal:[UIImage imageNamed:@"propnotb.png"]];
//    }
//    
//    if (imageHighlited) {
//        [_button setImageHighlited:imageHighlited];
//    }else{
//    
//    }
    NSString *normalName = [NSString stringWithFormat:@"%02d",prop.propID];
    NSString *downName = [NSString stringWithFormat:@"%02d.png.down",prop.propID];
    [_button setImageNormal:GetPngImage(normalName)];
    [_button setImageHighlited:GetPngImage(downName)];
}



- (void)initNumber:(NSString *)string{
    [_viewNumber removeFromSuperview];
    _viewNumber = [[UIView alloc] initWithFrame:CGRectMake(0, -6, 53, 17)];
    [self addSubview:_viewNumber];
    
    int number = [string intValue];
    //无限
    if (number<0) {
        UIImageView *imageviewwuxian = [[UIImageView alloc] initWithFrame:CGRectMake(_viewNumber.frame.size.width-13, 5, 15, 9)];
        imageviewwuxian.image = GetPngImage(@"wuxian");
        UIImageView *imageviewX = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewwuxian.frame.origin.x-4, 6, 6, 6)];
        imageviewX.image = GetPngImage(@"Goldx");
        [_viewNumber addSubview:imageviewX];
        [_viewNumber addSubview:imageviewwuxian];
        
        return;
    }
    if (number==0) {
        return;
    }
    if (number>999) {
        UIImageView *imageViewAdd = [[UIImageView alloc] initWithFrame:CGRectMake(_viewNumber.frame.size.width-8, 1, 8, 8)];
        imageViewAdd.image = GetPngImage(@"+");
        UIImageView *imageViewBit = [[UIImageView alloc] initWithFrame:CGRectMake(_viewNumber.frame.size.width-17+2, 3, 9, 11)];
        imageViewBit.image = GetPngImage(@"Snumbers9");
        UIImageView *imageViewTen = [[UIImageView alloc] initWithFrame:CGRectMake(_viewNumber.frame.size.width-26+4, 3, 9, 11)];
        imageViewTen.image = GetPngImage(@"Snumbers9");
        UIImageView *imageViewhundred = [[UIImageView alloc] initWithFrame:CGRectMake(_viewNumber.frame.size.width-35+6, 3, 9, 11)];
        imageViewhundred.image = GetPngImage(@"Snumbers9");
        UIImageView *imageviewX = [[UIImageView alloc] initWithFrame:CGRectMake(_viewNumber.frame.size.width-35+1, 5, 6, 6)];
        imageviewX.image = GetPngImage(@"Goldx");
        
        [_viewNumber addSubview:imageViewAdd];
        [_viewNumber addSubview:imageViewBit];
        [_viewNumber addSubview:imageViewTen];
        [_viewNumber addSubview:imageViewhundred];
        [_viewNumber addSubview:imageviewX];
        
        return;
    }

    UIView *view = [[UIView alloc] init];
    NSMutableArray *numbers = [NSMutableArray array];
    int left = 0;
    UIImage *image = GetPngImage(@"Goldx");
    UIImageView *coin = [[UIImageView alloc] initWithImage:image];
    [coin setFrame:(CGRect){CGPointMake(0, 3),{image.size.width / 2, image.size.height / 2}}];
    [view addSubview:coin];
    left = image.size.width / 2;
    while (number) {
        int c = number % 10;
        [numbers addObject:[NSNumber numberWithInt:c]];
        number = number / 10;
    }
    for (int i = [numbers count] - 1; i >= 0; i--){
        NSString *name =[NSString stringWithFormat:@"Snumbers%@", [numbers objectAtIndex:i]];
        image = GetPngImage(name);
        coin = [[UIImageView alloc] initWithImage:image];
        [coin setFrame:(CGRect){{left, 0}, {image.size.width / 2, image.size.height / 2}}];
        [view addSubview:coin];
        left += image.size.width / 2 - 1;
    }
    CGPoint point = CGPointMake(54-left, 2);
    [view setFrame:(CGRect){point,{left, coin.frame.size.height}}];
    [_viewNumber addSubview:view];
}

- (void)initPrice:(NSString *)string{
    _viewPrice.hidden = YES;
//    _viewPrice = [[UIView alloc] initWithFrame:CGRectMake(0, 68, 45, 20)];
//    [self addSubview:_viewPrice];
//    //int number = [string intValue];
//    
//    UIView *view = [[UIView alloc] init];
//    NSMutableArray *numbers = [NSMutableArray array];
//    int n = [string intValue];
//    int left = 0;
//    UIImage *image = GetPngImage(@"Sgold");
//    UIImageView *coin = [[UIImageView alloc] initWithImage:image];
//    [coin setFrame:(CGRect){CGPointMake(0, -3),{image.size.width / 2, image.size.height / 2}}];
//    [view addSubview:coin];
//    left = image.size.width / 2;
//    while (n) {
//        int c = n % 10;
//        [numbers addObject:[NSNumber numberWithInt:c]];
//        n = n / 10;
//    }
//    for (int i = [numbers count] - 1; i >= 0; i--){
//        image = GetPngImage([NSString stringWithFormat:@"Snumbers%@", [numbers objectAtIndex:i]]];
//        coin = [[UIImageView alloc] initWithImage:image];
//        [coin setFrame:(CGRect){{left, 0}, {image.size.width / 2, image.size.height / 2}}];
//        [view addSubview:coin];
//        left += image.size.width / 2;
//    }
//    CGPoint point = CGPointMake(40-left, 1);
//    [view setFrame:(CGRect){point,{left, coin.frame.size.height}}];
//    [_viewPrice addSubview:view];

}
- (void)buttonTouchUpInside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(collectionViewCellTouch:)]) {
        [_delegate collectionViewCellTouch:sender];
    }
}





@end
