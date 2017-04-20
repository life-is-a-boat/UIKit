//
//  ViewController.m
//  BaiDuMapDemo
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 lb. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface ViewController ()<BMKGeoCodeSearchDelegate>
{
    UIButton                *_centerView;
    BMKGeoCodeSearch        *_searcher;
}
@property (weak, nonatomic) IBOutlet BMKMapView *mapview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _mapview.mapType = BMKMapTypeStandard;
    _mapview.updateTargetScreenPtWhenMapPaddingChanged = YES;

    _centerView = [UIButton buttonWithType:UIButtonTypeCustom];
    _centerView.bounds = CGRectMake(0., 0., 60, 25.);
    _centerView.center = _mapview.center;
    _centerView.backgroundColor = [UIColor redColor];
    [_centerView setTitle:@"位置" forState:UIControlStateNormal];
    [_mapview addSubview:_centerView];

    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;

    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city= @"北京市";
    geoCodeSearchOption.address = @"北京市朝阳区南湖中园2区230号楼1单元601室";
    BOOL flag = [_searcher geoCode:geoCodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"\n---result:%@",result.address);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapview viewWillAppear];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapview viewWillDisappear];
}

#pragma mark - ---
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
