//
//  lowooAllProps.m
//  banana_clock
//
//  Created by MAC on 13-7-11.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooAllProps.h"


#define cellWidth   54
#define cellHeight  67
#define sectionHeiht 75
#define imageviewY   25

@interface lowooAllProps ()
@property (nonatomic, assign) double height1;
@property (nonatomic, assign) double height2;
@property (nonatomic, assign) double height3;
@property (nonatomic, assign) double height4;
@end

@implementation lowooAllProps

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
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
    self.stringTitle = @"PROPS SHOP";
    [self changeTitle];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.navigationController.viewControllers.count == 0) {
        if ([_delegate respondsToSelector:@selector(viewDismiss:)]) {
            [_delegate viewDismiss:self];
        }
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdataNetWorkDate:) name:@"getUserPropsInfo" object:nil];
        
        
        _mutableArray1 = [[NSMutableArray alloc] init];
        _mutableArray2 = [[NSMutableArray alloc] init];
        _mutableArray3 = [[NSMutableArray alloc] init];
        _mutableArray4 = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    CGRect frame = self.tableView.frame;
    frame.origin.y = frame.origin.y - 40;
    frame.size.height = frame.size.height + 40;
    self.tableView.frame = frame;

}

- (void)updataNetworkData{
    //查看更新道具图片
    //[[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:gettools];
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:userpropsinfo];
}

- (void)didUpdataNetWorkDate:(NSNotification *)sender{
    [self.slimeView endRefresh];
    [self initPropsGroup];
}

- (void)initView{
    [self.slimeView endRefresh];
    [self initArray];
    [self initPropsGroup];
}

- (void)initArray{
    [_mutableArray1 removeAllObjects];
    [_mutableArray2 removeAllObjects];
    [_mutableArray3 removeAllObjects];
    [_mutableArray4 removeAllObjects];
    NSDictionary *propsCache = [[userModel sharedUserModel] getCache:@"userpropsinfo"];
    NSArray *array = [[lowooHTTPManager getInstance] propModel:propsCache];
    _arrayProps = [NSArray arrayWithArray:array];

    for (int i=0; i<_arrayProps.count; i++) {
        modelProp *prop = [_arrayProps objectAtIndex:i];
        if ([prop.term intValue]==0) {
            
        }
        else if ([prop.term intValue]==1) {
            [_mutableArray1 addObject:prop];
        }
        else if ([prop.term intValue]==2) {
            [_mutableArray2 addObject:prop];
        }
        else if ([prop.term intValue]==3) {
            [_mutableArray3 addObject:prop];
        }
        else if ([prop.term intValue]==4) {
            [_mutableArray4 addObject:prop];
        }
    }
}

- (void)initPropsGroup{
//    dispatch_queue_t myqueue = dispatch_queue_create("new queue", NULL);
//    dispatch_async(myqueue, ^{
//        [self dispatchInitProps];
//        dispatch_group_t group = dispatch_group_create();
//        dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
//            if ([_delegate respondsToSelector:@selector(allPropsViewDidLoad:)]) {
//                [_delegate allPropsViewDidLoad:self];
//            }
//        });
//    });
    //[NSThread detachNewThreadSelector:@selector(dispatchInitProps) toTarget:self withObject:nil];
    [self dispatchInitProps];
}

- (void)dispatchInitProps{
    [self initArray];
    if (!_viewBase) {
        _viewBase = [[UIView alloc] initWithFrame:CGRectMake(0, -4, 320, SCREEN_HEIGHT-110)];
        
        
        _height1 = ceil(((double)_mutableArray1.count)/5);
        _height2 = ceil(((double)_mutableArray2.count)/5);
        _height3 = ceil(((double)_mutableArray3.count)/5);
        _height4 = ceil(((double)_mutableArray4.count)/5);
        
        //总高
        _viewHeight = sectionHeiht*4+cellHeight*(_height1+_height2+_height3+_height4);
        if (iPhone5_0||iPhone5) {
            
        }else{
            _viewHeight +=30;
        }
        CGRect frame = _viewBase.frame;
        frame.size.height = _viewHeight;
        _viewBase.frame = frame;
        [self.tableView reloadData];
        
        //图片表头
        _ButtonSectiona1 = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_ButtonSectiona1 setFrame:CGRectMake(12, imageviewY, 160, 50)];
        NSString *name = [BASE International:@"CTiticon_cn_04"];
        [_ButtonSectiona1 setImage:GetPngImage(name) forState:UIControlStateNormal];
        [_ButtonSectiona1 setImage:GetPngImage(name) forState:UIControlEventTouchDown];
        _ButtonSectiona1.tag = 1;
        [_ButtonSectiona1 addTarget:self action:@selector(sectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_viewBase addSubview:_ButtonSectiona1];
        
        UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, sectionHeiht+_height1*cellHeight, 250, 25)];
        imageview1.image = GetPngImage(@"light01");
        [_viewBase addSubview:imageview1];
        
        _ButtonSectiona2 = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_ButtonSectiona2 setFrame:CGRectMake(12, imageviewY+sectionHeiht+_height1*cellHeight, 160, 50)];
        NSString *name1 = [BASE International:@"CTiticon_cn_05"];
        [_ButtonSectiona2 setImage:GetPngImage(name1) forState:UIControlStateNormal];
        [_ButtonSectiona2 setImage:GetPngImage(name1) forState:UIControlEventTouchDown];
        _ButtonSectiona2.tag = 2;
        [_ButtonSectiona2 addTarget:self action:@selector(sectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_viewBase addSubview:_ButtonSectiona2];
        
        UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, sectionHeiht*2+(_height1+_height2)*cellHeight, 250, 25)];
        imageview2.image = GetPngImage(@"light01");
        [_viewBase addSubview:imageview2];
        
        _ButtonSectiona3 = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_ButtonSectiona3 setFrame:CGRectMake(12, imageviewY+sectionHeiht*2+(_height2+_height1)*cellHeight, 160, 50)];
        NSString *name2 = [BASE International:@"CTiticon_cn_06"];
        [_ButtonSectiona3 setImage:GetPngImage(name2) forState:UIControlStateNormal];
        [_ButtonSectiona3 setImage:GetPngImage(name2) forState:UIControlEventTouchDown];
        _ButtonSectiona3.tag = 3;
        [_ButtonSectiona3 addTarget:self action:@selector(sectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_viewBase addSubview:_ButtonSectiona3];
        
        
        UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(30, sectionHeiht*3+(_height1+_height2+_height3)*cellHeight, 250, 25)];
        imageview3.image = GetPngImage(@"light01");
        [_viewBase addSubview:imageview3];
        
        _ButtonSectiona4 = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [_ButtonSectiona4 setFrame:CGRectMake(12, imageviewY+sectionHeiht*3+(_height1+_height2+_height3)*cellHeight, 160, 50)];
        NSString *name3 = [BASE International:@"CTiticon_cn_07"];
        [_ButtonSectiona4 setImage:GetPngImage(name3) forState:UIControlStateNormal];
        [_ButtonSectiona4 setImage:GetPngImage(name3) forState:UIControlEventTouchDown];
        _ButtonSectiona4.tag = 4;
        [_ButtonSectiona4 addTarget:self action:@selector(sectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_viewBase addSubview:_ButtonSectiona4];
    }
    
    [self initSingleCell];
}

- (void)initSingleCell{
    if (!_arrayProps) {
        return;//切换账号后断网可导致nil
    }
    for (int i=0; i<[_arrayProps count]-1; i++) {
        [self performSelector:@selector(initSingleCellWithIndex:) withObject:[NSNumber numberWithInteger:i] afterDelay:0.01*i];
        //[self initSingleCellWithIndex:[NSNumber numberWithInt:i]];
    }
}

- (void)initSingleCellWithIndex:(NSNumber *)number{
    int count = [number intValue];
    if (!_arrayCells) {
        _arrayCells = [[NSMutableArray alloc] init];
    }
    propBuyCell *cell;
    @try {
        if ([_arrayCells objectAtIndex:count]) {
            cell = (propBuyCell *)[_arrayCells objectAtIndex:count];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

    //普通道具
    if (count < _mutableArray1.count) {
        int i = count;
        if (!cell) {
            cell = [[propBuyCell alloc] initWithFrame:CGRectMake(cellWidth*(i%5)+(i%5)*5+15, sectionHeiht*1+i/5*cellHeight, cellWidth, cellHeight)];
            [_arrayCells insertObject:cell atIndex:count];
            cell.delegate = self;
            modelProp  *prop = [_mutableArray1 objectAtIndex:i];
            cell.button.tag = prop.propID;
            [_viewBase addSubview:cell];
        }
        if (count<[[[userModel sharedUserModel] myNumber] intValue]) {
            modelProp *prop = [_mutableArray1 objectAtIndex:i];
            [cell confirmProp:prop];
            [cell initNumber:[NSString stringWithFormat:@"%d",prop.number]];
            [cell initPrice:[NSString stringWithFormat:@"%d",prop.propPrice]];
        }else{
            [cell setDefault];
        }
        
    }
    //抗盾道具
    else if (count < _mutableArray1.count + _mutableArray2.count){
        int i = count-_mutableArray1.count;
        if (!cell) {
            cell = [[propBuyCell alloc] initWithFrame:CGRectMake(cellWidth*(i%5)+(i%5)*5+15, sectionHeiht*2+_height1*cellHeight+i/5*cellHeight, cellWidth, cellHeight)];
            [_arrayCells insertObject:cell atIndex:count];
            cell.delegate = self;
            cell.button.tag = [(modelProp *)[_mutableArray2 objectAtIndex:i] propID];
            [_viewBase addSubview:cell];
        }
        
        if (count<[[[userModel sharedUserModel] myNumber] intValue]) {
            modelProp *prop = [_mutableArray2 objectAtIndex:i];
            [cell confirmProp:prop];
            [cell initNumber:[NSString stringWithFormat:@"%d",prop.number]];
            [cell initPrice:[NSString stringWithFormat:@"%d",prop.propPrice]];
        }else{
            [cell setDefault];
        }
        
    }
    //加金币道具
    else if (count < _mutableArray1.count + _mutableArray2.count +_mutableArray3.count){
        int i = count - _mutableArray1.count - _mutableArray2.count;
        if (!cell) {
            cell = [[propBuyCell alloc] initWithFrame:CGRectMake(cellWidth*(i%5)+(i%5)*5+15, sectionHeiht*3+_height1*cellHeight+_height2*cellHeight+i/5*cellHeight, cellWidth, cellHeight)];
            [_arrayCells insertObject:cell atIndex:count];
            cell.delegate = self;
            cell.button.tag = [(modelProp *)[_mutableArray3 objectAtIndex:i] propID];
            [_viewBase addSubview:cell];
        }
        
        if (count<[[[userModel sharedUserModel] myNumber] intValue]) {
            modelProp *prop = [_mutableArray3 objectAtIndex:i];
            [cell confirmProp:prop];
            [cell initNumber:[NSString stringWithFormat:@"%d",prop.number]];
            [cell initPrice:[NSString stringWithFormat:@"%d",prop.propPrice]];
        }else{
            [cell setDefault];
        }
        
    }
    //抢金币道具
    else if (count < _mutableArray1.count + _mutableArray2.count +_mutableArray3.count + _mutableArray4.count){
        int i = count - _mutableArray1.count - _mutableArray2.count - _mutableArray3.count;
        if (!cell) {
            cell = [[propBuyCell alloc] initWithFrame:CGRectMake(cellWidth*(i%5)+(i%5)*5+15, sectionHeiht*4+_height1*cellHeight+_height2*cellHeight+_height3*cellHeight+i/5*cellHeight, cellWidth, cellHeight)];
            [_arrayCells insertObject:cell atIndex:count];
            cell.delegate = self;
            cell.button.tag = [(modelProp *)[_mutableArray4 objectAtIndex:i] propID];
            [_viewBase addSubview:cell];
        }
        
        if (count<[[[userModel sharedUserModel] myNumber] intValue]) {
            modelProp *prop = [_mutableArray4 objectAtIndex:i];
            [cell confirmProp:prop];
            [cell initNumber:[NSString stringWithFormat:@"%d",prop.number]];
            [cell initPrice:[NSString stringWithFormat:@"%d",prop.propPrice]];
        }else{
            [cell setDefault];
        }
    }

    if ([number intValue] == [_arrayProps count]-2) {
        if ([_dataSource respondsToSelector:@selector(viewLoaded:)]) {
            [_dataSource viewLoaded:self];
        }
    }
}



#pragma mark----------- propBuyCellDelegate -------------
- (void)collectionViewCellTouch:(UIButton_custom *)sender{
    if (self.boolPush) {
        return;
    }
    [self setBoolPushYES];
    lowooPropsDetail *propsDetail = [[lowooPropsDetail alloc]init];
    for (modelProp *prop in _arrayProps) {
        if (prop.propID == sender.tag) {
            propsDetail.prop = prop;
            break;
        }
    }
    [self.navigationController pushViewController:propsDetail animated:YES];
}


#pragma mark----------UITableViewDataSource------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (void)sectionButtonAction:(UIButton_custom *)sender{
    lowooPOPPropKind *propKind = [[lowooPOPPropKind alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [propKind confirmDataWithTag:sender.tag];
    [[lowooAlertViewDemo sharedAlertViewManager] show:propKind];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell_custom *cell = [[UITableViewCell_custom alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identify"];
    [cell addSubview:_viewBase];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark----------UITableViewDelegate-------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _viewHeight;
}

- (void)rightButtonTouchUpInside{
    lowooPropsBuy *propBuy = [[lowooPropsBuy alloc]init];
    [self.navigationController pushViewController:propBuy animated:YES];
}


@end
