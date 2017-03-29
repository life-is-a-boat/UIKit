//
//  ViewController.m
//  UIViewDemo1
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "UICoronaView.h"
#import "UIColor+HexColor.h"
#import "UIPieChartView.h"
#import "UIRotationView.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor getColorWithHexString:@"F8F8F8"];

    UIPieChartView *coronaView = [[UIPieChartView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 200.) / 2., 90, 200, 200)];
    coronaView.backgroundColor = [UIColor whiteColor];

    [coronaView setCoronaMuti_colors:@[[UIColor magentaColor],[UIColor greenColor],[UIColor purpleColor],[UIColor blueColor]]];
    [coronaView setPieChartViewDatas:@[@100,@50,@20,@20]];
    
    [self.view addSubview:coronaView];

//    coronaView.center = CGPointMake(self.view.center.x, 64. + 180.);
//    coronaView.bounds = CGRectMake(0, 0, 200, 200);

//    coronaView.translatesAutoresizingMaskIntoConstraints = false;
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:coronaView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1. constant:0.]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:coronaView attribute:NSLayoutAttributeTrailing multiplier:1. constant:0.]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:coronaView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1. constant:64.]];
//    [coronaView addConstraint:[NSLayoutConstraint constraintWithItem:coronaView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1. constant:375.]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
