//
//  UIGradientView.h
//  UIViewDemo1
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICircleViewHeader.h"

@interface UIGradientView : UIView
-(void)setMutiColorStyle:(UIMutiColorStyle)style;
-(void)setMuti_colors:(NSArray *)colors;
-(void)setMuti_colorsLocations:(NSArray *)locations;
@end
