//
//  SGViewController.m
//  SGLocationObjC
//
//  Created by 吴小星 on 09/05/2016.
//  Copyright (c) 2016 吴小星. All rights reserved.
//

#import "SGViewController.h"

@interface SGViewController ()


@property(nonnull,strong,nonatomic) AGSGraphicsLayer *locationGraphicsLayer;

@end

@implementation SGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.mapView = [[AGSMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.mapView];
    
    self.locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.locationBtn.frame = CGRectMake(0, 0, 40, 40);
    self.locationBtn.backgroundColor = [UIColor blueColor];
    [self.locationBtn addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.locationBtn];
    
    [[SGTileLayerUtil sharedInstance]loadTdtCGCS2000:self.mapView];
    
    self.locationGraphicsLayer = [[AGSGraphicsLayer alloc]init];
    [self.mapView addMapLayer:self.locationGraphicsLayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)location:(UIButton *)button{
    [[SGLocationUtil sharedInstance]getUserLocation:self.mapView andSymbolImage:@"终点"];
    
    
    [[SGLocationUtil sharedInstance] getUserLocationWith:^(CLLocation * _Nullable location) {
        
        //先清除图层
        [self.locationGraphicsLayer removeAllGraphics];
        AGSPoint *point = [[AGSPoint alloc]initWithX:location.coordinate.longitude y:location.coordinate.latitude spatialReference:[[AGSSpatialReference alloc]initWithWKID:4326]];
        point = [point gdWebpointToWSpoint];

        AGSPictureMarkerSymbol *graphicSymbol = [[AGSPictureMarkerSymbol alloc]initWithImageNamed:@"终点"];

        
        AGSGraphic *graphic = [[AGSGraphic alloc]initWithGeometry:point symbol:graphicSymbol attributes:nil];
        [self.locationGraphicsLayer addGraphic:graphic];
        [self.locationGraphicsLayer refresh];
        
    } failed:^(NSError * _Nullable error) {
        
    }];

}




@end
