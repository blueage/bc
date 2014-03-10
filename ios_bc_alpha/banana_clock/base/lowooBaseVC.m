//
//  lowooBaseVC.m
//  banana clock
//
//  Created by MAC on 12-10-20.
//  Copyright (c) 2012年 MAC. All rights reserved.
//

#import "lowooBaseVC.h"


@implementation lowooBaseVC


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
    [self initRefreshTableView];
}

#pragma mark----------- 带下拉刷新的 UITableview ---------
- (void)initRefreshTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -15, 320, SCREEN_HEIGHT-100) style:UITableViewStylePlain];
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _slimeView = [[SRRefreshView alloc]init];
    _slimeView.delegate = self;
    _slimeView.upInset = 44;
    [_tableView setScrollsToTop:YES];

    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView addSubview:_slimeView];
}

#pragma mark----------- UITableViewDataSource --------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    return cell;
}

#pragma mark----------- scrollView delegate ------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_slimeView) {
        [_slimeView scrollViewDidScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_slimeView) {
        [_slimeView scrollViewDidEndDraging];
    }
}

#pragma mark----------- slimeRefresh delegate ----------------
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self updataNetworkData];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return YES;
}

- (void)leftButtonDidTouchedUpInside{
    if (self.navigationController.viewControllers.count > 1) {
//        [self.tableView removeFromSuperview];
//        self.tableView = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dealloc{
    [_slimeView removeFromSuperview];
    _slimeView = nil;
}

@end
