# SGLocationObjC

[![CI Status](http://img.shields.io/travis/crash_wu/SGLocationObjC.svg?style=flat)](https://travis-ci.org/crash-wu/SGLocationObjC)
[![Version](https://img.shields.io/cocoapods/v/SGLocationObjC.svg?style=flat)](http://cocoapods.org/pods/SGLocationObjC)
[![License](https://img.shields.io/cocoapods/l/SGLocationObjC.svg?style=flat)](http://cocoapods.org/pods/SGLocationObjC)
[![Platform](https://img.shields.io/cocoapods/p/SGLocationObjC.svg?style=flat)](http://cocoapods.org/pods/SGLocationObjC)

## Describe
基于ArcGis加载天地图瓦片的定位功能

## Usage
```
@import SGLocationObjC;//到项目中

```

###SGLocationUtil
```

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

```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
    ArcGIS-Runtime-SDK-iOS for version 10.2.5

## Installation

SGLocationObjC is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SGLocationObjC"
```

## Author

吴小星, crash_wu@163.com

## License

SGLocationObjC is available under the MIT license. See the LICENSE file for more info.
