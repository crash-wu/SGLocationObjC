//
//  EnumType.h
//  Pods
//
//  Created by 吴小星 on 16/10/10.
//
//

#import <Foundation/Foundation.h>

/**
 *  @author crash         crash_wu@163.com   , 16-10-10 10:10:23
 *
 *  @brief  定位模式
 */
NS_ENUM(NSInteger,LocationType){
    /**
     *  @author crash         crash_wu@163.com   , 16-10-10 10:10:23
     *
     *  @brief  前台后台
     */
    Alway = 0,
    /**
     *  @author crash         crash_wu@163.com   , 16-10-10 10:10:23
     *
     *  @brief  前台使用时定位
     */
    WhenInUse
};

@interface EnumType : NSObject

@end
