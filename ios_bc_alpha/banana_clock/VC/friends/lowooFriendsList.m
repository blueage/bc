//
//  lowooFriendsList.m
//  banana_clock
//
//  Created by MAC on 12-12-25.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooFriendsList.h"
#import "JSONKit.h"

#define REFRESH_HEADER_HEIGHT  52.0f

@implementation lowooFriendsList


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.leftBtn.userInteractionEnabled = YES;
    self.stringTitle = @"FRIENDS TOP";
    [self changeTitle];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdataNetWorkData:) name:@"getRanking" object:nil];
    }
    return self;
}

- (void)initView{
    [_tableViewPull reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)setVC{
    _cellCount = 20;
    if (iPhone5||iPhone5_0) {
        _tableViewPull = [[UITableView_pullUpToRefresh alloc] initWithFrame:CGRectMake(0, -4, SCREEN_WIDTH, SCREEN_HEIGHT-110)];
    }else{
        _tableViewPull = [[UITableView_pullUpToRefresh alloc] initWithFrame:CGRectMake(0, -4, SCREEN_WIDTH, SCREEN_HEIGHT-105)];
    }
    _tableViewPull.backgroundColor = [UIColor clearColor];
    _tableViewPull.delegate = self;
    _tableViewPull.dataSource = self;
    [self.view addSubview:_tableViewPull];
    
    [self updataNetworkData];
    [self initFirstCell];
    self.tableViewPull.boolHasMore = NO;
}

- (void)initFirstCell{
    _cellFirst = [[UITableViewCell_custom alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFirst"];
    [_cellFirst setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 78)];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 5, 48, 51)];
    imageView.image = GetPngImage(@"top20");
    [_cellFirst addSubview:imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(79, -2, 60, 60)];
    imageView1.image = GetPngImage(@"listicon_03");
    [_cellFirst addSubview:imageView1];
    _label1 = [[THLabel alloc] initWithFrame:CGRectMake(84, 48, 45, 13)];
    [_label1 setTextAlignment:NSTextAlignmentCenter];
    [_label1 setFont:[UIFont systemFontOfSize:8]];
    [_label1 setBackgroundColor:[UIColor clearColor]];
    [_label1 setTextColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];

    [_label1 setStrokeColor:[UIColor whiteColor]];
    [_label1 setStrokeSize:1.5f];
    
    [_label1 setShadowColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];
    [_label1 setShadowOffset:CGSizeMake(0, 0)];
    [_label1 setShadowBlur:2];
    
    
    [_cellFirst addSubview:_label1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(156, -2, 60, 60)];
    imageView2.image = GetPngImage(@"listicon_02");
    [_cellFirst addSubview:imageView2];
    _label2 = [[THLabel alloc] initWithFrame:CGRectMake(164, 48, 45, 13)];
    [_label2 setTextAlignment:NSTextAlignmentCenter];
    [_label2 setFont:[UIFont systemFontOfSize:8]];
    [_label2 setBackgroundColor:[UIColor clearColor]];
    [_label2 setTextColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];

    [_label2 setStrokeColor:[UIColor whiteColor]];
    [_label2 setStrokeSize:1.5f];
    
    [_label2 setShadowColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];
    [_label2 setShadowOffset:CGSizeMake(0, 0)];
    [_label2 setShadowBlur:2];
    
    
    [_cellFirst addSubview:_label2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(234, -2, 60, 60)];
    imageView3.image = GetPngImage(@"listicon_01");
    [_cellFirst addSubview:imageView3];
    _label3 = [[THLabel alloc] initWithFrame:CGRectMake(243, 48, 45, 13)];
    [_label3 setTextAlignment:NSTextAlignmentCenter];
    [_label3 setFont:[UIFont systemFontOfSize:8]];
    [_label3 setBackgroundColor:[UIColor clearColor]];
    [_label3 setTextColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];

    [_label3 setStrokeColor:[UIColor whiteColor]];
    [_label3 setStrokeSize:1.5f];
    
    [_label3 setShadowColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:0.7]];
    [_label3 setShadowOffset:CGSizeMake(0, 0)];
    [_label3 setShadowBlur:2];
    
    
    [_cellFirst addSubview:_label3];
    
    if (LANGUAGE_CHINESE) {
        _label1.text = @"起床榜";
        _label2.text = @"赖床榜";
        _label3.text = @"叫醒榜";
    }else{
        _label1.text = @"Getup";
        _label2.text = @"Lazy";
        _label3.text = @"Call";
    }
    
}

- (void)updataNetworkData{
    [[lowooHTTPManager getInstance] doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:ranking];
}

- (void)didUpdataNetWorkData:(NSNotification *)sender{
    _notificationSender = sender;
    NSDictionary *dict = sender.object;
    _arrayCall = [dict objectForKey:@"call"];
    _arrayUp = [dict objectForKey:@"getup"];
    _arrayLazy = [dict objectForKey:@"lazy"];
    if (_arrayUp!=nil&&_arrayLazy!=nil&&_arrayCall!=nil) {
        [_tableViewPull reloadData];
    }
}

- (void)refresh{
//    _cellCount += 20;
//    [_tableViewPull reloadData];
//    [_tableViewPull stopLoading];
}

#pragma mark ----UITableViewDataSource-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_arrayCall==nil) {
        return 1;
    }else{
        if (_cellCount<_arrayCall.count) {
            if (_arrayCall.count>20) {
                return 21;
            }
            return _cellCount+1;
        }
        _tableViewPull.labelRefresh.text = _tableViewPull.stringNoMore;
        _tableViewPull.boolHasMore = NO;
        return _arrayCall.count +1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"lowooListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.row == 0) {
        _cellFirst.selectionStyle = UITableViewCellSelectionStyleNone;
        _cellFirst.selectionStyle = UITableViewCellSelectionStyleNone;
        return _cellFirst;
    }else{
        if (cell==nil) {
            lowooFriendsListCell *listCell = [[lowooFriendsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            [listCell confirmUserGetup:[_arrayUp objectAtIndex:indexPath.row-1] UserLazy:[_arrayLazy objectAtIndex:indexPath.row-1] UserCall:[_arrayCall objectAtIndex:indexPath.row-1]];
            [listCell setListNumber:indexPath.row];
            cell = listCell;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            lowooFriendsListCell *listCell = (lowooFriendsListCell *)cell;
            [listCell confirmUserGetup:[_arrayUp objectAtIndex:indexPath.row-1] UserLazy:[_arrayLazy objectAtIndex:indexPath.row-1] UserCall:[_arrayCall objectAtIndex:indexPath.row-1]];
            [listCell setListNumber:indexPath.row];
        }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    aview.backgroundColor = [UIColor clearColor];
    return aview;
}

#pragma mark -----UITableViewDelegate----------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_tableViewPull.boolLoading) return;
    _tableViewPull.boolDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_tableViewPull.boolLoading && scrollView.contentOffset.y > 0) {
        // Update the content inset, good for section headers
        _tableViewPull.contentInset = UIEdgeInsetsMake(0, 0, REFRESH_HEADER_HEIGHT, 0);
    }else if(!_tableViewPull.boolHasMore){
        _tableViewPull.labelRefresh.text = _tableViewPull.stringNoMore;
        _tableViewPull.imageViewArrow.hidden = YES;
    }else if (_tableViewPull.boolDragging && scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= 0 ) {
        // Update the arrow direction and label
        [UIView beginAnimations:nil context:NULL];
        _tableViewPull.imageViewArrow.hidden = NO;
        if (scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= -REFRESH_HEADER_HEIGHT) {
            // User is scrolling above the header
            _tableViewPull.labelRefresh.text = _tableViewPull.stringRelease;
            [_tableViewPull.imageViewArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        } else { // User is scrolling somewhere within the header
            _tableViewPull.labelRefresh.text = _tableViewPull.stringPull;
            [_tableViewPull.imageViewArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
        }
        [UIView commitAnimations];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_tableViewPull.boolLoading || !_tableViewPull.boolHasMore) return;
    _tableViewPull.boolDragging = NO;
    //上拉刷新
    if(scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= -REFRESH_HEADER_HEIGHT && scrollView.contentOffset.y > 0){
        [self startLoading];
    }
}

- (void)startLoading {
    _tableViewPull.boolLoading = YES;
    
    // Show the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _tableViewPull.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
    _tableViewPull.labelRefresh.text = _tableViewPull.stringLoading;
    _tableViewPull.imageViewArrow.hidden = YES;
    [_tableViewPull.activityRefresh startAnimating];
    [UIView commitAnimations];
    
    [self refresh];

}

#pragma mark-------leftBtnPressed-------------
- (void)leftButtonDidTouchedUpInside{
    self.leftBtn.userInteractionEnabled = NO;
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.tableViewPull removeFromSuperview];
    self.tableViewPull = nil;
}

@end
