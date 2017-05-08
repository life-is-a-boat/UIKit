//
//  UIWavesAnimationView.m
//  UIViewDemo1
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIWavesAnimationView.h"
@interface UIWavesAnimationView ()
@property (nonatomic, strong) CADisplayLink *waveDisplaylink;
@property (nonatomic, strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer *secondWaveLayer;

@property (nonatomic) CGFloat waveA; //水纹振幅    表示上面的A
@property (nonatomic) CGFloat waveW;//水纹周期  表示上面的ω
@property (nonatomic) CGFloat offsetX; //位移   表示上面的φ
@property (nonatomic) CGFloat currentK; //当前波浪高度Y   表示上面的C
@property (nonatomic) CGFloat waveSpeed;//水纹速度   表示波浪流动的速度
@property (nonatomic) CGFloat waterWaveWidth; //水纹宽度
@property (nonatomic, strong) UIColor *firstWaveColor; //波浪的颜色
@end
@implementation UIWavesAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds  = YES;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setUp {
    //设置波浪的宽度
    self.waterWaveWidth = self.bounds.size.width;
    //设置波浪的颜色
    self.firstWaveColor = [UIColor colorWithWhite:0.6 alpha:0.2];
    //设置波浪的速度
    self.waveSpeed = 0.4/M_PI;
    //初始化layer
    if (_firstWaveLayer == nil) {
        //初始化
        _firstWaveLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
        //设置边缘线的颜色
                _firstWaveLayer.strokeColor = [UIColor blueColor].CGColor;
                //设置边缘线的宽度
                _firstWaveLayer.lineWidth = 4.0;
                _firstWaveLayer.strokeStart = 0.0;
                _firstWaveLayer.strokeEnd = 0.8;
        [self.layer addSublayer:_firstWaveLayer];
    }
    if (self.secondWaveLayer == nil) {
        //初始化
        self.secondWaveLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        self.secondWaveLayer.fillColor = [UIColor greenColor].CGColor;//_firstWaveColor.CGColor;
        //设置边缘线的颜色
        //        _firstWaveLayer.strokeColor = [UIColor blueColor].CGColor;
        //        //设置边缘线的宽度
        //        _firstWaveLayer.lineWidth = 4.0;
        //        _firstWaveLayer.strokeStart = 0.0;
        //        _firstWaveLayer.strokeEnd = 0.8;
        [self.layer addSublayer:self.secondWaveLayer];
    }
    //设置波浪流动速度
    self.waveSpeed = 0.1;
    //设置振幅
    self.waveA = 5;
    //设置周期
    self.waveW = 1/20.0;
    //设置波浪纵向位置
    self.currentK = self.frame.size.height/2;//屏幕居中
    //启动定时器
    self.waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    [self.waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

    //切圆
//    CAShapeLayer *_backgroundLayer = [CAShapeLayer layer];
//    _backgroundLayer.frame = self.bounds;
//    _backgroundLayer.lineWidth = 8;
//    _backgroundLayer.fillColor = nil;
//    _backgroundLayer.strokeColor = [UIColor blueColor].CGColor;
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake((self.frame.size.width - 8)/2,(self.frame.size.width - 8)/2) radius:(self.frame.size.width - 8)/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
//    _backgroundLayer.path = path.CGPath;
//    [self.layer addSublayer:_backgroundLayer];

    
    // 贝塞尔曲线(创建一个圆)
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake((self.frame.size.width - 8)/2,(self.frame.size.width - 8)/2) radius:10 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    // 创建一个shapeLayer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame         = self.bounds;                // 与showView的frame一致
    layer.strokeColor   = [UIColor greenColor].CGColor;   // 边缘线的颜色
    layer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
    layer.lineCap       = kCALineCapRound;               // 边缘线的类型
    layer.lineJoin      = kCALineCapRound;
    layer.path          = path.CGPath;                    // 从贝塞尔曲线获取到形状
    layer.lineWidth     = 8.0f;                           // 线条宽度
    // 将layer添加进图层
    [self.layer addSublayer:layer];
}

-(void)getCurrentWave:(CADisplayLink *)displayLink
{
    //实时的位移
    self.offsetX += self.waveSpeed;
    [self setCurrentFirstWaveLayerPath];
    [self setCurrentSecondWaveLayerPath];
}

-(void)setCurrentFirstWaveLayerPath
{
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = self.currentK;
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path, nil, 0, y);
    for (NSInteger x = 0.0f; x<=self.waterWaveWidth; x++) {
        //正玄波浪公式
        y = self.waveA * sin(self.waveW * x+ self.offsetX)+self.currentK;
        //将点连成线
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, self.waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    _firstWaveLayer.path = path;
    CGPathRelease(path);
}

-(void)setCurrentSecondWaveLayerPath
{
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = self.currentK;
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path, nil, 0, y);
    for (NSInteger x = 0.0f; x<=self.waterWaveWidth; x++) {
        //正玄波浪公式
        y = (self.waveA+2) * sin(self.waveW * x- self.offsetX + 10)+self.currentK;
        //将点连成线
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, self.waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    self.secondWaveLayer.path = path;
    CGPathRelease(path);
}

- (void)dealloc
{
    [_waveDisplaylink invalidate];
}

 - (void)drawRect:(CGRect)rect {
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
     UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:self.frame.size.width/2.0 - 10 startAngle:- M_PI_2 endAngle:-M_PI_2 + M_PI * 2 clockwise:YES];
     //path 决定layer将被渲染成何种形状
     trackLayer.path = path.CGPath;
     self.layer.mask = trackLayer;
//     [self.layer addSublayer:trackLayer];
 }

@end
