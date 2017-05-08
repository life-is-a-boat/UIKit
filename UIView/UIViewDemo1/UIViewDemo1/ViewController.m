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

#import "UIShapeView.h"

#import "LBProgressView.h"

#import "UIWavesAnimationView.h"
#import "LBDoubleWaveView.h"

#import "TYWaveProgressView.h"

@interface ViewController ()
{
    LBDoubleWaveView * label;
}
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

    self.view.backgroundColor = [UIColor greenColor];//[UIColor getColorWithHexString:@"F8F8F8"];

//    UIPieChartView *coronaView = [[UIPieChartView alloc] init];
//    coronaView.backgroundColor = [UIColor brownColor];
////    coronaView.startPercentage = 0.;
////    coronaView.endPercentage = 60.;
////    coronaView.radius = 300.;
//    [coronaView setCoronaMuti_colors:@[[UIColor magentaColor],[UIColor greenColor],[UIColor purpleColor],[UIColor blueColor]]];
//    [coronaView setPieChartViewDatas:@[@100,@50,@20,@20]];
//
//    [self.view addSubview:coronaView];
//
////    coronaView.center = CGPointMake(self.view.center.x, 64. + 180.);
////    coronaView.bounds = CGRectMake(0, 0, 200, 200);
//
//    coronaView.translatesAutoresizingMaskIntoConstraints = false;
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:coronaView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1. constant:20.]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:coronaView attribute:NSLayoutAttributeTrailing multiplier:1. constant:20.]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:coronaView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1. constant:64.]];
//    [coronaView addConstraint:[NSLayoutConstraint constraintWithItem:coronaView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:coronaView attribute:NSLayoutAttributeWidth multiplier:1. constant:20.]];


//    LBProgressView *proView = [[LBProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) setProgress:0.75 Duration:0.7*5];
//    proView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
//    proView.backgroundColor = [UIColor brownColor];
//    [self.view addSubview:proView];

//    UIWavesAnimationView *proView = [[UIWavesAnimationView alloc] init];
////    proView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
//    proView.frame = CGRectMake((self.view.bounds.size.width - 200)/2., 64, 200, 200);
//    proView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:proView];
//    [proView setUp];

//    label = [[LBDoubleWaveView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width - 180.)/2., 93., 180., 180.)];
//    label.present = 0.5;
//    [self.view addSubview:label];

//    UIShapeView *shapeView = [[UIShapeView alloc] initShapeViewWithFrame:CGRectMake( (self.view.bounds.size.width - 180.) / 2., 93., 180, 180) withStyle:UIShapeViewStyleCircle];
//    shapeView.backgroundColor = [UIColor redColor];
////    shapeView.center = CGPointMake(self.view.bounds.size.width/2, 160.);
////    shapeView.bounds = CGRectMake(0., 0., 200, 200);
//    [self.view addSubview:shapeView];


    [self addWaveProgressView1];

}
- (IBAction)change:(id)sender {
    label.present = 0.9;
}

- (void)addWaveProgressView1
{
    TYWaveProgressView *waveProgressView = [[TYWaveProgressView alloc]initWithFrame:CGRectMake( (self.view.bounds.size.width - 180.) / 2., 93., 180, 180)];
    waveProgressView.waveViewMargin = UIEdgeInsetsMake(15, 15, 20, 20);
    waveProgressView.numberLabel.text = @"80";
    waveProgressView.numberLabel.font = [UIFont boldSystemFontOfSize:70];
    waveProgressView.numberLabel.textColor = [UIColor whiteColor];
    waveProgressView.unitLabel.text = @"%";
    waveProgressView.unitLabel.font = [UIFont boldSystemFontOfSize:20];
    waveProgressView.unitLabel.textColor = [UIColor whiteColor];
    waveProgressView.explainLabel.text = @"电量";
    waveProgressView.explainLabel.font = [UIFont systemFontOfSize:20];
    waveProgressView.explainLabel.textColor = [UIColor whiteColor];
    waveProgressView.percent = 0.76;
    [self.view addSubview:waveProgressView];
    [waveProgressView startWave];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
