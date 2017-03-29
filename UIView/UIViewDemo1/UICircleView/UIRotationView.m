//
//  UIRotationView.m
//  UIViewDemo1
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIRotationView.h"
#import "UIOneTapGestrueRecognizer.h"

@interface UIRotationView ()

@property (nonatomic)UIView     *contentView;
@end
@implementation UIRotationView

-(id)init
{
    return [self initWithFrame:CGRectZero];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //
        _contentView = [[UIView alloc] init];
        _contentView.userInteractionEnabled = true;
        _contentView.backgroundColor = [UIColor redColor];
        [self addSubview:_contentView];
        _contentView.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1. constant:25.]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTrailing multiplier:1. constant:25.]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1. constant:25.]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeBottom multiplier:1. constant:25.]];
        [self addRotationGesture];
    }
    return self;
}

-(void)addRotationGesture
{
    UIPanGestureRecognizer *rotation = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureAction:)];
    [_contentView addGestureRecognizer:rotation];
}

-(void)rotationGestureAction:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStatePossible:
        {
            printf("\n UIGestureRecognizerStatePossible");
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
            printf("\n UIGestureRecognizerStateFailed");
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            printf("\n UIGestureRecognizerStateCancelled");
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            printf("\n UIGestureRecognizerStateEnded");
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            printf("\n UIGestureRecognizerStateChanged");
        }
            break;
        case UIGestureRecognizerStateBegan:
        {
            printf("\n UIGestureRecognizerStateBegan");
        }
            break;
        default:
            break;
    }

    CGPoint point = [recognizer translationInView:recognizer.view];
    NSLog(@"X:%f;Y:%f",point.x,point.y);

//    recognizer.view.center = CGPointMake(recognizer.view.center.x + point.x, recognizer.view.center.y + point.y);
//    [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];

//    printf("\n\n\n angle:%lf",recognizer.angle);

//    CGPoint translation = [recognizer translationInView:self];
//    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
//    recognizer.view.center.y + translation.y);
//    [recognizer setTranslation:CGPointZero inView:self];
//    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.angle);
//    recognizer.angle = 0;
//    printf("\n rotation:%lf  velocity:%lf",recognizer.rotation,recognizer.velocity);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
