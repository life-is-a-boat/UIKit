//
//  CalloutView.m
//  MAMapDemo
//
//  Created by 刘兵 on 2017/4/20.
//  Copyright © 2017年 刘兵. All rights reserved.
//

#import "CalloutView.h"
@interface CalloutView ()
{
    UIImageView     *_lineImageView;
    UIButton        *_navigation_btn;
}
@end
@implementation CalloutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    // 添加图片，即商户图
    self.portraitView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.portraitView.backgroundColor = [UIColor clearColor];
    self.portraitView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.portraitView];
    
    // 添加标题，即商户名
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = @"titletitletitletitle";
    [self addSubview:self.titleLabel];
    
    // 添加副标题，即商户地址
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.subtitleLabel.font = [UIFont systemFontOfSize:11];
    self.subtitleLabel.textColor = [UIColor lightGrayColor];
    self.subtitleLabel.text = @"subtitleLabelsubtitleLabelsubtitleLabel";
    [self addSubview:self.subtitleLabel];

    //线
    _lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_popup_loading_line"]];
    [self addSubview:_lineImageView];

    //导航图标
    _navigation_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _navigation_btn.contentMode = UIViewContentModeScaleAspectFit;
    [_navigation_btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self addSubview:_navigation_btn];
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
    self.subtitleLabel.text = subtitle;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.portraitView.image = image;
}

#define Text_badge    20.
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.title = @"江西省南昌市振林东路陆风研发中心";
    CGFloat width = 100.;
    CGFloat height = self.portraitView.image.size.height;
    CGFloat temp_width = 0.;
    if (self.title) {
        temp_width = [self.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size.width;
        if (temp_width > width) {
            width = temp_width;
        }
    }
    
    if (self.subtitle) {
        temp_width = [self.subtitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.subtitleLabel.font} context:nil].size.width;
        if (temp_width > width) {
            width = temp_width;
        }
    }
    self.bounds = CGRectMake(0., 0., width + 40. + 10., height+10.);
    self.center = CGPointMake(self.center.x, - height / 2.);
    self.portraitView.frame = self.bounds;
    self.titleLabel.frame = CGRectMake(Text_badge, (height - 15. - 13.)/2., (width), 15.);
    self.subtitleLabel.frame = CGRectMake(Text_badge, CGRectGetMaxY(self.titleLabel.frame), width,13.);
    _lineImageView.frame = CGRectMake((CGRectGetMaxX(self.titleLabel.frame)>CGRectGetMaxX(self.subtitleLabel.frame) ? CGRectGetMaxX(self.titleLabel.frame) : CGRectGetMaxX(self.subtitleLabel.frame)) + 5., (height - _lineImageView.image.size.height) / 2., _lineImageView.image.size.width, _lineImageView.image.size.height);

}

//#define kArrorHeight        10
//- (void)drawRect:(CGRect)rect
//{
//    [self drawInContext:UIGraphicsGetCurrentContext()];
//    
//    self.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.layer.shadowOpacity = 1.0;
//    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
//}
//    
//- (void)drawInContext:(CGContextRef)context
//{
//    
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
//    
//    [self getDrawPath:context];
//    CGContextFillPath(context);
//    
//}
//    
//- (void)getDrawPath:(CGContextRef)context
//{
//    CGRect rrect = self.bounds;
//    CGFloat radius = 6.0;
//    CGFloat minx = CGRectGetMinX(rrect),
//    midx = CGRectGetMidX(rrect),
//    maxx = CGRectGetMaxX(rrect);
//    CGFloat miny = CGRectGetMinY(rrect),
//    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
//    
//    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
//    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
//    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
//    
//    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
//    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
//    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
//    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
//    CGContextClosePath(context);
//}

@end
