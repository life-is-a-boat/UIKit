//
//  AnnotationView.h
//  MAMapDemo
//
//  Created by 刘兵 on 2017/4/20.
//  Copyright © 2017年 刘兵. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CalloutView.h"

@interface AnnotationView : MAAnnotationView
    
@property (nonatomic, strong, readwrite) CalloutView *calloutView;
@property (nonatomic, strong, readwrite) NSString *locationText;
@property (nonatomic, strong, readwrite) NSString *timeText;
    
@end
