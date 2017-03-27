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
    UIMutiColorStyle    _style;
}
@end
@implementation UIGradientView

-(void)setMutiColorStyle:(UIMutiColorStyle)style
{
    _style = style;
}

-(void)setMuti_colors:(NSArray *)colors
{
    _muti_colors = colors;
}

-(void)setMuti_colorsLocations:(NSArray *)locations
{
    _locations = locations;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    NSMutableArray *colors = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *locations = [[NSMutableArray alloc] initWithCapacity:0];

    if (_muti_colors && _muti_colors.count > 0) {
        for (UIColor *color in _muti_colors) {
            if (color) {
                [colors addObject:(__bridge id)[color CGColor]];
            }
        }
    }

    if ((!_locations || _locations.count < 1) && colors.count > 0) {
        CGFloat stepCount = 1./colors.count;
        for (int i = 0; i < colors.count; i ++) {
            [locations addObject:[NSNumber numberWithFloat:stepCount * i]];
        }
    }
    else {
        [locations addObjectsFromArray:[_locations sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj2 compare:obj1];
        }]];
    }

#pragma mark - 使用 Quartz Core
    switch (_style) {
        case UIMutiColorStyleVertical://垂直
        {
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.colors = colors;
            gradientLayer.locations = locations;
            gradientLayer.frame = self.bounds;
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1.0);
            [self.layer insertSublayer:gradientLayer atIndex:0];
        }
            break;
        case UIMutiColorStyleHorizontal://水平
        {
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.colors = colors;
            gradientLayer.locations = locations;
            gradientLayer.frame = self.bounds;
            gradientLayer.startPoint = CGPointMake(0, 1.0);
            gradientLayer.endPoint = CGPointMake(1.0, 1.0);
            [self.layer insertSublayer:gradientLayer atIndex:0];
        }
            break;
        case UIMutiColorStyleCircle://圆形
        {
            for (int i = 0; i< locations.count; i ++) {
                UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((self.bounds.size.width - self.bounds.size.width * [[locations objectAtIndex:i] floatValue]) / 2., (self.bounds.size.width - self.bounds.size.height * [[locations objectAtIndex:i] floatValue]) / 2., self.bounds.size.width * [[locations objectAtIndex:i] floatValue], self.bounds.size.width * [[locations objectAtIndex:i] floatValue])];
                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.frame = self.bounds;
                shapeLayer.strokeEnd = 0.5f;
                shapeLayer.strokeStart = 0.5f;
                shapeLayer.path = path.CGPath;
                shapeLayer.fillColor = [self randomColor].CGColor;
                shapeLayer.lineWidth = 2.0f;
                shapeLayer.strokeColor = [UIColor clearColor].CGColor;
                [self.layer addSublayer:shapeLayer];
            }

        }
            break;

        default:
            break;
    }
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random() % 256 / 256.f
                           green:arc4random() % 256 / 256.f
                            blue:arc4random() % 256 / 256.f
                           alpha:1];
}
@end
