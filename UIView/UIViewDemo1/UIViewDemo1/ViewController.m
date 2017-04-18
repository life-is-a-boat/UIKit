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

#import "UISectorView.h"

#import "UICircleCollectionViewLayout.h"


#import "UICircleFlowLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ViewController


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//
//    UICircleCollectionViewLayout * layout = [[UICircleCollectionViewLayout alloc]init];
//    layout.itemSize = CGSizeMake(100., 100.);
//    UICollectionView * collect  = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
//    collect.delegate=self;
//    collect.dataSource=self;
//    collect.center = self.view.center;
//    collect.bounds = CGRectMake(0., 0., 300., 300.);
//    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
//    [self.view addSubview:collect];
//}
//
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 10;
//}
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
//    cell.layer.masksToBounds = YES;
//    cell.layer.cornerRadius = 50.;
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//    return cell;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor getColorWithHexString:@"F8F8F8"];

    UIPieChartView *coronaView = [[UIPieChartView alloc] init];
    coronaView.backgroundColor = [UIColor brownColor];
//    coronaView.startPercentage = 0.;
//    coronaView.endPercentage = 60.;
//    coronaView.radius = 300.;
    [coronaView setCoronaMuti_colors:@[[UIColor magentaColor],[UIColor greenColor],[UIColor purpleColor],[UIColor blueColor]]];
    [coronaView setPieChartViewDatas:@[@100,@50,@20,@20]];

    [self.view addSubview:coronaView];

//    coronaView.center = CGPointMake(self.view.center.x, 64. + 180.);
//    coronaView.bounds = CGRectMake(0, 0, 200, 200);

    coronaView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:coronaView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1. constant:20.]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:coronaView attribute:NSLayoutAttributeTrailing multiplier:1. constant:20.]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:coronaView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1. constant:64.]];
    [coronaView addConstraint:[NSLayoutConstraint constraintWithItem:coronaView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:coronaView attribute:NSLayoutAttributeWidth multiplier:1. constant:20.]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
