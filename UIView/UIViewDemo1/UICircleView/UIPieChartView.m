//
//  UIPieChartView.m
//  UIViewDemo1
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIPieChartView.h"
#import "UIColor+HexColor.h"

@interface UIPieChartView ()

@property (nonatomic) UIView            *contentView;
@property (nonatomic) CAShapeLayer      *pieLayer;

@end
@implementation UIPieChartView

-(id)init
{
    return [self initWithFrame:CGRectZero];
}

-(id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame withItems:nil];
}

-(id)initWithFrame:(CGRect)frame withItems:(NSArray *)items
{
    if (self = [super initWithFrame:frame]) {
        [self loadDefault];
        [self strokeChart];
    }
    return self;
}

-(UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.frame = self.bounds;
        [self addSubview:_contentView];
//        _contentView.translatesAutoresizingMaskIntoConstraints = false;
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1. constant:0.]];
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1. constant:0.]];
//        [_contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1. constant:200.]];
//        [_contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1. constant:200.]];
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1. constant:0.]];
    }
    return _contentView;
}
-(void)loadDefault
{
    if (_contentView) {
        [_contentView removeFromSuperview];
        _contentView = nil;
    }
    _pieLayer = [CAShapeLayer layer];
    [self.contentView.layer addSublayer:_pieLayer];
}

-(void)strokeChart
{
    for (int i = 0; i < 3; i ++) {
        CGFloat startPercent = i * (90. + 10.) + 10.;
        CGFloat endPercent = i * (90. + 10.) + 90.;
        CAShapeLayer *currentPieLayer = [self createCircleLayerWithRadius:100. borderWidth:30. fillColor:[UIColor colorWithRed:arc4random()%256/256.f green:arc4random()%256/256.f  blue:arc4random()%256/256.f  alpha:1.] borderColor:[UIColor randomColor] startPercentage:startPercent endPercentage:endPercent];
        [_pieLayer addSublayer:currentPieLayer];
    }

    [self maskChart];
}

-(void)maskChart
{
    CAShapeLayer *maskLayer = [self createCircleLayerWithRadius:50. borderWidth:10. fillColor:[UIColor clearColor] borderColor:[UIColor blackColor] startPercentage:0. endPercentage:1.];
    _pieLayer.mask = maskLayer;
}

-(CAShapeLayer *)createCircleLayerWithRadius:(CGFloat)radius
                                 borderWidth:(CGFloat)borderWidth
                                   fillColor:(UIColor *)fillColor
                                 borderColor:(UIColor *)borderColor
                             startPercentage:(CGFloat)startPercentage
                               endPercentage:(CGFloat)endPercentage {
    CAShapeLayer *circel = [CAShapeLayer layer];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    circel.fillColor = fillColor.CGColor;
    circel.strokeColor = borderColor.CGColor;
    circel.strokeStart = startPercentage;
    circel.strokeEnd = endPercentage;
    circel.lineWidth = borderWidth;
    circel.path = path.CGPath;

    return circel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
