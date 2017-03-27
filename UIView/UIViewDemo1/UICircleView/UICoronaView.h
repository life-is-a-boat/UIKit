//
//  UICoronaView.h
//  UIViewDemo1
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICircleViewHeader.h"

@interface UICoronaView : UIView

-(id)initWithFrame:(CGRect)frame withStyle:(UIMutiColorStyle)style;

-(void)setCoronaMuti_colors:(NSArray *)muti_colors;

-(void)setCoronaMuti_colorsLocations:(NSArray *)locations;

-(void)setStyle:(UIMutiColorStyle)style;

@end
