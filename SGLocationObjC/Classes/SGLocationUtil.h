//
//  SGLocationUtil.h
//  Pods
//
//  Created by 吴小星 on 16/9/5.
//
//

#import <Foundation/Foundation.h>
//#import <ArcGIS/ArcGIS.h>
@import ArcGIS;

/**
 *  @author crash         crash_wu@163.com   , 16-09-05 08:09:48
 *
 *  @brief  定位工具类
 */
@interface SGLocationUtil : NSObject



/**
 *  @author crash         crash_wu@163.com   , 16-09-05 16:09:02
 *
 *  @brief  单例
 *
 *  @return 定位服务对象
 */
+(nonnull instancetype)sharedInstance;

/**
 *  @author crash         crash_wu@163.com   , 16-09-05 16:09:31
 *
 *  @brief  获取用户当前位置信息,并且展示到地图上
 *
 *  @param mapView   地图
 *  @param imageName 图标名称
 */
-(void)getUserLocation:(nonnull AGSMapView *)mapView andSymbolImage:(nonnull NSString *)imageName;

/**
 *  @author crash         crash_wu@163.com   , 16-09-05 16:09:29
 *
 *  @brief  获取当前用户用户位置坐标
 *
 *  @return 用户位置坐标
 */
-(nullable AGSPoint *)getUserPoint;



@end
