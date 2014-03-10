//
//  lowooPersonalDetails.m
//  banana clock
//
//  Created by MAC on 12-10-8.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooPersonalDetails.h"
#import <QuartzCore/QuartzCore.h>
#import "JSON.h"
#import "JSONKit.h"
#import "LocalNotification.h"
#import "liboTOOLS.h"

@implementation lowooPersonalDetails

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    
    if (_selfSetting) {//自己的信息
        self.stringTitle = @"PROFILE";
        [self changeTitle];
    }else{//好友的信息
        self.stringTitle = @"FRIEND‘s PROFILE";
        [self changeTitle];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.navigationController.viewControllers.count==0) {
        if ([_delegate respondsToSelector:@selector(viewDismiss:)]) {
            [_delegate viewDismiss:self];
        }
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdataNetworkData:) name:@"personalInformation" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeDay:) name:@"hadChangeDay" object:nil];//更新repeat
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(network) name:@"reloadCell" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameEnd) name:@"gameEnd" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameEnd) name:@"changedays" object:nil];
    }
    return self;
}

- (void)gameEnd{
    if (self.selfSetting) {
        [self networdDelay];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _boolReloadCell = NO;
    //self.tableView.userInteractionEnabled = NO;
    CGRect frame = self.tableView.frame;
    frame.origin.y -=20;
    frame.size.height  += 20;
    self.tableView.frame = frame;
    //[self updataNetworkData];
}

- (void)didChangeDay:(NSNotification *)sender{
    lowooSettingCell1 *settingCell1 = (lowooSettingCell1 *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    [settingCell1.labelDay setText:[[userModel sharedUserModel] getUserInformationWithKey:@"week"]];
}

- (void)network{
    [self performSelector:@selector(networdDelay) withObject:nil afterDelay:0.5];//给予连接后台服务器的时间
}

- (void)networdDelay{
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: self.memoryAddress, MEMORY_ADDRESS, @"yes", @"self", nil] requestType:achievelist];
}

- (void)updataNetworkData{
    if (!self.selfSetting) {//好友信息
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: self.memoryAddress, MEMORY_ADDRESS, self.fid, @"fid",@"no",@"self", nil] requestType:achievelist];
    }else{
        [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: self.memoryAddress, MEMORY_ADDRESS,@"yes",@"self", nil] requestType:achievelist];
    }
}

- (void)memoryNotificationAction:(NSNotification *)notification{
    if ([[notification.userInfo objectForKey:MEMORY_ADDRESS] isEqualToString:self.memoryAddress]) {
        [[activityView sharedActivityView] removeHUD];
        [self.slimeView endRefresh];
        _user = notification.object;
        if (_selfSetting) {
            [[userModel sharedUserModel] setUserInformation:_user.email forKey:USER_EMAIL];
            [[userModel sharedUserModel] setUserInformation:_user.name forKey:USER_NAME];
        }
        
        if (_boolReloadCell) {//单独刷新某cell
            _boolReloadCell = NO;
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForItem:0 inSection:0],[NSIndexPath indexPathForItem:0 inSection:1],[NSIndexPath indexPathForItem:1 inSection:1], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            if (_selfSetting) {
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForItem:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }else{//整体刷新
            [self.tableView reloadData];
        }
    }
    if ([_dataSoure respondsToSelector:@selector(viewLoaded:)]) {
        [_dataSoure viewLoaded:self];
    }
}

- (void)didUpdataNetworkData:(NSNotification *)sender{
}


#pragma mark -------UITableViewDataSource---------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
    case 0://头像
        if (_selfSetting) {
            return 2;
        }
        return 1;
        break;
    case 1://起床  重复
        return 2;
        break;
    case 2://起床天数
        return 3;
        break;
    case 3://勋章
        return _user.arrayMedal.count;
        break;
    case 4://成就
        return _user.arrayAchievement.count + 1;
        break;
    default:
        break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_selfSetting) {
        return 5;
    }else{
        return 6;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //section0 头像
    if (indexPath.section==0) {
        if (indexPath.row == 0) {
            static NSString *headCellIdentify = @"headCellIdentify";
            lowooHeadCell *headCell = [tableView dequeueReusableCellWithIdentifier:headCellIdentify];
            if (!headCell) {
                headCell = [[lowooHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCellIdentify];
            }
            headCell.imageviewUserHead.image = nil;
            
            if (!_selfSetting) {
                headCell.imageviewEditor.hidden = YES;
                headCell.buttonBig.userInteractionEnabled = NO;
                [headCell confirmDataWithUser:_user];
                headCell.buttonFoucs.hidden = NO;
            }else{//自己的详情页可点击
                headCell.imageviewEditor.hidden = NO;
                headCell.buttonBig.userInteractionEnabled = YES;
                headCell.boolSelf = YES;
                [headCell confirmDataWithUser:_user];
                headCell.buttonFoucs.hidden = YES;
            }

            headCell.delegate = self;
            headCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  headCell;
        }else{
            if (_selfSetting) {
                selfStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personalstate"];
                if (!cell) {
                    cell = [[selfStateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personalstate"];
                }
                if (LANGUAGE_CHINESE) {
                    cell.labelChinese.text = @"个人状态";
                    cell.labelChineseEnglish.text = @"Personal state";
                }else{
                    cell.labelEnglish.text = @"Personal State";
                }

                switch (_user.state) {
                    case 1://可被叫
                        cell.labelState.text = [BASE International:@"Available"];
                        break;
                    case 2://起床中
                        cell.labelState.text = [BASE International:@"Being Called"];
                        break;
                    case 3://已起床
                        cell.labelState.text = [BASE International:@"已起床"];
                        break;
                    case 4://不可叫
                        cell.labelState.text = [BASE International:@"Resting"];
                        break;
                    default:
                        break;
                }
                return cell;
            }
        }
    }

    //section1
    if (indexPath.section==1) {
        static NSString *settingCell1Identify = @"settingCell1Identify";
        lowooSettingCell1 *settingCell1 = [tableView dequeueReusableCellWithIdentifier:settingCell1Identify];
        if (!settingCell1) {
            settingCell1 = [[lowooSettingCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell1Identify];
        }
        //起床时间
        if (indexPath.row==0) {
            settingCell1.imageViewIcon.image = GetPngImage(@"pricon01");
            if (LANGUAGE_CHINESE) {
                [settingCell1.labelChinese setText:@"起床时间"];
                [settingCell1.labelEnglish setText:@"Time Setting"];
            }else{
                [settingCell1.labelEG setText:@"Time Setting"];
            }
            
            if (!_user.boolMoon) {
                [settingCell1.labelDay setText:[BASE International:@"Resting"]];
            }else{
                liboTOOLS *tool = [[liboTOOLS alloc] init];
                NSString *beginString = [tool timestamp_TO_time:[_user.timeStart intValue]];
                NSString *endString = [tool timestamp_TO_time:[_user.timeStop intValue]];
                [settingCell1.labelDay setText:[NSString stringWithFormat:@"%@ - %@",beginString,endString]];
            }
            [settingCell1.labelDay setFrame:settingCell1.labelDayFrame];
        }
        //重复 网络慢的话需要自己刷新才显示更改后的
        if (indexPath.row==1) {
            settingCell1.imageViewIcon.image = GetPngImage(@"pricon02");
            if (LANGUAGE_CHINESE) {
                [settingCell1.labelChinese setText:@"重复"];
                [settingCell1.labelEnglish setText:@"Repeat"];
            }else{
                [settingCell1.labelEG setText:@"Repeat"];
            }
            
            if ([BASE isNotNull:_user.arrayRepeat]) {
                [[LocalNotification sharedLocalNotification] setRepeatWeek:_user.arrayRepeat];
                [settingCell1.labelDay setFrame:settingCell1.labelDayFrame];
                [settingCell1.labelDay setText:[[userModel sharedUserModel] getUserInformationWithKey:@"week"]];
            }

        }
      
        settingCell1.button.tag = indexPath.row;
        settingCell1.delegate = self;
        settingCell1.selectionStyle = UITableViewCellSelectionStyleNone;
        settingCell1.backgroundColor = [UIColor clearColor];
        return settingCell1;
    }
    
    //section2
    if (indexPath.section==2) {
        static NSString *settingCell1Identify = @"settingCell1Identify";
        lowooSettingCell1 *settingCell1 = [tableView dequeueReusableCellWithIdentifier:settingCell1Identify];
        
        if (!settingCell1) {
            settingCell1 = [[lowooSettingCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell1Identify];
        }

        //被叫醒天数
        if (indexPath.row==0) {
            settingCell1.imageViewIcon.image = GetPngImage(@"pricon03");
            if (LANGUAGE_CHINESE) {
                [settingCell1.labelChinese setText:@"被叫醒天数"];
                [settingCell1.labelEnglish setText:@"Days of being wakened"];
                if (_user.getupTimes != 0) {
                    [settingCell1.labelDay setText:[NSString stringWithFormat:@"%d 天",_user.getupTimes]];
                }else{
                    [settingCell1.labelDay setText:@"0 天"];
                }
            }else{
                [settingCell1.labelEG setText:@"Days of being wakened"];
                if (_user.getupTimes != 0) {
                     [settingCell1.labelDay setText:[NSString stringWithFormat:@"%dD",_user.getupTimes]];
                }else{
                    [settingCell1.labelDay setText:@"0D"];
                }
            }
        }
        //懒床天数
        if (indexPath.row==1) {
            settingCell1.imageViewIcon.image = GetPngImage(@"pricon04");
            if (LANGUAGE_CHINESE) {
                [settingCell1.labelChinese setText:@"赖床天数"];
                [settingCell1.labelEnglish setText:@"Days of staying in bed"];
                if (_user.lazyTimes != 0) {
                    [settingCell1.labelDay setText:[NSString stringWithFormat:@"%d天",_user.lazyTimes]];
                }else{
                    [settingCell1.labelDay setText:@"0天"];
                }
            }else{
                if (_user.lazyTimes != 0) {
                    [settingCell1.labelDay setText:[NSString stringWithFormat:@"%dD",_user.lazyTimes]];
                }else{
                    [settingCell1.labelDay setText:@"0D"];
                }
                [settingCell1.labelEG setText:@"Days of staying in bed"];
            }
        }
        //成功叫醒天数
        if (indexPath.row==2) {
            settingCell1.imageViewIcon.image = GetPngImage(@"pricon05");
            if (LANGUAGE_CHINESE) {
                [settingCell1.labelChinese setText:@"成功叫醒天数"];
                [settingCell1.labelEnglish setText:@"Days of wakening others successfully"];
                if (_user.callTimes != 0) {
                    [settingCell1.labelDay setText:[NSString stringWithFormat:@"%d天",_user.callTimes]];
                }else{
                    [settingCell1.labelDay setText:@"0天"];
                }
            }else{
                [settingCell1.labelEG setText:@"Days of wakening others successfully"];
                if (_user.callTimes != 0) {
                    [settingCell1.labelDay setText:[NSString stringWithFormat:@"%dD",_user.callTimes]];
                }else{
                    [settingCell1.labelDay setText:@"0D"];
                }
            }
        }
        
        [settingCell1.labelDay setFrame:settingCell1.labelDayFrameBig];
        //自己的详情页可点击
        settingCell1.backgroundColor = [UIColor clearColor];
        settingCell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return settingCell1;
    }
    
    //section3  勋章
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            settingSectionCell *sectionCell = [[settingSectionCell alloc] init];
            sectionCell.labelDay.text = [NSString stringWithFormat:@"%d/%d",_user.getMedals, _user.allMedals];
            sectionCell.button.userInteractionEnabled = NO;
            sectionCell.imageViewIcon.image = GetPngImage(@"pricon06");
            if (LANGUAGE_CHINESE) {
                [sectionCell.labelChinese setText:@"勋章"];
                [sectionCell.labelEnglish setText:@"Medals"];
            }else{
                [sectionCell.labelEG setText:@"Medals"];
            }
            sectionCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return sectionCell;
        }else{
            static NSString *settingCell2Identify = @"settingCell2Identify";
            lowooSettingCell2 *settingCell2 = [tableView dequeueReusableCellWithIdentifier:settingCell2Identify];
            if (!settingCell2) {
                settingCell2 = [[lowooSettingCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell2Identify];
            }
            
            BOOL expanded;
            if ([[_arrayExpandedIndex objectAtIndex:indexPath.row] isEqualToString:@"yes"]) {
                expanded = YES;
            }else{
                expanded = NO;
            }
            settingCell2.indexPath = indexPath;
            settingCell2.delegate = self;
            settingCell2.boolExpanded = [[_mutableArrayBoolExpanded objectAtIndex:indexPath.row] boolValue];
            [settingCell2 confirmDataWithMedal:[_user.arrayMedal objectAtIndex:indexPath.row-1] withIndex:indexPath.row Expanded:expanded];
            [settingCell2 determineTheStatus];
            settingCell2.imageviewBackground.image = [UIImage imageNamed:@"friends_details_bk2.png"];
            [settingCell2 setClipsToBounds:YES];
            [_dictionarySubItemsAmt setObject:settingCell2 forKey:indexPath];
            settingCell2.buttonMedal.tag = indexPath.row;
            settingCell2.selectionStyle = UITableViewCellSelectionStyleNone;
            return settingCell2;
        }
    }
    
    //section4   成就
    if (indexPath.section==4) {
        if (indexPath.row==0) {
            settingSectionCell *sectionCell = [[settingSectionCell alloc] init];
            sectionCell.button.userInteractionEnabled = NO;
            sectionCell.imageViewIcon.image = GetPngImage(@"pricon07");
            if (LANGUAGE_CHINESE) {
                [sectionCell.labelChinese setText:@"成就"];
                [sectionCell.labelEnglish setText:@"Achievements"];
            }else{
                [sectionCell.labelEG setText:@"Achievements"];
            }

            [sectionCell.labelDay setText:[NSString stringWithFormat:@"%d/%d",_user.getAchievements, _user.allAchievements]];

            sectionCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return sectionCell;
        }else{
            static NSString *settingCell3Identify = @"settingCell3Identify";
            lowooSettingCell3 *settingCell3 = [tableView dequeueReusableCellWithIdentifier:settingCell3Identify];
            if (!settingCell3) {
                settingCell3 = [[lowooSettingCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell3Identify];
            }
            
            settingCell3.stringtemp = [NSString stringWithFormat:@"%@",(modelAchievement *)[[_user.arrayAchievement objectAtIndex:indexPath.row-1] nameEnglish]];
            [settingCell3 confirmData:[_user.arrayAchievement objectAtIndex:indexPath.row-1]];
            
            if (indexPath.row%2==0) {
                settingCell3.imageViewBackground.image = GetPngImage(@"friends_details_bk2");
            }else{
                settingCell3.imageViewBackground.image = GetPngImage(@"friends_details_bk3");
            }

            settingCell3.selectionStyle = UITableViewCellSelectionStyleNone;
            settingCell3.viewOne.alpha = 1;
            return settingCell3;
            }
        }
    

     
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

//点击勋章
- (void)buttonMedalTouchUpInside:(UIButton_custom *)sender{
    //未获得
    if ([[_user.arrayMedal objectAtIndex:sender.tag - 1] boolGet]) {
        lowooPOPViewMedal *medal = [[lowooPOPViewMedal alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [medal confirmMedal:[_user.arrayMedal objectAtIndex:sender.tag-1]];
        [[lowooAlertViewDemo sharedAlertViewManager] show:medal];
    }else{
        lowooDidNotGetTheMedal *medal = [[lowooDidNotGetTheMedal alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [[lowooAlertViewDemo sharedAlertViewManager] show:medal];
    }
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 6.0f;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                return 88;
            }else{
                return 38;
            }
            break;
        case 1:
            return 53;
            break;
        case 2:
            return 53;
            break;
        case 3:
            if (indexPath.row==0) {
                return 40;
                break;
            }
            if (_arrayExpandedIndex) {
                if ([[_arrayExpandedIndex objectAtIndex:indexPath.row] isEqualToString:@"yes"]) {
//                    return 124;
                    if (indexPath.row == 1) {
                        return 120;
                    }
                    return 184;
                    break;
                }
            }
            return 53.5;
            break;
        case 4:
            if (indexPath.row==0) {
                return 40;
                break;
            }
            return 53;
            break;
        default:
            break;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}


#pragma mark -----UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==4&&indexPath.row!=0) {
        if ([[(modelAchievement *)[_user.arrayAchievement objectAtIndex:indexPath.row-1] timeGet] intValue] !=0) {
            lowooPOPViewAchievements *viewAchievement = [[lowooPOPViewAchievements alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [viewAchievement confirmData:[_user.arrayAchievement objectAtIndex:indexPath.row-1]];
            [[lowooAlertViewDemo sharedAlertViewManager] show:viewAchievement];
        }else{
            lowooDidNotGetTheAchievement *notAchievement = [[lowooDidNotGetTheAchievement alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [[lowooAlertViewDemo sharedAlertViewManager] show:notAchievement];
        }
    }
}

- (double )dateToTimestamp:(NSInteger )hour minute:(NSInteger )minute{
    NSDate *date = [NSDate date];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    [components setHour:hour];
    [components setMinute:minute];
    
    NSDate *newData = [calendar dateFromComponents:components];
    double string = (long)[newData timeIntervalSince1970];
    return string;
}

#pragma mark----------------lowooSettingCell1Delegate--------------
- (void)settingCell1ButtonTouchUpInsideWithTag:(NSInteger)tag{
    if (self.boolPush) {
        return;
    }
    [self setBoolPushYES];
    _boolReloadCell = YES;
    if (tag==0) {
        _indexPathReload = [NSIndexPath indexPathForItem:0 inSection:1];
        lowooTimeSet *timeSet = [[lowooTimeSet alloc]init];
        [self.navigationController pushViewController:timeSet animated:YES];
        //时区转换
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
        NSInteger start = [_user.timeStart intValue] - timeZone.secondsFromGMT + localTimeZone.secondsFromGMT;
        NSInteger stop = [_user.timeStop intValue] - timeZone.secondsFromGMT + localTimeZone.secondsFromGMT;
        if (start<0) {
            start = start + 86400;
        }
        if (stop<0) {
            stop = stop + 86400;
        }
        [timeSet confirmDateWithStart:start Stop:stop];
    }
    else if (tag==1) {
        [self setBoolPushYES];
        lowooRepeat *repeatVC = [[lowooRepeat alloc]init];
        _indexPathReload = [NSIndexPath indexPathForItem:1 inSection:1];
        [self.navigationController pushViewController:repeatVC animated:YES];
    }
}

//点击显示大头像
- (void)imageHeadTaped:(UIImage *)image{
    BigImage *bigImage = [[BigImage alloc] init];
    bigImage.delegate = self;
    if (image) {
        NSString *small = _user.avatarUrl;
        NSInteger length = [small length];
        NSRange range = NSMakeRange(length-12,12);
        NSString *big = [small stringByReplacingCharactersInRange:range withString:@""];
        [bigImage showImageWithUrlstring:big];
    }else{
        [bigImage showDefaultImage];
    }
}

- (void)removeBigImage:(UIView *)view{
    [view removeFromSuperview];
    view = nil;
}

//展开和收拢
- (void)rotateWithIndexPath:(NSIndexPath *)indexPath{
    [self.tableView beginUpdates];
    
    UITableView *tableView = self.tableView;
    if (!_arrayExpandedIndex) {
        _arrayExpandedIndex = [[NSMutableArray alloc] init];
        for (int i=0; i<_user.arrayMedal.count; i++) {
            [_arrayExpandedIndex insertObject:@"no" atIndex:i];
        }
    }
    if ([[_arrayExpandedIndex objectAtIndex:indexPath.row] isEqualToString:@"no"]) {
        [_arrayExpandedIndex replaceObjectAtIndex:indexPath.row withObject:@"yes"];
    }else{
        [_arrayExpandedIndex replaceObjectAtIndex:indexPath.row withObject:@"no"];
    }
    
    if ([[_arrayExpandedIndex objectAtIndex:indexPath.row] isEqualToString:@"yes"]) {
        NSInteger heightMove = -(tableView.contentOffset.y-(indexPath.row-indexPath.row)*53-56);
        if (heightMove<0) {
            heightMove = 0;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint point = CGPointMake(self.tableView.contentOffset.x, self.tableView.contentOffset.y + heightMove);
            self.tableView.contentOffset = point;
        } completion:^(BOOL finished) {
            
        }];
    }
    [self.tableView endUpdates];
}

#pragma mark-----------lowooHeadCellDelegate-------------
-(void)buttonEditDidTouchedUpInside{
    if (self.boolPush) {
        return;
    }
    [self setBoolPushYES];
    _indexPathReload = [NSIndexPath indexPathForItem:0 inSection:0];
    lowooChangeOfPersonalInformationVC *changeOfPersonalInformationVC = [[lowooChangeOfPersonalInformationVC alloc] init];
    changeOfPersonalInformationVC.delegate = self;
    [changeOfPersonalInformationVC initView];
    [changeOfPersonalInformationVC confirmUser:_user];
    changeOfPersonalInformationVC.textFieldNikeName.text = [[userModel sharedUserModel] getUserInformationWithKey:USER_NAME];
    [self.navigationController pushViewController:changeOfPersonalInformationVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.slimeView) {
        [self.slimeView scrollViewDidScroll];
    }
}

#pragma mark ------------- lowooChangeOfPersonalInformationVCDelegate ------
- (void)didChangePersonalInformation{
    [self updataNetworkData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
