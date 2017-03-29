//
//  UIOneTapGestrueRecognizer.m
//  UIViewDemo1
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIOneTapGestrueRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <math.h>

@interface UIOneTapGestrueRecognizer ()
{
    CGPoint         _startPoint;
    CGPoint         _endPoint;
    CGFloat         _angle;
}
//需要几次点击
@property(nonatomic, assign)NSUInteger wpNumberOfTapsRequired;//默认0
@property(nonatomic, assign)BOOL isCorrected;
@end
@implementation UIOneTapGestrueRecognizer

//在began里面识别手势是否正确： 几根手指 几次点击 哪一边  此方法左右：作为手势识别器
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSArray *allTouches = [touches allObjects];
    //0.判断手指的tapCount  是否在move里面给出移动初始点
    for (UITouch * tou in allTouches) {
        if(tou.tapCount != (self.wpNumberOfTapsRequired + 1)){
            //不符合的话直接return 不再继续判断
            return;
        }
    }

    //1.判断手指个数是否符合
    if(allTouches.count != 1){
        //忽略不正确手指 防止干扰到识别
        for (UITouch * tou in allTouches) {
            [self ignoreTouch:tou forEvent:event];
        }
        return;
    }

    //2.手指个数满足情况下 判断手指位置是否满足条件
    //用临时变量topM等接收 防止屏幕旋转出现
    // 判断手指位置是否满足条件
    for (UITouch * tou in allTouches) {
        if (!self.view) {
            return;
        }//貌似能触发began就肯定有view
        CGPoint touchP = [tou locationInView:self.view];//手指位置
        _startPoint = touchP;
        _endPoint = touchP;
    }
    self.isCorrected = YES;//识别正确，当前状态UIGestureRecognizerStatePossible
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    if (!self.isCorrected) {
        //不满足began的情况 直接返回
        return;
    }

    //识别正确 移动既是began
    self.state = UIGestureRecognizerStateBegan;//自动内部会自动改变状态为move

    // 判断手指位置是否满足条件
    for (UITouch * tou in [touches allObjects]) {
        if (!self.view) {
            return;
        }//貌似能触发began就肯定有view
        CGPoint touchP = [tou locationInView:self.view];//手指位置
        if (fabs(touchP.y - _startPoint.y) > self.view.bounds.size.width * 0.5 && fabs(touchP.x - _startPoint.x) > 10.) {
            self.state = UIGestureRecognizerStateCancelled;
            NSLog(@" 不能在竖直方向移动的距离过大 ");
            return;
        }
        _endPoint = _startPoint;
        _startPoint = touchP;
        [self calculateAngle];
    }

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    // 判断手指位置是否满足条件
    for (UITouch * tou in [touches allObjects]) {
        if (!self.view) {
            return;
        }//貌似能触发began就肯定有view
        CGPoint touchP = [tou locationInView:self.view];//手指位置
        _endPoint = touchP;
        [self calculateAngle];
    }
    if(self.isCorrected){
        _startPoint = CGPointZero;
        _endPoint = CGPointZero;
        self.state = UIGestureRecognizerStateEnded;
        self.state = UIGestureRecognizerStateRecognized;
        [self reset];
    }
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"touchesCancelled");
}
- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches NS_AVAILABLE_IOS(9_1)
{
    [super touchesEstimatedPropertiesUpdated:touches];
    NSLog(@"touchesEstimatedPropertiesUpdated");
}

- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event NS_AVAILABLE_IOS(9_0)
{
    [super pressesBegan:presses withEvent:event];
    NSLog(@"pressesBegan");
}
- (void)pressesChanged:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event NS_AVAILABLE_IOS(9_0)
{
    [super pressesChanged:presses withEvent:event];
    NSLog(@"pressesChanged");
}
- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event NS_AVAILABLE_IOS(9_0)
{
    [super pressesEnded:presses withEvent:event];
    NSLog(@"pressesEnded");
}
- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event NS_AVAILABLE_IOS(9_0)
{
    [super pressesCancelled:presses withEvent:event];
    NSLog(@"pressesCancelled");
}

//没有end状态 又识别到其他手势的时候  多了手指出来
- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer{
    BOOL res = [super canPreventGestureRecognizer:preventedGestureRecognizer];
    self.state = UIGestureRecognizerStateCancelled;
    [self reset];
    return res;
}

//第一次识别 touchBegan之后调用
- (BOOL)shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL res = [super shouldRequireFailureOfGestureRecognizer:otherGestureRecognizer];
    return res;
}


-(CGFloat)angle
{
    return _angle;
}
-(void)setAngle:(CGFloat)angle
{
    _angle = angle;
}
-(void)calculateAngle
{
    CGPoint center = self.view.center;
    CGFloat angle = atan((_startPoint.y - center.y)/(_startPoint.x - center.x))+ atan((_endPoint.y - center.y)/(_endPoint.x - center.x));
    _angle = angle;
//    printf("\n \n \n _startPoint:%s    \n_endPoint:%s \n angle:%lf",[NSStringFromCGPoint(_startPoint) UTF8String],[NSStringFromCGPoint(_endPoint) UTF8String],angle);
}

#pragma mark - 重写方法
- (void)reset{
    [super reset];
    self.isCorrected = NO;
    _angle = 0.;
}

#pragma mark - 默认值设置
//重写init 设置默认值
- (instancetype)init{
    if(self = [super init]){
        self.wpNumberOfTapsRequired = 0;
        self.isCorrected = NO;
        _angle = 0.;
    }
    return self;
}

- (instancetype)initWithTarget:(id)target action:(SEL)action{
    if (self = [super initWithTarget:target action:action]) {
        self.wpNumberOfTapsRequired = 0;
        self.isCorrected = NO;
        _angle = 0.;
    }
    return self;
}

@end
