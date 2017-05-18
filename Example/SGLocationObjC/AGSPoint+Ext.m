//
//  AGSPoint+Ext.m
//  SGLocationObjC
//
//  Created by 吴小星 on 2017/5/18.
//  Copyright © 2017年 吴小星. All rights reserved.
//

#import "AGSPoint+Ext.h"

@implementation AGSPoint (Ext)

-(nullable AGSPoint *)gdWebpointToWSpoint{
    
    AGSSpatialReference *spa = [[AGSSpatialReference alloc]initWithWKID:4490];
    AGSGeometryEngine *geoEng = [AGSGeometryEngine defaultGeometryEngine];
    
    AGSPoint * point =(AGSPoint *) [geoEng projectGeometry:self toSpatialReference:spa];
    return  point;
}

@end
