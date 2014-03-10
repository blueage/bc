//
//  lowooSettingCell3.m
//  banana_clock
//
//  Created by MAC on 13-1-21.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooSettingCell3.h"

@implementation lowooSettingCell3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 320, 53)];
        [self.viewOne setFrame:CGRectMake(0, 0, 320, 53)];
        
        
        
        self.outerview = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,{100, 0}}];
        
        _imageViewBackground = [[UIImageView alloc]initWithFrame:CGRectMake(22, 0, 276, 53)];
        [self.viewOne addSubview:_imageViewBackground];
        
        UIImageView *imageViewDefault = [[UIImageView alloc] initWithFrame:CGRectMake(35, 4, 45, 45)];
        imageViewDefault.image = [UIImage imageNamed:@"90_00.png"];
        [self.viewOne addSubview:imageViewDefault];
        
        _imageViewIcon = [[UIImageView_custom alloc] initWithFrame:CGRectMake(35, 4, 45, 45)];
        _imageViewIcon.image = [UIImage imageNamed:@"90_00.png"];
        [self.viewOne addSubview:_imageViewIcon];
        
        _imageViewICON = [[UIImageView alloc] initWithFrame:CGRectMake(50 - 21, 3, 41, 17)];
        [_imageViewICON setImage:[UIImage imageNamed:@"chengjiuicon01.png"]];
        [self.outerview addSubview:_imageViewICON];

        
        UIImageView *imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(192, 13, 1, 22)];
        [imageViewLine setImage:[UIImage imageNamed:@"setting_line.png"]];
        [self.viewOne addSubview:imageViewLine];
        
        _label2 = [[UILabel alloc] init];
        [_label2 setTextAlignment:NSTextAlignmentRight];
        [_label2 setFrame:CGRectMake(196, 13, 88, 26)];
        [_label2 setFont:[UIFont systemFontOfSize:10.0]];
        [_label2 setTextColor:COLOR_ENGLISH];
        [_label2 setBackgroundColor:[UIColor clearColor]];
        [self.viewOne addSubview:_label2];
        
        [self.viewOne addSubview:self.outerview];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


- (UILabel *)label1{
    if (_labelEG1) {
        [_labelEG1 removeFromSuperview];
        [_labelEG2 removeFromSuperview];
        [_labelEG3 removeFromSuperview];
    }
    
    
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        [_label1 setTextAlignment:NSTextAlignmentRight];
        [_label1 setFrame:CGRectMake(196, 3, 88, 21)];
        [_label1 setFont:[UIFont systemFontOfSize:12.0]];
        [_label1 setTextColor:COLOR_CHINESE];
        [_label1 setBackgroundColor:[UIColor clearColor]];
        [self.viewOne addSubview:_label1];
    }
    return _label1;
}

//- (UILabel *)label2{
//    if (!_label2) {
//        _label2 = [[UILabel alloc] init];
//        [_label2 setTextAlignment:NSTextAlignmentRight];
//        [_label2 setFrame:CGRectMake(196, 13, 88, 26)];
//        [_label2 setFont:[UIFont systemFontOfSize:10.0]];
//        [_label2 setTextColor:COLOR_ENGLISH];
//        [_label2 setBackgroundColor:[UIColor clearColor]];
//        [self.viewOne addSubview:_label2];
//    }
//    return _label2;
//}

- (UILabel *)label3{
    if (!_label3) {
        _label3 = [[UILabel alloc] init];
        _label3.numberOfLines =0;
        [_label3 setLineBreakMode:NSLineBreakByCharWrapping];
        [_label3 setFont:[UIFont systemFontOfSize:9.0]];
        [_label3 setTextColor:COLOR_ENGLISH];
        [_label3 setTextAlignment:NSTextAlignmentCenter];
        [_label3 setBackgroundColor:[UIColor clearColor]];
        [_outerview addSubview:_label3];
    }
    return _label3;
}

- (UILabel *)label4{
    if (!_label4) {
        _label4 = [[UILabel alloc] init];
        [_label4 setTextAlignment:NSTextAlignmentRight];
        [_label4 setFrame:CGRectMake(196, 32, 89, 19)];
        [_label4 setFont:[UIFont systemFontOfSize:9.0]];
        [_label4 setTextColor:COLOR_ENGLISH];
        [_label4 setBackgroundColor:[UIColor clearColor]];
        [self.viewOne addSubview:_label4];
    }
    return _label4;
}


- (UILabel *)labelEG1{
    if (_label1) {
        [_label1 removeFromSuperview];
        _label1 = nil;
        [_label2 removeFromSuperview];
        _label2 = nil;
        [_label3 removeFromSuperview];
        _label3 = nil;
        [_label4 removeFromSuperview];
        _label4 = nil;
    }
    
    
    if (!_labelEG1) {
        _labelEG1 = [[UILabel alloc] init];
        [_labelEG1 setTextAlignment:NSTextAlignmentRight];
        [_labelEG1 setFrame:CGRectMake(196, 5, 88, 26)];
        [_labelEG1 setFont:[UIFont systemFontOfSize:10.0]];
        [_labelEG1 setTextColor:COLOR_CHINESE];
        [_labelEG1 setBackgroundColor:[UIColor clearColor]];
        [self.viewOne addSubview:_labelEG1];
    }
    return _labelEG1;
}

- (UILabel *)labelEG2{
    if (!_labelEG2) {
        _labelEG2 = [[UILabel alloc] init];
        [_labelEG2 setFrame:CGRectMake(88, 15, 100, 80)];
        [_labelEG2 setFont:[UIFont systemFontOfSize:9.0]];
        [_labelEG2 setTextColor:COLOR_ENGLISH];
        [_labelEG2 setBackgroundColor:[UIColor clearColor]];
        _labelEG2.lineBreakMode = NSLineBreakByCharWrapping;
        _labelEG2.numberOfLines = 0;
        [_outerview addSubview:_labelEG2];
    }
    return _labelEG2;
}

- (UILabel *)labelEG3{
    if (!_labelEG3) {
        _labelEG3 = [[UILabel alloc] init];
        [_labelEG3 setTextAlignment:NSTextAlignmentRight];
        [_labelEG3 setFrame:CGRectMake(196, 32, 89, 19)];
        [_labelEG3 setFont:[UIFont systemFontOfSize:9.0]];
        [_labelEG3 setTextColor:COLOR_ENGLISH];
        [_labelEG3 setBackgroundColor:[UIColor clearColor]];
        [self.viewOne addSubview:_labelEG3];
    }
    return _labelEG3;
}



- (void)confirmData:(modelAchievement *)achieve{
    _imageViewIcon.image = nil;
    if ([achieve.timeGet intValue] != 0){
        if (![achieve.imageUrl isEqualToString:@""]) {
            [_imageViewIcon setImageURL:[NSString stringWithFormat:@"%@",achieve.imageUrl]];
        }
    }
    
    if (LANGUAGE_CHINESE){
        [self.label1 setText:achieve.nameChinese];
        [self.label2 setText:achieve.nameEnglish];
        NSString *string = achieve.describChinese;
        self.label3.text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:9.0] constrainedToSize:CGSizeMake(100, 24) lineBreakMode:0];
        [self.label3 setFrame:(CGRect){{0, 23},size}];
        [self.label3 setCenter:(CGPoint){50, self.label3.center.y}];
        self.label3.textAlignment = NSTextAlignmentCenter;
        [self.outerview setFrame:(CGRect){CGPointZero,{100, size.height + 23}}];
        [self.outerview setCenter:(CGPoint){136, 25}];
        
        [self.label3 setText:achieve.describChinese];
        if ([achieve.timeGet intValue] != 0) {
            [self.label4 setText:achieve.timeGet];
            [self.label4 setTextColor:[UIColor colorWithRed:200/255.0 green:169/255.0 blue:0/255.0 alpha:0.9]];
            [self.imageViewICON setImage:[UIImage imageNamed:@"achieveCoin00.png"]];
        }else{
            [self.label4 setTextColor:[UIColor blackColor]];
            [self.label4 setText:[NSString stringWithFormat:@"%@ %@", [BASE International:@"Finished:"], achieve.percentage]];
            [self.imageViewICON setImage:[UIImage imageNamed:[NSString stringWithFormat:@"achieveCoin%d.png",achieve.coin]]];
        }
    }else{
        [self.labelEG1 setText:achieve.nameEnglish];

        
        NSString *string = achieve.describEnglish;
        self.labelEG2.text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:9.0] constrainedToSize:CGSizeMake(100, 24) lineBreakMode:0];
        [self.labelEG2 setFrame:(CGRect){{0, 23},size}];
        [self.labelEG2 setLineBreakMode:NSLineBreakByCharWrapping];
        [self.labelEG2 setCenter:(CGPoint){50, self.labelEG2.center.y}];
        self.labelEG2.textAlignment = NSTextAlignmentCenter;
        [self.outerview setFrame:(CGRect){CGPointZero,{100, size.height + 23}}];
        [self.outerview setCenter:(CGPoint){136, 25}];
        
        if ([achieve.timeGet intValue] != 0) {
            [self.labelEG3 setText:achieve.timeGet];
            self.labelEG3.textColor = [UIColor colorWithRed:200/255.0 green:169/255.0 blue:0/255.0 alpha:0.9];
            [self.imageViewICON setImage:[UIImage imageNamed:@"achieveCoin00.png"]];
        }else{
            [self.labelEG3 setText:[NSString stringWithFormat:@"%@ %@",[BASE International:@"Finished:"],achieve.percentage]];
            [self.labelEG3 setTextColor:COLOR_ENGLISH];
            [self.imageViewICON setImage:[UIImage imageNamed:[NSString stringWithFormat:@"achieveCoin%d.png",achieve.coin]]];
        }
    }
    
    
}

@end
