//
//  achievementView.m
//  banana_clock
//
//  Created by Lowoo on 2/12/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import "achievementView.h"


@implementation achievementView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:(CGRect){CGPointZero,85 ,55}];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(45, 0, 85-45, 55)];
        [self addSubview:view];
        view.clipsToBounds = YES;
        
        self.imageViewIcon = [[UIImageView_custom alloc] initWithFrame:CGRectMake(18, 23, 10, 10)];
        self.imageViewIcon.image = [UIImage imageNamed:@"90_00.png"];
        [self addSubview:self.imageViewIcon];
        
        
        
        self.labelChinese = [[UILabel alloc] initWithFrame:CGRectMake(45-45-50, 15, 42, 10)];
        self.labelChinese.textColor = COLOR_EXPANDED_NO;
        self.labelChinese.font = [UIFont systemFontOfSize:10.0];
        self.labelChinese.textAlignment = NSTextAlignmentLeft;
        [view addSubview:self.labelChinese];
        
        self.labelEnglish = [[UILabel alloc] initWithFrame:CGRectMake(45-45-50, 22, 42, 25)];
        self.labelEnglish.textColor = COLOR_EXPANDED_NO;
        self.labelEnglish.font = [UIFont systemFontOfSize:8.0];
        self.labelEnglish.textAlignment = NSTextAlignmentLeft;
        self.labelEnglish.lineBreakMode = NSLineBreakByCharWrapping;
        self.labelEnglish.numberOfLines = 2;
        [view addSubview:self.labelEnglish];
    }
    return self;
}

- (void)setAchievementData:(modelAchievement *)achieve{
    if ([achieve.timeGet intValue] != 0){
        if (![achieve.imageUrl isEqualToString:@""]) {
            [self.imageViewIcon setImageURL:[NSString stringWithFormat:@"%@",achieve.imageUrl]];
        }
    }
    self.labelChinese.text = achieve.nameChinese;
    self.labelEnglish.text = achieve.nameEnglish;
    [self setanimation];
    [self labelAnimation];
}


- (void)setanimation{
    if (IOS_7) {
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.7
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.imageViewIcon.transform = CGAffineTransformMakeScale(4, 4);
                         } completion:^(BOOL finished) {
                           
                         }];
        
    }else{
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.imageViewIcon.transform = CGAffineTransformMakeScale(4, 4);
                         } completion:^(BOOL finished) {
                             
                         }];
    }
}

- (void)labelAnimation{
    if (IOS_7) {
        [UIView animateWithDuration:0.3
                              delay:0.2
             usingSpringWithDamping:0.9
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.labelChinese.transform = CGAffineTransformMakeTranslation(50, 0);
                         } completion:^(BOOL finished) {
                                                          self.imageViewIcon.transform = CGAffineTransformMakeScale(4, 4);
                         }];
        
    }else{
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                         } completion:^(BOOL finished) {
                             
                         }];
    }
    
    if (IOS_7) {
        [UIView animateWithDuration:0.3
                              delay:0.3
             usingSpringWithDamping:0.9
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.labelEnglish.transform = CGAffineTransformMakeTranslation(50, 0);
                         } completion:^(BOOL finished) {
                             
                         }];
        
    }else{
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                                                          self.labelEnglish.transform = CGAffineTransformMakeTranslation(50, 0);
                         } completion:^(BOOL finished) {
                             
                         }];
    }
}




@end
