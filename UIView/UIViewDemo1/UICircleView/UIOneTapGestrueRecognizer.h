//
//  UIOneTapGestrueRecognizer.h
//  UIViewDemo1
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIOneTapGestrueRecognizer : UIGestureRecognizer
//状态
//@property(nonatomic) UIGestureRecognizerState state;
//旋转角度
@property (nonatomic, assign) CGFloat angle;

//- (instancetype)initWithTarget:(nullable id)target action:(nullable SEL)action; // designated initializer
@end
