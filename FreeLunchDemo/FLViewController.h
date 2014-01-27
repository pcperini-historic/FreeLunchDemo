//
//  FLViewController.h
//  FreeLunchDemo
//
//  Created by Patrick Perini on 1/25/14.
//  Copyright (c) 2014 FreeLunch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FLViewController : UIViewController <MKMapViewDelegate>

#pragma mark - Properties
@property IBOutlet MKMapView *mapView;

@end
