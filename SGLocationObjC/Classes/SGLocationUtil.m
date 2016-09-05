//
//  SGLocationUtil.m
//  Pods
//
//  Created by 吴小星 on 16/9/5.
//
//

#import "SGLocationUtil.h"

//用户当前定位图层名称
#define USERLOCATIONLAYER @"userlocationLayer"

@interface SGLocationUtil()<CLLocationManagerDelegate>

/**
 *  @author crash         crash_wu@163.com   , 16-09-05 16:09:24
 *
 *  @brief  当前定位坐标
 */
@property(nonatomic,strong,nullable)  AGSPoint *currentLocationPoint;

/**
 *  @author crash         crash_wu@163.com   , 16-09-05 16:09:18
 *
 *  @brief  当前地图
 */
@property(nonatomic,strong,nullable) AGSMapView *currentMapView;

/**
 *  @author crash         crash_wu@163.com   , 16-09-05 16:09:30
 *
 *  @brief  定位图标名称
 */
@property(nonatomic,strong,nullable) NSString *symbolImage;


/**
 *  @author crash         crash_wu@163.com   , 16-09-05 16:09:19
 *
 *  @brief
 */
@property(nonatomic,strong ,nullable ) AGSGraphicsLayer *locationLayer;

@property(nonatomic,strong,nullable) CLLocationManager *location;

@end

@implementation SGLocationUtil


/**
 *  @author crash         crash_wu@163.com   , 16-09-05 16:09:02
 *
 *  @brief  单例
 *
 *  @return 定位服务对象
 */
+(nonnull instancetype)sharedInstance{
    
    static SGLocationUtil *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        
    });
    return instance;
    
}

-(id)init{
    self = [super init];
    if (self) {
        
        _location = [[CLLocationManager alloc  ]init];
    }
    return self;
}

-(nullable AGSPoint *)currentLocationPoint{
    if (_currentLocationPoint == nil) {
        
        _currentLocationPoint = [[AGSPoint alloc]init];
    }
    
    return  _currentLocationPoint;
}



-(nullable AGSGraphicsLayer *)locationLayer{
    if (_locationLayer == nil) {
        
        _locationLayer = [[AGSGraphicsLayer alloc]init];
    }
    
    return _locationLayer   ;
}

/**
 *  @author crash         crash_wu@163.com   , 16-09-05 16:09:31
 *
 *  @brief  获取用户当前位置信息,并且展示到地图上
 *
 *  @param mapView   地图
 *  @param imageName 图标名称
 */
-(void)getUserLocation:(nonnull AGSMapView *)mapView andSymbolImage:(nonnull NSString *)imageName{
    
    self.currentMapView = mapView;
    self.symbolImage = imageName;
    if ([CLLocationManager locationServicesEnabled]) {
        
        self.location.delegate = self;
        self.location.desiredAccuracy = kCLLocationAccuracyBest;
        self.location.distanceFilter = 1000.0;
        [self.location requestAlwaysAuthorization];
        [self.location startUpdatingLocation];
    }
}



/**
 *  @author crash         crash_wu@163.com   , 16-09-05 16:09:29
 *
 *  @brief  获取当前用户用户位置坐标
 *
 *  @return 用户位置坐标
 */
-(nullable AGSPoint *)getUserPoint{
    
    return self.currentLocationPoint;
}



#pragma mark - CLLocationManagerDelegate
//IOS8 新特性
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    switch (status) {
            
        case kCLAuthorizationStatusAuthorizedAlways:
            
            if ([self.location respondsToSelector:@selector
                 (requestAlwaysAuthorization)]) {
                
                [self.location requestAlwaysAuthorization];
                
            }
            break;
        default:
            break;
            
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [self showCurrentLocation:self.currentMapView andLocation:locations.lastObject];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    
}



/**
 *  @author crash         crash_wu@163.com   , 16-09-05 17:09:41
 *
 *  @brief   给坐标点添加显示图形
 *
 *  @param point     坐标点
 *  @param imageName 图形名称
 *
 *  @return
 */
- (nonnull AGSGraphicsLayer *)insertImageLocation:(nonnull AGSPoint *)point andSymbol:(nonnull NSString *)imageName{

    
    AGSGraphicsLayer *symbolLayer = [[AGSGraphicsLayer alloc]init];
    AGSPictureMarkerSymbol *graphicSymbol = [[AGSPictureMarkerSymbol alloc]initWithImageNamed:imageName];
    NSDictionary *attributes = @{@"type":USERLOCATIONLAYER};
    
    AGSGraphic *graphic = [[AGSGraphic alloc]initWithGeometry:point symbol:graphicSymbol attributes:attributes];
    [symbolLayer addGraphic:graphic];
    [symbolLayer refresh];
    //缩放到第15级别
    [self.currentMapView zoomToScale:18055.990933506204 withCenterPoint:point animated:true];
    return symbolLayer;
    
}


/**
 *  @author crash         crash_wu@163.com   , 16-09-05 17:09:08
 *
 *  @brief  墨卡托坐标系转化经纬度
 *
 *  @param point 墨卡托坐标系坐标
 *
 *  @return ws84坐标系坐标
 */
-(nullable AGSPoint *)webpointToWS84point:(nonnull AGSPoint *)point{
    
    AGSSpatialReference * src = [[AGSSpatialReference alloc]initWithWKID:4490];
    AGSGeometryEngine *geoEng = [AGSGeometryEngine defaultGeometryEngine];
    AGSPoint *ws84Point = (AGSPoint *)[geoEng projectGeometry:point toSpatialReference:src];
    return ws84Point;
}


/**
 *  @author crash         crash_wu@163.com   , 16-09-05 17:09:06
 *
 *  @brief  显示定位图层
 *
 *  @param mapView  当前地图
 *  @param location 定位对象
 */
-(void)showCurrentLocation:(nonnull AGSMapView *)mapView andLocation:(nullable CLLocation *) location{
    
    
    [mapView removeMapLayerWithName:USERLOCATIONLAYER];
    
    self.currentLocationPoint = [[AGSPoint alloc]initWithX:location.coordinate.longitude y:location.coordinate.latitude spatialReference:self.currentMapView.spatialReference];
    
    //判断图层的坐标系
    if (mapView.spatialReference.isAnyWebMercator) {
        //墨卡托
        AGSPoint *ws84 = [self webpointToWS84point:self.currentLocationPoint];
        self.locationLayer = [self insertImageLocation:ws84 andSymbol:self.symbolImage];
    }else{
        //经纬度
        self.locationLayer = [self insertImageLocation:self.currentLocationPoint andSymbol:self.symbolImage];
    }
    
    [mapView addMapLayer:self.locationLayer withName:USERLOCATIONLAYER];
    
}




@end
