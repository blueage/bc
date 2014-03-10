//
//  lowooProps.m
//  banana clock
//
//  Created by MAC on 12-10-29.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooProps.h"
#import "lowooAppDelegate.h"


@implementation lowooProps


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
    
    self.stringTitle = @"MY PROPS";
    [self changeTitle];
    self.viewLeftButton.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.viewLeftButton.hidden = YES;
    _boolPushAllProps = YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdataNetWorkDate:) name:@"getUserPropsInfo" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self initView];
    CGRect frame = self.tableView.frame;
    frame.origin.y = frame.origin.y + 3 - [BASE statusBarHeight];
    frame.size.height = frame.size.height -3 +[BASE statusBarHeight];
    self.tableView.frame = frame;

    [self updataNetworkData];
}

- (void)initView{
    //游戏行
    [_jungleThrowingCell removeFromSuperview];_jungleThrowingCell = nil;
    _jungleThrowingCell = [[UITableViewCell_custom alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jungle"];
    UIButton_custom *buttonOfJungleThrow = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonOfJungleThrow setFrame:CGRectMake(9, 0, 150, 58) image:[BASE International:@"dream_brokera_cn01"] image:[BASE International:@"dream_brokera_cn02"]];
    [buttonOfJungleThrow addTarget:self action:@selector(buttonOfJungleThrowDidTouchUpInside:)];
    [_jungleThrowingCell addSubview:buttonOfJungleThrow];
    
    UIImageView *imageViewMore = [[UIImageView alloc]initWithFrame:CGRectMake(161, 0, 150, 58)];
    NSString *namepng = [BASE International:@"dream_broker_moreCN"];
    imageViewMore.image = GetPngImage(namepng);
    [_jungleThrowingCell addSubview:imageViewMore];
    
    [_cellPropStore removeFromSuperview]; _cellPropStore = nil;
    _cellPropStore = [[UITableViewCell_custom alloc]initWithFrame:CGRectMake(0, 0, 320, 52)];
    UIImageView *imageViewBaseMap = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 160, 50)];
    NSString *namepng1 = [BASE International:@"CTiticon_cn_02"];
    imageViewBaseMap.image = GetPngImage(namepng1);
    UIButton_custom *buttonAllProps = [UIButton_custom buttonWithType:UIButtonTypeCustom];
    [buttonAllProps setFrame:CGRectMake(250, 7, 55, 68)];
    [buttonAllProps setImageNormal:GetPngImage([BASE International:@"CTiticon_cn_03a"])];
    [buttonAllProps setImageHighlited:GetPngImage([BASE International:@"CTiticon_cn_03b"])];
    [buttonAllProps addTarget:self action:@selector(pushallProps:)];
    [_cellPropStore addSubview:buttonAllProps];
    [_cellPropStore addSubview:imageViewBaseMap];
}

#pragma mark----------- allProps -------------
- (void)pushallProps:(UIButton_custom *)sender{
    if (!_boolPushAllProps) {
        return;
    }
    _boolPushAllProps = NO;
    [[activityView sharedActivityView] showHUD:20];
    _allProps = [[lowooAllProps alloc] init];
    [_allProps initPropsGroup];
    _allProps.delegate = self;
    _allProps.dataSource = self;
}

- (void)viewLoaded:(lowooAllProps *)viewController{
    _allProps.dataSource = nil;
    [[activityView sharedActivityView] removeHUD];
    [self.navigationController pushViewController:_allProps animated:YES];
}

- (void)viewDismiss:(lowooAllProps *)viewController{
    _allProps.delegate = nil;
    [_allProps removeFromParentViewController]; _allProps = nil;
}

#pragma mark----------- collectionView --------
- (void)initCollectionView{
    //可流动布局
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(54, 73)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 0, 0, 0);//  section 高  section 左   section 右   cell 间距
    flowLayout.headerReferenceSize = CGSizeZero;
    _collectionView = nil;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(13, -4, 294, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    [_collectionView registerClass:[propCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    _collectionView.backgroundView = nil;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.scrollEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.clipsToBounds = NO;
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayReturn.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"collectionCell";
    propCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.button.tag = indexPath.row;
    [cell confirmProp:[self.arrayReturn objectAtIndex:indexPath.row]];
    [cell initNumber:[(modelProp *)[self.arrayReturn objectAtIndex:indexPath.row] number]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark----------- propCollectionViewCellDelegate --------------
- (void)collectionViewCellTouch:(UIButton_custom *)sender{
    if (self.boolPush) {
        return;
    }
    [self setBoolPushYES];
    lowooPropsDetail *propsDetail = [[lowooPropsDetail alloc] init];
    propsDetail.prop = [self.arrayReturn objectAtIndex:sender.tag];
    [self.navigationController pushViewController:propsDetail animated:YES];
}

- (void)updataNetworkData{
    
    if (self.slimeView.broken == NO) {
        self.slimeView.broken = YES;
        self.slimeView.loading = YES;
        [self.tableView setContentOffset:CGPointMake(0, -60)];
        [self.slimeView scrollViewDidEndDraging];
    }
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:userpropsinfo];
    //查看更新道具图片
    //[[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:gettools];
}

- (void)didUpdataNetWorkDate:(NSNotification *)sender{
    [self.slimeView endRefresh];
    NSMutableArray *mutableArrayMyprops = [[NSMutableArray alloc] init];
    for (int i=0; i<[sender.object count]; i++) {
        modelProp *prop = [sender.object objectAtIndex:i];
        if (prop.number != 0) {
            [mutableArrayMyprops addObject:prop];
        }
    }
    self.arrayReturn = [NSArray arrayWithArray:mutableArrayMyprops];

    [self initCollectionView];

    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userPropsChanged" object:nil];//告知其他界面，本地道具记录的数据已经改变
}

#pragma mark----------UITableViewDataSource------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }
    //道具列表视图
    if (section==1) {
        return 1;
    }
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"lowooPropCell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            UITableViewCell_custom *cellTraining = [[UITableViewCell_custom alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cellTraining.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(9, -20+[BASE statusBarHeight], 160, 50)];
            NSString *namepng = [BASE International:@"CTiticon_cn_01"];
            imageview.image = GetPngImage(namepng);
            [cellTraining addSubview:imageview];
   
            return cellTraining;
        }
        if (indexPath.row==1) {
            _jungleThrowingCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return _jungleThrowingCell;
        }
        if (indexPath.row==2) {
            _cellPropStore.selectionStyle = UITableViewCellSelectionStyleNone;
            return _cellPropStore;
        }
    }
    
    if (indexPath.section==1) {
        UITableViewCell_custom *cell = [[UITableViewCell_custom alloc] initWithFrame:CGRectMake(5, 0, 310, 480)];
        [cell addSubview:_collectionView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark----------UITableViewDelegate-------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 30+[BASE statusBarHeight];
        }
        if (indexPath.row==1) {
            return 60;
        }
        if (indexPath.row==2) {
            return 75;
        }
    }
    if (iPhone5_0||iPhone5) {
        return ceil(((double)self.arrayReturn.count)/5.0)*73+5;//32个道具排列的高度
    }else{
        return ceil(((double)self.arrayReturn.count)/5.0)*73+35;//32个道具排列的高度
    }
}

- (void)buttonOfJungleThrowDidTouchUpInside:(UIButton_custom *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startGame" object:nil userInfo:nil];
}

- (void)rightButtonTouchUpInside{
    lowooPropsBuy *propBuy = [[lowooPropsBuy alloc]init];
    [self.navigationController pushViewController:propBuy animated:YES];
}

@end
