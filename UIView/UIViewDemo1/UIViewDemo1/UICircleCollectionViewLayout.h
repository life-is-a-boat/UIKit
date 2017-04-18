//
//  UICircleCollectionViewLayout.h
//  UIViewDemo1
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICircleCollectionViewLayout : UICollectionViewLayout
//这个int值存储有多少个item
@property(nonatomic,assign)int itemCount;

@property(nonatomic,assign)CGSize  itemSize;

@end
