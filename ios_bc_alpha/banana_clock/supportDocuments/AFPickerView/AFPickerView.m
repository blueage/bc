//
//  AFPickerView.m
//  PickerView
//
//  Created by Fraerman Arkady on 24.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AFPickerView.h"

@implementation AFPickerView

#pragma mark - Synthesization

@synthesize dataSource;
@synthesize delegate;
@synthesize selectedRow = currentRow;
@synthesize rowFont = _rowFont;
@synthesize rowIndent = _rowIndent;




#pragma mark - Custom getters/setters
//点击某行，即选中某行
- (void)setSelectedRow:(int)selectedRow
{
    _boolMusic = NO;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    
    if (selectedRow >= rowsCount)
        return;
    
    currentRow = selectedRow;
    [contentView setContentOffset:CGPointMake(0.0, width * currentRow) animated:YES];
    
    _boolMusic = YES;
    //_timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(setBoolMusic:) userInfo:nil repeats:NO];
}

- (void)setBoolMusic:(BOOL)boolMusic{
    _boolMusic = YES;
}


- (void)setRowFont:(UIFont *)rowFont
{
    _rowFont = rowFont;
    
    for (UILabel *aLabel in visibleViews) 
    {
        aLabel.font = _rowFont;
    }
    
    for (UILabel *aLabel in recycledViews) 
    {
        aLabel.font = _rowFont;
    }
    
}




- (void)setRowIndent:(CGFloat)rowIndent
{
    _rowIndent = rowIndent;
    
    for (UILabel *aLabel in visibleViews) 
    {
        
        CGRect frame = aLabel.frame;
        frame.origin.x = _rowIndent;
        frame.size.width = self.frame.size.width - _rowIndent;
        aLabel.frame = frame;
    }
    
    for (UILabel *aLabel in recycledViews) 
    {
        CGRect frame = aLabel.frame;
        frame.origin.x = _rowIndent;
        frame.size.width = self.frame.size.width - _rowIndent;
        aLabel.frame = frame;
    }
}




#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {


        // setup
        [self setup];
        
        // backgound
//        UIImageView *bacground = [[UIImageView alloc] initWithImage:GetPngImage(PICKER_BACKGROUND)];
//        [self addSubview:bacground];
       // [bacground release];
        
        // content
        contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        contentView.showsHorizontalScrollIndicator = NO;
        contentView.showsVerticalScrollIndicator = NO;
        contentView.delegate = self;
        [self addSubview:contentView];
        
        tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [contentView addGestureRecognizer:tapRecognizer];
        
        
        // shadows
//        UIImageView *shadows = [[UIImageView alloc] initWithImage:GetPngImage(PICKER_SHADOWS)];
//        [self addSubview:shadows];
      //  [shadows release];
        
        // glass
//        UIImage *glassImage = GetPngImage(PICKER_GLASS);
//        glassImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 76.0, glassImage.size.width, glassImage.size.height)];
//        glassImageView.image = glassImage;
//        [self addSubview:glassImageView];
       // [glassImageView release];
        
        _currentPage = 0;
    }
    return self;
}




- (void)setup
{
    //_rowFont = [UIFont boldSystemFontOfSize:24.0];
    //_rowFont = [UIFont systemFontOfSize:24.0];
    _rowFont = [UIFont fontWithName:@"Helvetica" size:20.0];
    _rowFont = [UIFont boldSystemFontOfSize:20.0];
    _rowIndent = 30.0;
    currentRow = 0;
    rowsCount = 0;
    visibleViews = [[NSMutableSet alloc] init];
    recycledViews = [[NSMutableSet alloc] init];
}




#pragma mark - Buisness

- (void)reloadData
{
    width = [dataSource floatOfWidth];
    fromToTop = width*2;
    // empry views
    currentRow = 0;
    rowsCount = 0;
    
    for (UIView *aView in visibleViews) 
        [aView removeFromSuperview];
    
    for (UIView *aView in recycledViews)
        [aView removeFromSuperview];
    
    visibleViews = [[NSMutableSet alloc] init];
    recycledViews = [[NSMutableSet alloc] init];
    
    rowsCount = [dataSource numberOfRowsInPickerView:self];
    [contentView setContentOffset:CGPointMake(0.0, 0.0) animated:NO];
    contentView.contentSize = CGSizeMake(contentView.frame.size.width, width * rowsCount + 4 * width);
    //contentView.contentSize = CGSizeMake(contentView.frame.size.width, width * rowsCount*3);
    [self tileViews];
}




- (void)determineCurrentRow
{
    CGFloat delta = contentView.contentOffset.y;
    int position = round(delta / width);
    currentRow = position;
    [contentView setContentOffset:CGPointMake(0.0, width * position) animated:YES];
    [delegate pickerView:self didSelectRow:currentRow];
}




- (void)didTap:(id)sender
{
    tapRecognizer1 = (UITapGestureRecognizer *)sender;
    CGPoint point = [tapRecognizer1 locationInView:self];
    int steps = floor(point.y / width) - fromToTop/width;//返回小于或者等于指定表达式的最大整数    第几个被点击，初始前2个无数据
    [self makeSteps:steps];
}




- (void)makeSteps:(int)steps
{
    if (steps == 0 || steps > fromToTop/width || steps < -fromToTop/width)//点击当前行，或超出控件范围
        return;
    
    [contentView setContentOffset:CGPointMake(0.0, width * currentRow) animated:NO];
    
    int newRow = currentRow + steps;
    if (newRow < 0 || newRow >= rowsCount)//超出边界
    {
        if (steps == -2)
            [self makeSteps:-1];
        else if (steps == 2)
            [self makeSteps:1];
        
        return;
    }
    
    currentRow = currentRow + steps;
    [contentView setContentOffset:CGPointMake(0.0, width * currentRow) animated:YES];
    [delegate pickerView:self didSelectRow:currentRow];
}




#pragma mark - recycle queue

- (UIView *)dequeueRecycledView
{
	UIView *aView = [recycledViews anyObject];
	
    if (aView) 
        [recycledViews removeObject:aView];
    return aView;
}



- (BOOL)isDisplayingViewForIndex:(NSUInteger)index
{
	BOOL foundPage = NO;
    for (UIView *aView in visibleViews) //在visibleViews中有数据
	{
        int viewIndex = aView.frame.origin.y / width - 2;
        if (index==0) {
            viewIndex = aView.frame.origin.y / width - 1;
        }
        if (index==47) {
            return NO;
        }
        if (index==28) {
            return NO;
        }
        if (index==23) {
            return NO;
        }
        if (index==21) {
            return NO;
        }
        if (index==17) {
            return NO;
        }
        if (index==11) {
            return NO;
        }
        
        if (viewIndex == index) 
		{
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}




- (void)tileViews
{
    // Calculate which pages are visible
    CGRect visibleBounds = contentView.bounds;
    int firstNeededViewIndex = floorf(CGRectGetMinY(visibleBounds) / width) - 2;//-2
    int lastNeededViewIndex  = floorf((CGRectGetMaxY(visibleBounds) / width)) - 2;//3
    firstNeededViewIndex = MAX(firstNeededViewIndex, 0);//0
    lastNeededViewIndex  = MIN(lastNeededViewIndex, rowsCount - 1);//3
	
    // Recycle no-longer-visible pages 
	for (UIView *aView in visibleViews) 
    {
        int viewIndex = aView.frame.origin.y / width - 2;
        if (viewIndex < firstNeededViewIndex || viewIndex > lastNeededViewIndex) 
        {
            [recycledViews addObject:aView];//超出边界
            [aView removeFromSuperview];
        }
    }
    
    [visibleViews minusSet:recycledViews];//所有不在既定集合中的元素
    
    // add missing pages
	for (int index = firstNeededViewIndex; index <= lastNeededViewIndex; index++) 
	{
        
        if (!_mutableArray) {
            _mutableArray = [[NSMutableArray alloc]init];
            for (int i=0; i<64; i++) {
                NSString *string = [NSString stringWithFormat:@"%d",i];
                [_mutableArray insertObject:string atIndex:i];
            }
            
        }
        
        if ([[_mutableArray objectAtIndex:index] isKindOfClass:[UILabel class]]) {
            UILabel *labelview = [_mutableArray objectAtIndex:index];
            [self configureView:labelview atIndex:index];
            [contentView addSubview:labelview];
            
        }else{
            UILabel *labelnew = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, width)];
            labelnew.backgroundColor = [UIColor clearColor];
            labelnew.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.9];
            labelnew.font = self.rowFont;
            [labelnew setTextAlignment:NSTextAlignmentCenter];
            [self configureView:labelnew atIndex:index];
            [contentView addSubview:labelnew];
            [_mutableArray insertObject:labelnew atIndex:index];
         //   [labelnew release];
        }
        
        
        
        
        
//        if (![self isDisplayingViewForIndex:index])////////////////////不管有没有都生成  防止显示空白
//		{
//            if ([[dataSource contentView] isKindOfClass:[UILabel class]]) {
//                label = (UILabel *)[self dequeueRecycledView];
//                //生成真实数据
//                if (label == nil)
//                {
//                    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, width)];
//                    label.backgroundColor = [UIColor clearColor];
//                    label.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.9];
//                    label.font = self.rowFont;
//                    [label setTextAlignment:NSTextAlignmentCenter];
//                }
//                
//                [self configureView:label atIndex:index];
//                //[contentView addSubview:label];//显示label
//                [visibleViews addObject:label];
//            }
//        }
    }
    



}




- (void)configureView:(UIView *)view atIndex:(NSUInteger)index
{

        UILabel *label1 = (UILabel *)view;
        label1.text = [dataSource pickerView:self titleForRow:index];
        CGRect frame = label1.frame;
        frame.origin.y = width * index + fromToTop;
        label1.frame = frame;


}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (_boolMusic) {
//        if (_currentScroll&&width) {
//            if ([[lowooMusic sharedLowooMusic] isMusicAllow]) {
//                if ((scrollView.contentOffset.y - _currentScroll)>=width) {
//                    _currentScroll = scrollView.contentOffset.y;
//                    [[lowooMusic sharedLowooMusic] playShortMusic:@"time" Type:@"caf"];
//                }else{
//                    if (scrollView.contentOffset.y<_currentScroll) {
//                        if ((_currentScroll-scrollView.contentOffset.y)>=width) {
//                            _currentScroll = scrollView.contentOffset.y;
//                            [[lowooMusic sharedLowooMusic] playShortMusic:@"time" Type:@"caf"];
//                        }
//                    }
//                }
//            }
//        }
//
//    }

    
    
    [self tileViews];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    _currentScroll = scrollView.contentOffset.y;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
        [self determineCurrentRow];
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self determineCurrentRow];
}

- (void)dealloc{
    _boolMusic = NO;
}

@end
