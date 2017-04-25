//
//  AnnotationView.m
//  MAMapDemo
//
//  Created by 刘兵 on 2017/4/20.
//  Copyright © 2017年 刘兵. All rights reserved.
//

#import "AnnotationView.h"

@implementation AnnotationView

#define kCalloutWidth       200.0
#define kCalloutHeight      70.0
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CalloutView alloc] initWithFrame:CGRectZero];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        self.calloutView.image = [UIImage imageNamed:@"pic_popup_loading"];
        self.calloutView.title = self.annotation.title;
        self.calloutView.subtitle = self.annotation.subtitle;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image) {
        self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y - (self.imageView.image.size.height / 2.), self.imageView.frame.size.width, self.imageView.frame.size.height);
    }
}
-(void)setLocationText:(NSString *)locationText
{
    //
}
    
-(void)setTimeText:(NSString *)timeText
{
    //
}
    
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
