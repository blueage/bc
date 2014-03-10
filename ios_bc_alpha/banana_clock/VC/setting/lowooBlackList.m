//
//  lowooBlackList.m
//  banana_clock
//
//  Created by MAC on 13-3-18.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBlackList.h"
#import "lowooDeleteFromeBlackListViewController.h"

@interface lowooBlackList ()

@end

@implementation lowooBlackList

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"BLACK LIST";
    [self changeTitle];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshBlackNameList:) name:@"refreshBlackNameList" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeFromBlackNameList:) name:@"removeFromBlackNameList" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (LANGUAGE_CHINESE) {
        _imageViewNo = [[UIImageView alloc] initWithFrame:CGRectMake(103, 100, 113, 50)];
        _imageViewNo.image = GetPngImage(@"Blacklist_is_empty");
    }else{
        _imageViewNo = [[UIImageView alloc] initWithFrame:CGRectMake(80, 100, 159, 50)];
        _imageViewNo.image = GetPngImage(@"Blacklist_is_emptyEnglish");
    }
    _imageViewNo.hidden = YES;
    [self.view addSubview:_imageViewNo];

    [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:refreshBlackNameList];
}

- (void)removeFromBlackNameList:(NSNotification *)sender{
    [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys: nil] requestType:refreshBlackNameList];
}

- (void)refreshBlackNameList:(NSNotification *)sender{
    self.arrayReturn = sender.object;
    if (self.arrayReturn.count>0) {
        [self.tableView reloadData];
        _imageViewNo.hidden = YES;
        self.tableView.hidden = NO;
    }else{
        _imageViewNo.hidden = NO;
        self.tableView.hidden = YES;
    }
}





#pragma mark ----UITableViewDataSource-----------
//使用搜索的array
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayReturn.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"blackCellIdentifier";
    lowooBlackCell *cell = (lowooBlackCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell = [[lowooBlackCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.button.tag = indexPath.row;
    cell.delegate = self;
    [cell confirmUser:[self.arrayReturn objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -----UITableViewDelegate----------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)blackCellButtonTouchUpInside:(UIButton_custom *)sender{
    lowooDeleteFromeBlackListViewController *deleteVC = [[lowooDeleteFromeBlackListViewController alloc] init];
    [self.navigationController pushViewController:deleteVC animated:YES];
    [deleteVC confirmUser:[self.arrayReturn objectAtIndex:sender.tag]];
}


@end
