//
//  FLOffer.h
//  FreeLunchDemo
//
//  Created by Patrick Perini on 1/25/14.
//  Copyright (c) 2014 FreeLunch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface FLOffer : NSObject <MKAnnotation>

#pragma mark - Properties
@property NSString *businessName;
@property NSString *offerDescription;
@property NSString *durationDescription;
@property (getter = isFree) BOOL free;
@property NSString *foodType;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
