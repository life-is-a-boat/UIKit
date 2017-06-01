//
//  UIGradientView.m
//  UIViewDemo1
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIGradientView.h"
#import <QuartzCore/QuartzCore.h>

@interface UIGradientView ()
{
    NSArray             *_muti_colors;
    NSArray             *_locations;
    UICollectionViewScrollDirection _direction;
}

@end
@implementation UIGradientView

-(void)createGradientViewWithColors:(NSArray *)colors withLocations:(NSArray *)locations withDirection:(UICollectionViewScrollDirection)direction
{

    _muti_colors = colors;

    _locations = locations;

    _direction = direction;

    NSMutableArray *mult_colors = [[NSMutableArray alloc] initWithCapacity:0];

    if (_muti_colors && _muti_colors.count > 0) {
        for (UIColor *color in _muti_colors) {
            if (color) {
                [mult_colors addObject:(__bridge id)[color CGColor]];
            }
        }
    }

#pragma mark - 使用 Quartz Core
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = mult_colors;
    gradientLayer.locations = _locations;
    gradientLayer.frame = self.bounds;
    if (_direction == UICollectionViewScrollDirectionVertical) {
        gradientLayer.startPoint = CGPointMake(0, 0.);
        gradientLayer.endPoint = CGPointMake(0., 1.0);
    }
    else if (_direction == UICollectionViewScrollDirectionHorizontal) {
        gradientLayer.startPoint = CGPointMake(0, 0.);
        gradientLayer.endPoint = CGPointMake(1., 0.);
    }

    [self.layer insertSublayer:gradientLayer atIndex:0];
}

@end
