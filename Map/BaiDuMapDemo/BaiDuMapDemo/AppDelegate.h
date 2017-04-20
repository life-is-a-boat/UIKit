//
//  AppDelegate.h
//  BaiDuMapDemo
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 lb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    CLLocationManager   *_locationManager;
    BMKMapManager       *_mapManager;
}
@property (strong, nonatomic) UIWindow *window;


@end

