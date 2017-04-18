//
//  UISectorView.m
//  UIViewDemo1
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UISectorView.h"

@implementation UISectorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

// 覆盖drawRect方法，你可以在此自定义绘画和动画
- (void)drawRect:(CGRect)rect
{
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画大圆并填充颜
    UIColor*aColor = [UIColor colorWithRed:1 green:0.0 blue:0 alpha:1];
    //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
    aColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    //以radius为半径围绕圆心画指定角度扇形
    CGContextMoveToPoint(context, 0, self.bounds.size.height);
    CGFloat radius = self.radius > 0. ? self.radius:MIN(self.bounds.size.width, self.bounds.size.height);
    CGContextAddArc(context, 0, self.bounds.size.height, radius,  (-1) * self.startPercentage * M_PI / 180, (-1) * self.endPercentage * M_PI / 180, 1);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
}

@end
