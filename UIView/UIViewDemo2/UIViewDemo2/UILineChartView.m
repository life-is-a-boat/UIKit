//
//  UILineChartView.m
//  UIViewDemo2
//
//  Created by mac on 2017/6/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#define bounceBottom  (self.bounds.size.height)/8. - 1


#import "UILineChartView.h"
@interface UILineChartView ()
{
    NSMutableArray      *_pathArr;
}
@end
@implementation UILineChartView

-(void)createLineChartView:(NSArray *)datas
{
    [self monthLineChartView];
}

-(void)monthLineChartView
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:[NSDate date]];
    NSLog(@"current month count of day  %ld \n %@",range.length,components.description);
    NSInteger count = range.length;
    if (_pathArr == nil) {
        _pathArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    for (int i = 0; i < count + 2; i ++) {
        CGFloat num = arc4random()%10/10.;
        [_pathArr addObject:[NSNumber numberWithFloat:num]];
    }
    //添加日期
    [self createMonthLabel:count];
    //画竖线
    [self createMonthLine:count];
    //添加折线
    [self createMonthBrokenLine:count];
}

-(void)createMonthLabel:(NSInteger)count
{
    CGFloat width = (self.bounds.size.width - count) / count;
    for (int i = 0; i < count/2; i ++) {
        UILabel * LabelMonth = [[UILabel alloc]init];
        LabelMonth.frame = CGRectMake((width + 1) * i * 2 , self.bounds.size.height - bounceBottom, width * 2, bounceBottom);
        LabelMonth.text = [NSString stringWithFormat:@"%.2d",i * 2 + 1];
        LabelMonth.font = [UIFont systemFontOfSize:10];
        LabelMonth.textAlignment = NSTextAlignmentCenter;
        [self addSubview:LabelMonth];
    }
}

-(void)createMonthLine:(NSInteger)count
{
    CGFloat width = (self.bounds.size.width - count/2.) / count;
    for (int i = 1; i < count; i ++) {
        UIView * LabelMonth = [[UIView alloc]init];
        CGFloat height = (self.bounds.size.height - bounceBottom)*[[_pathArr objectAtIndex:i] floatValue];
        LabelMonth.frame = CGRectMake((width + 0.5) * i, (self.bounds.size.height - bounceBottom) - height, .5, height);
        LabelMonth.backgroundColor = [UIColor redColor];
        [self addSubview:LabelMonth];
    }
}

-(void)createMonthBrokenLine:(NSInteger)count
{
    // 创建layer并设置属性
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth =  2.0f;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.strokeColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:layer];

    CGPoint start_point = CGPointZero;
    CGPoint end_point = CGPointZero;

    // 创建贝塞尔路径~
    UIBezierPath *path = [UIBezierPath bezierPath];

    CGFloat width = (self.bounds.size.width - count/2.) / count;

    for (int i= 0; i< _pathArr.count; i++) {

        CGFloat X = (width + 0.5) * (i);
        CGFloat height = (self.bounds.size.height - bounceBottom)*[[_pathArr objectAtIndex:i] floatValue];
        CGFloat Y = (self.bounds.size.height - bounceBottom) - height;

        end_point = CGPointMake(X, Y);

        if (i==0) {
            start_point = end_point;
            [path moveToPoint:start_point];//起点
        }

        [path addCurveToPoint:end_point controlPoint1:CGPointMake((end_point.x - start_point.x)/2. + start_point.x, start_point.y) controlPoint2:CGPointMake((end_point.x - start_point.x)/2. + start_point.x, end_point.y)];

        start_point = end_point;

//        [path addLineToPoint:point];
    }

    // 关联layer和贝塞尔路径~
    layer.path = path.CGPath;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
