//
//  lowooPersonalInformation.m
//  banana_clock
//
//  Created by MAC on 13-1-10.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPersonalInformation.h"

@interface lowooPersonalInformation ()
- (void)initTableView;
@end

@implementation lowooPersonalInformation

@synthesize slimeView = _slimeView;
@synthesize reloading = _reloading,isSlimeView = _isSlimeView,myInformation = _myInformation,male = _male;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTableView];
}

- (void)initTableView{
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setBackgroundView:nil];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setSeparatorColor:[UIColor clearColor]];
    [_tableView setShowsVerticalScrollIndicator:NO];
    _slimeView = [[SRRefreshView alloc]init];
    [_slimeView setDelegate:self];
    [_slimeView setUpInset:44];
    [_tableView addSubview:_slimeView];
}

#pragma mark--------UITableViewDataSource----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]autorelease];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;   {

}

#pragma mark-------UITableViewDelegate-----------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

}

#pragma mark ----------scrollView delegate------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    _isSlimeView = YES;
    //得到网络数据后重写
    //[self doHTTP];
    [_slimeView performSelector:@selector(endRefresh)
                     withObject:nil afterDelay:3
                        inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    RELEASE_SAFELY(_slimeView);
    [_tableView release];
    [super dealloc];
}
@end
