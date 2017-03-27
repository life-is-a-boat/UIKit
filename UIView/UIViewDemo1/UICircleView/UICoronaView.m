//
//  UICoronaView.m
//  UIViewDemo1
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UICoronaView.h"
#import "UIMulti-colorView.h"
#import "UIGradientView.h"

@interface UICoronaView ()
{
    UIMutiColorStyle        _style;
}
@property (nonatomic, strong) UIGradientView     *muti_colorView;

@end
@implementation UICoronaView

-(id)init
{
    return [self initWithFrame:CGRectZero];
}

-(id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame withStyle:UIMutiColorStyleHorizontal];
}
-(id)initWithFrame:(CGRect)frame withStyle:(UIMutiColorStyle)style
{
    if (self = [super initWithFrame:frame]) {
        _style = style;
    }
    return self;
}

-(UIGradientView *)muti_colorView
{
    if (_muti_colorView == nil) {
        _muti_colorView = [[UIGradientView alloc] init];
        _muti_colorView.backgroundColor = [UIColor clearColor];
        [self addSubview:_muti_colorView];
        _muti_colorView.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_muti_colorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1. constant:25.]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_muti_colorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1. constant:0.]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_muti_colorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.5 constant:self.bounds.size.width/2.]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_muti_colorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_muti_colorView attribute:NSLayoutAttributeHeight multiplier:1. constant:0.]];

    }
    return _muti_colorView;
}

-(void)setCoronaMuti_colors:(NSArray *)muti_colors
{
    [self.muti_colorView setMutiColorStyle:_style];
    [self.muti_colorView setMuti_colors:muti_colors];
}
-(void)setCoronaMuti_colorsLocations:(NSArray *)locations
{
    [self.muti_colorView setMutiColorStyle:_style];
    [self.muti_colorView setMuti_colorsLocations:locations];
}

-(void)setStyle:(UIMutiColorStyle)style
{
    _style = style;
    [self.muti_colorView setMutiColorStyle:style];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}




@end
