//
//  UIBrokenLineView.m
//  UIViewDemo2
//
//  Created by mac on 2017/6/1.
//  Copyright © 2017年 mac. All rights reserved.
//

//#define bounceX  self.bounds.origin.x
//#define bounceY  self.bounds.origin.y

#define bounceBottom  (self.bounds.size.height)/8. - 1

#import "UIHistogramView.h"

#import "UIBarGraphView.h"

@implementation UIHistogramView

-(void)YearHistogramView
{
    [self createLabelX];
    [self setLineDashX];
    [self setLineDashY];
    [self createChartView];
}
-(void)createChartView
{
    CGFloat width = (self.bounds.size.width - 12.)/12.;
    for (int i = 0; i < 12; i ++) {
        UIBarGraphView *gradientView = [[UIBarGraphView alloc] init];
        gradientView.backgroundColor = [UIColor clearColor];
        gradientView.frame = CGRectMake([self configuXViewFrame:i withTotal:12].origin.x, 20., width, self.bounds.size.height - bounceBottom + 5. - 20.);
        [gradientView createGradientViewWithColors:@[[UIColor blueColor],[UIColor greenColor]] withLocations:@[@0.7,@1.0] withDirection:UICollectionViewScrollDirectionVertical];
        [gradientView setTitle:@"70"];
        [self addSubview:gradientView];
    }
}
#pragma mark - x轴添加 数据
-(void)createLabelX
{
    CGFloat  month = 12;
    for (NSInteger i = 0; i < month; i++) {
        UILabel * LabelMonth = [[UILabel alloc]init];
        LabelMonth.frame = [self configuXViewFrame:i withTotal:month];
//        LabelMonth.backgroundColor = [UIColor greenColor];
        LabelMonth.text = [NSString stringWithFormat:@"%ld月",i+1];
        LabelMonth.font = [UIFont systemFontOfSize:10];
        LabelMonth.textAlignment = NSTextAlignmentCenter;
//        LabelMonth.transform = CGAffineTransformMakeRotation(M_PI * 0.3);
        [self addSubview:LabelMonth];
    }
}
#pragma mark 添加虚线
- (void)setLineDashX
{
    CGFloat  month = 12;
    CGFloat bottom = (self.bounds.size.width - 12.)/month;
    for (NSInteger i = 1; i < 12; i++) {
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor blueColor].CGColor;
        dashLayer.fillColor = [[UIColor clearColor] CGColor];
        // 默认设置路径宽度为0，使其在起始状态下不显示
        dashLayer.lineWidth = 1.0;

        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
        UIColor * color = [UIColor blueColor];

        [color set];
        [path moveToPoint:CGPointMake((bottom + 1) * i, self.bounds.size.height)];
        [path addLineToPoint:CGPointMake((bottom + 1) * i, 0.)];
        [path stroke];
        dashLayer.path = path.CGPath;
        [self.layer addSublayer:dashLayer];
    }
}

-(void)setLineDashY
{
    CGFloat  month = 9;
    CGFloat bottom = (self.bounds.size.height)/(month - 1) - 1;
    for (NSInteger i = 0; i < month; i++) {
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor blueColor].CGColor;
        dashLayer.fillColor = [[UIColor clearColor] CGColor];
        // 默认设置路径宽度为0，使其在起始状态下不显示
        dashLayer.lineWidth = 1.0;

        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
        UIColor * color = [UIColor blueColor];

        [color set];
        [path moveToPoint:CGPointMake(0., (bottom + 1) * i)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width, (bottom + 1) * i)];
        [path stroke];
        dashLayer.path = path.CGPath;
        [self.layer addSublayer:dashLayer];
    }
}

-(CGRect)configuXViewFrame:(NSInteger)index withTotal:(NSInteger)total
{
    CGFloat width = (self.bounds.size.width - 12.)/total;
    return CGRectMake((width + 1) * index, self.bounds.size.height - bounceBottom, width, bounceBottom);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    /******画出坐标轴*****/
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 1.0);
//    CGContextSetRGBStrokeColor(context, 1., 0., 0., 1.);
//    CGContextMoveToPoint(context, 0., self.bounds.size.height - bounceBottom);
//    CGContextAddLineToPoint(context,self.bounds.size.width, self.bounds.size.height - bounceBottom);
//    CGContextStrokePath(context);
}

@end
