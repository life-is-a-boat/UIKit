//
//  LBDoubleWaveView.m
//  UIViewDemo1
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "LBDoubleWaveView.h"
@interface LBDoubleWaveView ()
@property (nonatomic,strong)NSTimer * myTimer;

@property (nonatomic,assign) CGRect MYframe;

@property (nonatomic,assign) CGFloat fa;

@property (nonatomic,assign) CGFloat bigNumber;

@end
@implementation LBDoubleWaveView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _MYframe = frame;
        self.backgroundColor = [UIColor clearColor];
        UILabel * presentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        presentLabel.textAlignment = 1;
        [self addSubview:presentLabel];
        self.presentlabel = presentLabel;
        self.presentlabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)createTimer{

    if (!self.myTimer) {
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(action) userInfo:nil repeats:YES];
    }
    [self.myTimer setFireDate:[NSDate distantPast]];
}

- (void)action{
    //让波浪移动效果
    _fa = _fa+10;
    if (_fa >= _MYframe.size.width * 2.0) {
        _fa = 0;
    }
    [self setNeedsDisplay];
}

- (void)setPresent:(CGFloat)present{
    _present = present;
    //启动定时器
    [self createTimer];
    //修改波浪的幅度
    if (present <= 0.5) {
        _bigNumber = _MYframe.size.height * 0.1 * present * 2;
    }else{
        _bigNumber = _MYframe.size.height * 0.1 * (1 - present) * 2;
    }
}

- (void)drawRect:(CGRect)rect{

    CGContextRef context = UIGraphicsGetCurrentContext();
    // 创建路径
    CGMutablePathRef path = CGPathCreateMutable();

    //画水
    CGContextSetLineWidth(context, 1);
    UIColor * blue = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.3];
    CGContextSetFillColorWithColor(context, [blue CGColor]);

    float y= (1 - self.present) * rect.size.height;
    float y1= (1 - self.present) * rect.size.height;

    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x=0;x<=rect.size.width * 3.0;x++){
        //正弦函数
        y=  sin( x/rect.size.width * M_PI + _fa/rect.size.width *M_PI ) *_bigNumber + (1 - self.present) * rect.size.height ;
        CGPathAddLineToPoint(path, nil, x, y);
    }

    CGPathAddLineToPoint(path, nil, rect.size.width , rect.size.height );
    CGPathAddLineToPoint(path, nil, 0, rect.size.height );
    // CGPathAddLineToPoint(path, nil, 0, 200);

    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);


    CGMutablePathRef path1 = CGPathCreateMutable();
    //  float y1=200;
    //画水
    CGContextSetLineWidth(context, 1);
    UIColor * blue1 = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.8];
    CGContextSetFillColorWithColor(context, [blue1 CGColor]);


    //  float y1= 200;
    CGPathMoveToPoint(path1, NULL, 0, y1);
    for(float x=0;x<=rect.size.width;x++){

        y1= sin( x/rect.size.width * M_PI + _fa/rect.size.width *M_PI  +M_PI ) *_bigNumber + (1 - self.present) * rect.size.height ;
        CGPathAddLineToPoint(path1, nil, x, y1);
    }

    CGPathAddLineToPoint(path1, nil, rect.size.height, rect.size.width );
    CGPathAddLineToPoint(path1, nil, 0, rect.size.height );
    //CGPathAddLineToPoint(path, nil, 0, _currentLinePointY);

    CGContextAddPath(context, path1);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path1);

    //添加文字
    NSString *str = [NSString stringWithFormat:@"%.2f%%",self.present * 100.0];
    self.presentlabel.text = str;


    // Drawing code
    //创建背景圆环
    CAShapeLayer *trackLayer = [CAShapeLayer layer];
    trackLayer.frame = self.bounds;
    //清空填充色
    trackLayer.fillColor = [UIColor clearColor].CGColor;
    //设置画笔颜色 即圆环背景色
    trackLayer.strokeColor =  [UIColor colorWithRed:170/255.0 green:210/255.0 blue:254/255.0 alpha:1].CGColor;
    trackLayer.lineWidth = 20;
    //设置画笔路径
    UIBezierPath *bgpath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:self.frame.size.width/2.0 - 10 startAngle:- M_PI_2 endAngle:-M_PI_2 + M_PI * 2 clockwise:YES];
    //path 决定layer将被渲染成何种形状
    trackLayer.path = bgpath.CGPath;
    self.layer.mask = trackLayer;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
