//
//  UIPieChartView.m
//  UIViewDemo1
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIPieChartView.h"
#import "UIColor+HexColor.h"
#import "UIOneTapGestrueRecognizer.h"
#import "UIImage+MaskImage.h"

@interface UIPieChartView ()
{
    NSArray             *_colors;
}
@property (nonatomic) UIImageView       *maskImageView;
@property (nonatomic) UIView            *contentView;
@property (nonatomic) CAShapeLayer      *pieLayer;
@property (nonatomic) UILabel           *countLabel;
@property (nonatomic) NSArray           *endPercentages;

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
    }
    return self;
}

-(UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.frame = self.bounds;
        [self addSubview:_contentView];
//        _contentView.translatesAutoresizingMaskIntoConstraints = false;
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1. constant:0.]];
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1. constant:0.]];
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1. constant:-20.]];
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1. constant:-20.]];
    }
    return _contentView;
}

-(UIImageView *)maskImageView
{
    if (_maskImageView == nil) {
        _maskImageView = [[UIImageView alloc] init];
        _maskImageView.contentMode = UIViewContentModeScaleAspectFit;
        _maskImageView.frame = _contentView.bounds;
        _maskImageView.hidden = YES;
        [_contentView addSubview:_maskImageView];
    }
    return _maskImageView;
}

-(void)loadDefault
{
    self.endPercentages = [[NSArray alloc] init];
    if (_contentView) {
        [_contentView removeFromSuperview];
        _contentView = nil;
    }
    _pieLayer = [CAShapeLayer layer];
    [self.contentView.layer addSublayer:_pieLayer];
    [self addRotationGesture];
}
-(void)addRotationGesture
{
    if (_contentView) {
        UIOneTapGestrueRecognizer *rotation = [[UIOneTapGestrueRecognizer alloc] initWithTarget:self action:@selector(rotationGestureAction:)];
        [_contentView addGestureRecognizer:rotation];
    }
}

-(void)rotationGestureAction:(UIOneTapGestrueRecognizer *)rotation
{
    switch (rotation.state) {
        case UIGestureRecognizerStatePossible:
        {
            printf("\n UIGestureRecognizerStatePossible");
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
            printf("\n UIGestureRecognizerStateFailed");
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            printf("\n UIGestureRecognizerStateCancelled");
            self.maskImageView.hidden = true;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            printf("\n UIGestureRecognizerStateEnded");
            self.maskImageView.hidden = true;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            printf("\n UIGestureRecognizerStateChanged");
        }
            break;
        case UIGestureRecognizerStateBegan:
        {
            printf("\n UIGestureRecognizerStateBegan");
            self.maskImageView.image = [UIImage getImageFromView:_contentView];
            self.maskImageView.hidden = false;
        }
            break;
        default:
            break;
    }

    //    printf("\n rotation:%lf  velocity:%lf",rotation.rotation,rotation.velocity);

    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.angle);
    rotation.angle = 0;
}

-(void)setCoronaMuti_colors:(NSArray *)muti_colors
{
    _colors = muti_colors;
}

-(UIColor *)getCurrent_color:(NSInteger)index
{
    if (index < _colors.count) {
        return [_colors objectAtIndex:index];
    }
    return self.backgroundColor;
}


-(CGFloat)getCurrentPercentFromIndex:(NSInteger)index {
    CGFloat count = 0.;
    for (int i = 0; i < index; i ++) {
        count += [[_endPercentages objectAtIndex:i] floatValue];
    }
    return count;
}

- (CGFloat)startPercentageForItemAtIndex:(NSUInteger)index{
    if(index == 0){
        return 0;
    }
    return [self getCurrentPercentFromIndex:index];
}

- (CGFloat)endPercentageForItemAtIndex:(NSUInteger)index{

    return [_endPercentages[index] floatValue] + [self getCurrentPercentFromIndex:index];
}

-(void)setPieChartViewDatas:(NSArray *)datas
{
    NSInteger sum = 0;
    for (int i = 0; i < datas.count; i ++) {
        sum += [[datas objectAtIndex:i] floatValue];
    }
    NSMutableArray *mutArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < datas.count; i ++) {
        [mutArray addObject:@([[datas objectAtIndex:i] floatValue]/sum)];
    }
    _endPercentages = mutArray;

    [self strokeChart];
}


-(void)strokeChart
{
    for (int i = 0; i < _endPercentages.count; i ++) {
        CGFloat startPercentage = [self startPercentageForItemAtIndex:i];
        CGFloat endPercentage   = [self endPercentageForItemAtIndex:i];
        CAShapeLayer *currentPieLayer = [self createCircleLayerWithRadius:75. borderWidth:50. fillColor:[UIColor clearColor] borderColor:[self getCurrent_color:i] startPercentage:startPercentage endPercentage:endPercentage];
        [_pieLayer addSublayer:currentPieLayer];
    }

    [self maskChart];

    self.countLabel.text = @"总金额";

}

-(UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont systemFontOfSize:15.];
        [self addSubview:_countLabel];
        _countLabel.text = @"总金额：";
        _countLabel.frame = self.bounds;
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

-(void)maskChart
{
    CAShapeLayer *maskLayer = [self createCircleLayerWithRadius:75. borderWidth:50. fillColor:[UIColor clearColor] borderColor:[UIColor blackColor] startPercentage:0. endPercentage:1.];
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
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:-M_PI_2
                                                      endAngle:M_PI_2 * 3
                                                     clockwise:YES];
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
