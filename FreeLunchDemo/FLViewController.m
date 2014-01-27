//
//  FLViewController.m
//  FreeLunchDemo
//
//  Created by Patrick Perini on 1/25/14.
//  Copyright (c) 2014 FreeLunch. All rights reserved.
//

#import "FLViewController.h"
#import "FLOffer.h"
#import "FLOfferView.h"
#import "FLOfferPopoverViewController.h"
#import "FLPopoverView.h"
#import "UIView+FLAnimations.h"

#pragma mark - Internal Constants
CLLocationCoordinate2D const FLViewControllerDefaultCoordinate = {40.442805, -79.955645};

@interface FLViewController ()

#pragma mark - Properties
@property FLOfferPopoverViewController *offerPopoverViewController;

#pragma mark - Mutators
- (void)fillWithDemoOffersFromURL:(NSURL *)url;

@end

@implementation FLViewController

#pragma mark - Accessors
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Mutators
- (void)fillWithDemoOffersFromURL:(NSURL *)url
{
    NSData *demoOffersData = [NSData dataWithContentsOfURL: url];
    NSArray *demoOffers = [NSJSONSerialization JSONObjectWithData: demoOffersData
                                                          options: 0
                                                            error: nil];
    
    for (NSDictionary *demoOffer in demoOffers)
    {
        FLOffer *offer = [[FLOffer alloc] init];
        [offer setBusinessName: [demoOffer objectForKey: @"businessName"]];
        [offer setFree: [[demoOffer objectForKey: @"free"] boolValue]];
        [offer setFoodType: [demoOffer objectForKey: @"foodType"]];
        [offer setOfferDescription: [demoOffer objectForKey: @"offerDescription"]];
        [offer setDurationDescription: [demoOffer objectForKey: @"durationDescription"]];
        [offer setCoordinate: CLLocationCoordinate2DMake([[[demoOffer objectForKey: @"coordinate"] firstObject] floatValue], [[[demoOffer objectForKey: @"coordinate"] lastObject] floatValue])];
        
        [[self mapView] addAnnotation: offer];
    }
}

#pragma mark - View Lifecycle Handlers
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setNeedsStatusBarAppearanceUpdate];
    [[[self mapView] camera] setCenterCoordinate: FLViewControllerDefaultCoordinate];
    
    NSURL *demoDataURL = [[NSBundle mainBundle] URLForResource: @"FLDemoOffers"
                                                 withExtension: @"json"];
    [self fillWithDemoOffersFromURL: demoDataURL];
}

#pragma mark - Map View Delegation
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (mapView != [self mapView])
        return nil;
    
    if (![annotation isKindOfClass: [FLOffer class]])
        return nil;
    
    FLOfferView *offerView = (FLOfferView *)[[self mapView] dequeueReusableAnnotationViewWithIdentifier: NSStringFromClass([FLOfferView class])];
    [offerView setAnnotation: annotation];
    
    if (!offerView)
    {
        offerView = [[FLOfferView alloc] initWithAnnotation: annotation
                                            reuseIdentifier: NSStringFromClass([FLOfferView class])];
    }

    [offerView setupForPopIn];
    
    CGFloat delay = (([[[self mapView] annotations] indexOfObject: annotation] + 1) * 0.25);
    [offerView popInWithDelay: delay];
    
    return offerView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if (mapView != [self mapView])
        return;
    
    if (![[view annotation] isKindOfClass: [FLOffer class]])
        return;
    
    [self mapView: mapView didDeselectAnnotationView: nil];
    
    // Adjust camera
    MKMapCamera *camera = [[[self mapView] camera] copy];
    [camera setCenterCoordinate: [[view annotation] coordinate]];
    [[self mapView] setCamera: camera
                     animated: YES];
    
    // Wait for camera adjustment, update popover
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.33 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^()
    {
        FLOffer *offer = [view annotation];
        [self setOfferPopoverViewController: [[FLOfferPopoverViewController alloc] initWithOffer: offer]];
        
        CGRect popoverFrame = CGRectZero;
        popoverFrame.origin.x = CGRectGetMidX([view frame]) - (CGRectGetWidth([[[self offerPopoverViewController] view] frame]) / 2.0);
        popoverFrame.origin.y = CGRectGetMinY([view frame]) - CGRectGetHeight([[[self offerPopoverViewController] view] frame]);
        [[[self offerPopoverViewController] view] setFrame: popoverFrame];
        
        [[[self offerPopoverViewController] view] setAlpha: 0];
        [[self view] addSubview: [[self offerPopoverViewController] view]];
        
        [UIView animateWithDuration: 0.25 animations: ^()
        {
            [[[self offerPopoverViewController] view] setAlpha: 1];
        }];
    });
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    if (mapView != [self mapView])
        return;
    
    if (![[view annotation] isKindOfClass: [FLOffer class]] && (view != nil))
        return;
    
    [UIView animateWithDuration: 0.10 animations: ^()
    {
        [[[self offerPopoverViewController] view] setAlpha: 0];
    } completion: ^(BOOL finished)
    {
        [[[self offerPopoverViewController] view] removeFromSuperview];
    }];
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    if (mapView != [self mapView])
        return;
    
    [self mapView: mapView didDeselectAnnotationView: nil];
}

@end
