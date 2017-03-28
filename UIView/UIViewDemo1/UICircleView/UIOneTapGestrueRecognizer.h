//
//  UIOneTapGestrueRecognizer.h
//  UIViewDemo1
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIOneTapGestrueRecognizer : UIGestureRecognizer
//需要几根手指
@property(nonatomic, assign)NSUInteger wpNumberOfTouchesRequired;//默认1
//需要几次点击
@property(nonatomic, assign)NSUInteger wpNumberOfTapsRequired;//默认0
//哪一边
@property (readwrite, nonatomic, assign) UIRectEdge wpEdges;//默认UIRectEdgeAll

//旋转角度
@property (readonly, nonatomic, assign) CGFloat angle;

@end
