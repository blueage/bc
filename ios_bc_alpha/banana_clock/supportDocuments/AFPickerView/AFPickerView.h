//
//  AFPickerView.h
//  PickerView
//
//  Created by Fraerman Arkady on 24.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


//#define PICKER_BACKGROUND       @""
//#define PICKER_SHADOWS          @""
//#define PICKER_GLASS            @""

@protocol AFPickerViewDataSource;
@protocol AFPickerViewDelegate;

@interface AFPickerView : UIView <UIScrollViewDelegate>
{
    __unsafe_unretained id <AFPickerViewDataSource> dataSource;
    __unsafe_unretained id <AFPickerViewDelegate> delegate;
    UIScrollView *contentView;
    UIImageView *glassImageView;
    
    int currentRow;
    int rowsCount;

    
    CGPoint previousOffset;
    BOOL isScrollingUp;
    
    // recycling
    NSMutableSet *recycledViews;
    NSMutableSet *visibleViews;
    
    UIFont *_rowFont;
    CGFloat _rowIndent;
    
    CGFloat width;
    CGFloat fromToTop;
    UITapGestureRecognizer *tapRecognizer;
    UITapGestureRecognizer *tapRecognizer1;
    UILabel *label;
    UIImageView *imageView;
}
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) float currentScroll;
@property (nonatomic, assign) BOOL boolMusic;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, unsafe_unretained) id <AFPickerViewDataSource> dataSource;
@property (nonatomic, unsafe_unretained) id <AFPickerViewDelegate> delegate;
@property (nonatomic, unsafe_unretained) int selectedRow;
@property (nonatomic, strong) UIFont *rowFont;
@property (nonatomic, unsafe_unretained) CGFloat rowIndent;

@property (nonatomic, strong) NSMutableArray *mutableArray;

- (void)setup;
- (void)reloadData;
- (void)determineCurrentRow;
- (void)didTap:(id)sender;
- (void)makeSteps:(int)steps;
- (void)setSelectedRow:(int)selectedRow;

// recycle queue
- (UIView *)dequeueRecycledView;
- (BOOL)isDisplayingViewForIndex:(NSUInteger)index;
- (void)tileViews;
- (void)configureView:(UIView *)view atIndex:(NSUInteger)index;

@end



@protocol AFPickerViewDataSource <NSObject>
@optional
- (UIView *)contentView;
- (CGFloat )floatOfWidth;
- (NSInteger )numberOfRowsInPickerView:(AFPickerView *)pickerView;
- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row;
- (UIImage *)pickerView:(AFPickerView *)pickerView imageForRow:(NSInteger )row;

@end



@protocol AFPickerViewDelegate <NSObject>
@optional

- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row;

@end