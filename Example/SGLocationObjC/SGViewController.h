//
//  SGViewController.h
//  SGLocationObjC
//
//  Created by 吴小星 on 09/05/2016.
//  Copyright (c) 2016 吴小星. All rights reserved.
//

@import UIKit;
@import ArcGIS;
@import SGLocationObjC;
@import SGTileLayer;


@interface SGViewController : UIViewController

@property(nonatomic,strong) AGSMapView *mapView;
@property(nonatomic,strong) UIButton *locationBtn;
@end
