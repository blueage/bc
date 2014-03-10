//
//  lowooSettingCell2.m
//  banana clock
//
//  Created by MAC on 12-10-9.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooSettingCell2.h"

@implementation lowooSettingCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setFrame:CGRectMake(0, 0, 320, 71)];
        [self.viewOne setFrame:CGRectMake(0, 0, 320, 54)];
        _imageViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(22, 0, 276, 54)];
        _imageViewOne.image = [UIImage imageNamed:@"List_item_bg01.png"];
        [self.viewOne addSubview:_imageViewOne];
        
        UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(22, 53, 276, 71)];
        viewDown.backgroundColor = [UIColor clearColor];
        [self addSubview:viewDown];
        
        _viewMove = [[UIView alloc]initWithFrame:CGRectMake(0, -26, 276, 71)];
        _viewMove.backgroundColor = [UIColor clearColor];
        [viewDown addSubview:_viewMove];
        
        self.imageViewDownBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 275, 71+60)];
        self.imageViewDownBack.image = [UIImage imageNamed:@"expaned.png"];
        [_viewMove addSubview:self.imageViewDownBack];
        
        _viewMask = [[UIView alloc]initWithFrame:CGRectMake(14.5, 0, 248, 71)];
        _viewMask.backgroundColor = [UIColor blackColor];
        [viewDown addSubview:_viewMask];
        
        _imageviewBackground = [[UIImageView alloc]initWithFrame:CGRectMake(22, 0, 276, 53)];
        _imageviewBackground.backgroundColor = [UIColor whiteColor];
        [self.viewOne addSubview:_imageviewBackground];
        
        _buttonExpand = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonExpand setFrame:CGRectMake(22, 0, 276, 53)];
        _buttonExpand.backgroundColor = [UIColor clearColor];
        [_buttonExpand addTarget:self action:@selector(rotateExpandButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.viewOne addSubview:_buttonExpand];
        
        _viewTriangle = [[UIView alloc]initWithFrame:CGRectMake(270, 34, 14, 14)];
        _viewTriangle.backgroundColor = [UIColor clearColor];
        [self.viewOne addSubview:_viewTriangle];
        
        _buttonMedal = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonMedal setFrame:CGRectMake(33, 5, 50*0.8, 50*0.8)];
        [_buttonMedal addTarget:self action:@selector(buttonMedalAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.viewOne addSubview:_buttonMedal];
        
        _imageViewSanjiao1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 14, 14)];
        [_imageViewSanjiao1 setImage:[UIImage imageNamed:@"sanjiao01.png"]];
        [_viewTriangle addSubview:_imageViewSanjiao1];
        _imageViewSanjiao2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 14, 14)];
        [_imageViewSanjiao2 setImage:[UIImage imageNamed:@"sanjiao02.png"]];
        [_viewTriangle addSubview:_imageViewSanjiao2];

        

        [self bringSubviewToFront:self.viewOne];
    }
    return self;
}

- (void)labelChinese{
    if (_label1) {
        return;
    }
    _label1 = [[UILabel alloc] init];
    [_label1 setFrame:CGRectMake(149, 3, 130, 21)];
    [_label1 setTextAlignment:NSTextAlignmentRight];
    [_label1 setFont:[UIFont systemFontOfSize:12.0]];
    [_label1 setTextColor:COLOR_CHINESE];
    [_label1 setBackgroundColor:[UIColor clearColor]];
    [self.viewOne addSubview:_label1];
    
    _label2 = [[UILabel alloc] init];
    [_label2 setFrame:CGRectMake(149, 13, 130, 26)];
    [_label2 setTextAlignment:NSTextAlignmentRight];
    [_label2 setFont:[UIFont systemFontOfSize:10.0]];
    [_label2 setTextColor:COLOR_ENGLISH];
    [_label2 setBackgroundColor:[UIColor clearColor]];
    [self.viewOne addSubview:_label2];
    
    _label3 = [[UILabel alloc] init];
    [_label3 setFrame:CGRectMake(88, 8, 94, 21)];
    [_label3 setTextAlignment:NSTextAlignmentCenter];
    [_label3 setFont:[UIFont systemFontOfSize:12.0]];
    [_label3 setTextColor:COLOR_ENGLISH];
    [_label3 setBackgroundColor:[UIColor clearColor]];
    [self.viewOne addSubview:_label3];
    
    _label4 = [[UILabel alloc] init];
    [_label4 setFrame:CGRectMake(88, 25, 94, 21)];
    [_label4 setTextAlignment:NSTextAlignmentCenter];
    [_label4 setFont:[UIFont systemFontOfSize:12.0]];
    [_label4 setTextColor:COLOR_ENGLISH];
    [_label4 setBackgroundColor:[UIColor clearColor]];
    [self.viewOne addSubview:_label4];
    
    _label5 = [[UILabel alloc] init];
    [_label5 setFrame:CGRectMake(164, 30, 105, 21)];
    [_label5 setTextAlignment:NSTextAlignmentRight];
    [_label5 setFont:[UIFont systemFontOfSize:9.0]];
    [_label5 setTextColor:COLOR_DAY];
    [_label5 setBackgroundColor:[UIColor clearColor]];
    [self.viewOne addSubview:_label5];
}

- (void)labelEnglish{
    if (_labelEG1) {
        return;
    }
    _labelEG1 = [[UILabel alloc] init];
    [_labelEG1 setFrame:CGRectMake(180, 0, 100, 40)];
    [_labelEG1 setTextAlignment:NSTextAlignmentRight];
    [_labelEG1 setFont:[UIFont systemFontOfSize:12.0]];
    [_labelEG1 setTextColor:COLOR_CHINESE];
    [_labelEG1 setBackgroundColor:[UIColor clearColor]];
    _labelEG1.lineBreakMode = NSLineBreakByCharWrapping;
    _labelEG1.numberOfLines = 0;
    [self.viewOne addSubview:_labelEG1];
    
    _labelEG2 = [[UILabel alloc] init];
    [_labelEG2 setFrame:CGRectMake(164, 30, 105, 20)];
    [_labelEG2 setTextAlignment:NSTextAlignmentRight];
    [_labelEG2 setFont:[UIFont systemFontOfSize:9.0]];
    [_labelEG2 setBackgroundColor:[UIColor clearColor]];
    [_labelEG2 setTextColor:COLOR_DAY];
    [self.viewOne addSubview:_labelEG2];
    
    _labelEG3 = [[UILabel alloc] init];
    [_labelEG3 setFrame:CGRectMake(88, 3, 100, 40)];
    [_labelEG3 setTextAlignment:NSTextAlignmentCenter];
    [_labelEG3 setFont:[UIFont systemFontOfSize:10.0]];
    [_labelEG3 setTextColor:COLOR_CHINESE];
    [_labelEG3 setBackgroundColor:[UIColor clearColor]];
    _labelEG3.lineBreakMode = NSLineBreakByCharWrapping;// UILineBreakModeWordWrap;
    _labelEG3.numberOfLines = 0;
    [self.viewOne addSubview:_labelEG3];
}

- (void)buttonMedalAction:(UIButton_custom *)sender{
    [_delegate buttonMedalTouchUpInside:sender];
}

- (void)confirmDataWithMedal:(modelMedal *)medal withIndex:(NSInteger)index Expanded:(BOOL)expand{
    if (index == 1) {
        [self.imageViewDownBack setFrame:CGRectMake(0, 0, 275, 68)];
    }else{
        [self.imageViewDownBack setFrame:CGRectMake(0, 0, 275, 71+60)];
    }
    self.medal = medal;
    NSString *namepng = [NSString stringWithFormat:@"Medal_big%d",index];
    [_buttonMedal setImage:GetPngImage(namepng) forState:UIControlStateNormal];
    _buttonMedal.tag = index-1;
    if (expand) {
        _imageViewSanjiao2.alpha = 0.0f;
        [self.viewAchievement removeFromSuperview]; self.viewAchievement = nil;
        [self setAchievement];
    }else{
        _imageViewSanjiao2.alpha = 1.0f;
        [self.viewAchievement removeFromSuperview]; self.viewAchievement = nil;
    }
    _boolExpanded = expand;
    
    //顶层
    if (LANGUAGE_CHINESE){
        [self labelChinese];
        [_label1 setText:medal.nameChinese];
        [_label2 setText:medal.nameEnglish];
        [_label3 setFrame:CGRectMake(88, 8, 94, 21)];
        NSString *string1 = medal.describChinese;
        NSInteger length = [string1 length];
        NSString *newString = [string1 substringToIndex:length-4];
        [_label3 setText:newString];
        [_label4 setText:@"系列成就"];
        
        if (medal.boolGet) {
            _label5.text = medal.timeGet;
        }else{
            _label5.text = [NSString stringWithFormat:@"%@ %@", [BASE International:@"Finished:"],medal.percentage];
        }
    }else{
        [self labelEnglish];
        [_labelEG1 setText:medal.nameEnglish];
        _labelEG3.text = medal.describEnglish;
        
        if (medal.boolGet) {
            _labelEG2.text = medal.timeGet;
        }else{
            _labelEG2.text = [NSString stringWithFormat:@"%@ %@", [BASE International:@"Finished:"],medal.percentage];
        }
    }
    
   
}



- (void)determineTheStatus{
    if (self.boolExpanded) {
        [UIView animateWithDuration:0
                         animations:^{
                                    CGPoint point = CGPointMake(138, 35);
                                    _viewMove.center = point;
                                    _viewTriangle.transform = CGAffineTransformMakeRotation(-M_PI*2.5);
                                    [_viewMask setAlpha:0.0];
                                } completion:^(BOOL finished) {
                                    
                                }];
        

    }else{
        [UIView animateWithDuration:0
                         animations:^{
                                    CGPoint point = CGPointMake(138, 0);
                                    _viewMove.center = point;
                                    _viewTriangle.transform = CGAffineTransformMakeRotation(+M_PI*0.0);
                                    [_viewMask setAlpha:0.3];
                                } completion:^(BOOL finished) {
                                    
                                }];
        

    }
}

- (void)rotateExpandButton:(UIButton_custom *)sender {//_indexPath
    [_delegate rotateWithIndexPath:_indexPath];
    _boolExpanded = !_boolExpanded;
    switch (_boolExpanded) {//真假  0  1
        case 0:
            [self rotateExpandBtnToCollapsed];
            break;
        case 1:
            [self rotateExpandBtnToExpanded];
        default:
            break;
    }
}

- (void)rotateExpandBtnToExpanded
{
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint point = CGPointMake(138, 35);
        _imageViewSanjiao2.alpha = 0.0f;
        _viewMove.center = point;
        _viewTriangle.transform = CGAffineTransformMakeRotation(-M_PI*2.5);
        //_buttonExpand.transform = CGAffineTransformMakeRotation(M_PI*2.5);

    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.22 animations:^{
        [_viewMask setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self setAchievement];
    }];
}

- (void)setAchievement{
    int height = 0;
    if (self.indexPath.row == 1) {
        height = 6;
    }
    self.viewAchievement = [[UIView alloc] initWithFrame:self.viewMask.bounds];
    [self.viewMove addSubview:self.viewAchievement];
    for (int i=0; i<self.medal.arrayAchievement.count; i++) {
        achievementView *viewAchievement = [[achievementView alloc] initWithFrame:CGRectZero];
        viewAchievement.tag = 99;
        viewAchievement.center = CGPointMake(56*((i%3)+1)+26*(i%3), 40*(i/3+1)+10*(i/3)-height);
        [self.viewAchievement addSubview:viewAchievement];
        [viewAchievement setAchievementData:[self.medal.arrayAchievement objectAtIndex:i]];
    }
}

- (void)rotateExpandBtnToCollapsed
{
    [UIView animateWithDuration:0.3 animations:^{
                _imageViewSanjiao2.alpha = 1.0f;
        CGPoint point = CGPointMake(138, 0);
        _viewMove.center = point;
        _viewTriangle.transform = CGAffineTransformMakeRotation(M_PI*0.0);
        //_buttonExpand.transform = CGAffineTransformMakeRotation(M_PI*0.0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.22 animations:^{
        [_viewMask setAlpha:0.3];
    } completion:^(BOOL finished) {
        [self.viewAchievement removeFromSuperview]; self.viewAchievement = nil;
//        for (UIView *aview in self.viewMove.subviews) {
//            if (aview.tag == 99) {
//                 [aview removeFromSuperview];
//            }
//        }
    }];
}




@end
