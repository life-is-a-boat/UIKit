//
//  ViewController.m
//  MAMapDemo
//
//  Created by 刘兵 on 2017/4/20.
//  Copyright © 2017年 刘兵. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "AnnotationView.h"
@interface ViewController ()<MAMapViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet MAMapView *mapView;
@property (strong, nonatomic) NSMutableArray    *annotations;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     ///地图类型
     typedef NS_ENUM(NSInteger, MAMapType)
     {
     MAMapTypeStandard = 0,  ///< 普通地图
     MAMapTypeSatellite,     ///< 卫星地图
     MAMapTypeStandardNight, ///< 夜间视图
     MAMapTypeNavi,          ///< 导航视图
     MAMapTypeBus            ///< 公交视图
     };
     */
    self.mapView.mapType = MAMapTypeStandard;
    
    ///是否支持旋转, 默认YES
    self.mapView.rotateEnabled = false;
    
    ///是否支持camera旋转, 默认YES
    self.mapView.rotateCameraEnabled = false;
    
    ///是否支持天空模式，默认为YES. 开启后，进入天空模式后，annotation重用可视范围会缩减
    self.mapView.skyModelEnable = false;
    
    ///是否显示指南针, 默认YES
    self.mapView.showsCompass = false;
    
    ///是否显示比例尺, 默认YES
    self.mapView.showsScale = false;
    
    ///当前地图的中心点，改变该值时，地图的比例尺级别不会发生变化
//    @property (nonatomic) CLLocationCoordinate2D centerCoordinate;
    
    ///当前地图的经纬度范围，设定的该范围可能会被调整为适合地图窗口显示的范围
//    @property (nonatomic) MACoordinateRegion region;
    
    ///可见区域, 设定的该范围可能会被调整为适合地图窗口显示的范围
//    @property (nonatomic) MAMapRect visibleMapRect;
    
    ///设置可见地图区域的矩形边界，如限制地图只显示北京市范围
//    @property (nonatomic, assign) MACoordinateRegion limitRegion;
    
    ///设置可见地图区域的矩形边界，如限制地图只显示北京市范围
//    @property (nonatomic, assign) MAMapRect limitMapRect;
    
    ///缩放级别（默认3-19，有室内地图时为3-20）
//    @property (nonatomic) CGFloat zoomLevel;
    
    ///最小缩放级别
//    @property (nonatomic) CGFloat minZoomLevel;
    
    ///最大缩放级别（有室内地图时最大为20，否则为19）
//    @property (nonatomic) CGFloat maxZoomLevel;
    
    ///设置地图旋转角度(逆时针为正向)
//    @property (nonatomic) CGFloat rotationDegree;
    
    ///设置地图相机角度(范围为[0.f, 60.f]，但高于40度的角度需要在16级以上才能生效)
//    @property (nonatomic) CGFloat cameraDegree;
    
    ///是否以screenAnchor点作为锚点进行缩放，默认为YES。如果为NO，则以手势中心点作为锚点
//    @property (nonatomic, assign) BOOL zoomingInPivotsAroundAnchorPoint;
    
    ///是否支持缩放, 默认YES
//    @property (nonatomic, getter = isZoomEnabled) BOOL zoomEnabled;
    
    ///是否支持平移, 默认YES
//    @property (nonatomic, getter = isScrollEnabled) BOOL scrollEnabled;
    
    ///是否显示楼块，默认为YES
//    @property (nonatomic, getter = isShowsBuildings) BOOL showsBuildings;
    
    ///是否显示底图标注, 默认为YES
//    @property (nonatomic, assign, getter = isShowsLabels) BOOL showsLabels;
    
    ///是否显示交通, 默认为NO
//    @property (nonatomic, getter = isShowTraffic) BOOL showTraffic;
    
    ///设置实时交通颜色,key为 MATrafficStatus
//    @property (nonatomic, copy) NSDictionary <NSNumber *, UIColor *> *trafficStatus;
    
    ///是否支持单击地图获取POI信息(默认为YES), 对应的回调是 -(void)mapView:(MAMapView *) didTouchPois:(NSArray *)
//    @property (nonatomic, assign) BOOL touchPOIEnabled;

    ///指南针原点位置
//    @property (nonatomic, assign) CGPoint compassOrigin;
    
    ///指南针的宽高
//    @property (nonatomic, readonly) CGSize compassSize;
    
    ///比例尺原点位置
//    @property (nonatomic, assign) CGPoint scaleOrigin;
    
    ///比例尺的最大宽高
//    @property (nonatomic, readonly) CGSize scaleSize;
    
    ///logo位置, 必须在mapView.bounds之内，否则会被忽略
//    @property (nonatomic, assign) CGPoint logoCenter;
    
    ///logo的宽高
//    @property (nonatomic, readonly) CGSize logoSize;
    
    ///在当前缩放级别下, 基于地图中心点, 1 screen point 对应的距离(单位是米)
//    @property (nonatomic, readonly) double metersPerPointForCurrentZoom;
    
    ///标识当前地图中心位置是否在中国范围外。此属性不是精确判断，不能用于边界区域
//    @property (nonatomic, readonly) BOOL isAbroad;
    
    ///最大帧数，有效的帧数为：60、30、20、10等能被60整除的数。默认为60
//    @property (nonatomic, assign) NSUInteger maxRenderFrame;
    
    ///是否允许降帧，默认为YES
//    @property (nonatomic, assign) BOOL isAllowDecreaseFrame;
    
    ///停止/开启 OpenGLES绘制, 默认NO. 对应回调是 - (void)mapView:(MAMapView *) didChangeOpenGLESDisabled:(BOOL)
//    @property (nonatomic, assign) BOOL openGLESDisabled;
    
    ///地图的视图锚点。坐标系归一化，(0, 0)为MAMapView左上角，(1, 1)为右下角。默认为(0.5, 0.5)，即当前地图的视图中心 since V5.0.0
//    @property (nonatomic) CGPoint screenAnchor;

    self.mapView.delegate = self; //代理
    
//    self.mapView.showsUserLocation = true;
//    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    /*添加annotation*/
//    self.annotations = [NSMutableArray array];
//    CLLocationCoordinate2D coordinates[10] = {
//        {39.992520, 116.336170},
//        {39.992520, 116.336170},
//        {39.998293, 116.352343},
//        {40.004087, 116.348904},
//        {40.001442, 116.353915},
//        {39.989105, 116.353915},
//        {39.989098, 116.360200},
//        {39.998439, 116.360201},
//        {39.979590, 116.324219},
//        {39.978234, 116.352792}};
//    for (int i = 0; i < 10; ++i)
//    {
//        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
//        a1.coordinate = coordinates[i];
//        a1.title      = [NSString stringWithFormat:@"anno: %d", i];
//        [self.annotations addObject:a1];
//    }
    
}
- (IBAction)user_location_action:(id)sender {
}
- (IBAction)car_location_action:(id)sender {
    MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39.992520, 116.336170);
    a1.coordinate = coordinate;
    a1.title = @"车辆位置";
    [self.mapView addAnnotation:a1];
    [self.mapView setCenterCoordinate:coordinate animated:true];
}
- (IBAction)electrc_action:(id)sender {
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
    /* 实现代理方法：*/
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        AnnotationView *annotationView = (AnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[AnnotationView alloc] initWithAnnotation:annotation                                                 reuseIdentifier:pointReuseIndetifier];
        }
//        annotationView.canShowCallout = YES;
//        annotationView.animatesDrop = YES;
        annotationView.draggable = YES;
//        annotationView.rightCalloutAccessoryView  = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.image = [UIImage imageNamed:@"icon_ positioning mark"];
        annotationView.annotation.title = @"当期车辆位置";
        annotationView.annotation.subtitle = @"2016/12/25-21:52";
//        annotationView.imageView.contentMode = UIViewContentModeScaleAspectFit;
        return annotationView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    

@end
