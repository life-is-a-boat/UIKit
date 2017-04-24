//
//  UIShapeView.m
//  UIViewDemo1
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIShapeView.h"
@interface UIShapeView ()
{
    //
}
@property (assign,nonatomic)UIShapeViewStyle style;
@property (nonatomic, strong) CAShapeLayer  *shapeLayer;
@end
@implementation UIShapeView
-(instancetype)init
{
    return [self initWithFrame:CGRectZero];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    return [self initShapeViewWithFrame:frame withStyle:UIShapeViewStyleCircle];
}

-(id)initShapeViewWithFrame:(CGRect)frame withStyle:(UIShapeViewStyle)style
{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.shapeLayer.frame = self.bounds;
        _style = style;
    }
    return self;
}

-(CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil) {
        _shapeLayer = [CAShapeLayer layer];
    }
    return _shapeLayer;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    switch (_style) {
        case UIShapeViewStyleNone:
            //
            break;
        case UIShapeViewStyleCircle:
        {
            _shapeLayer.frame = self.bounds;
            _shapeLayer.lineWidth = 8;
            _shapeLayer.fillColor = nil;
            _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
            _shapeLayer.lineCap = kCALineCapRound;
            _shapeLayer.lineJoin = kCALineCapRound;
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x , self.center.y) radius:(self.bounds.size.width - 8)/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
            _shapeLayer.path = path.CGPath;
            [self.layer addSublayer:_shapeLayer];
        }
            break;

        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end