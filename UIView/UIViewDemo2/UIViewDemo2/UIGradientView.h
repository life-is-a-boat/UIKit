//
//  UIGradientView.h
//  UIViewDemo1
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGradientView : UIView

-(void)createGradientViewWithColors:(NSArray *)colors withLocations:(NSArray *)location withDirection:(UICollectionViewScrollDirection)direction;

@end
