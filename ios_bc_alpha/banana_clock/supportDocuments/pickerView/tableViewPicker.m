//
//  tableViewPicker.m
//  time
//
//  Created by MAC on 14-1-25.
//  Copyright (c) 2014年 MAC. All rights reserved.
//

#import "tableViewPicker.h"
#import "pickerCell.h"

@implementation tableViewPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundView.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
        _currentY = 0;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellNumber+4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    pickerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[pickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.cellSize = _cellSize;
        [cell initView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row>1 && indexPath.row <_cellNumber+2) {
        cell.label.text = [NSString stringWithFormat:@"%d",indexPath.row-2];
    }else{
        cell.label.text = @"";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellSize.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>1 && indexPath.row<_cellNumber+2) {
        [self setContentOffset:CGPointMake(0, _cellSize.height*(indexPath.row-2)) animated:YES];
        if (abs(_currentPage - indexPath.row)==1) {
            [self music];
        }else if (abs(_currentPage - indexPath.row)==2){
            [self music];
            [self performSelector:@selector(music) withObject:nil afterDelay:0.1];
        }
        _currentPage = indexPath.row;
        [self selectAtRow];
    }
}

- (void)setStopNO{
    _boolStop = NO;
}

- (void)setSelectRow:(NSInteger)row{
    [self setContentOffset:CGPointMake(0, _cellSize.height*(row)) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_boolStop) {
        if (abs(_currentY-scrollView.contentOffset.y)>=_cellSize.height) {
            _currentY = scrollView.contentOffset.y;
            [self music];
            _currentPage = ceil(scrollView.contentOffset.y/_cellSize.height)+2;
            [self selectAtRow];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _boolStop = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _boolStop = NO;
    float offset = scrollView.contentOffset.y;
    int count = ceil(offset/_cellSize.height);
    float move = count*_cellSize.height - scrollView.contentOffset.y;
    if (move<_cellSize.height/2) {
        [scrollView setContentOffset:CGPointMake(0, _cellSize.height*count) animated:YES];
        if (abs(_currentY-scrollView.contentOffset.y)>=_cellSize.height/2){
            [self music];
        }
        _currentY = _cellSize.height*count;
        if (_currentPage != count) {
            _currentPage = count+2;
            [self selectAtRow];
            //[self music];
        }
    }else{
        [scrollView setContentOffset:CGPointMake(0, _cellSize.height*(count-1)) animated:YES];
        if (abs(_currentY-scrollView.contentOffset.y)>=_cellSize.height/2){
            [self music];
        }
        _currentY = _cellSize.height*(count-1);
        if (_currentPage != count-1) {
            _currentPage = count-1+2;
            [self selectAtRow];
            //[self music];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        float offset = scrollView.contentOffset.y;
        int count = ceil(offset/_cellSize.height);
        float move = count*_cellSize.height - scrollView.contentOffset.y;
        if (move<_cellSize.height/2) {
            [scrollView setContentOffset:CGPointMake(0, _cellSize.height*count) animated:YES];
            if (abs(_currentY-scrollView.contentOffset.y)>=_cellSize.height/2){
                [self music];
            }
            _currentY = _cellSize.height*count;
            if (_currentPage != count) {
                _currentPage = count+2;
                [self selectAtRow];
            }
        }else{
            [scrollView setContentOffset:CGPointMake(0, _cellSize.height*(count-1)) animated:YES];
            if (abs(_currentY-scrollView.contentOffset.y)>=_cellSize.height/2){
                [self music];
            }
            _currentY = _cellSize.height*(count-1);
            if (_currentPage != count-1) {
                _currentPage = count-1+2;
                [self selectAtRow];
              //  [self music];
            }
        }
    }
}

- (void)selectAtRow{
    if ([_pickerDataSource respondsToSelector:@selector(pickerSelectAtRow:tableViewPixker:)]) {
        [_pickerDataSource pickerSelectAtRow:_currentPage-2 tableViewPixker:self];
    }
}

- (void)music{
    [[lowooMusic sharedLowooMusic] SystemSoundID:@"time" type:@"mp3"];
}

@end
