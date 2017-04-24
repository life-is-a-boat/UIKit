//
//  ViewController.m
//  MAMapDemo
//
//  Created by 刘兵 on 2017/4/20.
//  Copyright © 2017年 刘兵. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "AnnotationView.h"
@interface ViewController ()<MAMapViewDelegate,AMapGeoFenceManagerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet MAMapView *mapView;
@property (strong, nonatomic) NSMutableArray    *annotations;
@property (strong, nonatomic) AMapGeoFenceManager   *geoFenceManager;
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

    ///缩放级别（默认3-19，有室内地图时为3-20）
    //    @property (nonatomic) CGFloat zoomLevel;

    ///最小缩放级别
    //    @property (nonatomic) CGFloat minZoomLevel;

    ///最大缩放级别（有室内地图时最大为20，否则为19）
    //    @property (nonatomic) CGFloat maxZoomLevel;
    [self.mapView setZoomLevel:14.5];

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
//    MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(31.1759441828, 121.4654445648);
//    a1.coordinate = coordinate;
//    a1.title = @"当前位置";
//    [self.mapView addAnnotation:a1];
//    [self.mapView setCenterCoordinate:coordinate animated:true];
//    [self.mapView setZoomLevel:14.5];

    self.geoFenceManager = [[AMapGeoFenceManager alloc] init];
    self.geoFenceManager.delegate = self;
    self.geoFenceManager.activeAction = AMapGeoFenceActiveActionInside | AMapGeoFenceActiveActionOutside | AMapGeoFenceActiveActionStayed; //设置希望侦测的围栏触发行为，默认是侦测用户进入围栏的行为，即AMapGeoFenceActiveActionInside，这边设置为进入，离开，停留（在围栏内10分钟以上），都触发回调
    self.geoFenceManager.allowsBackgroundLocationUpdates = YES;  //允许后台定位
}
- (IBAction)user_location_action:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39.908692, 116.397477); //天安门
    [self.mapView setCenterCoordinate:coordinate animated:true];
    [self.geoFenceManager addAroundPOIRegionForMonitoringWithLocationPoint:coordinate aroundRadius:10000 keyword:@"肯德基" POIType:@"050301" size:20 customID:@"poi_2"];
}
- (IBAction)car_location_action:(id)sender {
    MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(31.1759441828, 121.4654445648);
    a1.coordinate = coordinate;
    a1.title = @"车辆位置";
    [self.mapView addAnnotation:a1];
    [self.mapView setCenterCoordinate:coordinate animated:true];
    [self.mapView setZoomLevel:14.5];

    //构造圆
    MACircle *circle = [MACircle circleWithCenterCoordinate:coordinate radius:1000];
    //在地图上添加圆
    [_mapView addOverlay: circle];
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
        if ([annotation.title isEqualToString:@"当前位置"]) {
            static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
            MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
            if (annotationView == nil)
            {
                annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation                                                 reuseIdentifier:pointReuseIndetifier];
            }
            //        annotationView.canShowCallout = YES;
            //        annotationView.animatesDrop = YES;
            annotationView.draggable = YES;
            //        annotationView.rightCalloutAccessoryView  = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            annotationView.image = [UIImage imageNamed:@"icon_ positioning mark"];
            annotationView.annotation.title = @"当前位置";
            annotationView.annotation.subtitle = @"2016/12/25-21:52";
            //        annotationView.imageView.contentMode = UIViewContentModeScaleAspectFit;
            return annotationView;
        }
        else if ([annotation.title isEqualToString:@"车辆位置"]) {
            static NSString *AnnotationViewpointReuseIndetifier = @"AnnotationViewpointReuseIndetifier";
            AnnotationView *annotationView = (AnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewpointReuseIndetifier];
            if (annotationView == nil)
            {
                annotationView = [[AnnotationView alloc] initWithAnnotation:annotation                                                 reuseIdentifier:AnnotationViewpointReuseIndetifier];
            }
            //        annotationView.canShowCallout = YES;
            //        annotationView.animatesDrop = YES;
            annotationView.draggable = YES;
            //        annotationView.rightCalloutAccessoryView  = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            annotationView.image = [UIImage imageNamed:@"icon_ positioning mark"];
            annotationView.annotation.title = @"江西省南昌市振林东路陆风研发中心";
            annotationView.annotation.subtitle = @"2016/12/25-21:52";
            //        annotationView.imageView.contentMode = UIViewContentModeScaleAspectFit;
            return annotationView;
        }
    }
    return nil;
}
/**
 * @brief 当选中一个annotation view时，调用此接口. 注意如果已经是选中状态，再次点击不会触发此回调。取消选中需调用-(void)deselectAnnotation:animated:
 * @param mapView 地图View
 * @param view 选中的annotation view
 */
//- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
//{
//    //
//}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];

        circleRenderer.lineWidth    = 2.f;
        circleRenderer.strokeColor  = [UIColor redColor];//[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        circleRenderer.fillColor    = [UIColor colorWithRed:1. green:0. blue:0. alpha:0.25];//[UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:0.8];
        return circleRenderer;
    }
    return nil;
}
#pragma mark -  地理围栏
/**
 * @brief 添加地理围栏完成后的回调，成功与失败都会调用
 * @param manager 地理围栏管理类
 * @param regions 成功添加的一个或多个地理围栏构成的数组
 * @param customID 用户执行添加围栏函数时传入的customID
 * @param error 添加失败的错误信息
 */
- (void)amapGeoFenceManager:(AMapGeoFenceManager *)manager didAddRegionForMonitoringFinished:(NSArray <AMapGeoFenceRegion *> *)regions customID:(NSString *)customID error:(NSError *)error
{
    NSLog(@"didAddRegionForMonitoringFinished");
}


/**
 * @brief 地理围栏状态改变时回调，当围栏状态的值发生改变，定位失败都会调用
 * @param manager 地理围栏管理类
 * @param region 状态改变的地理围栏
 * @param customID 用户执行添加围栏函数时传入的customID
 * @param error 错误信息，如定位相关的错误
 */
- (void)amapGeoFenceManager:(AMapGeoFenceManager *)manager didGeoFencesStatusChangedForRegion:(AMapGeoFenceRegion *)region customID:(NSString *)customID error:(NSError *)error
{
    NSLog(@"didGeoFencesStatusChangedForRegion");
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    

@end
