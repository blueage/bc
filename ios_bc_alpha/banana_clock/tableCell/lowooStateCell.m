//
//  lowooStateCell.m
//  banana_clock
//
//  Created by MAC on 12-12-17.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooStateCell.h"
#import <QuartzCore/QuartzCore.h>

NSString *const LowooStateCellShouldHideMenuNotification = @"LowooStateCellShouldHideMenuNotification";
#define deleteWidth 67.0f

@interface lowooStateCell () <UIScrollViewDelegate>
@property (nonatomic, strong) UIView *scrollViewContentView;
@property (nonatomic, strong) UIView *scrollViewButtonView;
@property (nonatomic, assign) BOOL isShowingMenu;
@property (nonatomic, strong) UIButton_custom *buttonDelete;
@end

@implementation lowooStateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = Nil;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        [self setFrame:CGRectMake(0, 0, 320, 70)];
        
        self.isShowingMenu = NO;

        self.scrollViewContentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        [self addSubview:self.scrollViewContentView];
        
        self.scrollViewButtonView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)-15, 0.0f,0, CGRectGetHeight(self.bounds))];
        self.scrollViewButtonView.clipsToBounds = YES;
        [self.contentView addSubview:self.scrollViewButtonView];
        _buttonDelete = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonDelete setFrame:CGRectMake(-67, 13, 67, 39) image:@"del_cn01" image:@"del_cn02"];
        [_buttonDelete addTarget:self action:@selector(userPressedDeleteButton:)];
        [self.scrollViewButtonView addSubview:_buttonDelete];

        _viewCellBase = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
        _viewCellBase.backgroundColor = [UIColor clearColor];
        [self.scrollViewContentView addSubview:_viewCellBase];
        
        
        _buttonState = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonState setHighlighted:NO];
        [_buttonState setFrame:CGRectMake(83, 5, 219, 56)];
        _buttonState.backgroundColor = [UIColor clearColor];
        [_viewCellBase addSubview:_buttonState];

        _imageViewState = [[UIImageView alloc]initWithFrame:CGRectMake(239, -5, 60, 60)];
        [_viewCellBase addSubview:_imageViewState];
        
        _labelState = [[THLabel alloc] initWithFrame:CGRectMake(240, 42, 58, 21)];
        [_labelState setTextAlignment:NSTextAlignmentCenter];
        [_labelState setFont:[UIFont systemFontOfSize:8]];
        [_labelState setBackgroundColor:[UIColor clearColor]];
        [_labelState setTextColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];
        
        [_labelState setStrokeColor:[UIColor whiteColor]];
        [_labelState setStrokeSize:1.5f];
        
        [_labelState setShadowColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];
        [_labelState setShadowOffset:CGSizeMake(0, 0)];
        [_labelState setShadowBlur:2];

        
        [_viewCellBase addSubview:_labelState];
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(94, 22, 140, 21)];
        _labelName.backgroundColor = [UIColor clearColor];
        [_labelName setTextColor:[UIColor colorWithRed:48/255.0 green:48/255.0 blue:48/255.0 alpha:1]];
        [_labelName setFont:[UIFont systemFontOfSize:12]];
        [_viewCellBase addSubview:_labelName];
        
        _labelTime = [[UILabel alloc] initWithFrame:CGRectMake(94, 37, 150, 21)];
        _labelTime.backgroundColor = [UIColor clearColor];
        [_labelTime setTextColor:[UIColor colorWithRed:48/255.0 green:48/255.0 blue:48/255.0 alpha:0.8]];
        [_labelTime setFont:[UIFont systemFontOfSize:10]];
        [_viewCellBase addSubview:_labelTime];
        

        

        
        //头像
        _viewHead = [[UIView alloc] initWithFrame:CGRectMake(15, 3, 60, 60)];
        
        _buttonHead = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_buttonHead setFrame:CGRectMake(0, 0, 60, 60)];
        [_buttonHead addTarget:self action:@selector(buttonHeadTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        _buttonHead.backgroundColor = [UIColor clearColor];
        [_viewHead addSubview:_buttonHead];

        _imageViewHead = [[UIImageView_custom alloc]initWithFrame:CGRectMake(4, 3, 52, 52)];
        _imageViewHead.image = [UIImage imageNamed:@"default_head_small.png"];
        [_viewHead addSubview:_imageViewHead];
        
        //遮罩
        UIImageView *imageViewHeadMask = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 61, 61)];
        imageViewHeadMask.image = [UIImage imageNamed:@"headBack.png"];
        [_viewHead addSubview:imageViewHeadMask];
        
        
        
        [self addSubview:_viewHead];
        [self bringSubviewToFront:_viewHead];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rightSwipeAction) name:@"rightSwipeAction" object:nil];
        
        _swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeAction)];
        [_swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeAction)];
        [_swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.scrollViewContentView addGestureRecognizer:_swipeLeft];
        _point = self.scrollViewContentView.center;
    }
    return self;
}

- (void)leftSwipeAction{
    _boolScrollToLeft = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rightSwipeAction" object:nil];
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollViewContentView.center = CGPointMake(_point.x - deleteWidth, _point.y);
        _viewHead.alpha = 0.0f;
        if (_imageViewMedal) {
            _imageViewMedal.alpha = 0.0f;
        }
        CGRect frame = self.scrollViewButtonView.frame;
        frame.origin.x = CGRectGetWidth(self.bounds) - deleteWidth - 15;
        frame.size.width = deleteWidth;
        self.scrollViewButtonView.frame = frame;
        
        CGRect frameButton = _buttonDelete.frame;
        frameButton.origin.x = 0;
        _buttonDelete.frame = frameButton;

    } completion:^(BOOL finished) {
        [self.scrollViewContentView removeGestureRecognizer:_swipeLeft];
        [self.scrollViewContentView addGestureRecognizer:_swipeRight];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"rightSwipeAction" object:nil];
        _boolScrollToLeft = NO;
        _isShowingMenu = YES;
    }];
}

- (void)rightSwipeAction{
    if (_boolScrollToLeft) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollViewContentView.center = _point;
        _viewHead.alpha = 1.0f;
        if (_imageViewMedal) {
            _imageViewMedal.alpha = 1.0f;
        }
        CGRect frame = self.scrollViewButtonView.frame;
        frame.origin.x = CGRectGetWidth(self.bounds) - 15;
        frame.size.width = 0;
        self.scrollViewButtonView.frame = frame;
        
        CGRect frameButton = _buttonDelete.frame;
        frameButton.origin.x = - deleteWidth;
        _buttonDelete.frame = frameButton;

    } completion:^(BOOL finished) {
        [self.scrollViewContentView removeGestureRecognizer:_swipeRight];
        [self.scrollViewContentView addGestureRecognizer:_swipeLeft];
        _boolScrollToLeft = NO;
        _isShowingMenu = NO;
    }];
}

- (void)userPressedDeleteButton:(UIButton_custom *)button{
    if ([_delegate respondsToSelector:@selector(cellDidSelectDelete:)]) {
        [_delegate cellDidSelectDelete:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


-(void)stateCellConfirmDataWithDictionary:(modelUser *)user{
    _labelName.text = user.name;
    if (user.boolTodayCanBeCall) {
        if ([user.timeStart compare:user.timeStop] <= 0) {
            _labelTime.text = [NSString stringWithFormat:@"%@-%@",user.timeStart,user.timeStop];
        }else{
            if (LANGUAGE_CHINESE) {
                    _labelTime.text = [NSString stringWithFormat:@"%@-第二天:%@",user.timeStart,user.timeStop];
                }else{
                    _labelTime.text = [NSString stringWithFormat:@"%@-Tomorrow:%@",user.timeStart,user.timeStop];
                }
        }
    }else{
        _labelTime.text = [BASE International:@"休息中"];
    }
    //头像
    if (![user.avatarUrl isEqualToString:@""]) {
        [_imageViewHead setImageURL:user.avatarUrl];
    }else{
        _imageViewHead.image = [UIImage imageNamed:@"default_head_small.png"];
    }

    /*
     可被叫      1
     起床中    2
     已起床    3
     */
    
    [_buttonState removeTarget:self action:@selector(buttonStateTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    switch (user.state) {
        case 4://不可叫
            _imageViewState.image = [UIImage imageNamed:@"listicon_04.png"];
            [_buttonState setBackgroundImage:[UIImage imageNamed:@"statelist2.png"] forState:UIControlStateNormal];
            [_buttonState setBackgroundImage:[UIImage imageNamed:@"statelist2.png"] forState:UIControlEventTouchDown];
            _buttonState.userInteractionEnabled = NO;
            [_labelState setText:[BASE International:@"Resting"]];
            break;
        case 1:{//可被叫
            _imageViewState.image = [UIImage imageNamed:@"listicon_02.png"];
            [_buttonState setBackgroundImage:[UIImage imageNamed:@"statelist.png"] forState:UIControlStateNormal];
            [_buttonState setBackgroundImage:[UIImage imageNamed:@"statelist.png"] forState:UIControlEventTouchDown];
            [_labelState setText:[BASE International:@"Available"]];
            _buttonState.userInteractionEnabled = YES;
            [_buttonState addTarget:self action:@selector(buttonStateTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case 2://起床中
            _imageViewState.image = [UIImage imageNamed:@"listicon_01.png"];
            [_buttonState setBackgroundImage:[UIImage imageNamed:@"statelist.png"] forState:UIControlStateNormal];
            [_buttonState setBackgroundImage:[UIImage imageNamed:@"statelist.png"] forState:UIControlEventTouchDown];
            [_labelState setText:[BASE International:@"Being Called"]];
            _buttonState.userInteractionEnabled = YES;
            [_buttonState addTarget:self action:@selector(buttonStateTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 3://已起床
            _imageViewState.image = [UIImage imageNamed:@"listicon_03.png"];
            [_buttonState setBackgroundImage:[UIImage imageNamed:@"statelist2.png"] forState:UIControlStateNormal];
            [_buttonState setBackgroundImage:[UIImage imageNamed:@"statelist2.png"] forState:UIControlEventTouchDown];
            [_labelState setText:[BASE International:@"已起床"]];
            _buttonState.userInteractionEnabled = NO;
            break;
        default:
            break;
    }
    [_buttonState setTag:_indexPath.row];
    
    [self confirmMedal:user.arrayGetMedal];
    
    //调整名称位置
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:MEDAL_HIDDEN] boolValue]) {
        [_labelName setFrame:CGRectMake(94, 22, 140, 21)];
        [_labelTime setFrame:CGRectMake(94, 37, 150, 21)];
    }else{
        [_labelName setFrame:CGRectMake(94, 15, 140, 21)];
        [_labelTime setFrame:CGRectMake(94, 30, 150, 21)];
    }
    //蜘蛛网
    if (user.boolSpider) {
        if (!_imageViewMoss) {
            _imageViewMoss = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
            _imageViewMoss.image = [UIImage imageNamed:@"moss_big.png"];
            [_viewHead addSubview:_imageViewMoss];
        }else{
            _imageViewMoss.hidden = NO;
        }
    }else{
        if (!_imageViewMoss) {
            
        }else{
            _imageViewMoss.hidden = YES;
        }
    }

    //关注
    if (user.boolFoucs) {
        if (!_imageViewFoucs) {
            _imageViewFoucs = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 0, 37/2, 37/2)];
            _imageViewFoucs.image = [UIImage imageNamed:@"foucs_c.png"];
            [_viewHead addSubview:_imageViewFoucs];
        }else{
            _imageViewFoucs.hidden = NO;
        }
    }else{
        if (!_imageViewFoucs) {
            
        }else{
            _imageViewFoucs.hidden = YES;
        }
    }
    if (_imageViewFoucs) {
        [self bringSubviewToFront:_imageViewFoucs];
    }
}

- (void)confirmMedal:(NSArray *)sender{
    
    _labelTime.hidden = ![[[NSUserDefaults standardUserDefaults] objectForKey:TIME_HIDDEN] boolValue];
    if (sender.count == 0) {
        return;
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:MEDAL_HIDDEN] boolValue]) {
        _viewMedal = [[UIView alloc]initWithFrame:CGRectMake(91, -3, 150, 26)];
        _viewMedal.userInteractionEnabled = NO;
        _viewMedal.backgroundColor = [UIColor clearColor];
        [_viewCellBase addSubview:_viewMedal];
        
        _viewMedal.hidden = ![[[NSUserDefaults standardUserDefaults] objectForKey:MEDAL_HIDDEN] boolValue];
        _imageViewMedal.hidden = ![[[NSUserDefaults standardUserDefaults] objectForKey:MEDAL_HIDDEN] boolValue];
        if (!_viewMedal.hidden){
            BOOL boolfirst = NO;
            for (NSString *str in sender) {
                if ([str intValue] == 0) {
                    boolfirst = YES;
                    for (int i=0; i<sender.count; i++) {
                        if ([[sender objectAtIndex:i] intValue]==0) {
//                            _imageViewMedal = [[UIImageView alloc] initWithFrame:CGRectMake(12, -3, 21, 26)];
//                            _imageViewMedal.image = [UIImage imageNamed:@"Medal00.png"];
//                            [_viewCellBase addSubview:_imageViewMedal];
                        }else{
                            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((i-1)*17, 0, 21, 26)];
                            imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"Medal_s%d.png",[[sender objectAtIndex:i] intValue]]];
                            [_viewMedal addSubview:imageview];
                        }
                    }
                }
            }
            if (!boolfirst) {
                for (int i=0; i<sender.count; i++) {
                    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((i)*17, 0, 21, 26)];
                    imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"Medal%02d.png",[[sender objectAtIndex:i] intValue]]];
                    [_viewMedal addSubview:imageview];
                }
            }
        }
    }

    
}

- (void)buttonStateTouchUpInside:(UIButton_custom *)sender {
    if (!self.isShowingMenu) {
        if ([[lowooHTTPManager getInstance] isExistenceNetwork]) {
            if ([_delegate respondsToSelector:@selector(buttonStateAction:Name:indexPath:)]) {
                [_delegate buttonStateAction:sender Name:_labelName.text indexPath:_indexPath];
            }
        }
    }else{
        [self rightSwipeAction];
    }
}

- (void)buttonHeadTouchUpInside:(NSIndexPath *)indexPath {
    if (!self.isShowingMenu) {
        if ([[lowooHTTPManager getInstance] isExistenceNetwork]) {
            if ([_delegate respondsToSelector:@selector(buttonHeadDidTouchUpInside:)]) {
                [_delegate buttonHeadDidTouchUpInside:_indexPath];
            }
        }
    }else{
        [self rightSwipeAction];
    }
}




@end
