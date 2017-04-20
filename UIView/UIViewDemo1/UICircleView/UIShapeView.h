//
//  UIShapeView.h
//  UIViewDemo1
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 mac. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,UIShapeViewStyle) {
    UIShapeViewStyleNone = 0,
    UIShapeViewStyleCircle = 1,
};
@interface UIShapeView : UIView

-(instancetype)initShapeViewWithFrame:(CGRect)frame withStyle:(UIShapeViewStyle)style;

@end
