//
//  SGViewController.m
//  SGLocationObjC
//
//  Created by 吴小星 on 09/05/2016.
//  Copyright (c) 2016 吴小星. All rights reserved.
//

#import "SGViewController.h"

@interface SGViewController ()

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)location:(UIButton *)button{
    [[SGLocationUtil sharedInstance]getUserLocation:self.mapView andSymbolImage:@"终点"];
}

@end
