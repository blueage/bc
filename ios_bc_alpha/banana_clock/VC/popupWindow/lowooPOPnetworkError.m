//
//  lowooPOPnetworkError.m
//  banana_clock
//
//  Created by MAC on 13-10-30.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPOPnetworkError.h"

@implementation lowooPOPnetworkError

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (iPhone5 || iPhone5_0) {
            [self.viewMove setFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            [self.viewMove setFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }

        if (iPhone5||iPhone5_0) {
            _imageViewPeople = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 290)];
        }else{
            _imageViewPeople = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 290)];
        }
        
        NSString *namepng = [BASE International:@"networkConnectErrorCN"];
        _imageViewPeople.image = GetPngImage(namepng);
        [self.viewMove addSubview:_imageViewPeople];
        
        self.buttonClose = [UIButton_custom buttonWithType:UIButtonTypeCustom];
        [self.viewMove addSubview:self.buttonClose];
        [self.buttonClose setFrame:CGRectMake(0 , 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.buttonClose addTarget:self action:@selector(buttonCloseTouchUpinside:)];
    }
    return self;
}

- (void)buttonCloseTouchUpinside:(UIButton_custom *)sender{
    if ([_delegate respondsToSelector:@selector(networkError:)]) {
        [_delegate networkError:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc{

}

@end
