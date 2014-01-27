//
//  FLOfferPopoverViewController.m
//  FreeLunchDemo
//
//  Created by Patrick Perini on 1/25/14.
//  Copyright (c) 2014 FreeLunch. All rights reserved.
//

#import "FLOfferPopoverViewController.h"
#import "FLOffer.h"

@interface FLOfferPopoverViewController ()

#pragma mark - Properties
@property (nonatomic) FLOffer *offer;

@end

@implementation FLOfferPopoverViewController

#pragma mark - Initializers
- (id)initWithOffer:(FLOffer *)offer
{
    self = [super initWithNibName: NSStringFromClass([self class]) bundle: nil];
    if (!self)
        return nil;
    
    [self setOffer: offer];
    
    return self;
}

#pragma mark - View Lifecycle Handlers
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self businessNameLabel] setText: [[self offer] businessName]];
    [[self offerDescriptionLabel] setText: [[self offer] offerDescription]];
    [[self durationDescriptionLabel] setText: [[self offer] durationDescription]];
    
    if (![[self offer] isFree])
    {
        [[self businessNameLabel] setTextColor: [UIColor colorWithRed: 0.46
                                                                green: 0.80
                                                                 blue: 0.15
                                                                alpha: 1.00]];
        
        [[self acceptButton] setBackgroundImage: [UIImage imageNamed: @"PaidButton"] forState: UIControlStateNormal];
    }
}

#pragma mark - Responders
- (void)acceptButtonWasPressed:(id)sender
{
    if (sender != [self acceptButton])
        return;
}

@end
