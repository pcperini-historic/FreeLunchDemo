//
//  FLOfferPopoverViewController.h
//  FreeLunchDemo
//
//  Created by Patrick Perini on 1/25/14.
//  Copyright (c) 2014 FreeLunch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLOffer;

@interface FLOfferPopoverViewController : UIViewController

#pragma mark - Properties
@property (nonatomic, readonly) FLOffer *offer;
@property IBOutlet UILabel *businessNameLabel;
@property IBOutlet UILabel *offerDescriptionLabel;
@property IBOutlet UILabel *durationDescriptionLabel;
@property IBOutlet UIButton *acceptButton;

#pragma mark - Initializers
- (id)initWithOffer:(FLOffer *)offer;

#pragma mark - Responders
- (IBAction)acceptButtonWasPressed:(id)sender;

@end
