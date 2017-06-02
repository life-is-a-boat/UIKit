//
//  UIBarGraphView.m
//  UIViewDemo2
//
//  Created by mac on 2017/6/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIBarGraphView.h"

#import "UIGradientView.h"

@interface UIBarGraphView ()

@property (nonatomic, strong) UILabel  *title_label;

@end
@implementation UIBarGraphView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

-(void)createGradientViewWithColors:(NSArray *)colors withLocations:(NSArray *)location withDirection:(UICollectionViewScrollDirection)direction
{
    UIGradientView *gradientView = [[UIGradientView alloc] init];
    gradientView.frame = CGRectMake(self.bounds.size.width / 3., 20., self.bounds.size.width / 3., self.bounds.size.height - 20.);

    gradientView.layer.masksToBounds = true;
    gradientView.layer.cornerRadius = 5.;

//    gradientView.layer.shadowOffset = CGSizeMake(0, 15.);
//    gradientView.layer.shadowRadius = 10.;
//    gradientView.layer.shadowColor = [UIColor redColor].CGColor;
//    gradientView.layer.shadowOpacity = 1.;

    [gradientView createGradientViewWithColors:colors withLocations:location withDirection:direction];
    [self addSubview:gradientView];
}
-(void)setTitle:(NSString *)title
{
    self.title_label.text = title;
}

-(UILabel *)title_label
{
    if (_title_label == nil) {
        _title_label = [[UILabel alloc] init];
        _title_label.textColor = [UIColor whiteColor];
        _title_label.font = [UIFont systemFontOfSize:10.];
        _title_label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_title_label];
    }
    return _title_label;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_title_label) {
        _title_label.frame = CGRectMake(0., 5., 20., 14.);
    }
}
@end
