//
//  UIBarGraphView.h
//  UIViewDemo2
//
//  Created by mac on 2017/6/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarGraphView : UIView

-(void)setTitle:(NSString *)title;

-(void)createGradientViewWithColors:(NSArray *)colors withLocations:(NSArray *)location withDirection:(UICollectionViewScrollDirection)direction;

@end
